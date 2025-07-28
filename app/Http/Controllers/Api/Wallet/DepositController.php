<?php

namespace App\Http\Controllers\Api\Wallet;

use App\Http\Controllers\Controller;
use App\Models\Setting;
use App\Models\Deposit;
use App\Models\Wallet;
use App\Traits\Gateways\DigitoPayTrait;
use App\Traits\Gateways\MercadoPagoTrait;
use App\Traits\Gateways\SharkPayTrait;
use App\Traits\Gateways\SuitpayTrait;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;

class DepositController extends Controller
{
    use SuitpayTrait, SharkPayTrait, MercadoPagoTrait, DigitoPayTrait;

    /**
     * @param Request $request
     * @return array|false[]
     */
    public function submitPayment(Request $request)
    {
        \Log::info($request->gateway);
        $response = null;
        
        switch ($request->gateway) {
            case 'digitopay':
                $response = self::digitoPayRequestQrcode($request);
                break;
            case 'mercadopago':
                $response = self::requestQrcodeMercadoPago($request);
                break;
            case 'sharkpay':
                $response = self::requestQrcodeSharkPay($request);
                break;
            case 'suitpay':
                $response = self::requestQrcode($request);
                break;
        }

        if ($response) {
            return response()->json([
                'qrcode' => $response['qrcode'],
                'created_at' => now(), // Retornando a data e hora atual como exemplo
            ]);
        }

        return response()->json(['error' => 'Failed to process payment'], 400);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function consultStatusTransactionPix(Request $request)
    {
        return self::consultStatusTransaction($request);
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $deposits = Deposit::select('amount', 'created_at', 'currency', 'id', 'status', 'symbol', 'type', 'updated_at', 'user_id')
                        ->whereUserId(auth('api')->id())
                        ->paginate();
        return response()->json(['deposits' => $deposits], 200);
    }
    
    
    public function claimDepositBonus(Request $request)
{
    $userId = auth('api')->id();

    if (!$userId) {
        return response()->json(['error' => 'Usuário não autenticado'], 401);
    }

    // Gerar a chave de cache para esse usuário
    $cacheKey = "claimed_deposit_bonus_{$userId}";

    // Verificar se o usuário já resgatou o bônus
    if (Cache::has($cacheKey)) {
        \Log::warning("⚠️ Usuário ID {$userId} já resgatou o bônus anteriormente.");
        return response()->json(['error' => 'Você já resgatou este bônus!'], 400);
    }

    \Log::info("🔎 Usuário ID: {$userId} tentando resgatar bônus...");

    // Tabela de bônus com valores esperados
    $bonusTable = [
        50 => 1,
        100 => 3,
        500 => 17,
        1000 => 27,
        5000 => 77,
        10000 => 277,
        50000 => 888,
        100000 => 1777,
        200000 => 3777,
    ];

    // Buscar depósito mais recente do usuário com status 1 (aprovado)
    $deposit = Deposit::where('user_id', $userId)
        ->where('status', 1)
        ->whereIn('amount', array_keys($bonusTable))
        ->latest()
        ->first();

    if (!$deposit) {
        \Log::warning("⚠️ Nenhum depósito válido encontrado para user_id: {$userId}");
        return response()->json(['error' => 'Nenhum depósito válido encontrado'], 400);
    }

    // Converter amount para inteiro
    $depositAmount = (int) $deposit->amount;

    \Log::info("✅ Depósito encontrado - Valor: {$depositAmount}, Status: {$deposit->status}");

    // Determinar o valor do bônus
    $bonusAmount = $bonusTable[$depositAmount];

    // Buscar a carteira do usuário
    $wallet = Wallet::where('user_id', $userId)->first();

    if (!$wallet) {
        \Log::error("❌ Carteira não encontrada para user_id: {$userId}");
        return response()->json(['error' => 'Carteira não encontrada'], 404);
    }

    // Aplicar o bônus na carteira
    $wallet->increment('balance_bonus', $bonusAmount);
    $wallet->increment('balance_bonus_rollover', $bonusAmount);

    // Salvar no cache para evitar múltiplos resgates
    Cache::put($cacheKey, true, now()->addYear()); // ✅ Cache expira em 1 ano

    \Log::info("🎉 Bônus de R$ {$bonusAmount} adicionado para user_id: {$userId}");

    return response()->json([
        'message' => "Reivindicado com êxito!",
        'bonus_received' => $bonusAmount,
        'wallet' => [
            'balance_bonus' => $wallet->balance_bonus,
            'balance_bonus_rollover' => $wallet->balance_bonus_rollover
        ]
    ]);
}

public function checkClaimStatus(Request $request)
{
    $userId = auth('api')->id();

    if (!$userId) {
        return response()->json(['error' => 'Usuário não autenticado'], 401);
    }

    // Gerar a chave de cache para esse usuário
    $cacheKey = "claimed_deposit_bonus_{$userId}";
    $hasClaimed = Cache::has($cacheKey); // ✅ Verificação única

    // 🔹 Buscar o último depósito válido do usuário
    $lastDeposit = Deposit::where('user_id', $userId)
        ->where('status', 1)
        ->latest()
        ->first();

    // Se não houver depósito, retorna valores padrão
    if (!$lastDeposit) {
        \Log::warning("⚠️ Nenhum depósito válido encontrado para user_id: {$userId}");
        return response()->json([
            'claimed' => $hasClaimed,
            'bonus' => 0.00,
            'depositAmount' => null // ✅ Mantém nulo para evitar confusão
        ]);
    }

    // 🔹 Definir a tabela de bônus
    $bonusTable = [
        50 => 1, 100 => 3, 500 => 17, 1000 => 27,
        5000 => 77, 10000 => 277, 50000 => 888,
        100000 => 1777, 200000 => 3777,
    ];

    // Determinar valores
    $depositAmount = (int) $lastDeposit->amount;
    $bonusAmount = $bonusTable[$depositAmount] ?? 0;

    \Log::info("✅ Usuário ID {$userId} pode resgatar um bônus de R$ {$bonusAmount}");

    return response()->json([
        'claimed' => $hasClaimed,
        'bonus' => $hasClaimed ? 0.00 : $bonusAmount, // ✅ Retorna 0 se já foi resgatado
        'depositAmount' => $depositAmount // ✅ Sempre retorna o último depósito
    ]);
}

public function hasDeposited()
{
    // Obtém o ID do usuário autenticado via API
    $userId = auth('api')->id();

    // Verifica se o usuário está autenticado
    if (!$userId) {
        return response()->json([
            'error' => 'Usuário não autenticado'
        ], 401);
    }

     // Verifica se há pelo menos um depósito registrado com status = 1
    $hasDeposit = Deposit::where('user_id', $userId)
        ->where('status', 1)
        ->exists();

    return response()->json([
        'has_deposit' => $hasDeposit
    ], 200);
}






    
    
    
    
}
