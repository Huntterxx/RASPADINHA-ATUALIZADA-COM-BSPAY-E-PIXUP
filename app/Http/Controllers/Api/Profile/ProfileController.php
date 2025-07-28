<?php

namespace App\Http\Controllers\Api\Profile;

use App\Http\Controllers\Controller;
use App\Models\Deposit;
use App\Models\GGRGames;
use App\Models\Order;
use App\Models\Wallet;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;

class ProfileController extends Controller
{
    // Outros métodos já existentes...

    /**
     * Criação da senha de saque.
     */
    public function createWithdrawPassword(Request $request)
    {
        $user = auth('api')->user();

        $request->validate([
            'password' => 'required|min:6',
        ]);

        // Hasheando e salvando a senha de saque
        $user->withdraw_password = Hash::make($request->password);
        $user->save();

        return response()->json(['message' => 'Senha de saque criada com sucesso.'], 200);
    }

    /**
     * Verificação da senha de saque.
     */
    public function verifyWithdrawPassword(Request $request)
    {
        $user = auth('api')->user();

        $request->validate([
            'password' => 'required',
        ]);

        // Verificando se a senha está correta
        if (Hash::check($request->password, $user->withdraw_password)) {
            return response()->json(['message' => 'Senha verificada com sucesso.'], 200);
        } else {
            return response()->json(['message' => 'Senha incorreta.'], 403);
        }
    }

    /**
     * Verifica se o usuário já tem uma senha de saque configurada.
     */
    public function hasWithdrawPassword()
    {
        $user = auth('api')->user();

        return response()->json([
            'has_withdraw_password' => !is_null($user->withdraw_password),
        ], 200);
    }
    
    
    
     
    /**
     * Processa o giro da roleta e credita o prêmio na Wallets.
     */
   






    public function getTotalGGRGamesBet()
    {
        $userId = auth('api')->id(); // 🔹 Pegando apenas o ID corretamente
    
        // 🔹 Soma tudo que o usuário jogou na coluna balance_bet
        $totalBet = GGRGames::where('user_id', $userId)->sum('balance_loss');
    
        // 🔹 Log para depuração (opcional)
        \Log::info("Usuário {$userId} total apostado em GGRGames: {$totalBet}");
    
        return response()->json([
            'totalBet' => $totalBet
        ]);
    }


    
    


    public function getWalletBalance()
    {
        $user = auth('api')->user();
    
        if (!$user) {
            return response()->json(['error' => 'Usuário não autenticado'], 400);
        }
    
        $wallet = \App\Models\Wallet::firstOrCreate(['user_id' => $user->id]);
    
        return response()->json([
            'balance' => $wallet->balance,
            'balance_withdrawal' => $wallet->balance_withdrawal,
            'balance_bonus' => $wallet->balance_bonus,
        ]);
    }



public function playScratchCard()
{
    $user = auth('api')->user();
    
    $isBanned = $user->banned == 1;
    
    $wallet = \App\Models\Wallet::firstOrCreate(['user_id' => $user->id]);

    $cost = 1.00;
    $balanceTotal = $wallet->balance + $wallet->balance_withdrawal;

    if ($balanceTotal < $cost) {
        return response()->json(['error' => 'Saldo insuficiente para jogar.'], 400);
    }

    // Desconta o valor
    if ($wallet->balance >= $cost) {
        $wallet->decrement('balance', $cost);
    } else {
        $remaining = $cost - $wallet->balance;
        $wallet->update(['balance' => 0]);
        $wallet->decrement('balance_withdrawal', $remaining);
    }

    // Pool de prêmios com probabilidade individual de vitória
    $itemsPool = [
        ['name' => 'R$15,00',    'value' => 15.00,   'win_chance' => $isBanned ? 10 : 10,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/15_reais_5fbfe586.png')],
        ['name' => 'R$10,00',    'value' => 10.00,   'win_chance' => $isBanned ? 10 : 10,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/10_reais.png')],
        ['name' => 'R$5,00',     'value' => 5.00,    'win_chance' => $isBanned ? 10 : 20,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/5_reais.png')],
        ['name' => 'R$2,00',     'value' => 2.00,    'win_chance' => $isBanned ? 0 : 30,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/2_reais.png')],
        ['name' => 'FONE',       'value' => 50.00,   'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/fone_bluetooth_c2050b7a.webp')],
        ['name' => 'Iphone',     'value' => 2000.00, 'win_chance' => $isBanned ? 0 : 0, 'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/iphone12_white_12897651.webp')],
        ['name' => 'R$150,00',   'value' => 150.00,  'win_chance' => $isBanned ? 10 : 0,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/150_reais_b179f726.png')],
        ['name' => 'JBL',        'value' => 500.00,  'win_chance' => $isBanned ? 10 : 0, 'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/JBL_944de913.webp')],
        ['name' => 'R$100,00',   'value' => 100.00,  'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/100_reais.jpg')],
        ['name' => 'R$1,00',     'value' => 1.00,    'win_chance' => $isBanned ? 0 : 30,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/1_reais.png')],
        ['name' => 'R$50,00',    'value' => 50.00,   'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/50_reais.png')],
        ['name' => 'R$25,00',    'value' => 25.00,   'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/25_reais_1d140f81.png')],
        ['name' => 'R$1000,00',  'value' => 1000.00, 'win_chance' => $isBanned ? 10 : 0, 'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/dinheiro_859419ed.webp')],
    ];

    // Gera pool ponderada com base no win_chance
    $weightedPool = [];
    foreach ($itemsPool as $item) {
        $reps = (int)($item['win_chance'] * 10); // exemplo: 1% = 10 repetições
        for ($i = 0; $i < $reps; $i++) {
            $weightedPool[] = $item;
        }
    }

    $items = [];
    $win = false;
    $value = 0;

    // Sorteio: o jogador vai ganhar?
    $winChanceGlobal = $isBanned ? 45 : 10;
    if (!empty($weightedPool) && mt_rand(1, 100) <= $winChanceGlobal) {
        // Sorteia o item que aparecerá 3x
        $winningItem = $weightedPool[array_rand($weightedPool)];
        $value = $winningItem['value'];

        // Posições aleatórias para o item vencedor
        $indexes = array_rand(range(0, 8), 3);
        if (!is_array($indexes)) $indexes = [$indexes];
        $items = array_fill(0, 9, null);
        foreach ($indexes as $i) {
            $items[$i] = $winningItem;
        }

        // Preenche os demais espaços sem repetir 3x outros itens
        foreach ($items as $i => $slot) {
            if ($slot === null) {
                do {
                    $randItem = $itemsPool[array_rand($itemsPool)];
                    $count = count(array_filter($items, fn($it) => $it && $it['name'] === $randItem['name']));
                } while ($count >= 2);
                $items[$i] = $randItem;
            }
        }

        $wallet->increment('balance_withdrawal', $value);
        if (!$isBanned && $value > 0) {
            $user->increment('earnings', $value);
        }
        $win = true;
    } else {
        // Não ganhou: preenche com prêmios aleatórios sem repetir 3x nenhum
        while (count($items) < 9) {
            $item = $itemsPool[array_rand($itemsPool)];
            $count = count(array_filter($items, fn($i) => $i['name'] === $item['name']));
            if ($count < 2) {
                $items[] = $item;
            }
        }
    }

    return response()->json([
        'items' => $items,
        'win' => $win,
        'value' => $value,
        'newBalance' => $wallet->balance_withdrawal,
    ]);
}

public function playScratchCardCincoMil()
{
    $user = auth('api')->user();
    
    $isBanned = $user->banned == 1;
    
    $wallet = \App\Models\Wallet::firstOrCreate(['user_id' => $user->id]);

    $cost = 2.00;
    $balanceTotal = $wallet->balance + $wallet->balance_withdrawal;

    if ($balanceTotal < $cost) {
        return response()->json(['error' => 'Saldo insuficiente para jogar.'], 400);
    }

    // Desconta o valor
    if ($wallet->balance >= $cost) {
        $wallet->decrement('balance', $cost);
    } else {
        $remaining = $cost - $wallet->balance;
        $wallet->update(['balance' => 0]);
        $wallet->decrement('balance_withdrawal', $remaining);
    }

    // Pool de prêmios com probabilidade individual de vitória
    $itemsPool = [
        ['name' => 'R$3,00',    'value' => 3.00,   'win_chance' => $isBanned ? 0 : 67,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/3_reais.png')],
        ['name' => 'R$5.000,00',    'value' => 5000.00,   'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/saco_dinheiro_4b71930f-1.webp')],
        ['name' => 'R$2.500,00',     'value' => 2500.00,    'win_chance' => $isBanned ? 20 : 0,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/JBL_944de913.webp')],
        ['name' => 'R$5.000,00',     'value' => 5000.00,    'win_chance' => $isBanned ? 10 : 0,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/afe8269c-9c9a-45f7-bb2a-0f710cff2b42.png')],
        ['name' => 'R$600,00',       'value' => 600.00,   'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/fone_bluetooth_c2050b7a.webp')],
        ['name' => 'R$5,00',     'value' => 5.00, 'win_chance' => $isBanned ? 0 : 20, 'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/5_reais.png')],
        ['name' => 'R$150,00',   'value' => 150.00,  'win_chance' => $isBanned ? 10 : 0,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/150_reais_b179f726.png')],
        ['name' => 'R$3.300,00',        'value' => 3300.00,  'win_chance' => $isBanned ? 10 : 0, 'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/73da873b-528a-452b-a9f1-78fa787392af.png')],
        ['name' => 'R$100,00',   'value' => 100.00,  'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/100_reais.jpg')],
        ['name' => 'R$20,00',     'value' => 20.00,    'win_chance' => $isBanned ? 0 : 5,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/20_reais.png')],
        ['name' => 'R$10,00',    'value' => 10.00,   'win_chance' => $isBanned ? 0 : 5,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/10_reais.png')],
        ['name' => 'R$25,00',    'value' => 25.00,   'win_chance' => $isBanned ? 0 : 3,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/25_reais_1d140f81.png')],
        ['name' => 'R$1.000,00',  'value' => 1000.00, 'win_chance' => $isBanned ? 20 : 0, 'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/dinheiro_859419ed.webp')],
    ];

    // Gera pool ponderada com base no win_chance
    $weightedPool = [];
    foreach ($itemsPool as $item) {
        $reps = (int)($item['win_chance'] * 10); // exemplo: 1% = 10 repetições
        for ($i = 0; $i < $reps; $i++) {
            $weightedPool[] = $item;
        }
    }

    $items = [];
    $win = false;
    $value = 0;

    // Sorteio: o jogador vai ganhar?
    $winChanceGlobal = $isBanned ? 30 : 20;
    if (!empty($weightedPool) && mt_rand(1, 100) <= $winChanceGlobal) {
        // Sorteia o item que aparecerá 3x
        $winningItem = $weightedPool[array_rand($weightedPool)];
        $value = $winningItem['value'];

        // Posições aleatórias para o item vencedor
        $indexes = array_rand(range(0, 8), 3);
        if (!is_array($indexes)) $indexes = [$indexes];
        $items = array_fill(0, 9, null);
        foreach ($indexes as $i) {
            $items[$i] = $winningItem;
        }

        // Preenche os demais espaços sem repetir 3x outros itens
        foreach ($items as $i => $slot) {
            if ($slot === null) {
                do {
                    $randItem = $itemsPool[array_rand($itemsPool)];
                    $count = count(array_filter($items, fn($it) => $it && $it['name'] === $randItem['name']));
                } while ($count >= 2);
                $items[$i] = $randItem;
            }
        }

        $wallet->increment('balance_withdrawal', $value);
        if (!$isBanned && $value > 0) {
            $user->increment('earnings', $value);
        }
        $win = true;
    } else {
        // Não ganhou: preenche com prêmios aleatórios sem repetir 3x nenhum
        while (count($items) < 9) {
            $item = $itemsPool[array_rand($itemsPool)];
            $count = count(array_filter($items, fn($i) => $i['name'] === $item['name']));
            if ($count < 2) {
                $items[] = $item;
            }
        }
    }

    return response()->json([
        'items' => $items,
        'win' => $win,
        'value' => $value,
        'newBalance' => $wallet->balance_withdrawal,
    ]);
}

public function playScratchCardDezMil()
{
    $user = auth('api')->user();
    
    $isBanned = $user->banned == 1;
    
    $wallet = \App\Models\Wallet::firstOrCreate(['user_id' => $user->id]);

    $cost = 5.00;
    $balanceTotal = $wallet->balance + $wallet->balance_withdrawal;

    if ($balanceTotal < $cost) {
        return response()->json(['error' => 'Saldo insuficiente para jogar.'], 400);
    }

    // Desconta o valor
    if ($wallet->balance >= $cost) {
        $wallet->decrement('balance', $cost);
    } else {
        $remaining = $cost - $wallet->balance;
        $wallet->update(['balance' => 0]);
        $wallet->decrement('balance_withdrawal', $remaining);
    }

    // Pool de prêmios com probabilidade individual de vitória
    $itemsPool = [
        ['name' => 'R$10.000,00',    'value' => 10000.00,   'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/91ccb792-8a97-4d72-8142-31a98d4a6fa4.png')],
        ['name' => 'R$8.300,00',    'value' => 8300.00,   'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/9652ef5f-6424-4874-8cca-a290cf72423e.png')],
        ['name' => 'R$5,00',     'value' => 5.00,    'win_chance' => $isBanned ? 0 : 65,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/5_reais.png')],
        ['name' => 'R$15,00',     'value' => 15.00,    'win_chance' => $isBanned ? 10 : 20,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/15_reais_5fbfe586.png')],
        ['name' => 'R$800,00',       'value' => 800.00,   'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/fone_bluetooth_c2050b7a.webp')],
        ['name' => 'R$7.100,00',     'value' => 7300.00, 'win_chance' => $isBanned ? 10 : 0, 'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/f37d3942-4b76-4e12-923c-752bae217de0.png')],
        ['name' => 'R$500,00',   'value' => 500.00,  'win_chance' => $isBanned ? 10 : 0,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/saco_dinheiro_4b71930f-1.webp')],
        ['name' => 'IPAD',        'value' => 3900.00,  'win_chance' => $isBanned ? 10 : 0, 'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/721d5399-2171-495e-877a-5c051a5caf99.png')],
        ['name' => 'R$100,00',   'value' => 100.00,  'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/100_reais.jpg')],
        ['name' => 'R$10,00',     'value' => 10.00,    'win_chance' => $isBanned ? 0 : 10,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/10_reais.png')],
        ['name' => 'R$50,00',    'value' => 50.00,   'win_chance' => $isBanned ? 20 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/50_reais.png')],
        ['name' => 'R$25,00',    'value' => 25.00,   'win_chance' => $isBanned ? 0 : 5,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/25_reais_1d140f81.png')],
        ['name' => 'R$1.000,00',  'value' => 1000.00, 'win_chance' => $isBanned ? 0 : 0, 'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/dinheiro_859419ed.webp')],
    ];

    // Gera pool ponderada com base no win_chance
    $weightedPool = [];
    foreach ($itemsPool as $item) {
        $reps = (int)($item['win_chance'] * 10); // exemplo: 1% = 10 repetições
        for ($i = 0; $i < $reps; $i++) {
            $weightedPool[] = $item;
        }
    }

    $items = [];
    $win = false;
    $value = 0;

    // Sorteio: o jogador vai ganhar?
    $winChanceGlobal = $isBanned ? 30 : 10;
    if (!empty($weightedPool) && mt_rand(1, 100) <= $winChanceGlobal) {
        // Sorteia o item que aparecerá 3x
        $winningItem = $weightedPool[array_rand($weightedPool)];
        $value = $winningItem['value'];

        // Posições aleatórias para o item vencedor
        $indexes = array_rand(range(0, 8), 3);
        if (!is_array($indexes)) $indexes = [$indexes];
        $items = array_fill(0, 9, null);
        foreach ($indexes as $i) {
            $items[$i] = $winningItem;
        }

        // Preenche os demais espaços sem repetir 3x outros itens
        foreach ($items as $i => $slot) {
            if ($slot === null) {
                do {
                    $randItem = $itemsPool[array_rand($itemsPool)];
                    $count = count(array_filter($items, fn($it) => $it && $it['name'] === $randItem['name']));
                } while ($count >= 2);
                $items[$i] = $randItem;
            }
        }

        $wallet->increment('balance_withdrawal', $value);
        if (!$isBanned && $value > 0) {
            $user->increment('earnings', $value);
        }
        $win = true;
    } else {
        // Não ganhou: preenche com prêmios aleatórios sem repetir 3x nenhum
        while (count($items) < 9) {
            $item = $itemsPool[array_rand($itemsPool)];
            $count = count(array_filter($items, fn($i) => $i['name'] === $item['name']));
            if ($count < 2) {
                $items[] = $item;
            }
        }
    }

    return response()->json([
        'items' => $items,
        'win' => $win,
        'value' => $value,
        'newBalance' => $wallet->balance_withdrawal,
    ]);
}

public function playScratchCardMilhao()
{
    $user = auth('api')->user();
    
    $isBanned = $user->banned == 1;
    
    $wallet = \App\Models\Wallet::firstOrCreate(['user_id' => $user->id]);

    $cost = 50.00;
    $balanceTotal = $wallet->balance + $wallet->balance_withdrawal;

    if ($balanceTotal < $cost) {
        return response()->json(['error' => 'Saldo insuficiente para jogar.'], 400);
    }

    // Desconta o valor
    if ($wallet->balance >= $cost) {
        $wallet->decrement('balance', $cost);
    } else {
        $remaining = $cost - $wallet->balance;
        $wallet->update(['balance' => 0]);
        $wallet->decrement('balance_withdrawal', $remaining);
    }

    // Pool de prêmios com probabilidade individual de vitória
    $itemsPool = [
        ['name' => 'iPhone 16',    'value' => 6000.00,   'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/iphone16_cd5d761c.webp')],
        ['name' => 'iPhone 16 Max',    'value' => 8300.00,   'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/e36da5a5-c88b-4da4-8e22-2485adfa1b5f.png')],
        ['name' => 'R$10.000,00',     'value' => 10000.00,    'win_chance' => $isBanned ? 10 : 0,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/91ccb792-8a97-4d72-8142-31a98d4a6fa4.png')],
        ['name' => 'R$7.000,00',     'value' => 7000.00,    'win_chance' => $isBanned ? 10 : 0,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/saco_dinheiro_4b71930f-1.webp')],
        ['name' => 'R$4.500,00',       'value' => 4500.00,   'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/dinheiro_859419ed.webp')],
        ['name' => 'AirPods Max',     'value' => 4200.00, 'win_chance' => $isBanned ? 10 : 0, 'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/5d89384c-6a70-46bd-a5a1-647773875758.png')],
        ['name' => 'Honda CB 2025',   'value' => 0.00,  'win_chance' => $isBanned ? 0 : 0,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/imagem-home-honda-cb-300f-twister-abs-lateral-azul.webp')],
        ['name' => 'BMW X1',        'value' => 0.00,  'win_chance' => $isBanned ? 0 : 0, 'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/model_main_webp_comprar-sdrive20i-x-line_3c6b55fef4.png.png')],
        ['name' => 'R$7.000,00',   'value' => 7000.00,  'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/721d5399-2171-495e-877a-5c051a5caf99.png')],
        ['name' => 'R$150,00',     'value' => 150.00,    'win_chance' => $isBanned ? 10 : 10,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/150_reais_b179f726.png')],
        ['name' => 'R$300,00',    'value' => 300.00,   'win_chance' => $isBanned ? 20 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/Design-sem-nome-2025-07-09T124815.290.png')],
        ['name' => 'U$50.000,00',    'value' => 0.00,   'win_chance' => $isBanned ? 0 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/e9269138-91e4-432a-80e2-08fe8e8c79c4.png')],
        ['name' => 'R$1000,00',  'value' => 1000.00, 'win_chance' => $isBanned ? 0 : 0, 'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/dinheiro_859419ed.webp')],
    ];

    // Gera pool ponderada com base no win_chance
    $weightedPool = [];
    foreach ($itemsPool as $item) {
        $reps = (int)($item['win_chance'] * 10); // exemplo: 1% = 10 repetições
        for ($i = 0; $i < $reps; $i++) {
            $weightedPool[] = $item;
        }
    }

    $items = [];
    $win = false;
    $value = 0;

    // Sorteio: o jogador vai ganhar?
    $winChanceGlobal = $isBanned ? 30 : 10;
    if (!empty($weightedPool) && mt_rand(1, 100) <= $winChanceGlobal) {
        // Sorteia o item que aparecerá 3x
        $winningItem = $weightedPool[array_rand($weightedPool)];
        $value = $winningItem['value'];

        // Posições aleatórias para o item vencedor
        $indexes = array_rand(range(0, 8), 3);
        if (!is_array($indexes)) $indexes = [$indexes];
        $items = array_fill(0, 9, null);
        foreach ($indexes as $i) {
            $items[$i] = $winningItem;
        }

        // Preenche os demais espaços sem repetir 3x outros itens
        foreach ($items as $i => $slot) {
            if ($slot === null) {
                do {
                    $randItem = $itemsPool[array_rand($itemsPool)];
                    $count = count(array_filter($items, fn($it) => $it && $it['name'] === $randItem['name']));
                } while ($count >= 2);
                $items[$i] = $randItem;
            }
        }

        $wallet->increment('balance_withdrawal', $value);
        if (!$isBanned && $value > 0) {
            $user->increment('earnings', $value);
        }
        $win = true;
    } else {
        // Não ganhou: preenche com prêmios aleatórios sem repetir 3x nenhum
        while (count($items) < 9) {
            $item = $itemsPool[array_rand($itemsPool)];
            $count = count(array_filter($items, fn($i) => $i['name'] === $item['name']));
            if ($count < 2) {
                $items[] = $item;
            }
        }
    }

    return response()->json([
        'items' => $items,
        'win' => $win,
        'value' => $value,
        'newBalance' => $wallet->balance_withdrawal,
    ]);
}


public function playScratchCardMake()
{
    $user = auth('api')->user();
    
    $isBanned = $user->banned == 1;
    
    $wallet = \App\Models\Wallet::firstOrCreate(['user_id' => $user->id]);

    $cost = 25.00;
    $balanceTotal = $wallet->balance + $wallet->balance_withdrawal;

    if ($balanceTotal < $cost) {
        return response()->json(['error' => 'Saldo insuficiente para jogar.'], 400);
    }

    // Desconta o valor
    if ($wallet->balance >= $cost) {
        $wallet->decrement('balance', $cost);
    } else {
        $remaining = $cost - $wallet->balance;
        $wallet->update(['balance' => 0]);
        $wallet->decrement('balance_withdrawal', $remaining);
    }

    // Pool de prêmios com probabilidade individual de vitória
    $itemsPool = [
        ['name' => 'R$1.200,00',    'value' => 1200.00,   'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/c792ef3c-c5af-482d-9438-64147f482f97.png')],
        ['name' => 'R$1.350,00',    'value' => 1350.00,   'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/db649f13-53ed-43c0-928b-bb64648158a7.png')],
        ['name' => 'R$1.400,00',     'value' => 1400.00,    'win_chance' => $isBanned ? 10 : 0,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/8b8607a2-817f-4459-ab05-fb2ceffd0366.png')],
        ['name' => 'R$400,00',     'value' => 400.00,    'win_chance' => $isBanned ? 10 : 0,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/Design-sem-nome-2025-07-09T124815.290.png')],
        ['name' => 'R$6.000,00',       'value' => 6000.00,   'win_chance' => $isBanned ? 10 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/iphone12_white_12897651.webp')],
        ['name' => 'R$14.000,00',     'value' => 14000.00, 'win_chance' => $isBanned ? 10 : 0, 'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/9e7f91db-820c-4641-bac6-06bfeadf24ec.png')],
        ['name' => 'R$1.455,00',   'value' => 1455.00,  'win_chance' => $isBanned ? 10 : 0,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/399fa857-de70-4cf3-8152-4d139a15caba.png')],
        ['name' => 'R$1.700,00',        'value' => 1700.00,  'win_chance' => $isBanned ? 10 : 0, 'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/bdd43f1f-35f2-40c7-952a-cef890e2c380.png')],
        ['name' => 'R$100,00',   'value' => 100.00,  'win_chance' => $isBanned ? 10 : 10,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/100_reais.jpg')],
        ['name' => 'Bolsa Prada',     'value' => 1700.00,    'win_chance' => $isBanned ? 10 : 0,  'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/8610294e-6244-48bf-a06b-9b69dc3336cf.png')],
        ['name' => 'R$3.990,00',    'value' => 3990.00,   'win_chance' => $isBanned ? 0 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/9da0ee08-7f18-4db9-8d04-cd0e27f5297a.png')],
        ['name' => 'R$2.110,00',    'value' => 2110.00,   'win_chance' => $isBanned ? 0 : 0,   'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/a565383b-c748-43be-9997-52600759eacd.png')],
        ['name' => 'R$1.000,00',  'value' => 1000.00, 'win_chance' => $isBanned ? 0 : 0, 'image' => url('https://worldgamesbr.com.br/wp-content/uploads/2025/07/dinheiro_859419ed.webp')],
    ];

    // Gera pool ponderada com base no win_chance
    $weightedPool = [];
    foreach ($itemsPool as $item) {
        $reps = (int)($item['win_chance'] * 10); // exemplo: 1% = 10 repetições
        for ($i = 0; $i < $reps; $i++) {
            $weightedPool[] = $item;
        }
    }

    $items = [];
    $win = false;
    $value = 0;

    // Sorteio: o jogador vai ganhar?
    $winChanceGlobal = $isBanned ? 30 : 10;
    if (!empty($weightedPool) && mt_rand(1, 100) <= $winChanceGlobal) {
        // Sorteia o item que aparecerá 3x
        $winningItem = $weightedPool[array_rand($weightedPool)];
        $value = $winningItem['value'];

        // Posições aleatórias para o item vencedor
        $indexes = array_rand(range(0, 8), 3);
        if (!is_array($indexes)) $indexes = [$indexes];
        $items = array_fill(0, 9, null);
        foreach ($indexes as $i) {
            $items[$i] = $winningItem;
        }

        // Preenche os demais espaços sem repetir 3x outros itens
        foreach ($items as $i => $slot) {
            if ($slot === null) {
                do {
                    $randItem = $itemsPool[array_rand($itemsPool)];
                    $count = count(array_filter($items, fn($it) => $it && $it['name'] === $randItem['name']));
                } while ($count >= 2);
                $items[$i] = $randItem;
            }
        }

        $wallet->increment('balance_withdrawal', $value);
        if (!$isBanned && $value > 0) {
            $user->increment('earnings', $value);
        }
        $win = true;
    } else {
        // Não ganhou: preenche com prêmios aleatórios sem repetir 3x nenhum
        while (count($items) < 9) {
            $item = $itemsPool[array_rand($itemsPool)];
            $count = count(array_filter($items, fn($i) => $i['name'] === $item['name']));
            if ($count < 2) {
                $items[] = $item;
            }
        }
    }

    return response()->json([
        'items' => $items,
        'win' => $win,
        'value' => $value,
        'newBalance' => $wallet->balance_withdrawal,
    ]);
}
    
    

    // Outros métodos continuam aqui...
}
