<?php

namespace App\Filament\Admin\Resources\UserResource\Pages;

use App\Filament\Admin\Resources\UserResource;
use AymanAlhattami\FilamentPageWithSidebar\Traits\HasPageSidebar;
use Filament\Resources\Pages\ViewRecord;
use App\Models\User;
use App\Models\Deposit;
use App\Models\Withdrawal;
use App\Filament\Admin\Resources\UserResource\Widgets\UserPartiallyOverview;

class ViewUser extends ViewRecord
{
    protected function getHeaderWidgets(): array
    {
        $userId = $this->record->id;

        // Total user deposits using the Deposit model
        $userWithDepositsSum = Deposit::where('user_id', $userId)
            ->where('status', 1)
            ->sum('amount');
        $approvedDepositsSum = 'R$ ' . number_format($userWithDepositsSum, 2, ',', '.');

        // Total user cashouts using the Withdrawal model
        $userWithCashoutsSum = Withdrawal::where('user_id', $userId)
            ->where('status', 1)
            ->sum('amount');
        $approvedCashoutsSum = 'R$ ' . number_format($userWithCashoutsSum, 2, ',', '.');

        return [
            UserPartiallyOverview::make([
                'deposits' => $approvedDepositsSum,
                'cashouts' => $approvedCashoutsSum,
            ]),
        ];
    }

    use HasPageSidebar;

    protected static string $resource = UserResource::class;
}
