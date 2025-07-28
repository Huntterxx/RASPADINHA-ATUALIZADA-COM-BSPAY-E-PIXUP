<?php

namespace App\Http\Controllers\Api\Wallet;

use App\Http\Controllers\Controller;
use App\Models\Withdrawal;
use App\Models\AffiliateWithdraw;
use Illuminate\Http\Request;

class WithdrawController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $userId = auth('api')->id();
        
        // Obter os saques do usuário com paginação
        $withdraws = Withdrawal::whereUserId($userId)->paginate()->through(function ($withdrawal) {
            return [
                'id' => $withdrawal->id,
                'amount' => $withdrawal->amount,
                'currency' => $withdrawal->currency,
                'status' => $withdrawal->status,
                'creationTime' => $withdrawal->created_at->format('Y-m-d H:i:s'),
                'orderNumber' => str_pad(mt_rand(0, 9999999999999999), 16, '0', STR_PAD_LEFT),
            ];
        });

        // Obter os saques de afiliados do usuário com paginação
        $affiliateWithdraws = AffiliateWithdraw::whereUserId($userId)->paginate()->through(function ($affiliateWithdrawal) {
            return [
                'id' => $affiliateWithdrawal->id,
                'amount' => $affiliateWithdrawal->amount,
                'currency' => $affiliateWithdrawal->currency,
                'status' => $affiliateWithdrawal->status,
                'creationTime' => $affiliateWithdrawal->created_at->format('Y-m-d H:i:s'),
                'orderNumber' => str_pad(mt_rand(0, 9999999999999999), 16, '0', STR_PAD_LEFT),
            ];
        });

        return response()->json([
            'withdraws' => $withdraws,
            'affiliate_withdraws' => $affiliateWithdraws
        ], 200);
    }
}
