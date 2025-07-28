<?php

namespace App\Models;

use Attribute;
use Carbon\Carbon;
use Filament\Models\Contracts\FilamentUser;
use Filament\Panel;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Hash;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Traits\HasRoles;
use Tymon\JWTAuth\Contracts\JWTSubject;
use App\Models\AffiliateHistory;
use App\Models\Deposit;

class User extends Authenticatable implements FilamentUser, JWTSubject
{
    use HasApiTokens, HasFactory, Notifiable, HasRoles;

    protected static function boot()
{
    parent::boot();

    static::creating(function ($user) {
        do {
            $id = random_int(10000, 999999999);
        } while (User::where('id', $id)->exists());

        $user->id = $id;
    });

    static::created(function (User $user) {
        $user->createWallet($user);
    });

    static::deleted(function (User $user) {
        $user->deleteAll($user);
    });
}


        

   

    public static function updateIndicatedCount()
    {
        $indicatedCounts = AffiliateHistory::distinct('user_id')
            ->groupBy('inviter')
            ->selectRaw('inviter, COUNT(DISTINCT user_id) as count')
            ->pluck('count', 'inviter');

        foreach ($indicatedCounts as $inviterId => $count) {
            static::where('id', $inviterId)->update(['indicated_count' => $count]);
        }
    }

    public function deposits(): HasMany
    {
        return $this->hasMany(Deposit::class);
    }

    public function affiliateHistories(): HasMany
    {
        return $this->hasMany(AffiliateHistory::class, 'inviter', 'id');
    }

    public static function updateTotalDepositAmounts()
    {
        try {
            $totalAmounts = Deposit::join('users', 'deposits.user_id', '=', 'users.id')
                ->groupBy('users.inviter')
                ->where('deposits.status', 1)
                ->selectRaw('users.inviter, SUM(deposits.amount) as total_amount')
                ->pluck('total_amount', 'users.inviter');

            foreach ($totalAmounts as $inviterId => $totalAmount) {
                static::where('id', $inviterId)->update(['total_deposit_amount' => $totalAmount]);
            }
        } catch (\Exception $e) {
            \Log::error('Erro ao atualizar o total de valores de depósito: ' . $e->getMessage());
            throw $e;
        }
    }

    public static function updateDistinctInvitersCount()
    {
        try {
            // Obter a lista de 'inviter' e 'user_id' únicos de AffiliateHistory
            $affiliateHistories = AffiliateHistory::select('inviter', 'user_id')
                ->distinct()
                ->get();

            // Mapear os 'inviter' para os 'user_id'
            $inviterUserMap = [];
            foreach ($affiliateHistories as $affiliate) {
                $inviterUserMap[$affiliate->inviter][] = $affiliate->user_id;
            }

            // Inicializar um array para armazenar as contagens de usuários distintos
            $distinctInvitersCounts = [];

            // Para cada 'inviter', contar os usuários distintos com status 1 em Deposit
            foreach ($inviterUserMap as $inviterId => $userIds) {
                $distinctCount = Deposit::where('status', 1)
                    ->whereIn('user_id', $userIds)
                    ->distinct('user_id')
                    ->count('user_id');
                $distinctInvitersCounts[$inviterId] = $distinctCount;
            }

            // Atualizar o campo 'distinct_inviters_count' no modelo User
            foreach ($distinctInvitersCounts as $inviterId => $count) {
                static::where('id', $inviterId)->update(['distinct_inviters_count' => $count]);
            }
        } catch (\Exception $e) {
            \Log::error('Erro ao atualizar a contagem de inviters distintos: ' . $e->getMessage());
            throw $e;
        }
    }
    public static function updateInvitersCount()
{
    try {
        // Obter a lista de 'inviter' e 'user_id' únicos de AffiliateHistory
        $affiliateHistories = AffiliateHistory::select('inviter', 'user_id')
            ->get();

        // Mapear os 'inviter' para os 'user_id'
        $inviterUserMap = [];
        foreach ($affiliateHistories as $affiliate) {
            $inviterUserMap[$affiliate->inviter][] = $affiliate->user_id;
        }

        // Inicializar um array para armazenar as contagens de usuários
        $invitersCounts = [];

        // Para cada 'inviter', contar os usuários com status 1 em Deposit
        foreach ($inviterUserMap as $inviterId => $userIds) {
            $count = Deposit::where('status', 1)
                ->whereIn('user_id', $userIds)
                ->count('user_id');
            $invitersCounts[$inviterId] = $count;
        }

        // Atualizar o campo 'inviters_count' no modelo User
        foreach ($invitersCounts as $inviterId => $count) {
            static::where('id', $inviterId)->update(['inviters_count' => $count]);
        }
    } catch (\Exception $e) {
        \Log::error('Erro ao atualizar a contagem de inviters: ' . $e->getMessage());
        throw $e;
    }
}



    public function deleteAll($user)
    {
        $wallet = Wallet::find($user->id);
        if (!empty($wallet)) {
            $wallet->delete();
        }

        $affiliateHistory = AffiliateHistory::where('user_id', $user->id)->get();
        foreach ($affiliateHistory as $affh) {
            $affh->delete();
        }

        $affiliateWithdraw = AffiliateWithdraw::where('user_id', $user->id)->get();
        foreach ($affiliateWithdraw as $affw) {
            $affw->delete();
        }

        $deposits = Deposit::where('user_id', $user->id)->get();
        foreach ($deposits as $dep) {
            $dep->delete();
        }

        $likes = Like::where('user_id', $user->id)->get();
        foreach ($likes as $lk) {
            $lk->delete();
        }

        $transactions = Transaction::where('user_id', $user->id)->get();
        foreach ($transactions as $trans) {
            $trans->delete();
        }

        $withdrawals = Withdrawal::where('user_id', $user->id)->get();
        foreach ($withdrawals as $wts) {
            $wts->delete();
        }
    }

    public function createWallet($user)
    {
        $setting = \Helper::getSetting();

        Wallet::create([
            'user_id' => $user->id,
            'currency' => $setting->currency_code,
            'symbol' => $setting->prefix,
            'active' => 1
        ]);
    }

    protected $fillable = [
        'role_id',
        'avatar',
        'name',
        'last_name',
        'cpf',
        'phone',
        'email',
        'password',
        'logged_in',
        'banned',
        'inviter',
        'inviter_code',
        'affiliate_revenue_share',
        'affiliate_revenue_share_fake',
        'affiliate_cpa',
        'affiliate_baseline',
        'is_demo_agent',
        'is_admin',
        'language',
        'role_id',
        'indicated_count',
        'total_deposit_amount',
        'distinct_inviters_count',
        'inviters_count',
        'withdraw_password',
        'whatsapp',
        'facebook_id',
        'telegram_id',
        'line_id',
        'twitter_id',
        'birthdate',
        'earnings'
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    protected $appends = ['dateHumanReadable', 'createdAt', 'totalLikes'];

    public function favorites(): HasMany
    {
        return $this->hasMany(GameFavorite::class);
    }

    public function likes(): HasMany
    {
        return $this->hasMany(Like::class);
    }

    protected function password(): Attribute
    {
        return Attribute::make(
            set: fn(string $value) => Hash::make($value),
        );
    }

    public function affiliate(): BelongsTo
    {
        return $this->belongsTo(User::class, 'inviter', 'id');
    }

    public function wallet(): HasOne
    {
        return $this->hasOne(Wallet::class)->where('active', 1);
    }

    public function roles(): BelongsToMany
    {
        return $this->belongsToMany(Role::class, 'model_has_roles', 'model_id', 'role_id');
    }

    public function canAccessPanel(Panel $panel): bool
    {
        return $this->hasRole(['admin', 'afiliado']);
    }

    public function getTotalLikesAttribute()
    {
        return $this->likes()->count();
    }

    public function getCreatedAtAttribute()
    {
        return Carbon::parse($this->attributes['created_at'])->format('Y-m-d');
    }

    public function getDateHumanReadableAttribute()
    {
        return Carbon::parse($this->created_at)->diffForHumans();
    }

    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return [];
    }
}
