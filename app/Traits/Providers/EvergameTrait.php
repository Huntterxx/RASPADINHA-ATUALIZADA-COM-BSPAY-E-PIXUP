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

trait EvergameTrait
{
    use MissionTrait;

    /**
     * @var string
     */
    protected static $agentCode;
    protected static $agentToken;
    protected static $agentSecretKey;
    protected static $apiEndpoint;

    /**
     * @return void
     */
    public static function getCredentialsEvergame(): bool
    {
        $setting = GamesKey::first();

        self::$agentCode        = $setting->getAttributes()['evergame_agent_code'];
        self::$agentToken       = $setting->getAttributes()['evergame_agent_token'];
        self::$apiEndpoint      = $setting->getAttributes()['evergame_api_endpoint'];

        return true;
    }


    /**
     * @param $rtp
     * @param $provider
     * @return void
     */
    public static function UpdateRTPEvergame($rtp, $provider)
    {
        if(self::getCredentialsEvergame()) {
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
     *
     * @return bool
     */
    public static function createUserEvergame()
    {
        if(self::getCredentialsEvergame()) {
            $postArray = [
                "method"        => "createUser",
                "agentCode"    => self::$agentCode,
                "token"   => self::$agentToken,
                "userCode"     => auth('api')->id() . '',
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
     * Metodo responsavel para iniciar o jogo
     *
     */
    public static function GameLaunchEvergame($provider_code, $game_code, $lang, $userId)
    {
        if(self::getCredentialsEvergame()) {
            $postArray = [
                "method"        => "GetGameUrl",
                "agentCode"    => self::$agentCode,
                "token"   => self::$agentToken,
                "userCode"     => $userId.'',
                "vendorCode" => $provider_code,
                "gameCode"     => $game_code,
                "lang"          => $lang
            ];

            //\DB::table('debug')->insert(['text' => json_encode($postArray)]);
            $response = Http::post(self::$apiEndpoint, $postArray);
            
            $data = $response->json();

            $endpointwo = "https://m.pgsoft-games.xyz/api/v1/game_launch";

            if($game_code === '98'|| $game_code === '68' || $game_code === '69' || $game_code === '126' || $game_code === '1543462' || $game_code === '1695365'|| $game_code === '40'|| $game_code === '42'|| $game_code === '48'|| $game_code === '63'|| $game_code === '1682240'|| $game_code === '1738001' || $game_code === '1760238' || $game_code === '1747549' || $game_code === '1727711' || $game_code === '1580541' || $game_code === '53' || $game_code === '1338274' || $game_code === '1368367' || $game_code === '1778752' || $game_code === '57' || $game_code === '39' || $game_code === '82' || $game_code === '67' || $game_code === '59' || $game_code === '35' || $game_code === '3' || $game_code === '1879752' || $game_code === '1815268' || $game_code === '1786529' || $game_code === '1755623' || $game_code === '88' || $game_code === '83' || $game_code === '62' || $game_code === '60' || $game_code === '58' ){
                $wallet = Wallet::where('user_id', $userId)->where('active', 1)->first();

                error_log($game_code);

                switch ($game_code) {
                    case '98':
                        error_log("Dentro do Switch 98");
                        $gamename = "fortune-ox";
                        break;
                    case '68':
                        $gamename = "fortune-mouse";
                        break;
                    case '69':
                        $gamename = "bikini-paradise";
                        break;
                    case '126':
                        $gamename = "fortune-tiger";
                        break;
                    case '1543462':
                        $gamename = "fortune-rabbit";
                        break;
                    case '1695365':
                        $gamename = "fortune-dragon";
                        break;
                    case '40':
                        $gamename = "jungle-delight";
                        break;
                    case '42':
                        $gamename = "ganesha-gold";
                        break;
                    case '48':
                        $gamename = "double-fortune";
                        break;
                    case '63':
                        $gamename = "dragon-tiger-luck";
                        break;    
                    case '1682240':
                        $gamename = "cash-mania";
                        break;
                    case '1738001':
                        $gamename = "chicky-run";
                        break;
                    case '1760238':
                        $gamename = "yakuza-honor";
                        break;
                    case '1747549':
                        $gamename = "wings-of-iguazu";
                        break;
                    case '1727711':
                        $gamename = "three-crazy-piggies";
                        break;
                    case '1580541':
                        $gamename = "mafia-mayhem";
                        break;
                    case '53':
                        $gamename = "the-great-icescape";
                        break;
                    case '1338274':
                        $gamename = "totem-wonders";
                        break;
                    case '1368367':
                        $gamename = "alchemy-gold";
                        break;
                    case '1778752':
                        $gamename = "futebol-fever";
                        break;
                    case '57':
                        $gamename = "dragon-hatch";
                        break;
                    case '39':
                        $gamename = "piggy-gold";
                        break;
                    case '82':
                        $gamename = "phoenix-rises";
                        break;    
                    case '67':
                        $gamename = "shaolin-soccer";
                        break;
                    case '59':
                        $gamename = "samurai-vs-ninja";
                        break;
                    case '35':
                        $gamename = "mr-hallow-win";
                        break;
                    case '3':
                        $gamename = "fortune-gods";
                        break;
                    case '1879752':
                        $gamename = "fortune-snake";
                        break;
                    case '1815268':
                        $gamename = "oish-delight";
                        break;
                    case '1786529':
                        $gamename = "rio-fantasia";
                        break;
                    case '1755623':
                        $gamename = "museum-mystery";
                        break;
                    case '88':
                        $gamename = "jewels-prosper";
                        break;
                    case '83':
                        $gamename = "wild-fireworks";
                        break;
                    case '62':
                        $gamename = "gem-saviour-conquest";
                        break;
                    case '60':
                        $gamename = "leprechaun-riches";
                        break;
                    case '58':
                        $gamename = "vampire-charm";
                        break;    
                }

                $postArray = [
                    "agentToken"   => '61643fe7-3e2d-47f0-a1ed-e85bb2647388',
                    "secretKey"    => 'b9960e4b-a4e9-4b16-9df0-d21625b4277c',
                    "user_code"     => $userId.'',
                    "provider_code" => $provider_code,
                    "game_code"     => $gamename,
                    "user_balance" => $wallet->total_balance
                    
                ];
                
                error_log(print_r($postArray, true));
                
                $wallet = Wallet::where('user_id', $userId)->where('active', 1)->first();


                $response = Http::post($endpointwo, $postArray);
                $data = $response->json();

                $data['launchUrl'] = $data['launch_url'];

            }

            return $data;

        }

    }

    /**
     * Get FIvers Balance
     * @return false|void
     */
    public static function getFiversUserDetailEvergame()
    {
        if(self::getCredentialsEvergame()) {
            $dataArray = [
                "method"        => "GetUserInfo",
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
     * @param $provider_code
     * @param $game_code
     * @param $lang
     * @param $userId
     * @return false|void
     */
    public static function getBalanceEvergame()
    {
        if(self::getCredentialsEvergame()) {
            $dataArray = [
                "method"        => "GetBalance",
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
     * @param $request
     * @return \Illuminate\Http\JsonResponse
     */
    private static function GetBalanceInfoEvergame($request)
    {
        $wallet = Wallet::where('user_id', $request->userCode)->where('active', 1)->first();

        if(!empty($wallet) && $wallet->total_balance > 0) {

            \Log::info('Balance '.$wallet->total_balance);

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
     * @param $request
     * @return \Illuminate\Http\JsonResponse
     */
    private static function SetTransactionEvergame($request)
    {

        $data = $request->all();
        $wallet = Wallet::where('user_id', $data['userCode'])->where('active', 1)->first();

        if(!empty($wallet)) {
            if(isset($data['userCode'])) {

                $amount = floatval($data['amount']);
                $changeBonus = 'balance';

                if($amount < 0){
                    $bet = abs($amount);
                    $win = 0;
                }else{
                    $bet = 0;
                    $win = $amount;
                }

                \Log::info('_____________________________________________________________________________________________');

                // \Log::info('Bet: '.$bet);
                // \Log::info('Win: '.$win);
                // \Log::info('txnType: '. $data['txnType']);
                // \Log::info('data: '.json_encode($data));


                if ($bet == 0 && $win == 0) {
                    return response()->json([
                        "status"      => 0,
                        "balance"  => floatval(number_format($wallet->total_balance, 2, '.', '')),
                        "msg"    => "SUCCESS",
                    ]);
                }

                $game = Game::where('game_id', $data['gameCode'])->first();
                $provider = Provider::where('id', $game->provider_id)->first();

                self::CheckMissionExist($data['userCode'], $game);

                if ($wallet->balance >= $bet) {
                    $wallet->decrement('balance', $bet); // retira do saldo depositado
                    $changeBonus = 'balance';

                } elseif ($wallet->balance_bonus > $bet) {
                    $wallet->decrement('balance_bonus', $bet); // retira do bônus
                    $changeBonus = 'balance_bonus';

                } elseif ($wallet->balance_withdrawal >= $bet) {
                    $wallet->decrement('balance_withdrawal', $bet);
                    $changeBonus = 'balance_withdrawal';

                } elseif ($wallet->total_balance >= $bet) {
                    $remainingBet = $bet - $wallet->balance;
                    $wallet->decrement('balance', $wallet->balance);
                    $wallet->decrement('balance_withdrawal', $remainingBet);
                    $changeBonus = 'balance';
                } else {
                    return false;
                }

                return self::PrepareTransactionsEvergame($wallet, $data['userCode'], $data['txnCode'], $bet, $win, $game->game_name, $provider->code, $changeBonus, $data['txnType']);
            }
        }
    }

    /**
     * Prepare Transaction
     * Metodo responsavel por preparar a transação
     *
     * @param $wallet
     * @param $userCode
     * @param $txnId
     * @param $betMoney
     * @param $winMoney
     * @param $gameCode
     * @return \Illuminate\Http\JsonResponse|void
     */
    private static function PrepareTransactionsEvergame($wallet, $userCode, $txnId, $betMoney, $winMoney, $gameCode, $providerCode, $changeBonus, $txnType)
    {
        $user = User::find($wallet->user_id);
        Helper::lossRollover($wallet, $betMoney);

        if($winMoney > $betMoney) {
            $transaction = self::CreateTransactionsEvergame($userCode, time(), $txnId, 'check', $changeBonus, $winMoney, $gameCode, $gameCode);

            if(!empty($transaction)) {

                /// salvar transação GGR
                GGRGames::create([
                    'user_id' => $userCode,
                    'provider' => $providerCode,
                    'game' => $gameCode,
                    'balance_bet' => $betMoney,
                    'balance_win' => $winMoney,
                    'currency' => $wallet->currency,
                    'aggregator' => "evergame",
                    "type" => "win"
                ]);


                /// pagar afiliado
                Helper::generateGameHistory($user->id, 'win', $winMoney, $betMoney, $changeBonus, $transaction->transaction_id);

                $wallet = Wallet::where('user_id', $wallet->user_id)->where('active', 1)->first();
                return response()->json([
                    "status"      => 0,
                    "balance"  => floatval(number_format($wallet->total_balance, 2, '.', '')),
                    "msg"    => "SUCCESS",
                ]);
            }
        }else{


            /// criar uma transação
            $checkTransaction = Order::where('transaction_id', $txnId)->first();
            if(empty($checkTransaction)) {
                $checkTransaction = self::CreateTransactionsEvergame($userCode, time(), $txnId, 'check', $changeBonus, $betMoney, $gameCode, $gameCode);
            }

            /// salvar transação GGR
            GGRGames::create([
                'user_id' => $userCode,
                'provider' => $providerCode,
                'game' => $gameCode,
                'balance_bet' => $betMoney,
                'balance_win' => $winMoney,
                'currency' => $wallet->currency,
                'aggregator' => "evergame",
                "type" => "loss"
            ]);

            /// pagar afiliado           

            Helper::generateGameHistory($user->id, 'bet', $winMoney, $betMoney, $changeBonus, $txnId);
            $wallet = Wallet::where('user_id', $wallet->user_id)->where('active', 1)->first();

            return response()->json([
                "status"      => 0,
                "balance"  => floatval(number_format($wallet->total_balance, 2, '.', '')),
                "msg"    => "SUCCESS",
            ]);

        }
    }
    /**
     * @param $request
     * @return \Illuminate\Http\JsonResponse|null
     */
    public static function WebhooksEvergame($request)
    {
        switch ($request->method) {
            case "GetBalance":
                return self::GetBalanceInfoEvergame($request);
            case "ChangeBalance":
                return self::SetTransactionEvergame($request);
            default:
                return response()->json(['status' => 0]);
        }
    }


    /**
     * Create Transactions
     * Metodo para criar uma transação
     *
     * @return false
     */
    private static function CreateTransactionsEvergame($playerId, $betReferenceNum, $transactionID, $type, $changeBonus, $amount, $game, $pn)
    {

        $order = Order::create([
            'user_id'       => $playerId,
            'session_id'    => $betReferenceNum,
            'transaction_id'=> $transactionID,
            'type'          => $type,
            'type_money'    => $changeBonus,
            'amount'        => $amount,
            'providers'     => 'Evergame',
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

    public static function getProviderEvergame()
    {
        if (self::getCredentialsEvergame()) {
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
                        $checkProvider = Provider::where('code', $vendor['vendorCode'])->where('distribution', 'evergame')->first();
                        if (empty($checkProvider)) {
                            $dataProvider = [
                                'code' => $vendor['vendorCode'],
                                'name' => $cleanedName,
                                'rtp' => 80,
                                'status' => 1,
                                'distribution' => 'evergame',
                            ];
                            Provider::create($dataProvider);
                            echo "provedor criado com sucesso \n";
                        }
                    }
                }
            }
        }
    }

    /**
     * Buscar Jogos
     * Metodo para Buscar Jogos
     *
     * @return bool
     */

    public static function getGamesEvergame()
    {
        if(self::getCredentialsEvergame()) {
            $providers = Provider::where('distribution', 'evergame')->get();
            
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
                            // Extrair o nome do jogo preferencialmente em Português, caso contrário em Inglês
                            $gameName = isset(json_decode($game['gameName'], true)['pt']) ? json_decode($game['gameName'], true)['pt'] : json_decode($game['gameName'], true)['en'];
    
                            // Extrair a URL da imagem, se estiver disponível
                            $imageUrl = !empty($game['imageUrl']) ? json_decode($game['imageUrl'], true)['en'] : null;
                            $image = !empty($imageUrl) ? self::uploadFromUrlWorldSlot($imageUrl, $game['gameCode']) : null;
    
                            // Definindo game_type
                            $gameTypeStored = $game['gameType'] == 2 ? "live" : "slot";
    
                            if (!empty($game['gameCode']) && !empty($gameName)) {
                                $data = [
                                    'provider_id'   => $provider->id,
                                    'game_id'       => $game['gameCode'],
                                    'game_code'     => $game['gameCode'],
                                    'game_name'     => $gameName,
                                    'technology'    => 'html5',
                                    'distribution'  => 'evergame',
                                    'rtp'           => 80,
                                    'cover'         => $image,
                                    'status'        => 1,
                                    'game_type'     => $gameTypeStored, // Game type
                                ];
    
                                Game::create($data);
                            }
                        }
                    }
                }
            }
        }
    }




    /**
     * @param $url
     * @return string|null
     * @throws \GuzzleHttp\Exception\GuzzleException
     */
    private static function uploadFromUrlEverGame($url, $name = null)
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
                $fileName = 'ever/'.$fileName . '.' . $extension;

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