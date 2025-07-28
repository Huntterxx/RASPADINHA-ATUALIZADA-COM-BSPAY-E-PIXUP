<?php

namespace App\Http\Controllers\Api\Profile;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\PixAccount;

class PixAccountController extends Controller
{
    /**
     * Lista todas as contas PIX do usuário autenticado.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        $user = auth('api')->user();
        $accounts = PixAccount::where('user_id', $user->id)->get();

        return response()->json($accounts);
    }

    /**
     * Cria uma nova conta PIX para o usuário autenticado.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        // Validação dos dados recebidos com base no tipo
        $request->validate([
            'name' => 'required|string|max:255',
            'type' => 'required|in:document,phoneNumber,email', // Alterado para aceitar 'phoneNumber'
            'cpf' => 'required_if:type,document|nullable|string|max:14',
            'phoneNumber' => 'required_if:type,phoneNumber|nullable|string|max:15', // Alterado para 'phoneNumber'
            'email' => 'required_if:type,email|nullable|string|email|max:255',
        ]);

        // Criação de uma nova conta PIX
        $account = new PixAccount([
            'name' => $request->name,
            'cpf' => $request->type === 'document' ? $request->cpf : null,
            'email' => $request->type === 'email' ? $request->email : null,
            'phone' => $request->type === 'phoneNumber' ? $request->phoneNumber : null, // Alterado para 'phoneNumber'
            'type' => $request->type,
            'user_id' => auth('api')->id(),
        ]);

        $account->save();

        return response()->json($account, 201);
    }

    /**
     * Exclui uma conta PIX específica do usuário autenticado.
     *
     * @param  int  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy($id)
    {
        $account = PixAccount::findOrFail($id);

        // Verifica se a conta pertence ao usuário autenticado
        if ($account->user_id !== auth('api')->id()) {
            return response()->json(['error' => 'Unauthorized'], 403);
        }

        $account->delete();

        return response()->json(null, 204);
    }
}
