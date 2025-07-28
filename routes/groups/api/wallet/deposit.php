<?php

use App\Http\Controllers\Api\Wallet\DepositController;
use Illuminate\Support\Facades\Route;

Route::prefix('deposit')
    ->group(function ()
    {
        Route::get('/', [DepositController::class, 'index']);
        Route::post('/payment', [DepositController::class, 'submitPayment']);
        Route::post('/wallet/deposit-bonus', [DepositController::class, 'claimDepositBonus']);
        Route::get('/wallet/check-deposit-bonus', [DepositController::class, 'checkClaimStatus']);
        Route::get('/wallet/has-deposited', [DepositController::class, 'hasDeposited']);



    });

