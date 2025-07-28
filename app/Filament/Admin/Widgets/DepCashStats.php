<?php

namespace App\Filament\Admin\Widgets;

use App\Models\Withdrawal;
use App\Models\Deposit;
use Carbon\Carbon;
use Filament\Widgets\ChartWidget;
use Flowframe\Trend\Trend;
use Flowframe\Trend\TrendValue;
use Illuminate\Support\Facades\DB;

class DepCashStats extends ChartWidget
{
    protected static ?string $heading = 'Visão Geral Entradas e Saídas';
    protected static ?string $pollingInterval = '5s';
    public ?string $filter = 'hour';
    
    protected function getData(): array
    {
        $activeFilter = $this->filter;
        $startDate = match($activeFilter) {
            'hour' => Carbon::now()->subHour(),
            'today' => Carbon::today(),
            'week' => Carbon::now()->subWeek(),
            'month' => Carbon::now()->subMonth(),
            'year' => Carbon::now()->startOfYear(),
            default => Carbon::now()->subHour(),
        };
        
        $data = collect(range(7, 0))->mapWithKeys(function ($daysAgo) use ($startDate) {
            $date = $startDate->copy()->subDays($daysAgo)->toDateString();
            
            $totalDeposits = Deposit::whereDate('created_at', $date)
                ->where('status',1)
                ->sum(DB::raw('amount'));
            
            $totalCashouts = Withdrawal::whereDate('updated_at', $date)
                ->where('status', 1)
                ->sum(DB::raw('amount'));
            
            return [
                $date => [
                    'deposits' => $totalDeposits,
                    'cashouts' => $totalCashouts
                ]
            ];
        })->toArray();
        
//        $data = collect(range(6, 0))->mapWithKeys(function ($daysAgo) {
//            $date = Carbon::today()->subDays($daysAgo)->toDateString();
//
//            // Obtem o total de Depósitos
//            $totalDeposits = Deposit::whereDate('created_at', $date)
//                ->where('status', 'approved')
//                ->sum(DB::raw('amount / 100')); // Converte o valor para reais
//
//            // Obtem o total de Cashouts
//            $totalCashouts = Cashout::whereDate('created_at', $date)
//                ->where('status', 'paid')
//                ->sum(DB::raw('amount / 100')); // Converte o valor para reais
//
//            return [
//                $date => [
//                    'deposits' => $totalDeposits,
//                    'cashouts' => $totalCashouts
//                ]
//            ];
//        })->toArray();

        return [
            'labels' => array_keys($data),
            'datasets' => [
                [
                    'label' => 'Total de Depósitos',
                    'data' => array_column($data, 'deposits'),
                    'backgroundColor' => 'rgba(45,236,145, 0.5)',
                    'borderColor' => 'rgba(45,236,145, 1)',
                ],
                [
                    'label' => 'Total de Retiradas',
                    'data' => array_column($data, 'cashouts'),
                    'backgroundColor' => 'rgba(244,1,53, 0.5)',
                    'borderColor' => 'rgba(244,1,53, 1)',
                ],
            ],
        ];
    }
    
//    protected function getFilters(): ?array
//    {
//        return [
//            'hour' => 'Última hora',
//            'today' => 'Diário',
//            'week' => 'Última Semana',
//            'month' => 'Último Mês',
//            'year' => 'Este Ano',
//        ];
//    }
    
    protected function getType(): string
    {
        return 'line';
    }
}
