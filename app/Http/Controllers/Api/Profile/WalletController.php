<?php

namespace App\Http\Controllers\Api\Profile;

use App\Http\Controllers\Controller;
use App\Models\Setting;
use App\Models\User;
use App\Models\Vip;
use App\Models\VipUser;
use App\Models\GGRGames;
use App\Models\Wallet;
use App\Models\Withdrawal;
use App\Models\Deposit;
use App\Models\Transaction;
use App\Notifications\NewWithdrawalNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;



class WalletController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $userId = auth('api')->id();
        
        $wallet = Wallet::where('user_id', $userId)->where('active', 1)->first();
        
        return response()->json([
            'wallet' => $wallet,
        ], 200);
    }


    public function depositToSavings(Request $request)
{
    $request->validate([
        'amount' => 'required|numeric|min:0.01',
    ]);

    $user = auth('api')->user();
    $wallet = $user->wallet;

    if ($wallet->balance_withdrawal < $request->amount) {
        return response()->json(['error' => 'Saldo insuficiente'], 400);
    }

    // Deduz do saldo de saque e adiciona à poupança
    $wallet->balance_withdrawal -= $request->amount;
    $wallet->balance_savings += $request->amount;
    $wallet->save();

    return response()->json(['message' => 'Depósito realizado com sucesso!', 'wallet' => $wallet]);
}

public function withdrawFromSavings(Request $request)
{
    $request->validate([
        'amount' => 'required|numeric|min:0.01',
    ]);

    $user = auth('api')->user();
    $wallet = $user->wallet;

    if ($wallet->balance_savings < $request->amount) {
        return response()->json(['error' => 'Saldo insuficiente na poupança'], 400);
    }

    // Deduz da poupança e adiciona ao saldo de saque
    $wallet->balance_savings -= $request->amount;
    $wallet->balance_withdrawal += $request->amount;
    $wallet->save();

    return response()->json(['message' => 'Resgate realizado com sucesso!', 'wallet' => $wallet]);
}


public function calculateSavingsInterest()
{
    $interestRate = 0.01; // 1% ao dia
    $wallets = Wallet::where('balance_savings', '>', 0)->get();

    foreach ($wallets as $wallet) {
        $lastUpdate = Carbon::parse($wallet->last_interest_update ?? now()->subDay());
        $days = $lastUpdate->diffInDays(now());

        if ($days > 0) {
            $earned = ($wallet->balance_savings * $interestRate) * $days;
            $wallet->savings_interest += $earned;
            $wallet->last_interest_update = now();
            $wallet->save();
        }
    }

    return response()->json(['message' => 'Rendimento atualizado']);
}





    /**
     * @return \Illuminate\Http\JsonResponse
     */
   public function myWallet(Request $request)
{
    Log::info("🚀 Iniciando myWallet() para user_id: " . auth('api')->id());
    Log::info("📝 Request recebido: ", $request->all());

    $userId = auth('api')->id();
    $wallet = Wallet::where('user_id', $userId)->first();

    if (!$wallet) {
        Log::error("❌ Erro: Carteira não encontrada para user_id: {$userId}");
        return response()->json(['error' => 'Carteira não encontrada'], 404);
    }

    // ✅ Aplicar juros automaticamente se passaram 24h desde o último rendimento
    $lastUpdate = Carbon::parse($wallet->last_interest_update ?? now()->subDay());
    $hoursSinceLastUpdate = $lastUpdate->diffInHours(now());

    if ($hoursSinceLastUpdate >= 24) {
        $interestRate = 0.01; // 1% ao dia
        $earned = $wallet->balance_savings * $interestRate;
        $wallet->increment('balance_savings', $earned);
        $wallet->increment('savings_interest', $earned);
        $wallet->last_interest_update = now();
        $wallet->save();

        Log::info("🏦 Juros de R$ {$earned} aplicados à poupança do user_id: {$userId}");
        Log::info("⏳ `last_interest_update` atualizado para: " . $wallet->last_interest_update);
    } else {
        Log::info("⏳ Juros ainda não aplicados para user_id: {$userId}. Apenas {$hoursSinceLastUpdate} horas passaram.");
    }

    // ✅ Pegando valores da requisição corretamente
    $depositAmount = $request->input('deposit_amount') ?? $request->query('deposit_amount');
    $withdrawAmount = $request->input('withdraw_amount') ?? $request->query('withdraw_amount');

    Log::info("💰 Depósito recebido: " . ($depositAmount ?: 'Nenhum'));
    Log::info("🏦 Saque recebido: " . ($withdrawAmount ?: 'Nenhum'));

   // 📌 Obtém o total de apostas do usuário
$totalBets = GGRGames::where('user_id', $userId)->count();
$sumBets = GGRGames::where('user_id', $userId)->sum('balance_bet');

Log::info("📊 Total de apostas: {$totalBets}, Soma das apostas: {$sumBets}");

// 📌 Obtém o nível VIP atual do usuário
$vipUser = VipUser::where('user_id', $userId)->first();
if (!$vipUser) {
    Log::error("🚨 Usuário não encontrado na tabela Vip_users. user_id: {$userId}");
    return;
}

$currentLevel = $vipUser->level;
$nextLevel = $currentLevel + 1;

$vipLevels = [
    1 => ['required_bets' => 5000, 'reward' => 5],
    2 => ['required_bets' => 18000, 'reward' => 18],
    3 => ['required_bets' => 88000, 'reward' => 28],
    4 => ['required_bets' => 200000, 'reward' => 58],
    5 => ['required_bets' => 700000, 'reward' => 108],
];


// 📌 Define o required_bets para o próximo nível ou 0 se já estiver no máximo
$required_bets = isset($vipLevels[$nextLevel]) ? $vipLevels[$nextLevel]['required_bets'] : 0;

// 📌 Verifica se o usuário pode subir de nível
if (isset($vipLevels[$nextLevel])) {
    $requiredBets = $vipLevels[$nextLevel]['required_bets'];
    $rewardAmount = $vipLevels[$nextLevel]['reward'];
    $cacheKey = "vip_bonus_{$userId}_level_{$nextLevel}";

    // 📌 Se o usuário atingir a meta e ainda não tiver recebido o bônus do nível
    if ($sumBets >= $requiredBets && !Cache::has($cacheKey)) {
        // Incrementa o nível do usuário
        $vipUser->update(['level' => $nextLevel]);

        // Adiciona a recompensa ao saldo de saque
        $wallet->increment('balance_withdrawal', $rewardAmount);

        // Armazena no cache para evitar recompensas duplicadas
        Cache::put($cacheKey, true, now()->addYear());

        Log::info("🎉 Usuário {$userId} subiu para VIP {$nextLevel} e recebeu R$ {$rewardAmount} de bônus.");
    }
}

    // ✅ Realiza depósito na poupança
if ($depositAmount) {
    if ($depositAmount < 20) {
        Log::warning("⚠️ Tentativa de depósito abaixo do mínimo de R$ 20,00 - User ID: {$userId}");
        return response()->json(['error' => 'O valor mínimo para depósito é R$ 20,00'], 400);
    }

    if ($wallet->balance_withdrawal >= $depositAmount && $depositAmount > 0) {
        $wallet->decrement('balance_withdrawal', $depositAmount);
        $wallet->increment('balance_savings', $depositAmount);

        // ✅ Atualiza `last_deposit_update` com a data e hora atual
        $wallet->last_deposit_update = now();
        $wallet->save();

        Log::info("✅ Depósito de R$ {$depositAmount} na poupança concluído!");
        Log::info("⏳ `last_deposit_update` atualizado para: " . $wallet->last_deposit_update);

        // ✅ REGISTRAR O DEPÓSITO NA TABELA `transactions`
        Transaction::create([
            'user_id' => $userId,
            'type' => 'deposit_savings',
            'savings_amount' => $depositAmount,
            'deposit_savings' => 1, // Marcar que é um depósito na poupança
            'created_at' => now()
        ]);

        Log::info("💾 Depósito registrado na tabela transactions! User ID: {$userId}, Valor: R$ {$depositAmount}");
    } else {
        Log::warning("⚠️ Saldo insuficiente para depósito de R$ {$depositAmount} - User ID: {$userId}");
        return response()->json(['error' => 'Saldo insuficiente para depósito'], 400);
    }
}


    // ✅ Realiza saque da poupança
    if ($withdrawAmount) {
        if ($withdrawAmount < 50) {
            Log::warning("⚠️ Tentativa de saque abaixo do mínimo de R$ 20,00 - User ID: {$userId}");
            return response()->json(['error' => 'O valor mínimo para saque é R$ 50,00'], 400);
        }

        if ($wallet->balance_savings < 50) {
            Log::warning("⚠️ Saldo da poupança insuficiente para saque - User ID: {$userId}");
            return response()->json(['error' => 'Você precisa ter pelo menos R$ 20,00 na poupança para sacar'], 400);
        }

        // ✅ Bloqueia saque baseado no `last_deposit_update`, e não no `last_interest_update`
        $lastDepositUpdate = Carbon::parse($wallet->last_deposit_update ?? now()->subDay());
        if ($lastDepositUpdate->diffInHours(now()) < 24) {
            Log::warning("⏳ Tentativa de saque antes de 24h - Último depósito em: {$lastDepositUpdate}");
            return response()->json(['error' => 'Os saques só podem ser feitos 24 horas após o último depósito'], 400);
        }

        if ($wallet->balance_savings >= $withdrawAmount && $withdrawAmount > 0) {
            $wallet->decrement('balance_savings', $withdrawAmount);
            $wallet->increment('balance_withdrawal', $withdrawAmount);
            Log::info("✅ Saque de R$ {$withdrawAmount} da poupança concluído!");
        } else {
            Log::warning("⚠️ Saldo insuficiente para saque de R$ {$withdrawAmount} - User ID: {$userId}");
            return response()->json(['error' => 'Saldo insuficiente para saque'], 400);
        }
    }
    
    // 🔹 Buscar os depósitos na poupança do usuário
$savingsDeposits = Transaction::where('user_id', $userId)
    ->where('deposit_savings', 1) // Apenas depósitos na poupança
    ->orderBy('created_at', 'desc')
    ->get(['savings_amount', 'created_at']); // Pegando os campos necessários
    

    // ✅ Retorno da resposta com os valores atualizados
    return response()->json([
        'wallet' => [
            'balance_total' => $wallet->balance_total,
            'balance_withdrawal' => $wallet->balance_withdrawal,
            'balance_savings' => $wallet->balance_savings,
            'savings_interest' => $wallet->savings_interest,
        ],
        'earnings' => $earned ?? 0,
        'totalBets' => $totalBets,
        'sumBets' => $sumBets,
        
        'required_bets' => $required_bets,
        'hoursSinceLastUpdate' => $hoursSinceLastUpdate,
        'last_deposit_update' => $wallet->last_deposit_update,
        'savings_deposits' => $savingsDeposits, // Enviando as transações para o Vue
        'currentLevel' => $currentLevel,


    ], 200);
}







    /**
     * @param $id
     * @return \Illuminate\Http\JsonResponse|void
     */
    public function setWalletActive($id)
    {
        $checkWallet = Wallet::whereUserId(auth('api')->id())->where('active', 1)->first();
        if (!empty($checkWallet)) {
            $checkWallet->update(['active' => 0]);
        }

        $wallet = Wallet::find($id);
        if (!empty($wallet)) {
            $wallet->update(['active' => 1]);
            return response()->json(['wallet' => $wallet], 200);
        }
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function requestWithdrawal(Request $request)
    {
        $setting = Setting::first();

        /// Verificar se é afiliado
        if (auth('api')->check()) {

            if ($request->type === 'pix') {
                $rules = [
                    'amount'        => ['required', 'numeric', 'min:'.$setting->min_withdrawal, 'max:'.$setting->max_withdrawal],
                    'pix_type'      => 'required',
                    'accept_terms'  => 'required',
                    'cpf' => ['required', 'string', 'min:11'],
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
            }

            if ($request->type === 'bank') {
                $rules = [
                    'amount'        => ['required', 'numeric', 'min:'.$setting->min_withdrawal, 'max:'.$setting->max_withdrawal],
                    'bank_info'     => 'required',
                    'accept_terms'  => 'required',
                ];
            }

            $validator = Validator::make($request->all(), $rules);

            if ($validator->fails()) {
                return response()->json($validator->errors(), 400);
            }

            if ($request->amount < 0) {
                return response()->json(['error' => 'Você tem que solicitar um valor'], 400);
            }

            /// verificar o limite de saque
            if (!empty($setting->withdrawal_limit) && !empty($setting->withdrawal_period)) {
                switch ($setting->withdrawal_period) {
                    case 'daily':
                        $registrosDiarios = Withdrawal::where('user_id', auth('api')->user()->id)->whereDate('created_at', now()->toDateString())->count();
                        if ($registrosDiarios >= $setting->withdrawal_limit) {
                            return response()->json(['error' => trans('You have already reached the daily withdrawal limit')], 400);
                        }
                        break;
                    case 'weekly':
                        $registrosDiarios = Withdrawal::where('user_id', auth('api')->user()->id)->whereBetween('created_at', [now()->startOfWeek(), now()->endOfWeek()])->count();
                        if ($registrosDiarios >= $setting->withdrawal_limit) {
                            return response()->json(['error' => trans('You have already reached the weekly withdrawal limit')], 400);
                        }
                        break;
                    case 'monthly':
                        $registrosDiarios = Withdrawal::where('user_id', auth('api')->user()->id)->whereYear('created_at', now()->year)->whereMonth('data', now()->month)->count();
                        if ($registrosDiarios >= $setting->withdrawal_limit) {
                            return response()->json(['error' => trans('You have already reached the monthly withdrawal limit')], 400);
                        }
                        break;
                    case 'yearly':
                        $registrosDiarios = Withdrawal::where('user_id', auth('api')->user()->id)->whereYear('created_at', now()->year)->count();
                        if ($registrosDiarios >= $setting->withdrawal_limit) {
                            return response()->json(['error' => trans('You have already reached the yearly withdrawal limit')], 400);
                        }
                        break;
                }
            }

            if ($request->amount > $setting->max_withdrawal) {
                return response()->json(['error' => 'Você excedeu o limite máximo permitido de: '. $setting->max_withdrawal], 400);
            }

            if ($request->accept_terms == true) {
                $user = auth('api')->user();
                // Atualiza o CPF do usuário, caso ainda não esteja salvo ou queira sobrescrever
                if (empty($user->cpf)) {
                    $user->cpf = $request->cpf;
                    $user->save();
                }

                $wallet = auth('api')->user()->wallet;
                $amount = floatval($request->amount);
            
                // Verifica se a soma dos saldos é suficiente
                $totalBalance = floatval($wallet->balance) + floatval($wallet->balance_withdrawal);
                if ($amount > $totalBalance) {
                    return response()->json(['error' => 'Você não tem saldo suficiente'], 400);
                }
            
                // Dados do saque
                $data = [
                    'user_id'   => auth('api')->user()->id,
                    'amount'    => \Helper::amountPrepare($amount),
                    'type'      => $request->type,
                    'currency'  => $request->currency,
                    'symbol'    => $request->symbol,
                    'status'    => 0,
                ];
            
                if ($request->type === 'pix') {
                    $data['pix_key']  = $request->pix_key;
                    $data['pix_type'] = $request->pix_type;
                } elseif ($request->type === 'bank') {
                    $data['bank_info'] = $request->bank_info;
                }
            
                $withdrawal = Withdrawal::create($data);
            
                if ($withdrawal) {
                    // Desconta primeiro de balance_withdrawal, depois de balance
                    $fromWithdrawal = min($amount, $wallet->balance_withdrawal);
                    $remaining = $amount - $fromWithdrawal;
            
                    $wallet->decrement('balance_withdrawal', $fromWithdrawal);
            
                    if ($remaining > 0) {
                        $wallet->decrement('balance', $remaining);
                    }
            
                    // Notificar admins
                    $admins = User::where('role_id', 0)->get();
                    foreach ($admins as $admin) {
                        $admin->notify(new NewWithdrawalNotification(auth()->user()->name, $amount));
                    }
            
                    return response()->json([
                        'status' => true,
                        'message' => 'Saque realizado com sucesso',
                        'creationTime' => $withdrawal->created_at->format('Y-m-d H:i:s'),
                        'orderNumber' => str_pad(mt_rand(0, 9999999999999999), 16, '0', STR_PAD_LEFT),
                    ], 200);
                }
            
                return response()->json(['error' => 'Erro ao salvar saque'], 400);
            }


            return response()->json(['error' => 'Você precisa aceitar os termos'], 400);
        }

        return response()->json(['error' => 'Erro ao realizar o saque'], 400);
    }
    
    
    
    public function claimBetReward(Request $request)
{
    $userId = auth('api')->id();
    $wallet = Wallet::where('user_id', $userId)->first();

    if (!$wallet) {
        return response()->json(['error' => 'Carteira não encontrada'], 404);
    }

    // 📌 Verifica o total apostado pelo usuário
    $totalBets = GGRGames::where('user_id', $userId)->sum('balance_bet');

    if ($totalBets <= 0) {
        return response()->json(['error' => 'Nenhuma aposta encontrada'], 400);
    }

    // 📌 Define o valor do bônus (2% do total apostado)
    $bonusAmount = $totalBets * 0.02;

    // 📌 Cria uma chave única para evitar resgates duplicados
    $cacheKey = "claimed_bet_reward_{$userId}";

    if (Cache::has($cacheKey)) {
        return response()->json(['error' => 'Bônus já resgatado! Faça novas apostas para resgatar novamente.'], 400);
    }

    // 📌 Adiciona o bônus ao saldo de saque do usuário
    $wallet->increment('balance_withdrawal', $bonusAmount);

    // 📌 Salva no cache que o usuário já resgatou esse bônus
    Cache::put($cacheKey, true, now()->addHours(24)); // O usuário pode resgatar novamente após novas apostas

    Log::info("🎉 Usuário {$userId} resgatou R$ {$bonusAmount} de bônus das apostas.");

    return response()->json([
        'message' => 'Bônus resgatado com sucesso!',
        'bonus' => $bonusAmount,
        'wallet' => [
            'balance_total' => $wallet->balance_total,
            'balance_withdrawal' => $wallet->balance_withdrawal,
            'balance_savings' => $wallet->balance_savings,
        ],
    ]);
}

public function checkClaimStatus()
{
    $userId = auth('api')->id();
    $cacheKey = "claimed_bet_reward_{$userId}";
    
    // Calcula o bônus disponível baseado no total de apostas
    $totalBets = GGRGames::where('user_id', $userId)->sum('balance_bet');
    $bonusAmount = $totalBets * 0.02; // 2% do total apostado

 // Se o bônus já foi claimado, retorna 0
    if (Cache::has($cacheKey)) {
        $bonusAmount = 0.00;
    }

    return response()->json([
        'claimed' => Cache::has($cacheKey),
        'bonus' => $bonusAmount // ✅ Agora envia o bônus antes mesmo de ser claimado
    ]);
}

public function getUserBetReport()
{
    $userId = auth('api')->id();

    if (!$userId) {
        return response()->json(['error' => 'Usuário não autenticado'], 401);
    }

    $bets = DB::table('ggr_games')
        ->select('game', 'balance_bet', 'balance_loss', 'created_at', 'balance_win')
        ->where('user_id', $userId)
        ->orderBy('created_at', 'desc')
        ->get();

    if ($bets->isEmpty()) {
        return response()->json(['message' => 'Nenhuma aposta encontrada.']);
    }

    // Garantir que os valores sejam numéricos antes de enviar
    $bets = $bets->map(function ($bet) {
        return [
            'game' => $bet->game,
            'balance_bet' => (float) $bet->balance_bet,
            'balance_loss' => (float) $bet->balance_loss,
            'created_at' => $bet->created_at,
            'balance_win' => (float) $bet->balance_win,
        ];
    });

    return response()->json(['bets' => $bets], 200);
}




public function claimLossBonus(Request $request)
{
    $userId = auth('api')->id();

    if (!$userId) {
        return response()->json(['error' => 'Usuário não autenticado'], 401);
    }

    // Gerar chave de cache para evitar múltiplos resgates
    $cacheKey = "claimed_loss_bonus_{$userId}";

    if (Cache::has($cacheKey)) {
        \Log::warning("⚠️ Usuário ID {$userId} já resgatou o bônus de perdas anteriormente.");
        return response()->json(['error' => 'Você já resgatou este bônus!'], 400);
    }

    \Log::info("🔎 Usuário ID: {$userId} tentando resgatar bônus de perdas...");

   $lossData = DB::table('ggr_games')
    ->where('user_id', $userId)
    ->selectRaw('GREATEST(SUM(balance_loss), 0) as total_loss')
    ->first();


    $totalLoss = $lossData->total_loss ?? 0;

    if ($totalLoss < 100) {
        \Log::warning("⚠️ Usuário ID {$userId} não possui perdas suficientes para resgatar bônus.");
        return response()->json(['error' => 'Você não perdeu o suficiente para resgatar um bônus.'], 400);
    }

    // Tabela de bônus baseada em perdas
    $bonusTable = [
        100 => 1,
        300 => 2,
        500 => 3,
        1000 => 10,
        3000 => 20,
        6000 => 50,
        10000 => 100,
        30000 => 200,
        50000 => 500,
        100000 => 5000
    ];

    // Determinar o bônus a partir da maior perda qualificada
    $bonusAmount = 0;
    foreach ($bonusTable as $lossThreshold => $bonus) {
        if ($totalLoss >= $lossThreshold) {
            $bonusAmount = $bonus;
        }
    }

    // Buscar a carteira do usuário
    $wallet = Wallet::where('user_id', $userId)->first();

    if (!$wallet) {
        \Log::error("❌ Carteira não encontrada para user_id: {$userId}");
        return response()->json(['error' => 'Carteira não encontrada'], 404);
    }

    // Aplicar o bônus na carteira
    $wallet->increment('balance_bonus', $bonusAmount);

    // Salvar no cache para evitar múltiplos resgates
    Cache::put($cacheKey, true, now()->addYear()); // ✅ Cache expira em 1 ano

    \Log::info("🎉 Bônus de R$ {$bonusAmount} adicionado para user_id: {$userId} devido a perdas de R$ {$totalLoss}");

    return response()->json([
        'message' => "Bônus de perdas reivindicado com sucesso!",
        'bonus_received' => $bonusAmount,
        'total_loss' => $totalLoss,
        'wallet' => [
            'balance_bonus' => $wallet->balance_bonus
        ]
    ]);
}

public function checkLossClaimStatus(Request $request)
{
    $userId = auth('api')->id();

    if (!$userId) {
        return response()->json(['error' => 'Usuário não autenticado'], 401);
    }

    // Gerar chave de cache para verificar se o usuário já resgatou o bônus
    $cacheKey = "claimed_loss_bonus_{$userId}";
    $hasClaimed = Cache::has($cacheKey);

     $lossData = DB::table('ggr_games')
    ->where('user_id', $userId)
    ->selectRaw('GREATEST(SUM(balance_loss), 0) as total_loss')
    ->first();

    $totalLoss = $lossData->total_loss ?? 0;

    // Se a perda for menor que 100, não há bônus disponível
    if ($totalLoss < 100) {
        return response()->json([
            'claimed' => $hasClaimed,
            'bonus' => 0.00,
            'lossAmount' => $totalLoss
        ]);
    }

    // Tabela de bônus baseada em perdas
    $bonusTable = [
        100 => 1,
        300 => 2,
        500 => 3,
        1000 => 10,
        3000 => 20,
        6000 => 50,
        10000 => 100,
        30000 => 200,
        50000 => 500,
        100000 => 5000
    ];

    // Determinar o bônus com base na maior perda qualificada
    $bonusAmount = 0;
    foreach ($bonusTable as $lossThreshold => $bonus) {
        if ($totalLoss >= $lossThreshold) {
            $bonusAmount = $bonus;
        }
    }

    return response()->json([
        'claimed' => $hasClaimed,
        'bonus' => $hasClaimed ? 0.00 : $bonusAmount, // Retorna 0 se já foi resgatado
        'lossAmount' => $totalLoss
    ]);
}



public function getUserBetAndDepositInfo(Request $request)
{
    $userId = auth('api')->id();

    if (!$userId) {
        Log::error("🔴 Erro: Usuário não autenticado ao tentar buscar informações de apostas e depósitos.");
        return response()->json(['error' => 'Usuário não autenticado'], 401);
    }

    Log::info("✅ Usuário autenticado: {$userId}");

    // ✅ Obtém o total de depósitos aprovados do usuário
    $totalDeposits = Deposit::where('user_id', $userId)
        ->where('status', 1) // Filtra apenas depósitos aprovados
        ->sum('amount');
        
    // ✅ Obtém o último depósito do usuário
    $lastDeposit = Deposit::where('user_id', $userId)
        ->where('status', 1)
        ->orderBy('created_at', 'desc') // Ordena do mais recente para o mais antigo
        ->first();
        
    $lastDepositTime = $lastDeposit ? $lastDeposit->created_at->format('H:i:s') : null; // 🔥 Formata para HH:MM
        

    // ✅ Obtém o total de apostas (bets) do usuário na tabela `ggr_games`
    $totalBets = DB::table('ggr_games')
        ->where('user_id', $userId)
        ->sum('balance_loss');

    // ✅ Obtém o balance_deposit_rollover da tabela `wallets`
    $balanceDepositRollover = DB::table('wallets')
        ->where('user_id', $userId)
        ->value('balance_deposit_rollover');

    // ✅ Retorna os dados para o Vue.js ou outra interface
    return response()->json([
        'total_deposits' => $totalDeposits, // 🔥 Total de depósitos
        'total_bets' => $totalBets, // 🔥 Total de apostas
        'balance_deposit_rollover' => $balanceDepositRollover ?? 0, // 🔥 Se não encontrar, retorna 0
        'last_deposit_time' => $lastDepositTime, // 🔥 Horário do último depósito

    ]);
}


    public function hasDeposit()
    {
    $userId = auth('api')->id();

        $hasDeposit = Deposit::where('user_id', $userId)
            ->where('status', 1)
            ->exists(); // Verifica se há pelo menos um depósito aprovado

        return response()->json([
            'has_deposit' => $hasDeposit
        ]);
    }

    // Função POST para transferir saldo para a coluna 'partnership'
    public function transferToPartnership(Request $request)
    {
    $userId = auth('api')->id();
        $amount = $request->input('amount'); // Valor que o usuário quer transferir

        // Buscar a carteira do usuário
        $wallet = Wallet::where('user_id', $userId)->first();

        if (!$wallet) {
            return response()->json(['error' => 'Carteira não encontrada.'], 404);
        }

        // Verifica se o saldo é suficiente
        if ($wallet->balance + $wallet->balance_withdrawal < $amount) {
            return response()->json(['error' => 'Saldo insuficiente.'], 400);
        }

        // Se possível, desconta primeiro do balance, depois do balance_withdrawal
        if ($wallet->balance >= $amount) {
            $wallet->balance -= $amount;
        } else {
            $remaining = $amount - $wallet->balance;
            $wallet->balance = 0;
            $wallet->balance_withdrawal -= $remaining;
        }

        // Adiciona o valor à partnership
        $wallet->partnership += $amount;
        $wallet->save();

        return response()->json([
            'message' => 'Parceria solicitada com êxito!',
            'balance' => $wallet->balance,
            'balance_withdrawal' => $wallet->balance_withdrawal,
            'partnership' => $wallet->partnership
        ]);
    }

    
    
}
