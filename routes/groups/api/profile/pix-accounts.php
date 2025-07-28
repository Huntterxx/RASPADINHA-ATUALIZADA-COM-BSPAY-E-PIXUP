<?php

use App\Http\Controllers\Api\Profile\PixAccountController;
use Illuminate\Support\Facades\Route;

Route::prefix('pix-accounts')
    ->group(function () {
        Route::get('/', [PixAccountController::class, 'index']); // Listar todas as contas PIX do usuário
        Route::post('/', [PixAccountController::class, 'store']); // Criar uma nova conta PIX
        Route::delete('/{id}', [PixAccountController::class, 'destroy']); // Apagar uma conta PIX
    });
