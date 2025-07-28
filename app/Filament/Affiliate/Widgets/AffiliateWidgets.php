<?php

namespace App\Filament\Affiliate\Widgets;

use App\Models\AffiliateHistory;
use App\Models\User;
use App\Models\Wallet;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use App\Models\Transaction;

class AffiliateWidgets extends BaseWidget
{
    protected static ?int $navigationSort = -2;

    /**
     * @return array|Stat[]
     */
    protected function getCards(): array
    {
        $inviterId      = auth()->user()->id;
        $usersIds       = User::where('inviter', $inviterId)->get()->pluck('id');
        $usersTotal     = User::where('inviter', $inviterId)->count();
        $comissaoTotal  = Wallet::whereIn('user_id', $usersIds)->sum('balance');
        $mycomission    = Wallet::where('user_id', $inviterId)->sum('refer_rewards');
        $indicatedUsers = User::where('inviter', $inviterId)->pluck('id'); // IDs dos usuários indicados
        $totalTransactionAmount = 0;

        foreach ($indicatedUsers as $userId) {
            $userTransactionSum = Transaction::where('user_id', $userId)
                                             ->where('status', 1)
                                             ->sum('price');
            $totalTransactionAmount += $userTransactionSum;
        }

        $fdepositedCount = 0;

        foreach ($indicatedUsers as $userId) {
            $userDepositedCount = Transaction::where('user_id', $userId)
                                             ->where('status', 1)
                                             ->count();
            $fdepositedCount += $userDepositedCount;
        }

        return [
            Stat::make('Saldo Disponível', \Helper::amountFormatDecimal($mycomission))
                ->description('Saldo Disponível para saque')
                ->descriptionIcon('heroicon-m-arrow-trending-up')
                ->color('success'),
            Stat::make('Saldo dos indicados', \Helper::amountFormatDecimal($comissaoTotal))
                ->description('Saldo geral dos indicados.')
                ->descriptionIcon('heroicon-m-arrow-trending-up')
                ->color('success'),
            Stat::make('Cadastros', $usersTotal)
                ->description('Usuários cadastrados com meu link')
                ->descriptionIcon('heroicon-m-arrow-trending-up')
                ->color('success'),
            Stat::make('Total Depositado', \Helper::amountFormatDecimal($totalTransactionAmount))
                ->description('Total depositado pelos indicados')
                ->descriptionIcon('heroicon-m-arrow-trending-up')
                ->color('success'),
            Stat::make('Total Depósitos', ($fdepositedCount))
                ->description('Total de depósitos dos indicados')
                ->descriptionIcon('heroicon-m-arrow-trending-up')
                ->color('success'),
        ];
    }

    /**
     * @return bool
     */
    public static function canView(): bool
    {
        return auth()->user()->hasRole('afiliado');
    }
}
