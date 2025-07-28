<?php

use App\Http\Controllers\Api\Profile\ProfileController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Broadcast;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Settings\SettingController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


/*
 * Auth Route with JWT
 */
Route::group(['prefix' => 'auth', 'as' => 'auth.'], function () {
    include_once(__DIR__ . '/groups/api/auth/auth.php');
});

Route::group(['middleware' => ['auth.jwt']], function () {
    Route::prefix('profile')
        ->group(function ()
        {
            include_once(__DIR__ . '/groups/api/profile/profile.php');
            include_once(__DIR__ . '/groups/api/profile/affiliates.php');
            include_once(__DIR__ . '/groups/api/profile/wallet.php');
            include_once(__DIR__ . '/groups/api/profile/likes.php');
            include_once(__DIR__ . '/groups/api/profile/favorites.php');
            include_once(__DIR__ . '/groups/api/profile/recents.php');
            include_once(__DIR__ . '/groups/api/profile/vip.php');
            include_once(__DIR__ . '/groups/api/profile/pix-accounts.php');
        });

    Route::prefix('wallet')
        ->group(function ()
        {
            include_once(__DIR__ . '/groups/api/wallet/deposit.php');
            include_once(__DIR__ . '/groups/api/wallet/withdraw.php');
        });

    include_once(__DIR__ . '/groups/api/missions/mission.php');;
    include_once(__DIR__ . '/groups/api/missions/missionuser.php');;
});


Route::prefix('categories')
    ->group(function ()
    {
        include_once(__DIR__ . '/groups/api/categories/index.php');;
    });

include_once(__DIR__ . '/groups/api/games/index.php');
include_once(__DIR__ . '/groups/api/gateways/digitopay.php');
include_once(__DIR__ . '/groups/api/gateways/suitpay.php');

Route::prefix('search')
    ->group(function ()
    {
        include_once(__DIR__ . '/groups/api/search/search.php');
    });

Route::prefix('profile')
    ->group(function ()
    {
        Route::post('/getLanguage', [ProfileController::class, 'getLanguage']);
        Route::put('/updateLanguage', [ProfileController::class, 'updateLanguage']);
    });

Route::prefix('providers')
    ->group(function ()
    {

    });


Route::prefix('settings')
    ->group(function ()
    {
        include_once(__DIR__ . '/groups/api/settings/settings.php');
        include_once(__DIR__ . '/groups/api/settings/banners.php');
        include_once(__DIR__ . '/groups/api/settings/currency.php');
        include_once(__DIR__ . '/groups/api/settings/bonus.php');

        // Rotas para os textos de promoção
        Route::get('/promotion-texts', [SettingController::class, 'getPromotionTexts']);
        Route::post('/promotion-texts', [SettingController::class, 'updatePromotionTexts']);
    });

// LANDING SPIN
Route::prefix('spin')
    ->group(function ()
    {
        include_once(__DIR__ . '/groups/api/spin/index.php');
    })
    ->name('landing.spin.');

Route::post('profile/create-withdraw-password', [ProfileController::class, 'createWithdrawPassword']);
Route::post('profile/verify-withdraw-password', [ProfileController::class, 'verifyWithdrawPassword']);
Route::get('profile/has-withdraw-password', [ProfileController::class, 'hasWithdrawPassword']);

