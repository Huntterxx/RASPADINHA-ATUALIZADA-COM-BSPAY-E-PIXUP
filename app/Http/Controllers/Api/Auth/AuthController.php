<?php

namespace App\Http\Controllers\Api\Auth;

use App\Models\SpinRuns;
use App\Models\Setting;
use App\Models\Wallet;
use App\Traits\Affiliates\AffiliateHistoryTrait;
use App\Http\Controllers\Controller;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Tymon\JWTAuth\Exceptions\JWTException;
use Illuminate\Support\Str;
use Illuminate\Validation\Rules;

class AuthController extends Controller
{
    use AffiliateHistoryTrait;

    /**
     * Create a new AuthController instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth.jwt', ['except' => ['login', 'register', 'submitForgetPassword', 'submitResetPassword']]);
    }

    /**
     * @return \Illuminate\Http\JsonResponse
     */
    public function verify()
    {
        return response()->json(auth('api')->user());
    }

    /**
     * Get a JWT via given credentials.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function login()
    {
        try {
            $credentials = request(['email', 'password']);

            if (!$token = auth('api')->attempt($credentials)) {
                return response()->json(['error' => trans('Check credentials')], 400);
            }

            return $this->respondWithToken($token);
        } catch (JWTException $e) {
            return response()->json([
                'error' => 'Could not create token'
            ], 400);
        }
    }

    /**
     * Get a JWT via given credentials.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function register(Request $request)
{
    try {
        $setting = \Helper::getSetting();

        $rules = [
            'name'          => 'required|string',
            'email'         => 'required|unique:users',
            'password'      => ['required', Rules\Password::min(6)],
            'term_a'        => 'required',
            'agreement'     => 'required',
        ];

        $validator = \Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        $userData = $request->only(['name', 'password', 'email', 'phone', 'cpf']);

        // Criando dados do afiliado
        $userData['affiliate_revenue_share']    = $setting->revshare_percentage;
        $userData['affiliate_cpa']              = $setting->cpa_value;
        $userData['affiliate_baseline']         = $setting->cpa_baseline;

        DB::beginTransaction();

        if($user = User::create($userData))
        {
            // Adicionar usuário na tabela vip_users com level 0
            DB::table('vip_users')->insert([
                'user_id' => $user->id,
                'level' => 0,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            if(isset($request->reference_code) && !empty($request->reference_code)) {
                $checkAffiliate = User::where('inviter_code', $request->reference_code)->first();
                if(!empty($checkAffiliate)) {
                    if($checkAffiliate->affiliate_revenue_share > 0 || $checkAffiliate->affiliate_cpa > 0) {
                        $user->update(['inviter' => $checkAffiliate->id]);
                        self::saveAffiliateHistory($user);
                    }
                }
            }

            if ($setting->disable_spin && !empty($request->spin_token)) {
                try {
                    $str = base64_decode($request->spin_token);
                    $obj = json_decode($str);

                    $spin_run = SpinRuns::where([
                        'key'   => $obj->signature,
                        'nonce' => $obj->nonce
                    ])->first();

                    $data = $spin_run->prize;
                    $obj = json_decode($data);
                    $value = $obj->value;

                    Wallet::where('user_id', $user->id)->increment('balance_bonus', $value);

                } catch (\Exception $e) {
                    return response()->json(['error' => $e->getMessage()], 400);
                }
            }

            $credentials = $request->only(['email', 'password']);
            $token = auth('api')->attempt($credentials);
            
            if (!$token) {
                DB::rollBack();
                return response()->json(['error' => 'Unauthorized'], 401);
            }

            DB::commit();
            return $this->respondWithToken($token);
        }

        DB::rollBack();
        return response()->json(['error' => 'Erro ao criar usuário'], 400);

    } catch (\Exception $e) {
        DB::rollBack();
        return response()->json(['error' => $e->getMessage()], 400);
    }
}


    /**
     * Get the authenticated User.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function me()
    {
        return response()->json(auth('api')->user());
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
        auth('api')->logout();

        return response()->json(['message' => 'Successfully logged out']);
    }

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        return $this->respondWithToken(auth('api')->refresh());
    }


    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function submitForgetPassword(Request $request)
    {
        $request->validate([
            'email' => 'required|email|exists:users',
        ]);

        $token = Str::random(5);

        $psr = DB::table('password_reset_tokens')->where('email', $request->email)->first();
        if(!empty($psr)) {
            DB::table('password_reset_tokens')->where('email', $request->email)->delete();
        }

        DB::table('password_reset_tokens')->insert([
            'email' => $request->email,
            'token' => $token,
            'created_at' => Carbon::now()
        ]);

        \Mail::send('emails.forget-password', [ 'token' => $token, 'resetLink' => url('/reset-password/'.$token) ], function($message) use($request){
            $message->to($request->email);
            $message->subject('Reset Password');
        });

        return response()->json(['status' => true, 'message' => 'We have e-mailed your password reset link!'], 200);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function submitResetPassword(Request $request)
    {
        try {
            $request->validate([
                'email' => 'required|email|exists:users',
                'password' => 'required|string|min:6|confirmed',
                'password_confirmation' => 'required',
                'token' => 'required',
            ]);

            $checkToken = DB::table('password_reset_tokens')->where('token', $request->token)->first();
            if(!empty($checkToken)) {
                $user = User::where('email', $request->email)->first();
                if(!empty($user)) {
                    if($user->update(['password' => $request->password])) {
                        DB::table('password_reset_tokens')->where(['email'=> $request->email])->delete();
                        return response()->json(['status' => true, 'message' => 'Your password has been changed!'], 200);
                    }else{
                        return response()->json(['error' => 'Erro ao atualizar senha'], 400);
                    }
                }else{
                    return response()->json(['error' => 'Email não é valido!'], 400);
                }
            }

            return response()->json(['error' => 'Token não é valido!'], 400);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 400);
        }
    }


    /**
     * Get the token array structure.
     *
     * @param string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken(string $token)
    {
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'user' => auth('api')->user(),
            'expires_in' => time() + 1
            //'expires_in' => auth('api')->factory()->getTTL() * 6000000
        ]);
    }
    
    
    /**
 * Atualizar informações de segurança do usuário.
 *
 * @param Request $request
 * @return \Illuminate\Http\JsonResponse
 */
public function updateSecurityInfo(Request $request)
{
    $user = auth('api')->user();

    if (!$user) {
        return response()->json(['error' => 'Usuário não autenticado'], 401);
    }

    $rules = [
        'phone' => 'nullable|string|max:20',
        'email' => 'nullable|email|unique:users,emailnew,' . $user->id, // Garantir que emailnew seja único
        'password' => 'nullable|string|min:6|confirmed',
    ];

    $validator = \Validator::make($request->all(), $rules);

    if ($validator->fails()) {
        return response()->json(['error' => $validator->errors()], 400);
    }

    // Atualizar os dados do usuário
    $updateData = [];

    if ($request->filled('phone')) {
        $updateData['phone'] = $request->phone;
    }

    if ($request->filled('email')) {
        $updateData['emailnew'] = $request->email;
    }

    if ($request->filled('password')) {
        $updateData['password'] = bcrypt($request->password);
    }

    if (!empty($updateData)) {
        $user->update($updateData);
    }

    return response()->json([
        'message' => 'Informações de segurança atualizadas com sucesso!',
        'user' => [
            'phone' => $user->phone,
            'email' => $user->emailnew, // Pegando do campo correto
            'name' => $user->name,
        ]
    ], 200);
}


/**
 * Retorna as informações de segurança do usuário autenticado.
 *
 * @return \Illuminate\Http\JsonResponse
 */
public function getSecurityInfo()
{
    $user = auth('api')->user();

    if (!$user) {
        return response()->json(['error' => 'Usuário não autenticado'], 401);
    }

    return response()->json([
        'phone' => $user->phone,
        'email' => $user->emailnew, // Corrigido o comentário
        'name' => $user->name,
    ]);
}


/**
 * Retorna as informações de contato e redes sociais do usuário autenticado.
 *
 * @return \Illuminate\Http\JsonResponse
 */
public function getContactInfo()
{
    $user = auth('api')->user();

    if (!$user) {
        return response()->json(['error' => 'Usuário não autenticado'], 401);
    }

    return response()->json([
        'name' => $user->name,  // Somente leitura
        'phone' => $user->phone, // Somente leitura
        'avatar' => $user->avatar, // Somente leitura
        'whatsapp' => $user->whatsapp,
        'facebook_id' => $user->facebook_id,
        'telegram_id' => $user->telegram_id,
        'line_id' => $user->line_id,
        'twitter_id' => $user->twitter_id,
        'birthdate' => $user->birthdate, // Data de nascimento
        'id' => $user->id,
    ]);
}

/**
 * Atualiza as informações de contato e redes sociais do usuário autenticado.
 *
 * @param Request $request
 * @return \Illuminate\Http\JsonResponse
 */
public function updateContactInfo(Request $request)
{
    $user = auth('api')->user();

    if (!$user) {
        return response()->json(['error' => 'Usuário não autenticado'], 401);
    }

    $rules = [
        'whatsapp' => 'nullable|string|max:20',
        'facebook_id' => 'nullable|string|max:50',
        'telegram_id' => 'nullable|string|max:50',
        'line_id' => 'nullable|string|max:50',
        'twitter_id' => 'nullable|string|max:50',
        'birthdate' => 'nullable|date_format:Y-m-d', // Garantir formato correto de data
    ];

    $validator = \Validator::make($request->all(), $rules);

    if ($validator->fails()) {
        return response()->json(['error' => $validator->errors()], 400);
    }

    // Atualizar os dados do usuário
    $updateData = [];

    if ($request->filled('whatsapp')) {
        $updateData['whatsapp'] = $request->whatsapp;
    }

    if ($request->filled('facebook_id')) {
        $updateData['facebook_id'] = $request->facebook_id;
    }

    if ($request->filled('telegram_id')) {
        $updateData['telegram_id'] = $request->telegram_id;
    }

    if ($request->filled('line_id')) {
        $updateData['line_id'] = $request->line_id;
    }

    if ($request->filled('twitter_id')) {
        $updateData['twitter_id'] = $request->twitter_id;
    }

    if ($request->filled('birthdate')) {
        $updateData['birthdate'] = $request->birthdate;
    }

    if (!empty($updateData)) {
        $user->update($updateData);
    }

    return response()->json([
        'message' => 'Informações de contato atualizadas!',
        'user' => [
            'whatsapp' => $user->whatsapp,
            'facebook_id' => $user->facebook_id,
            'telegram_id' => $user->telegram_id,
            'line_id' => $user->line_id,
            'twitter_id' => $user->twitter_id,
            'birthdate' => $user->birthdate,
        ]
    ], 200);
}




    
}
