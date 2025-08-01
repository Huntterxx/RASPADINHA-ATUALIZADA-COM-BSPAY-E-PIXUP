<?php

namespace App\Filament\Admin\Resources\GameResource\Pages;

use App\Filament\Admin\Resources\GameResource;
use App\Traits\Providers\Games2ApiTrait;
use App\Traits\Providers\WorldSlotTrait;
use Filament\Actions\Action;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;


class ListGames extends ListRecords
{
    use WorldSlotTrait, Games2ApiTrait;

    /**
     * @var string
     */
    protected static string $resource = GameResource::class;

    /**
     * @return array|Action[]|\Filament\Actions\ActionGroup[]
     */
    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make()
                ->icon('heroicon-o-plus')
                ->label('Novo Jogo')
            ,

//            Action::make('loadingGame2Api')
//                ->label('Provedor Games2Api')
//                ->icon('heroicon-o-puzzle-piece')
//                ->color('info')
//                ->requiresConfirmation()
//                ->action(fn () => self::LoadingProviderGames2Api())
//            ,

//           Action::make('loadingGame2Api')
//                ->label('Jogos Games2Api')
//                ->icon('heroicon-o-puzzle-piece')
//                ->color('success')
//                ->requiresConfirmation()
//                ->action(fn () => self::LoadingGames2Api()),

//            Action::make('loadingGame')
//                ->label('Carregar World Slot')
//                ->icon('heroicon-o-puzzle-piece')
//                ->color('success')
//                ->requiresConfirmation()
//                ->action(fn () => self::LoadingGames())
        ];
    }

    /**
     * Carregar todos os provedores
     * telegram @hugosilva021
     * @return void
     */
    protected static function LoadingProviderGames2Api()
    {
        dd("dsfsdsdf");
        self::GetAllProvidersGames2Api();
    }

    /**
     * Carregar todos os jogos
     * telegram @hugosilva021
     * @return void
     */
    protected static function LoadingGames2Api()
    {
        self::GetAllGamesGames2Api();
    }

    protected static function LoadingGames()
    {
        self::LoadingGamesWorldSlot();
    }
}
