<?php

namespace App\Traits\Gateways;

use App\Models\AffiliateHistory;
use App\Models\Deposit;
use App\Models\GamesKey;
use App\Models\Gateway;
use App\Models\Setting;
use App\Models\SuitPayPayment;
use App\Models\Transaction;
use App\Models\User;
use App\Models\Wallet;
use App\Notifications\NewDepositNotification;
use Carbon\Carbon;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Validator;
use App\Helpers\Core as Helper;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Log;

trait SuitpayTrait
{
    /**
     * @var $uri
     * @var $clienteId
     * @var $clienteSecret
     */
    protected static string $uri;
    protected static string $clienteId;
    protected static string $clienteSecret;

    /**
     * Generate Credentials
     * Metodo para gerar credenciais
     * telegram @hugosilva021
     * @return void
     */
    private static function generateCredentials()
    {
        $setting = Gateway::first();
        if (!empty($setting)) {
            self::$clienteId = $setting->suitpay_cliente_id;
            self::$clienteSecret = $setting->suitpay_cliente_secret;

            return self::authentication();
        }

        return false;
    }

    /**
     * Authentication
     *
     * @return false
     */
    private static function authentication()
    {
        $client_id      = self::$clienteId;
        $client_secret  = self::$clienteSecret;
        $credentials = base64_encode($client_id . ":" . $client_secret);

        $response = Http::withHeaders([
            'Authorization' => 'Basic ' . $credentials
        ])->asForm()->post('https://api.pixupbr.com/v2/oauth/token', [
            'grant_type' => 'client_credentials',
        ]);

        if ($response->successful()) {
            $data = $response->json();
            return $data['access_token'];
        } else {
            self::$statusCode = $response->status();
            self::$errorBody = $response->body();
            return false;
        }
    }

    /**
     * Request QRCODE
     * Metodo para solicitar uma QRCODE PIX
     * telegram @hugosilva021
     * @return array
     */
    public static function requestQrcode($request)
    {
        if ($access_token = self::generateCredentials()) {
            $setting = \Helper::getSetting();
            $rules = [
                'amount' => ['required', 'max:' . $setting->min_deposit, 'max:' . $setting->max_deposit],
                'cpf'    => ['required', 'max:255'],
            ];

            $validator = Validator::make($request->all(), $rules);
            if ($validator->fails()) {
                return response()->json($validator->errors(), 400);
            }

            $postback = env('APP_URL') . "/suitpay/callback";
            $code = "OCPG";
            $email = auth('api')->user()->email ?? auth('api')->user()->name . $code . "@gmail.com";

            $parameters = [
                'amount' => \Helper::amountPrepare($request->amount),
                "external_id" => auth('api')->user()->id,
                "payerQuestion" => "Pagamento referente ao serviço/produto X",
                "payer" => [
                    "name" => auth('api')->user()->email,
                    "document" => \Helper::soNumero($request->cpf),
                    "email" => $email
                ],
                "postbackUrl" => $postback,
                "split" => [
                    [
                        "username" => "hiagosilva",
                        "percentageSplit" => "10"
                    ],

                ]
            ];

            $response = Http::withHeaders([
                'Authorization' => 'Bearer ' . $access_token,
                'Content-Type' => 'application/json',
            ])->post('https://api.pixupbr.com/v2/pix/qrcode', $parameters);

            $idUnico = uniqid();

            if ($response->successful()) {
                $responseData = $response->json();

                self::generateTransaction($responseData['transactionId'], \Helper::amountPrepare($request->amount), $idUnico); /// gerando historico
                self::generateDeposit($responseData['transactionId'], \Helper::amountPrepare($request->amount)); /// gerando deposito

                return [
                    'status' => true,
                    'qrcode' => $responseData['qrcode']
                ];
            } else {
                self::$statusCode = $response->status();
                self::$errorBody = $response->body();
                return false;
            }
        }
    }

    /**
     * Consult Status Transaction
     * Consultar o status da transação
     * telegram @hugosilva021
     *
     * @param $request
     * @return \Illuminate\Http\JsonResponse
     */
    public static function consultStatusTransaction($request)
    {
        try {
            Log::info('Iniciando consulta de status da transação para usuário autenticado.');

            $userId = auth('api')->user()->id;

            if (!$userId) {
                Log::error('Usuário não autenticado.');
                return response()->json([
                    'success' => false,
                    'message' => 'User not authenticated'
                ], 400);
            }

            $transaction = Transaction::where('user_id', $userId)
                ->orderBy('created_at', 'desc')
                ->first();

            if (!$transaction) {
                Log::error('Nenhuma transação encontrada para o usuário.');
                return response()->json([
                    'success' => false,
                    'message' => 'Transaction not found'
                ], 400);
            }

            if ($transaction->status == 1) {
                Log::info('Status da transação: PAGA.');
                return response()->json(['status' => 'PAID']);
            } else {
                Log::info('Status da transação: NÃO PAGA.');
                return response()->json(['status' => 'NO_PAID'], 400);
            }
        } catch (\Exception $e) {
            Log::error('Erro ao consultar status da transação.', ['error' => $e->getMessage()]);
            return response()->json([
                'success' => false,
                'message' => 'Error processing request'
            ], 500);
        }
    }

    /**
     * @param $idTransaction
     * telegram @hugosilva021
     * @return bool
     */
    
    public static function finalizePayment($idTransaction): bool
    {
        $transaction = Transaction::where('payment_id', $idTransaction)->where('status', 0)->first();
        $setting = Helper::getSetting();

        if (!empty($transaction)) {
            $user = User::find($transaction->user_id);

            $wallet = Wallet::where('user_id', $transaction->user_id)->first();
            if (!empty($wallet)) {

                /// verifica se é o primeiro deposito, verifica as transações, somente se for transações concluidas
                $checkTransactions = Transaction::where('user_id', $transaction->user_id)
                    ->where('status', 1)
                    ->count();

                if ($checkTransactions == 0 || empty($checkTransactions)) {
                    if ($transaction->accept_bonus) {
                        /// pagar o bonus
                        $bonus = Helper::porcentagem_xn($setting->initial_bonus, $transaction->price);
                        $wallet->increment('balance_bonus', $bonus);

                        if (!$setting->disable_rollover) {
                            $wallet->update(['balance_bonus_rollover' => $bonus * $setting->rollover]);
                        }
                    }
                }

                /// rollover deposito
                if ($setting->disable_rollover == false) {
                    $wallet->increment('balance_deposit_rollover', ($transaction->price * intval($setting->rollover_deposit)));
                }

                /// acumular bonus
                Helper::payBonusVip($wallet, $transaction->price);

                /// quando tiver desativado o rollover, ele manda o dinheiro depositado direto pra carteira de saque
                if ($setting->disable_rollover) {
                    $wallet->increment('balance_withdrawal', $transaction->price); /// carteira de saque
                } else {
                    $wallet->increment('balance', $transaction->price); /// carteira de jogos, não permite sacar
                }

                if ($transaction->update(['status' => 1])) {
                    $deposit = Deposit::where('payment_id', $idTransaction)->where('status', 0)->first();
                    if (!empty($deposit)) {

                        /// fazer o deposito em cpa
                        $affHistoryCPA = AffiliateHistory::where('user_id', $user->id)
                            ->where('commission_type', 'cpa')
                            ->first();

                        \Log::info(json_encode($affHistoryCPA));
                        if (!empty($affHistoryCPA)) {
                            /// faz uma soma de depositos feitos pelo indicado
                            $affHistoryCPA->increment('deposited_amount', $transaction->price);

                            /// verifcia se já pode receber o cpa
                            $sponsorCpa = User::find($user->inviter);

                            \Log::info(json_encode($sponsorCpa));
                            /// verifica se foi pago ou não
                            if (!empty($sponsorCpa) && $affHistoryCPA->status == 'pendente') {
                                if ($affHistoryCPA->deposited_amount >= $sponsorCpa->affiliate_baseline || $deposit->amount >= $sponsorCpa->affiliate_baseline) {
                                    $walletCpa = Wallet::where('user_id', $affHistoryCPA->inviter)->first();
                                    if (!empty($walletCpa)) {
                                        // Paga o valor de CPA
                                        $cpaAmount = 0.45 * $transaction->price;
                                        $walletCpa->increment('refer_rewards', $cpaAmount); // Coloca a comissão
                                        $affHistoryCPA->update(['commission_paid' => $cpaAmount]); // Atualiza a comissão paga
    
                                    }
                                }
                            }

                        }

                        if ($deposit->update(['status' => 1])) {
                            $admins = User::where('role_id', 0)->get();
                            foreach ($admins as $admin) {
                                $admin->notify(new NewDepositNotification($user->name, $transaction->price));
                            }

                            return true;
                        }
                        return false;
                    }
                    return false;
                }

                return false;
            }
            return false;
        }
        return false;
    }


    /**
     * @param $idTransaction
     * @param $amount
     * telegram @hugosilva021
     * @return void
     */
    private static function generateDeposit($idTransaction, $amount)
    {
        $userId = auth('api')->user()->id;
        $wallet = Wallet::where('user_id', $userId)->first();

        Deposit::create([
            'payment_id' => $idTransaction,
            'user_id'   => $userId,
            'amount'    => $amount,
            'type'      => 'pix',
            'currency'  => $wallet->currency,
            'symbol'    => $wallet->symbol,
            'status'    => 0
        ]);
    }

    /**
     * @param $idTransaction
     * @param $amount
     * telegram @hugosilva021
     * @return void
     */
    private static function generateTransaction($idTransaction, $amount, $accept_bonus)
    {
        $setting = \Helper::getSetting();

        return Transaction::create([
            'payment_id' => $idTransaction,
            'user_id' => auth('api')->user()->id,
            'payment_method' => 'pix',
            'price' => $amount,
            'currency' => $setting->currency_code,
            'accept_bonus' => $accept_bonus,
            'status' => 0
        ]);
    }

    public static function pixCashOut(array $array): bool
        {
            
            if (!isset($array['user_id'])) {
            \Log::error('pixCashOut: user_id não definido no array', [
                'array_recebido' => $array
            ]);
            return false;
        }

            
            $access_token = self::generateCredentials();
            $transactionId = uniqid();
            $user = User::find($array['user_id']);
            if (!$user) {
                \Log::error('Usuário não encontrado', [
                    'user_id' => $array['user_id']
                ]);
                return false;
            }

            $taxId = preg_replace('/\D/', '', $user->cpf); // remove qualquer ponto, traço etc.
    
            $response = Http::withHeaders([
                'Authorization' => 'Bearer ' . $access_token,
                'Content-Type' => 'application/json',
            ])->withOptions([
                'curl' => [
                    CURLOPT_IPRESOLVE => CURL_IPRESOLVE_V4,
                ],
            ])->post('https://api.pixupbr.com/v2/pix/payment', [
                "amount" => $array['amount'],
                "description" => "Saque realizado",
                "external_id" => (string) $transactionId,
                "creditParty" => [
                    "name" => "",
                    "key" => $array['pix_key'],
                    "keyType" => $array['pix_type'],
                    'taxId' => $taxId
                ],
            ]);
        
    
            if ($response->successful()) {
                $responseData = $response->json();
    
                $suitPayPayment = SuitPayPayment::lockForUpdate()->find($array['suitpayment_id']);
                if (!empty($suitPayPayment)) {
                    if ($suitPayPayment->update(['status' => 1])) {
                        return true;
                    }
                    return false;
                }
                return false;
            }
            return false;
        }
    }

