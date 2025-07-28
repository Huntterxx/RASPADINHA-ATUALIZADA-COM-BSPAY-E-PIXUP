<?php

namespace App\Filament\Affiliate\Resources;

use App\Filament\Affiliate\Resources\SubAffiliateResource\Widgets\SubAffiliateOverview;
use App\Filament\Affiliate\Resources\SubAffiliateResource\Pages;
use App\Models\SubAffiliate;
use App\Models\User;
use App\Models\AffiliateHistory;
use App\Models\Deposit;
use App\Models\Withdrawal;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Columns\IconColumn;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Model;

class SubAffiliateResource extends Resource
{
    protected static ?string $model = SubAffiliate::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    protected static ?string $navigationLabel = 'Sub. Afiliados';

    protected static ?string $modelLabel = 'Painel de Gerente';

    /**
     * Verifica se o usuário autenticado pode acessar este recurso.
     *
     * @return bool
     */
    public static function canAccess(): bool
    {
        return auth()->user()->hasRole('afiliado');
    }

    /**
     * Configura a tabela de sub-afiliados.
     *
     * @param Table $table
     * @return Table
     */
    public static function table(Table $table): Table
    {
        $usersIds = User::where('inviter', auth()->id())->get()->pluck('id');

        return $table
            ->query(User::query()->whereIn('id', $usersIds))
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->searchable(),
                Tables\Columns\TextColumn::make('email')
                    ->searchable(),
               Tables\Columns\TextColumn::make('depositos')
                ->label('Depósitos')
                ->getStateUsing(function (User $record) {
                    $affiliateIds = AffiliateHistory::where('inviter', $record->id)->pluck('user_id');
                    return Deposit::whereIn('user_id', $affiliateIds)
                        ->where('status', 1)
                        ->sum('amount');
                }),

                Tables\Columns\TextColumn::make('saques')
                    ->label('Saques')
                    ->getStateUsing(function (User $record) {
                        $affiliateIds = AffiliateHistory::where('inviter', $record->id)->pluck('user_id');
                        return Withdrawal::whereIn('user_id', $affiliateIds)->sum('amount');
                    }),
                Tables\Columns\TextColumn::make('email_verified_at')
                    ->dateTime()
                    ->toggleable(isToggledHiddenByDefault: true)
                    ->sortable(),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable(),
                Tables\Columns\TextColumn::make('updated_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),

            ])
            ->filters([
                // Adicione filtros personalizados aqui
            ])
            ->actions([
                // Adicione ações personalizadas aqui
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    // Adicione ações em massa aqui
                ]),
            ]);
    }

    /**
     * Configura as relações do recurso.
     *
     * @return array
     */
    public static function getRelations(): array
    {
        return [
            // Defina relações aqui, se necessário
        ];
    }

    /**
     * Configura os widgets do recurso.
     *
     * @return string[]
     */
    public static function getWidgets(): array
    {
        return [
            SubAffiliateOverview::class,
        ];
    }

    /**
     * Configura as páginas do recurso.
     *
     * @return array
     */
    public static function getPages(): array
    {
        return [
            'index' => Pages\ListSubAffiliates::route('/'),
        ];
    }
}
