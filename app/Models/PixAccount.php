<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PixAccount extends Model
{
    use HasFactory;

    protected $table = 'pix_accounts';

    protected $fillable = [
        'user_id',
        'name',
        'cpf',
        'email',
        'phone',
        'type',
    ];

    // Relacionamento com o modelo User
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
