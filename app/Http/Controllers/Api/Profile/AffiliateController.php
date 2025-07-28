<?php

namespace App\Http\Controllers\Api\Profile;

use App\Http\Controllers\Controller;
use App\Models\AffiliateHistory;
use App\Models\AffiliateWithdraw;
use App\Models\User;
use App\Models\Wallet;
use App\Models\Setting;
use App\Models\GGRGames;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Validator;
use App\Models\Transaction;
use App\Events\DepositedCountUpdated;
use App\Models\Withdrawal;
use App\Models\Deposit;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;

class AffiliateController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $userId = auth('api')->id();
        $inviterId = auth('api')->id(); // ID do usuário autenticado

        $directIndicatedUsers = AffiliateHistory::where('inviter', $inviterId)->pluck('user_id');
        $subAffiliateIds = AffiliateHistory::whereIn('inviter', $directIndicatedUsers)->pluck('user_id');
        $totalWithdrawalsAmount = Withdrawal::whereIn('user_id', $subAffiliateIds)->sum('amount');
        $totalDepositsAmount = Deposit::whereIn('user_id', $subAffiliateIds)
            ->where('status', 1)
            ->sum('amount');
        $totalRegistrations = User::whereIn('id', $subAffiliateIds)->count();
        $indicatedUsers = User::where('inviter', $inviterId)->pluck('id'); // IDs dos usuários indicados

        $minimumBets = 200;
        $usuariosValidos = [];
        $totalTransactionAmount = 0;
        $userBetSums = [];

        foreach ($indicatedUsers as $userId) {
        // Verifica se o indicado fez ao menos um depósito com status 1
        $temDepositoValido = Transaction::where('user_id', $userId)
            ->where('status', 1)
            ->exists();
    
        // Soma o valor apostado
        $userBetSum = GGRGames::where('user_id', $userId)->sum('balance_bet');
        $userBetSums[$userId] = $userBetSum;
    
        // Se fez depósito válido E apostou o mínimo → entra como "válido"
        if ($temDepositoValido && $userBetSum >= $minimumBets) {
            $usuariosValidos[] = $userId;
        }
    
        // Soma o total das transações válidas de todos indicados
        $totalTransactionAmount += Transaction::where('user_id', $userId)
            ->where('status', 1)
            ->sum('price');
    }

        $indications = User::where('inviter', $inviterId)->count(); // Conta quantos usuários foram indicados
        $walletDefault = Wallet::where('user_id', $inviterId)->first(); // Obtém a carteira padrão
        $fdepositedCount = 0;
        
        foreach ($indicatedUsers as $userId) {
            $userDepositedCount = Transaction::where('user_id', $userId)->where('status', 1)->count();
            $fdepositedCount += $userDepositedCount;
        }

        $uniqueStatusCount = count($usuariosValidos);

        $user = auth('api')->user();
        $cacheKey = "bonus_received_{$user->id}_{$uniqueStatusCount}";

        $bonuses = [
            // De 1 ao 10
            1 => 10,
            2 => 10,
            3 => 10,
            4 => 10,
            5 => 10,
            6 => 10,
            7 => 10,
            8 => 10,
            9 => 10,
            10 => 10,
            15 => 50,
            20 => 50,
            25 => 50,
            30 => 50,
            35 => 50,
            40 => 50,
            45 => 50,
            50 => 50,
            60 => 100,
            70 => 100,
            80 => 100,
            90 => 100,
            150 => 500,
            200 => 500,
            250 => 500,
            300 => 500,
            350 => 500,
            400 => 500,
            450 => 500,
            500 => 500,
            
            
        ];

        $openChests = $user->open_chests ? json_decode($user->open_chests, true) : [];

        // Verifica e concede bônus se o uniqueStatusCount for exatamente um dos valores-chave, 
        // se o usuário indicado atingiu a quantidade mínima de apostas, e se o bônus ainda não tiver sido concedido
        if (array_key_exists($uniqueStatusCount, $bonuses) && !Cache::has($cacheKey)) {
            // Incrementa a carteira
            $walletDefault->increment('balance_withdrawal', $bonuses[$uniqueStatusCount]);

            // Armazena no cache que o bônus foi recebido
            Cache::put($cacheKey, true, now()->addYear()); // Armazena por um ano, ajuste conforme necessário

            // Adiciona o uniqueStatusCount ao array de baús abertos
            if (!in_array($uniqueStatusCount, $openChests)) {
                $openChests[] = $uniqueStatusCount;
                $user->open_chests = json_encode($openChests);
                $user->save();
            }
        }
        $userId = auth('api')->id();

        $directIndications = User::where('inviter', $userId)->pluck('id');

        // Filtrando apenas os depósitos diretos
        $deposits = Deposit::whereIn('user_id', $directIndications)
            ->where('status', 1) // Filtra apenas os depósitos com status igual a 1
            ->select('user_id', 'amount', 'type', 'created_at')
            ->get()
            ->map(function ($deposit) {
                $deposit->source = 'direct';
                $deposit->balance_bet = GGRGames::where('user_id', $deposit->user_id)->sum('balance_bet');
                return $deposit;
            });
            

            $totalBalanceBetPorUsuario = [];

            foreach ($indicatedUsers as $userId) {
                $somaBalanceBet = GGRGames::where('user_id', $userId)->sum('balance_bet');
                $totalBalanceBetPorUsuario[$userId] = $somaBalanceBet;
            }
            
            $totalFirstDepositsValue = 0;

            foreach ($indicatedUsers as $userId) {
                // Obtém o primeiro depósito (menor ID ou mais antigo) de cada usuário indicado
                $firstDeposit = Deposit::where('user_id', $userId)
                    ->where('status', 1) // Certifique-se de filtrar apenas os depósitos confirmados
                    ->orderBy('created_at', 'asc') // Ordena por data de criação (primeiro depósito)
                    ->first();
            
                if ($firstDeposit) {
                    $totalFirstDepositsValue += $firstDeposit->amount; // Soma o valor do primeiro depósito
                }
            }
            
            $totalPrimeiroDeposito = 0;
            
            foreach ($indicatedUsers as $userId) {
                // Contar registros distintos em AffiliateHistory para um único usuário com status 1
                $hasUniqueStatus = Transaction::where('user_id', $userId)->where('status', 1)->distinct()->count('user_id');
    
                // Se o usuário tiver ao menos um registro com o status específico, incrementamos o contador total
                if ($hasUniqueStatus > 0) {
                    $totalPrimeiroDeposito++;
                }
            }

            $totalCommissions = AffiliateHistory::where('inviter', $inviterId)
                        ->where('status', 1) // Considera apenas comissões já pagas
                        ->sum('commission');

            $userId = auth('api')->id();
            $totalSaques = AffiliateWithdraw::where('user_id', $userId)
                ->where('status', 1)
                ->sum('amount');            
                        

        return response()->json([
            'status' => true,
            'code' => auth('api')->user()->inviter_code,
            'url' => config('app.url') . '/?code=' . auth('api')->user()->inviter_code,
            'indications' => $indications,
            'wallet' => $walletDefault,
            'amount' => $totalTransactionAmount,
            'fdepositedCount' => $fdepositedCount,
            'uniqueStatusCount' => $uniqueStatusCount,
            'openChests' => $openChests, // Adiciona a lista de baús abertos ao JSON de resposta
            'totalregistrations' => $totalRegistrations,
            'totalafdeposit' => $totalDepositsAmount,
            'totalafwithdrawal' => $totalWithdrawalsAmount,
            'deposits' => $deposits,
            'totalFirstDepositsValue' => $totalFirstDepositsValue, // Adiciona o valor total dos primeiros depósitos
            'totalCommissions' => $totalCommissions, // Soma total das comissões do afiliado
            'totalSaques' => $totalSaques,
            'minimumBets' => $minimumBets,
            'totalBalanceBetPorUsuario' => $totalBalanceBetPorUsuario,
            'totalPrimeiroDeposito' => $totalPrimeiroDeposito,



        ]);
    }
    /**
     * Show the form for creating a new resource.
     */
    public function generateCode()
    {
        $code = $this->gencode();
        $setting = \Helper::getSetting();

        if (!empty($code)) {
            $user = auth('api')->user();
            \DB::table('model_has_roles')->updateOrInsert(
                [
                    'role_id' => 2,
                    'model_type' => 'App\Models\User',
                    'model_id' => $user->id,
                ],
            );

            if (auth('api')->user()->update(['inviter_code' => $code, 'affiliate_revenue_share' => $setting->revshare_percentage])) {
                return response()->json(['status' => true, 'message' => trans('Successfully generated code')]);
            }

            return response()->json(['error' => ''], 400);
        }

        return response()->json(['error' => ''], 400);
    }

    /**
     * @return null
     */
    private function gencode()
    {
        $code = \Helper::generateCode(10);

        $checkCode = User::where('inviter_code', $code)->first();
        if (empty($checkCode)) {
            return $code;
        }

        return $this->gencode();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function makeRequest(Request $request)
    {
        // Obtendo as configurações de saque do usuário
        $settings = Setting::where('id', 1)->first();

        // Verificando se as configurações foram encontradas e se os limites de saque foram definidos
        if ($settings) {
            $withdrawalLimit = $settings->withdrawal_limit;
            $withdrawalPeriod = $settings->withdrawal_period;
        } else {
            // Caso as configurações não tenham sido encontradas, defina os valores padrão ou trate conforme necessário
            $withdrawalLimit = null;
            $withdrawalPeriod = null;
        }

        if ($withdrawalLimit !== null && $withdrawalPeriod !== null) {
            $startDate = now()->startOfDay();
            $endDate = now()->endOfDay();

            switch ($withdrawalPeriod) {
                case 'daily':
                    break;

                case 'weekly':
                    $startDate = now()->startOfWeek();
                    $endDate = now()->endOfWeek();
                    break;
                case 'monthly':
                    $startDate = now()->startOfMonth();
                    $endDate = now()->endOfMonth();
                    break;
                case 'yearly':
                    $startDate = now()->startOfYear();
                    $endDate = now()->endOfYear();
                    break;
            }

            $withdrawalCount = AffiliateWithdraw::where('user_id', auth('api')->user()->id)
                ->whereBetween('created_at', [$startDate, $endDate])
                ->count();

            if ($withdrawalCount >= $withdrawalLimit) {
                return response()->json(['message' => 'Você atingiu o limite de saques para este período'], 400);
            }
        }

        $rules = [
            'amount' => ['required', 'numeric', 'min:' . $settings->min_withdrawal, 'max:' . $settings->max_withdrawal],
            'pix_type' => 'required',
        ];

        switch ($request->pix_type) {
            case 'document':
                $rules['pix_key'] = 'required|cpf_ou_cnpj';
                break;
            case 'email':
                $rules['pix_key'] = 'required|email';
                break;
            default:
                $rules['pix_key'] = 'required';
                break;
        }

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        // Verificando se o usuário tem saldo suficiente para o saque
        $comission = auth('api')->user()->wallet->refer_rewards;

        if (floatval($comission) >= floatval($request->amount) && floatval($request->amount) > 0) {
            // Criando o registro de saque
            AffiliateWithdraw::create([
                'user_id' => auth('api')->id(),
                'amount' => $request->amount,
                'pix_key' => $request->pix_key,
                'pix_type' => $request->pix_type,
                'currency' => 'BRL',
                'symbol' => 'R$',
            ]);

            // Decrementando o saldo do usuário
            auth('api')->user()->wallet->decrement('refer_rewards', $request->amount);

            // Retornando mensagem de sucesso
            return response()->json(['message' => trans('Commission withdrawal successfully carried out')], 200);
        }

        // Retornando mensagem de erro se não houver saldo suficiente
        return response()->json(['message' => trans('Commission withdrawal error')], 400);
    }
}
