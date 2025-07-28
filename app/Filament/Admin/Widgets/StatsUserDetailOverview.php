<?php

namespace App\Filament\Admin\Widgets;

use App\Helpers\Core as Helper;
use App\Models\AffiliateHistory;
use App\Models\Order;
use App\Models\User;
use App\Models\GGRGames;
use App\Models\Deposit;
use App\Models\Withdrawal;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class StatsUserDetailOverview extends BaseWidget
{

    public User $record;

    public function mount($record)
    {
        $this->record = $record;
    }

    /**
     * @return array|Stat[]
     */
    protected function getStats(): array
    {
        $userId = $this->record->id;

        // Obtendo o CPF do usuário
$cpf = preg_replace('/(\d{3})(\d{3})(\d{3})(\d{2})/', '$1.$2.$3-$4', $this->record->cpf);

        // Usando a tabela GGRGames e a coluna balance_win para calcular o total de ganhos
        $totalGanhos = GGRGames::where('user_id', $userId)->sum('balance_win');
        // Usando a tabela GGRGames e a coluna balance_loss para calcular o total de perdas
        $totalPerdas = GGRGames::where('user_id', $userId)->sum('balance_loss');
        // Calculando o lucro/perda como a diferença entre balance_win e balance_loss
        $lucroPerda = $totalGanhos - $totalPerdas;

        // Total user deposits using the Deposit model
        $totalDepositos = Deposit::where('user_id', $userId)
            ->where('status', 1)
            ->sum('amount');
        
        // Count user deposits
        $quantidadeDepositos = Deposit::where('user_id', $userId)
            ->where('status', 1)
            ->count();
        
        // Calculating the average deposit ticket
        $ticketMedioDeposito = $quantidadeDepositos > 0 ? $totalDepositos / $quantidadeDepositos : 0;

        // Total user withdrawals using the Withdrawal model
        $totalSaques = Withdrawal::where('user_id', $userId)
            ->where('status', 1)
            ->sum('amount');

        return [
          	Stat::make('Usuário', $this->record->name)
    			->description('Nome do usuário')
    			->descriptionIcon('heroicon-m-user')
    			->color('secondary'),
            Stat::make('CPF', $cpf)
                ->description('CPF do usuário')
                ->descriptionIcon('heroicon-m-identification')
                ->color('secondary'),
            Stat::make('Total de Depósitos', Helper::amountFormatDecimal(Helper::formatNumber($totalDepositos)))
                ->description('Total de Depósitos com status aprovado')
                ->descriptionIcon('heroicon-m-banknotes')
                ->color('primary'),
            Stat::make('Total de Saques', Helper::amountFormatDecimal(Helper::formatNumber($totalSaques)))
                ->description('Total de Saques com status aprovado')
                ->descriptionIcon('heroicon-o-credit-card')
                ->color('warning'),
            Stat::make('Ticket Médio do Depósito', Helper::amountFormatDecimal(Helper::formatNumber($ticketMedioDeposito)))
                ->description('Valor médio por depósito')
                ->descriptionIcon('heroicon-m-currency-dollar')
                ->color('info'),
            Stat::make('Total de Ganhos', Helper::amountFormatDecimal(Helper::formatNumber($totalGanhos)))
                ->description('Total de Ganhos na plataforma')
                ->descriptionIcon('heroicon-m-arrow-trending-up')
                ->color('success'),
            Stat::make('Total de Perdas', Helper::amountFormatDecimal(Helper::formatNumber($totalPerdas)))
                ->description('Total de Perdas na plataforma')
                ->descriptionIcon('heroicon-m-arrow-trending-down')
                ->color('danger'),
            Stat::make('Lucro / Perda', Helper::amountFormatDecimal(Helper::formatNumber($lucroPerda)))
                ->description('Diferença entre Ganhos e Perdas')
                ->descriptionIcon('heroicon-m-scale')
                ->color($lucroPerda >= 0 ? 'success' : 'danger'),
        ];
    }
}
