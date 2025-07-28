<?php

namespace App\Filament\Admin\Widgets;


use App\Models\Withdrawal;
use App\Models\Deposit;
use App\Models\User;
use Carbon\Carbon;
use Filament\Widgets\ChartWidget;
use Illuminate\Support\Facades\DB;

class UsersStats extends ChartWidget
{
    protected static ?string $heading = 'Usuários cadastrados x Depósitos aprovados';
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
            default => Carbon::today(),
        };
        
        $data = collect(range(7, 0))->mapWithKeys(function ($daysAgo) use ($startDate) {
            $date = $startDate->copy()->subDays($daysAgo)->toDateString();
            
            $totalUsers = User::whereDate('created_at', $date)->count();
            
            $usersWithApprovedDeposits = Deposit::whereDate('created_at', $date)
                ->where('status', 1)
                ->distinct()
                ->count('user_id');
            
            return [
                $date => [
                    'total_users' => $totalUsers,
                    'users_with_deposits' => $usersWithApprovedDeposits,
                ]
            ];
        })->toArray();
        
//        $data = collect(range(6, 0))->mapWithKeys(function ($daysAgo) {
//            $date = Carbon::today()->subDays($daysAgo)->toDateString();
//
//            // Obtem o total de usuários cadastrados
//            $totalUsers = User::whereDate('created_at', $date)->count();
//
//            // Obtem o total de usuários que fizeram depósitos aprovados
//            $usersWithApprovedDeposits = Deposit::whereDate('created_at', $date)
//                ->where('status', 'approved')
//                ->distinct('user_id') // Considera cada usuário apenas uma vez
//                ->count('user_id');
//
//            return [
//                $date => [
//                    'total_users' => $totalUsers,
//                    'users_with_deposits' => $usersWithApprovedDeposits
//                ]
//            ];
//        })->toArray();
        
        return [
            'labels' => array_keys($data),
            'datasets' => [
                [
                    'label' => 'Usuários Cadastrados',
                    'data' => array_column($data, 'total_users'),
                    'backgroundColor' => 'rgba(45,236,145, 0.5)',
                    'borderColor' => 'rgba(45,236,145, 1)',
                ],
                [
                    'label' => 'Usuários com Depósitos Aprovados',
                    'data' => array_column($data, 'users_with_deposits'),
                    'backgroundColor' => 'rgba(255, 206, 86, 0.5)',
                    'borderColor' => 'rgba(255, 206, 86, 1)',
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
