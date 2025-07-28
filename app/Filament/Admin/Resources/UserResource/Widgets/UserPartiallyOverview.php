<?php

namespace App\Filament\Admin\Resources\UserResource\Widgets;

use App\Models\User;
use Carbon\Carbon;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class UserPartiallyOverview extends BaseWidget
{
    public string $deposits;
    public string $cashouts;
    public string $affiliates_deposits;
    public string $total_cpa;
    
    protected static ?string $pollingInterval = '60s';
    
    protected function getStats (): array
    {
        return [
            Stat::make('Depósitos Totais', $this->deposits),
            Stat::make('Saques Totais', $this->cashouts),
        ];
    }
}
