<?php


use App\Http\Controllers\Api\Profile\ProfileController;
use Illuminate\Support\Facades\Route;

Route::get('/', [ProfileController::class, 'index']);
Route::post('/upload-avatar', [ProfileController::class, 'uploadAvatar']);
Route::post('/updateName', [ProfileController::class, 'updateName']);
Route::get('/wheel/can-spin', [ProfileController::class, 'canSpin']);
Route::post('/wheel/spin', [ProfileController::class, 'spinWheel']);
Route::get('/wheel/total-ggr-games-bet', [ProfileController::class, 'getTotalGGRGamesBet']);
Route::post('/wheel/spin/ouro', [ProfileController::class, 'spinWheelOuro']);
Route::post('/item-carousel/spin', [ProfileController::class, 'spinItemCarousel']);
Route::get('/item-carousel/items', [ProfileController::class, 'getItems']);
Route::get('/get-balance', [ProfileController::class, 'getWalletBalance']);
Route::post('/item-carousel/simulate', [ProfileController::class, 'simulateSpin']);
Route::post('/raspadinha', [ProfileController::class, 'playScratchCard']);
Route::post('/raspadinha-cinco', [ProfileController::class, 'playScratchCardCincoMil']);
Route::post('/raspadinha-dez', [ProfileController::class, 'playScratchCardDezMil']);
Route::post('/raspadinha-milhao', [ProfileController::class, 'playScratchCardMilhao']);
Route::post('/raspadinha-make', [ProfileController::class, 'playScratchCardMake']);
