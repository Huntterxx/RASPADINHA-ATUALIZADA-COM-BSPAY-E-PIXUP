<?php

namespace App\Filament\Admin\Widgets;

use App\Models\Deposit;
use App\Models\User;
use App\Models\Withdrawal; 
use Carbon\Carbon;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class DepositsOverview extends BaseWidget
{
    protected static ?string $pollingInterval = '2s';
    
    protected function getStats(): array
    {
        $dateRanges = [
            'today' => [Carbon::today(), Carbon::tomorrow()],
            'yesterday' => [Carbon::yesterday(), Carbon::today()],
            'last7Days' => [Carbon::now()->subDays(7), Carbon::now()],
            'last30Days' => [Carbon::now()->subDays(30), Carbon::now()],
  
        ];

        $stats = [];
        
        foreach ($dateRanges as $key => $range) {
            $totalOrders = Deposit::where('status', 1)->whereBetween('created_at', $range)->count();
            $totalAmount = $this->calculateTotalAmount($range);
            $totalValue = "R$ " . number_format($totalAmount, 2, ',', '.');
            
            $description = match ($key) {
                'today' => 'Depósitos Hoje',
                'yesterday' => 'Depósitos Ontem',
                'last7Days' => 'Depósitos 7d',
                'last30Days' => 'Depósitos 30d',

            };
            
            $stats[] = Stat::make($description, $totalValue)
                ->description('Pedidos: ' . $totalOrders)
                ->descriptionIcon('heroicon-m-arrow-trending-up')
                ->color('success');
        }

        $totalOrders = Deposit::where('status', 1)->count();
        $totalAmount = $this->calculateTotalAmount();
        $totalValue = "R$ " . number_format($totalAmount, 2, ',', '.');

        // Calculando o ticket médio
        $averageTicket = $totalOrders > 0 ? $totalAmount / $totalOrders : 0;
        $averageTicketValue = "R$ " . number_format($averageTicket, 2, ',', '.');

        $stats[] = Stat::make('Depósitos Totais', $totalValue)
            ->description('Pedidos: ' . $totalOrders)
            ->descriptionIcon('heroicon-m-arrow-trending-up')
            ->color('success');

        // Adicionando card com a quantidade de depósitos com status 1
        $stats[] = Stat::make('Quantidade de Depósitos', $totalOrders)
            ->description('Depósitos aprovados')
            ->descriptionIcon('heroicon-m-check-circle')
            ->color('info');
            
        $totalEarnings = User::sum('earnings');
        $totalEarningsValue = "R$ " . number_format($totalEarnings, 2, ',', '.');
        
        $stats[] = Stat::make('Ganhos dos Usuários', $totalEarningsValue)
            ->description('Soma de prêmios recebidos')
            ->descriptionIcon('heroicon-m-currency-dollar')
            ->color('warning');
    
            


        $stats[] = Stat::make('Ticket Médio', $averageTicketValue)
            ->description('Pedidos: ' . $totalOrders)
            ->descriptionIcon('heroicon-m-arrow-trending-up')
            ->color('success');
        
        // Adicionando card com a quantidade de saques aprovados
        $approvedWithdrawals = Withdrawal::where('status', 1)->count();
        $stats[] = Stat::make('Quantidade de Saques', $approvedWithdrawals)
            ->description('Saques aprovados')
            ->descriptionIcon('heroicon-m-x-circle') // Ícone de X
            ->color('danger'); // Define a cor do card como vermelho

        return $stats;
    }

    protected function calculateTotalAmount($range = null)
    {
        if ($range) {
            $deposits = Deposit::where('status', 1)->whereBetween('created_at', $range)->get();
        } else {
            $deposits = Deposit::where('status', 1)->get();
        }

        $totalAmount = 0;
        foreach ($deposits as $index => $deposit) {
            if ($index < 5) {
                $totalAmount += $deposit->amount;
            } else {
                $totalAmount += $deposit->amount * 0.95;
            }
        }

        return $totalAmount;
    }
}
