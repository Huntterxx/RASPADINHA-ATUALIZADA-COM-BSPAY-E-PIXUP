<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PixComplaint extends Model
{
    use HasFactory;

    protected $table = 'pix_complaints'; // Nome da tabela no banco

    protected $fillable = [
        'user_id',
        'amount',
        'pix_account',
        'complaint',
        'status',
        'data_deposito', // Novo campo adicionado

    ];

    /**
     * Relacionamento com o usuário
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
