<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DailyCheckin extends Model
{
    use HasFactory;

    // Define a tabela associada ao modelo
    protected $table = 'daily_checkins';

    // Atributos que podem ser preenchidos em massa
    protected $fillable = [
        'user_id',
        'checkin_date',
        'rewards' // 🔥 Agora permite salvar o valor da recompensa

    ];

    // Define a relação com o modelo User
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
