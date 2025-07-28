<?php

namespace App\Http\Controllers\Api\Missions;

use App\Http\Controllers\Controller;
use App\Models\GGRGames;
use App\Models\Wallet;
use App\Models\Vip;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;

class MissionController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        // Increment 1% of each minimum balance_loss to user's wallet balance
        $userId = auth('api')->id();
        $wallet = Wallet::where('user_id', $userId)->first();
        $balanceLosses = GGRGames::where('user_id', $userId)->sum('balance_loss');
        
        // Supondo que há apenas uma configuração VIP para simplificação
        $vip = Vip::first();
        $minimumBalanceLoss = $vip->bet_level;
        
        // Calculate number of increments to be made
        $increments = intdiv($balanceLosses, $minimumBalanceLoss);
        
        // Cache key for tracking increments paid
        $cacheKey = "bonus_received_{$userId}_increments";
        $incrementsPaid = Cache::get($cacheKey, 0);
        
        // Calculate new increments since last payment
        $newIncrements = $increments - $incrementsPaid;

        if ($newIncrements > 0 && $wallet) {
            // Calculate the total increment amount to be paid
            $incrementAmount = $newIncrements * $minimumBalanceLoss * 0.01; // 1% of each minimum balance_loss
            $wallet->increment('balance', $incrementAmount);

            // Update the cache to reflect the new increments paid
            Cache::put($cacheKey, $increments, now()->addYear()); // Adjust the time as necessary
        }

        return response()->json(['message' => 'Cashback processed successfully.']);
    }






    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
