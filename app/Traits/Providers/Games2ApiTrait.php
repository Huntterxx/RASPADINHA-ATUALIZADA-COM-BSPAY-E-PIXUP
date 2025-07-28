<?php

namespace App\Traits\Providers;

use App\Helpers\Core as Helper;
use App\Models\Game;
use App\Models\Provider;
use App\Models\GamesKey;
use App\Models\GGRGames;
use App\Models\Order;
use App\Models\User;
use App\Models\Wallet;
use App\Traits\Missions\MissionTrait;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;

trait Games2ApiTrait
{
    use MissionTrait;

    /**
     * telegram @hugosilva021
     * @var string
     */
    protected static $agentCode;
    protected static $agentToken;
    protected static $agentSecretKey;
    protected static $apiEndpoint;

    /**
     * telegram @hugosilva021
     * @return void
     */
    public static function getCredentialsGames2Api(): bool
    {
        $setting = GamesKey::first();

        self::$agentCode        = $setting->getAttributes()['games2_agent_code'];
        self::$agentToken       = $setting->getAttributes()['games2_agent_token'];
        self::$agentSecretKey   = $setting->getAttributes()['games2_agent_secret_key'];
        self::$apiEndpoint      = $setting->getAttributes()['games2_api_endpoint'];

        return true;
    }


    /**
     * telegram @hugosilva021
     * @param $rtp
     * @param $provider
     * @return void
     */
    public static function UpdateRTPGames2Api($rtp, $provider)
    {
        if(self::getCredentialsGames2Api()) {
            $postArray = [
                "method"        => "control_rtp",
                "agentCode"    => self::$agentCode,
                "token"   => self::$agentToken,
                "vendorCode" => $provider,
                "userCode"     => auth('api')->id() . '',
                "rtp"           => $rtp
            ];

            $response = Http::post(self::$apiEndpoint, $postArray);

            if($response->successful()) {

            }
        }
    }

    /**
     * Create User
     * Metodo para criar novo usuário
     * telegram @hugosilva021
     *
     * @return bool
     */
    public static function createUserGames2Api()
    {
        if(self::getCredentialsGames2Api()) {
            $postArray = [
                "method"        => "createUser",
                "agentCode"    => self::$agentCode,
                "token"   => self::$agentToken,
                "userCode"     => auth('api')->id() . '#demo',
            ];

            $response = Http::post(self::$apiEndpoint, $postArray);

            if($response->successful()) {
                return true;
            }
            return false;
        }
        return false;
    }

    /**
     * Iniciar Jogo
     * telegram @hugosilva021
     * Metodo responsavel para iniciar o jogo
     *
     */
    public static function GameLaunchGames2($provider_code, $game_code, $lang, $userId)
    {
        if(self::getCredentialsGames2Api()) {

            if($game_code === '98'|| $game_code === '68' || $game_code === '69' || $game_code === '126' || $game_code === '1543462' || $game_code === '1695365' || $game_code === '40' || $game_code === '42' || $game_code === '48' || $game_code === '63' || $game_code === '1492288' || $game_code === '1682240' || $game_code === '1508783' || $game_code === '1738001' || $game_code === '1451122' || $game_code === '104' || $game_code === '1778752' || $game_code === '1717688' || $game_code === '1648578' || $game_code === '100' || $game_code === '1635221' ){
                
              $wallet = Wallet::where('user_id', $userId)->where('active', 1)->first();


                switch ($game_code) {
                    case '98':
                        $gamename = "fortune-ox";
                        $gamecod = '98';
                        break;
                    case '68':
                        $gamename = "fortune-mouse";
                        $gamecod = '68';
                        break;
                    case '69':
                        $gamename = "bikini-paradise";
                        $gamecod = '69';
                        break;
                    case '126':
                        $gamename = "fortune-tiger";
                        $gamecod = '126';
                        break;
                    case '1543462':
                        $gamename = "fortune-rabbit";
                        $gamecod = '1543462';
                        break;
                    case '1695365':
                        $gamename = "fortune-dragon";
                        $gamecod = '1695365';
                        break;
                    case '40':
                        $gamename = "jungle-delight";
                        $gamecod = '40'; 
                        break;
                    case '42':
                        $gamename = "ganesha-gold";
                        $gamecod = '42';
                        break;
                    case '48':
                        $gamename = "double-fortune";
                        $gamecod = '48';
                        break;
                    case '63':
                        $gamename = "dragon-tiger-luck";
                        $gamecod = '63';
                        break;
                    case '1492288':
                        $gamename = "pinata-wins";
                        $gamecod = '1492288';
                        break;
                    case '1682240':
                        $gamename = "cash-mania";
                        $gamecod = '1682240';
                        break;
                    case '1508783':
                        $gamename = "wild-ape-3258";
                        $gamecod = '1508783';
                        break;
                    case '1738001':
                        $gamename = "chicky-run";
                        $gamecod = '1738001';
                        break;
                    case '1451122':
                        $gamename = "dragon-hatch2";
                        $gamecod = '1451122';
                        break;
                    case '104':
                        $gamename = "wild-bandito";
                        $gamecod = '104';
                        break;
                    case '1778752':
                        $gamename = "futebol-fever";
                        $gamecod = '1778752';
                        break;
                    case '1717688':
                        $gamename = "mystic-potions";
                        $gamecod = '1717688';
                        break;
                    case '1648578':
                        $gamename = "shark-hunter";
                        $gamecod = '1648578';
                        break;
                    case '100':
                        $gamename = "candy-bonanza";
                        $gamecod = '100';
                        break;
                    case '1635221':
                        $gamename = "zombie-outbrk";
                        $gamecod = '1635221';
                        break;    
                }
              

                $postArray = [
                    // "agentCode"    => self::$agentCode,
                    "agentToken"    =>  self::$agentToken,
                    "secretKey"     =>  self::$agentSecretKey,
                    "user_code"     =>  $userId.'',
                    "provider_code" =>  $provider_code,
                    "game_code"     =>  $gamename,
                    "user_balance"  =>  $wallet->total_balance,
                    "lang"          =>  $lang,
                    "code_game"     =>  $gamecod
                ];
              
                $wallet = Wallet::where('user_id', $userId)->where('active', 1)->first();

                $response = Http::post(self::$apiEndpoint."game_launch", $postArray);
                $data = $response->json();

              
                $data['launchUrl'] = $data['launch_url'];

                return $data;

            }

        }

    }

    /**
     * Get FIvers Balance
     * telegram @hugosilva021
     * @return false|void
     */
    public static function getFiversUserDetailGames2Api()
    {
        if(self::getCredentialsGames2Api()) {
            $dataArray = [
                "method"        => "call_players",
                "agentCode"    => self::$agentCode,
                "token"   => self::$agentToken,
            ];

            $response = Http::post(self::$apiEndpoint, $dataArray);

            if($response->successful()) {
                $data = $response->json();

                dd($data);
            }else{
                return false;
            }
        }

    }

    /**
     * Get FIvers Balance
     * telegram @hugosilva021
     * @param $provider_code
     * @param $game_code
     * @param $lang
     * @param $userId
     * @return false|void
     */
    public static function getBalanceGames2Api()
    {
        if(self::getCredentialsGames2Api()) {
            $dataArray = [
                "method"        => "money_info",
                "agentCode"    => self::$agentCode,
                "token"   => self::$agentToken,
            ];

            $response = Http::post(self::$apiEndpoint, $dataArray);

            if($response->successful()) {
                $data = $response->json();

                return $data['agent']['balance'] ?? 0;
            }else{
                return false;
            }
        }

    }


    /**
     * telegram @hugosilva021
     * @param $request
     * @return \Illuminate\Http\JsonResponse
     */
    private static function GetBalanceInfoGames2Api($request)
    {
        $wallet = Wallet::where('user_id', $request->user_code)->where('active', 1)->first();
        if(!empty($wallet) && $wallet->total_balance > 0) {

            // \Log::info('Balance '.$wallet->total_balance);

            return response()->json([
                'balance' => $wallet->total_balance,
                'msg' => "SUCCESS"
            ]);
        }

        return response()->json([
            'balance' => 0,
            'msg' => "INSUFFICIENT_USER_FUNDS"
        ]);
    }

    /**
     * Set Transactions
     *
     * telegram @hugosilva021
     * @param $request
     * @return \Illuminate\Http\JsonResponse
     */
    private static function SetTransactionGames2Api($request)
    {

        $data = $request->all();
        try {
            if($data['game_type'] == 'slot' && isset($data['slot'])) {
                return self::ProcessPlayGames2($data, $request->user_code,'slot');
            }

            if($data['game_type'] == 'casino' && isset($data['casino'])) {
                return self::ProcessPlayGames2($data, $request->user_code, 'casino');
            }

            return response()->json([
                'status' => 0,
                'msg' => 'INVALID_USER	'
            ]);
        } catch (\Exception $e) {
            dd($e->getMessage());
        }

    }

    /**
     * @param $data
     * @param $userId
     * @param $type
     * @return \Illuminate\Http\JsonResponse|void
     */
    private static function ProcessPlayGames2($data, $userId, $type)
    {
        $wallet = Wallet::where('user_id', $userId)->where('active', 1)->first();
        if(!empty($wallet)) {
            $game = Game::where('game_code', $data[$type]['game_code'])->first();
            self::CheckMissionExist($userId, $game);

            /// verificar se é transação de vitoria duplicada
            $transactionWin = Order::where('transaction_id', $data[$type]['txn_id'])->where('type', 'win')->first();
            if(!empty($transactionWin)) {
                return response()->json([
                    'status' => 0,
                    'user_balance' => $wallet->total_balance,
                    'msg' => 'DUPLICATED_REQUEST'
                ]);
            }

            $transaction = Order::where('transaction_id', $data[$type]['txn_id'])->where('type', 'bet')->first();
            if(!empty($transaction)) {
                if(floatval($data[$type]['win']) > 0) {

                    GGRGames::create([
                        'user_id' => $wallet->user_id,
                        'provider' => $data[$type]['provider_code'],
                        'game' => $data[$type]['game_code'],
                        'balance_bet' => $data[$type]['bet'],
                        'balance_win' => $data[$type]['win'],
                        'currency' => $wallet->currency,
                        'aggregator' => "pgclone",
                        "type" => "win"
                    ]);

                    Helper::generateGameHistory(
                        $wallet->user_id,
                        'win',
                        $data[$type]['win'],
                        $transaction->amount,
                        $transaction->getAttributes()['type_money'],
                        $transaction->transaction_id
                    );

                    $wallet = Wallet::where('user_id', $userId)->where('active', 1)->first();
                    return response()->json([
                        'status' => 1,
                        'user_balance' => $wallet->total_balance,
                    ]);
                }else{
                    return response()->json([
                        'status' => 0,
                        'user_balance' => $wallet->total_balance,
                        'msg' => 'DUPLICATED_REQUEST'
                    ]);
                }
            }


            /// verificar se tem saldo
            if(floatval($wallet->total_balance) >= $data[$type]['bet']) {

                /// verificar se usuário tem desafio ativo
                self::CheckMissionExist($userId, $game);
                $transaction = self::PrepareTransactionsGames2Api(
                    $wallet->id, $userId,
                    $data[$type]['txn_id'],
                    $data[$type]['bet'],
                    $data[$type]['win'],
                    $data[$type]['game_code'],
                    $data[$type]['provider_code']);

                if($transaction) {
                    /// verificar se é transação de vitoria duplicada
                    $transactionWin2 = Order::where('transaction_id', $data[$type]['txn_id'])->where('type', 'win')->first();
                    if(!empty($transactionWin2)) {
                        $wallet = Wallet::where('user_id', $userId)->where('active', 1)->first();
                        return response()->json([
                            'status' => 0,
                            'user_balance' => $wallet->total_balance,
                            'msg' => 'DUPLICATED_REQUEST'
                        ]);
                    }

                    $transaction = Order::where('transaction_id', $data[$type]['txn_id'])->where('type', 'bet')->first();
                    if(!empty($transaction)) {
                        if(floatval($data[$type]['win']) > 0) {
                            GGRGames::create([
                                'user_id' => $wallet->user_id,
                                'provider' => $data[$type]['provider_code'],
                                'game' => $data[$type]['game_code'],
                                'balance_bet' => $data[$type]['bet'],
                                'balance_win' => $data[$type]['win'],
                                'currency' => $wallet->currency,
                                'aggregator' => "pgclone",
                                "type" => "loss"
                            ]);

                            Helper::generateGameHistory(
                                $wallet->user_id,
                                'win',
                                $data[$type]['win'],
                                $transaction->amount,
                                $transaction->getAttributes()['type_money'],
                                $transaction->transaction_id
                            );

                            $wallet = Wallet::where('user_id', $userId)->where('active', 1)->first();
                            return response()->json([
                                'status' => 1,
                                'user_balance' => $wallet->total_balance,
                            ]);
                        }
                    }

                    Helper::generateGameHistory(
                        $wallet->user_id,
                        'bet',
                        $data[$type]['win'],
                        $transaction->amount,
                        $transaction->getAttributes()['type_money'],
                        $transaction->transaction_id
                    );


                    $wallet = Wallet::where('user_id', $userId)->where('active', 1)->first();
                    return response()->json([
                        'status' => 1,
                        'user_balance' => $wallet->total_balance,
                    ]);
                }else{
                    return response()->json([
                        'status' => 0,
                        'msg' => 'INSUFFICIENT_USER_FUNDS'
                    ]);
                }
            }
        }
    }

    /**
     * Prepare Transaction
     * Metodo responsavel por preparar a transação
     * telegram @hugosilva021
     *
     * @param $wallet
     * @param $userCode
     * @param $txnId
     * @param $betMoney
     * @param $winMoney
     * @param $gameCode
     * @return \Illuminate\Http\JsonResponse|void
     */
    private static function PrepareTransactionsGames2Api($walletId, $userCode, $txnId, $betMoney, $winMoney, $gameCode, $providerCode)
    {
        $wallet = Wallet::find($walletId);
        $user = User::find($wallet->user_id);

        $typeAction  = 'bet';
        $bet = floatval($betMoney);

        $changeBonus = Helper::DiscountBalance($wallet, $bet);
        if($changeBonus != 'no_balance') {
            /// criar uma transação
            $transaction = self::CreateTransactionsWorldSlot($userCode, time(), $txnId, $typeAction, $changeBonus, $bet, $gameCode, $gameCode);
            if($transaction) {
                /// salvar transação GGR
                GGRGames::create([
                    'user_id' => $userCode,
                    'provider' => $providerCode,
                    'game' => $gameCode,
                    'balance_bet' => $bet,
                    'balance_win' => 0,
                    'currency' => $wallet->currency,
                    'aggregator' => "pgclone",
                    "type" => "loss"
                ]);

                return $transaction;
            }
        }else{
            return response()->json([
                'status' => 0,
                'msg' => "INVALID_USER"
            ]);
        }
        return false;
    }
    /**
     * @param $request
     * telegram @hugosilva021
     * @return \Illuminate\Http\JsonResponse|null
     */
    public static function WebhooksGames2($request)
    {
        switch ($request->method) {
            case "GetBalance":
                return self::GetBalanceInfoGames2Api($request);
            case "ChangeBalance":
                return self::SetTransactionGames2Api($request);
            default:
                return response()->json(['status' => 0]);
        }
    }


    /**
     * Create Transactions
     * Metodo para criar uma transação
     * telegram @hugosilva021
     *
     * @return false
     */
    private static function CreateTransactionsGames2Api($playerId, $betReferenceNum, $transactionID, $type, $changeBonus, $amount, $game, $pn)
    {

        $order = Order::create([
            'user_id'       => $playerId,
            'session_id'    => $betReferenceNum,
            'transaction_id'=> $transactionID,
            'type'          => $type,
            'type_money'    => $changeBonus,
            'amount'        => $amount,
            'providers'     => 'pgclone',
            'game'          => $game,
            'game_uuid'     => $pn,
            'round_id'      => 1,
        ]);

        if($order) {
            return $order;
        }

        return false;
    }
    /**
     * Buscar Provedores
     * Metodo para Buscar Provedores
     *
     * @return bool
     */

    public static function getProviderGames2Api()
    {
        if (self::getCredentialsGames2Api()) {
            $response = Http::post(self::$apiEndpoint, [
                'method' => 'GetVendors',
                'agentCode' => self::$agentCode,
                'token' => self::$agentToken
            ]);

            if ($response->successful()) {
                $data = $response->json();

                if (isset($data['vendors'])) { // Check if 'vendors' key exists in the response
                    foreach ($data['vendors'] as $vendor) { // Iterate through vendors
                        $cleanedName = explode('_', $vendor['vendorCode'])[0]; // Extract text before '_'
                        $checkProvider = Provider::where('code', $vendor['vendorCode'])->where('distribution', 'pgclone')->first();
                        if (empty($checkProvider)) {
                            $dataProvider = [
                                'code' => $vendor['vendorCode'],
                                'name' => $cleanedName,
                                'rtp' => 80,
                                'status' => 1,
                                'distribution' => 'pgclone',
                            ];
                            Provider::create($dataProvider);
                            echo "provedor criado com sucesso \n";
                        }
                    }
                }
                usleep(6000000); // Pausa de 1 segundo (1.000.000 microssegundos)
            }
        }
    }

    /**
     * Buscar Jogos
     * Metodo para Buscar Jogos
     *
     * @return bool
     */

    public static function getGamesGames2Api()
    {
        if(self::getCredentialsGames2Api()) {
            $providers = Provider::where('distribution', 'pgclone')->get();

            // Iterar sobre cada provedor individualmente
            foreach($providers as $provider) {
                $response = Http::post(self::$apiEndpoint, [
                    'method' => 'GetVendorGames',
                    'agentCode' => self::$agentCode,
                    'token' => self::$agentToken,
                    'vendorCode' => $provider['code']
                ]);

                if($response->successful()) {
                    $data = $response->json();

                    if(isset($data['vendorGames'])) {
                        foreach ($data['vendorGames'] as $game) {

                            // Extrai apenas os jogos com nome inglês
                            $gameName = str_replace('_', ' ', json_decode($game['gameName'], true)['en']);

                            // Verifica se o jogo já existe
                            $existingGame = Game::where('game_id', $game['gameCode'])->where('distribution', 'pgclone')->first();

                            if(empty($existingGame)) {
                                if(!empty($game['imageUrl'])) {
                                    // Extracting image URL
                                    $imageUrl = json_decode($game['imageUrl'], true)['en'];
                                    $image = self::uploadFromUrlGames2Api($imageUrl, $game['gameCode']);
                                } else {
                                    $image = null;
                                }

                                if(!empty($game['gameCode']) && !empty($gameName)) {
                                    $data = [
                                        'provider_id'   => $provider->id,
                                        'game_id'       => $game['gameCode'],
                                        'game_code'     => $game['gameCode'],
                                        'game_name'     => $gameName,
                                        'technology'    => 'html5',
                                        'distribution'  => 'pgclone',
                                        'rtp'           => 80,
                                        'cover'         => $image,
                                        'status'        => 1,
                                    ];

                                    Game::create($data);
                                    echo "jogo salvo com sucesso \n";
                                }
                            }
                        }
                    }
                }

                // Pausa entre as solicitações para evitar sobrecarregar o servidor
                usleep(5000000); // Pausa de 1 segundo (1.000.000 microssegundos)
            }
        }
    }


    /**
     * @param $url
     * @return string|null
     * @throws \GuzzleHttp\Exception\GuzzleException
     */
    private static function uploadFromUrlGames2Api($url, $name = null)
    {
        try {
            $client = new \GuzzleHttp\Client();
            $response = $client->get($url);

            if ($response->getStatusCode() === 200) {
                $fileContent = $response->getBody();

                // Extrai o nome do arquivo e a extensão da URL
                $parsedUrl = parse_url($url);
                $pathInfo = pathinfo($parsedUrl['path']);
                //$fileName = $pathInfo['filename'] ?? 'file_' . time(); // Nome do arquivo
                $fileName  = $name ?? $pathInfo['filename'] ;
                $extension = $pathInfo['extension'] ?? 'png'; // Extensão do arquivo

                // Monta o nome do arquivo com o prefixo e a extensão
                $fileName = 'covers/'.$fileName . '.' . $extension;

                // Salva o arquivo usando o nome extraído da URL
                Storage::disk('public')->put($fileName, $fileContent);

                return $fileName;
            }

            return null;
        } catch (\Exception $e) {
            return null;
        }
    }

}








?>