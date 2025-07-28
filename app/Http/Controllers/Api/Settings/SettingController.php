<?php

namespace App\Http\Controllers\Api\Settings;

use App\Http\Controllers\Controller;
use App\Models\Setting;
use App\Models\User;
use App\Models\Vip;
use App\Models\VipUser;
use App\Models\GGRGames;
use App\Models\PixComplaint;
use App\Models\Wallet;
use App\Models\PixAccount;
use App\Models\Deposit;
use App\Models\Withdrawal;
use App\Models\Transaction;
use App\Models\DailyCheckin;
use App\Notifications\NewWithdrawalNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;



class SettingController extends Controller
{

    public function index()
    {
        $setting = Setting::first();
        return response()->json(['setting' => $setting], 200);
    }

    public function getPromotionTexts()
    {
        $setting = Setting::first();
        return response()->json([
            'promotion_text' => $setting->promotion_text,
            'promotion_button_text' => $setting->promotion_button_text,
        ]);
    }

  
    public function updatePromotionTexts(Request $request)
    {
        $request->validate([
            'promotion_text' => 'nullable|string',
            'promotion_button_text' => 'nullable|string',
        ]);

        $setting = Setting::first();
        $setting->promotion_text = $request->promotion_text;
        $setting->promotion_button_text = $request->promotion_button_text;
        $setting->save();

        return response()->json(['message' => 'Promotion texts updated successfully!']);
    }
    
    
    
    public function updateAvatar(Request $request)
{
    // Validação
    $validated = $request->validate([
        'user_id' => 'required|exists:users,id',
        'avatar' => 'required|url',
    ]);

    // Buscar usuário
    $user = User::find($validated['user_id']);

    if (!$user) {
        \Log::error("🚨 Usuário com ID {$validated['user_id']} não encontrado.");
        return response()->json([
            'success' => false,
            'message' => 'Usuário não encontrado.',
        ], 404);
    }

    // Atualiza o avatar
    $user->update(['avatar' => $validated['avatar']]);

    return response()->json([
        'success' => true,
        'message' => 'Avatar atualizado com sucesso!',
        'avatar' => $user->avatar,
    ]);
}

public function getBetMissions(Request $request)
{
    $userId = auth('api')->id(); // Obtém apenas o ID do usuário autenticado

    if (!$userId) {
        return response()->json(['error' => 'Usuário não autenticado'], 401);
    }

    // Obtendo os depósitos do usuário
    $deposits = Deposit::where('user_id', $userId)
        ->where('status', 1)
        ->sum('amount');

    // Obtendo o balance_bet da tabela GGRGames
    $balanceBet = GGRGames::where('user_id', $userId)->sum('balance_bet');

    // Obtendo o saldo do usuário
    $wallet = Wallet::where('user_id', $userId)->first();
    $currentBalance = $wallet ? ($wallet->balance_withdrawal + $wallet->balance) : 0;

    return response()->json([
        'deposits' => $deposits,
        'balance_bet' => $balanceBet,
        'current_balance' => $currentBalance,
    ]);
}


public function submitPixComplaint(Request $request)
{
    $userId = auth('api')->id(); // Pegando o ID do usuário autenticado

    if (!$userId) {
        return response()->json(['error' => 'Usuário não autenticado'], 401);
    }

    // Recuperando a última chave Pix cadastrada na tabela pix_accounts
    $lastPixAccount = DB::table('pix_accounts')
                        ->where('user_id', $userId)
                        ->latest('created_at')
                        ->first();

    if (!$lastPixAccount) {
        return response()->json(['error' => 'Nenhuma chave Pix cadastrada.'], 400);
    }

    // Verifica qual campo contém a chave Pix válida (email, phone ou cpf)
    $pixKey = $lastPixAccount->email ?? $lastPixAccount->phone ?? $lastPixAccount->cpf ?? null;

    if (!$pixKey) {
        return response()->json(['error' => 'A chave Pix cadastrada está vazia ou inválida.'], 400);
    }

    // Validação dos dados recebidos
    $validator = Validator::make($request->all(), [
        'amount' => 'required|numeric|min:0.01',
        'complaint' => 'required|string|max:500',
        'data_deposito' => 'required|', // Validação com formato correto

    ]);

    if ($validator->fails()) {
        return response()->json(['errors' => $validator->errors()], 422);
    }

    // Criando a reclamação com a chave Pix correta
    $complaint = PixComplaint::create([
        'user_id' => $userId,
        'amount' => $request->amount,
        'pix_account' => $pixKey, // Agora armazenamos a chave Pix correta
        'complaint' => $request->complaint,
        'data_deposito' => $request->data_deposito, // Novo campo sendo salvo

    ]);

    return response()->json([
        'message' => 'Reclamação registrada com sucesso!',
        'data' => $complaint
    ], 201);
}


public function getPixAccounts()
{
    $userId = auth('api')->id();

    if (!$userId) {
        Log::error("🔴 Erro: Usuário não autenticado ao tentar buscar chaves Pix.");
        return response()->json(['error' => 'Usuário não autenticado'], 401);
    }

    Log::info("✅ Usuário autenticado: {$userId}");

    try {
        // Buscar todas as chaves Pix do usuário
        $pixAccounts = DB::table('pix_accounts')
                        ->where('user_id', $userId)
                        ->select('type', 'email', 'phone', 'cpf')
                        ->get();

        Log::info("🔍 Registros encontrados na tabela pix_accounts:", $pixAccounts->toArray());

        // Se não houver registros, retorna erro
        if ($pixAccounts->isEmpty()) {
            Log::warning("⚠️ Nenhuma chave Pix encontrada para o usuário ID: {$userId}");
            return response()->json(['pix_accounts' => [], 'error' => 'Nenhuma chave Pix cadastrada.']);
        }

        // Formatar a resposta para Vue.js
        $formattedAccounts = [];
        foreach ($pixAccounts as $account) {
            if (!empty($account->email)) {
                $formattedAccounts[] = ['type' => 'PIX', 'value' => $account->email];
            }
            if (!empty($account->phone)) {
                $formattedAccounts[] = ['type' => 'PIX', 'value' => $account->phone];
            }
            if (!empty($account->cpf)) {
                $formattedAccounts[] = ['type' => 'PIX', 'value' => $account->cpf];
            }
        }

        Log::info("🟢 Lista formatada enviada para Vue.js:", $formattedAccounts);

        return response()->json([
            'pix_accounts' => $formattedAccounts
        ]);

    } catch (\Exception $e) {
        Log::error("❌ Erro ao buscar chaves Pix:", ['message' => $e->getMessage()]);
        return response()->json(['error' => 'Erro ao buscar chaves Pix.'], 500);
    }
}




public function getUserDeviceInfo(Request $request)
{
    // Obtém o User-Agent
    $userAgent = $request->header('User-Agent');

    // Obtém o IP do usuário
    $userIp = $request->ip();

    // Obtém informações de geolocalização do IP (usando API externa)
    $geoData = Http::get("http://ip-api.com/json/{$userIp}")->json();

    // Pega a localização formatada
    $location = isset($geoData['status']) && $geoData['status'] === 'success'
        ? "{$geoData['country']}/{$geoData['regionName']}-{$geoData['city']}"
        : 'Desconhecido';

    // Detecta o tipo de dispositivo e SO
    $device = 'Desconhecido';
    $os = 'Desconhecido';
    $appVersion = 'v5.5.7';

    if (strpos($userAgent, 'iPhone') !== false) {
        $device = 'iPhone';
        preg_match('/OS (\d+_\d+)/', $userAgent, $matches);
        $os = isset($matches[1]) ? 'iOS ' . str_replace('_', '.', $matches[1]) : 'iOS';
    } elseif (strpos($userAgent, 'Android') !== false) {
        $device = 'Android';
        preg_match('/Android (\d+\.\d+)/', $userAgent, $matches);
        $os = isset($matches[1]) ? 'Android ' . $matches[1] : 'Android';
    } elseif (strpos($userAgent, 'Windows') !== false) {
        $device = 'PC';
        $os = 'Windows';
    } elseif (strpos($userAgent, 'Macintosh') !== false) {
        $device = 'Mac';
        $os = 'macOS';
    }

    // Se a versão do app for enviada via header, capturamos
    if ($request->hasHeader('App-Version')) {
        $appVersion = $request->header('App-Version');
    }

    return response()->json([
        'app' => 'H5',
        'version' => $appVersion,
        'device_type' => $device,
        'os' => $os,
        'ip' => $userIp,
        'location' => $location,
        'login_time' => now()->timezone('America/Sao_Paulo')->format('d/m/Y H:i:s')
    ]);
}



public function checkIn(Request $request)
{
    $userId = auth('api')->id();

    if (!$userId) {
        return response()->json(['error' => 'Usuário não autenticado'], 401);
    }

    // ✅ Obtém o total de depósitos aprovados do usuário
    $totalDeposits = Deposit::where('user_id', $userId)
        ->where('status', 1) // Filtra apenas depósitos aprovados
        ->sum('amount');

    // ✅ Obtém o total de apostas do usuário na tabela `ggr_games`
    $totalBets = DB::table('ggr_games')
        ->where('user_id', $userId)
        ->sum('balance_bet');

    // ✅ Verifica se o usuário atende aos requisitos mínimos para check-in
    if ($totalDeposits < 50) {
        return response()->json(['error' => 'Depósito mínimo de R$50 não atingido.'], 400);
    }

    if ($totalBets < 1000) {
        return response()->json(['error' => 'Aposta mínima de R$1.000 não atingida.'], 400);
    }

    // ✅ Verifica se o usuário já fez check-in hoje
    $today = Carbon::now()->format('Y-m-d');
    $alreadyCheckedIn = DailyCheckin::where('user_id', $userId)
        ->whereDate('checkin_date', $today)
        ->exists();

    if ($alreadyCheckedIn) {
        return response()->json(['error' => 'Check-in já realizado hoje.'], 409);
    }

    // ✅ Prêmios por dia (exemplo)
    $rewardsByDay = [1, 3, 9, 15, 17, 27, 47]; // Prêmios para cada dia

    // ✅ Obtém o número de check-ins já feitos para definir o prêmio do próximo check-in
    $checkinCount = DailyCheckin::where('user_id', $userId)->count();
    $rewardAmount = isset($rewardsByDay[$checkinCount]) ? $rewardsByDay[$checkinCount] : 0;

    // ✅ Salva o check-in com a recompensa
    DailyCheckin::create([
        'user_id' => $userId,
        'checkin_date' => $today,
        'rewards' => $rewardAmount
    ]);

    // ✅ Atualiza a carteira do usuário (wallet.balance_bonus)
    DB::table('wallets')
        ->where('user_id', $userId)
        ->increment('balance_bonus', $rewardAmount);

    return response()->json([
        'success' => 'Check-in realizado com sucesso!',
        'reward' => $rewardAmount,
        'next_day' => $checkinCount + 1
    ], 200);
}



    public function getCheckInStatus(Request $request)
{
    $userId = auth('api')->id();

    if (!$userId) {
        Log::error("🔴 Erro: Usuário não autenticado ao tentar buscar status do check-in.");
        return response()->json(['error' => 'Usuário não autenticado'], 401);
    }

    Log::info("✅ Usuário autenticado: {$userId}");

    // Obtém todos os check-ins do usuário
    $checkins = DailyCheckin::where('user_id', $userId)
        ->orderBy('checkin_date', 'desc')
        ->get();

    // Obtém o número de check-ins consecutivos
    $consecutiveDays = 0;
    $previousDate = null;

    foreach ($checkins as $checkin) {
        if ($previousDate === null || $previousDate->diffInDays($checkin->checkin_date) === 1) {
            $consecutiveDays++;
            $previousDate = Carbon::parse($checkin->checkin_date);
        } else {
            break;
        }
    }

    // ✅ Obtém o total de depósitos aprovados do usuário
    $totalDeposits = Deposit::where('user_id', $userId)
        ->where('status', 1)
        ->sum('amount');

    // ✅ Obtém o total de apostas do usuário na tabela `ggr_games`
    $totalBets = DB::table('ggr_games')
        ->where('user_id', $userId)
        ->sum('balance_bet');
        
        
        // ✅ Soma total das recompensas (`rewards`) recebidas nos check-ins
    $totalRewards = DailyCheckin::where('user_id', $userId)->sum('rewards');

    // ✅ Determina o próximo dia de check-in
    $nextCheckInDay = $checkins->count() + 1;

    // ✅ Retorna os dados para o Vue.js
    return response()->json([
        'checkins_consecutive' => $consecutiveDays,
        'checkins_total' => $checkins->count(),
        'total_deposits' => $totalDeposits, // 🔥 Total de depósitos
        'total_bets' => $totalBets, // 🔥 Total de apostas
        'total_rewards' => $totalRewards, // 🔥 Total de recompensas recebidas
        'next_checkin_day' => $nextCheckInDay // 🔥 Próximo dia para check-in
    ]);
}





    
}
