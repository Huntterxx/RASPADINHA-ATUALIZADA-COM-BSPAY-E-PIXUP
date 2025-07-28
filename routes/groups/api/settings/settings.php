<?php

use App\Http\Controllers\Api\Settings\SettingController;
use Illuminate\Support\Facades\Route;

Route::get('/data', [SettingController::class, 'index']);
Route::post('/user/update-avatar', [SettingController::class, 'updateAvatar']);
Route::get('/user/bet-missions', [SettingController::class, 'getBetMissions']);
Route::post('/user/store-bet-mission', [SettingController::class, 'storeBetMission']);
Route::post('/pix/complaint', [SettingController::class, 'submitPixComplaint']);
Route::get('/user/pix-account', [SettingController::class, 'getPixAccounts']);
Route::get('/user/device-info', [SettingController::class, 'getUserDeviceInfo']);
Route::post('/daily-checkin', [SettingController::class, 'checkIn']);
Route::get('/daily-checkin/status', [SettingController::class, 'getCheckInStatus']);





