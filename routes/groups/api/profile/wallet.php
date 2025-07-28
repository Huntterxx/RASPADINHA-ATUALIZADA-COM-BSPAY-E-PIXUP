<?php

use App\Http\Controllers\Api\Profile\WalletController;
use Illuminate\Support\Facades\Route;

Route::prefix('wallet')
    ->group(function ()
    {
        Route::get('/', [WalletController::class, 'index']);
    });

Route::prefix('mywallet')
    ->group(function ()
    {
        Route::get('/', [WalletController::class, 'myWallet']);
        Route::post('/{id}', [WalletController::class, 'setWalletActive']);
        Route::post('/wallet/claim-bonus', [WalletController::class, 'claimBetReward']);
        Route::get('/wallet/claim-status', [WalletController::class, 'checkClaimStatus']);
        Route::get('/wallet/bet-report', [WalletController::class, 'getUserBetReport']);
        Route::post('/wallet/claim-loss', [WalletController::class, 'claimLossBonus']);
        Route::get('/wallet/check-status', [WalletController::class, 'checkLossClaimStatus']);
        Route::get('/wallet/userbet-deposit', [WalletController::class, 'getUserBetAndDepositInfo']);
        Route::get('/user/has-deposit', [WalletController::class, 'hasDeposit']);
        Route::post('/user/transfer-to-partnership', [WalletController::class, 'transferToPartnership']);



    });




