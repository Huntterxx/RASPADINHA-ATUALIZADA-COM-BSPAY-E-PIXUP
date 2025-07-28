<?php

namespace App\Filament\Affiliate\Resources\SubAffiliateResource\Widgets;

use App\Models\AffiliateHistory;
use App\Models\AffiliateWithdraw;
use App\Models\Withdrawal;
use App\Models\Deposit;
use App\Models\User;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class SubAffiliateOverview extends BaseWidget
{
    protected function getColumns(): int
    {
        return 3;
    }

    protected function getStats(): array
    {
        $inviterId = auth()->id();

        $directIndicatedUsers = AffiliateHistory::where('inviter', $inviterId)->pluck('user_id');

        $subAffiliateIds = AffiliateHistory::whereIn('inviter', $directIndicatedUsers)->pluck('user_id');

        $totalWithdrawalsAmount = Withdrawal::whereIn('user_id', $subAffiliateIds)->sum('amount');

        $totalDepositsAmount = Deposit::whereIn('user_id', $subAffiliateIds)
        ->where('status', 1)
        ->sum('amount');

        $totalRegistrations = User::whereIn('id', $subAffiliateIds)->count();

        $ftdCount = Deposit::whereIn('user_id', $subAffiliateIds)->where('status', 1)->distinct('user_id')->count('user_id');

        $directWithdrawalsAmount = AffiliateWithdraw::whereIn('user_id', $directIndicatedUsers)->sum('amount');
        
        $profit = ($totalDepositsAmount * 0.95) - $totalWithdrawalsAmount - $directWithdrawalsAmount;

        return [
            
            Stat::make('Total Cadastros dos indicados dos Colaboradores', $totalRegistrations)
                ->description('Número total de cadastros dos indicados dos Colaboradores')
                ->descriptionIcon('heroicon-m-user-group')
                ->color('primary'),
            
            
            Stat::make('Total Depósitos dos indicados dos Colaboradores', \Helper::amountFormatDecimal($totalDepositsAmount))
                ->description('Soma de todos os depósitos dos indicados dos Colaboradores')
                ->descriptionIcon('heroicon-m-arrow-trending-up')
                ->color('success'),
            
            
             Stat::make('FTD dos Indicados', $ftdCount)
                ->description('Número de primeiros depósitos dos indicados')
                ->descriptionIcon('heroicon-m-currency-dollar')
                ->color('success'),
            
            
            Stat::make('Total Saques dos indicados dos Colaboradores', \Helper::amountFormatDecimal($totalWithdrawalsAmount))
                ->description('Soma de todos os saques dos indicados dos Colaboradores')
                ->descriptionIcon('heroicon-m-arrow-trending-up')
                ->color('success'),
            
            
           
                
            
           
            Stat::make('Total Saques dos Colaboradores', \Helper::amountFormatDecimal($directWithdrawalsAmount))
                ->description('Soma de todos os saques dos Colaboradores')
                ->descriptionIcon('heroicon-m-arrow-trending-up')
                ->color('success'),
                Stat::make('Lucro', \Helper::amountFormatDecimal($profit))
                ->description('Total de Lucro')
                ->descriptionIcon('heroicon-m-calculator')
                ->color('primary'),
                 Stat::make('Link de Convite', 'convite')
                ->view('filament.components.convite'),
        ];
    }

    public function copyReferCode()
    {
        // Método para copiar o código de referência, se necessário
    }
}
