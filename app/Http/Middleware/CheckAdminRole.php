<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class CheckAdminRole
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        // Verifica se o usuário autenticado tem o papel de 'admin'
        if (!auth()->user() || !auth()->user()->hasRole('admin')) {
            // Se o usuário não for um administrador, redireciona para uma página de erro ou outra rota
            abort(403, 'Acesso negado');
        }

        return $next($request);
    }
}
