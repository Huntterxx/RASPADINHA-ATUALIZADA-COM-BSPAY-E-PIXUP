<?php

namespace App\Filament\Admin\Resources;

use App\Filament\Admin\Resources\UserResource\Widgets\UserOverview;
use App\Filament\Resources\UserResource\Pages;
use App\Models\User;
use AymanAlhattami\FilamentPageWithSidebar\FilamentPageSidebar;
use AymanAlhattami\FilamentPageWithSidebar\PageNavigationItem;
use Carbon\Carbon;
use Filament\Forms;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Filters\Filter;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use App\Models\Deposit;

class UserResource extends Resource
{
    protected static ?string $model = User::class;

    protected static ?string $navigationIcon = 'heroicon-o-users';

    protected static ?string $navigationGroup = 'Administração';

    protected static ?string $navigationLabel = 'Usuários';

    protected static ?string $modelLabel = 'Usuários';

    protected static ?string $recordTitleAttribute = 'name';

    /**
     * telegram @hugosilva021
     * @return bool
     */
    public static function canAccess(): bool
    {
        return auth()->user()->hasRole('admin');
    }

    /**
     * @param Model $record
     * @return string
     */
    public static function getGlobalSearchResultTitle(Model $record): string
    {
        return $record->name; // TODO: Change the autogenerated stub
    }

    /**
     * @return string[]
     */
    public static function getGloballySearchableAttributes(): array
    {
        return ['name', 'email']; // TODO: Change the autogenerated stub
    }

    /**
     * @param Model $record
     * @return FilamentPageSidebar
     */
    public static function sidebar(Model $record): FilamentPageSidebar
    {
        return FilamentPageSidebar::make()
            ->setTitle($record->name)
            ->setDescription($record->created_at)
            ->setNavigationItems([
                PageNavigationItem::make(__('base.list_user'))
                    ->translateLabel()
                    ->url(static::getUrl('index'))->icon('heroicon-o-user-group')
                    ->isActiveWhen(function () {
                        return request()->routeIs(static::getRouteBaseName() . '.list-users');
                    }),
                PageNavigationItem::make(__('base.view_user'))
                    ->translateLabel()
                    ->url(static::getUrl('view', ['record' => $record->id]))->icon('heroicon-o-user')
                    ->isActiveWhen(function () {
                        return request()->routeIs(static::getRouteBaseName() . '.view');
                    }),
                PageNavigationItem::make(__('base.edit_user'))
                    ->translateLabel()
                    ->url(static::getUrl('edit', ['record' => $record->id]))
                    ->icon('heroicon-o-pencil-square')
                    ->isActiveWhen(function () {
                        return request()->routeIs(static::getRouteBaseName() . '.edit');
                    }),
                PageNavigationItem::make(__('base.change_password'))
                    ->translateLabel()
                    ->url(static::getUrl('password.change', ['record' => $record->id]))
                    ->icon('heroicon-o-key')
                    ->isActiveWhen(function () {
                        return request()->routeIs(static::getRouteBaseName() . '.password.change');
                    }),

            ]);
    }


    /**
     * @param Form $form
     * @return Form
     */
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make()
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->label('Nome')
                            ->placeholder('Digite o nome')
                            ->required()
                            ->maxLength(191),
                        Forms\Components\TextInput::make('email')
                            ->label('E-mail')
                            ->placeholder('Digite o e-mail')
                            
                            ->unique(ignorable: fn ($record) => $record)
                            ->maxLength(191),
                        Forms\Components\TextInput::make('cpf')
                            ->label('CPF')
                            ->placeholder('Digite o CPF')
                            ->maxLength(191),
                        Forms\Components\TextInput::make('phone')
                            ->label('Telefone')
                            ->placeholder('Digite o Telefone')
                            ->maxLength(191),
                        Forms\Components\Select::make('inviter')
                            ->label('Afiliado')
                            ->placeholder('Selecione um afiliado')
                            ->relationship(name: 'affiliate', titleAttribute: 'name')
                            ->options(
                                fn($get) => User::query()->pluck('name', 'id')
                            )
                            ->searchable()
                            ->preload()
                            ->live(),
                        Forms\Components\DateTimePicker::make('email_verified_at')
                            ->label('Verificação E-mail'),
                    ])->columns(3),
                Forms\Components\Section::make()
                    ->schema([
                        Forms\Components\TextInput::make('affiliate_revenue_share')
                            ->label('Revenue Share (%)')
                            ->required()
                            ->default(2)
                            ->numeric(),
                        Forms\Components\TextInput::make('affiliate_revenue_share_fake')
                            ->label('Revenue Share Fake (%)')
                            ->numeric(),
                        Forms\Components\TextInput::make('affiliate_cpa')
                            ->label('CPA')
                            ->default(10)
                            ->required()
                            ->numeric(),
                        Forms\Components\TextInput::make('affiliate_baseline')
                            ->label('Baseline')
                            ->default(40)
                            ->required()
                            ->numeric(),
                    ])->columns(4),
                Forms\Components\Section::make()
                    ->schema([
                        Forms\Components\Toggle::make('banned')
                            ->label('Conta Demo')
                            ->columnSpanFull()
                        ,
                        
                        Forms\Components\Toggle::make('status')
                            ->label('Status')
                            ->default(true)
                            ->columnSpanFull()
                        ,
                    ]),
                
            ]);
    }

    /**
     * @param Table $table
     * @return Table
     */
    public static function table(Table $table): Table
    {
        return $table
            ->defaultSort('created_at', 'desc')
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->searchable(),
                Tables\Columns\TextColumn::make('indicated_count')
                    ->label('CAD'),
                Tables\Columns\TextColumn::make('total_deposit_amount')
                    ->label('TDA')
                    ->money('BRL'),
                Tables\Columns\TextColumn::make('distinct_inviters_count')
                    ->label('FTD'),
                Tables\Columns\TextColumn::make('inviters_count')
                    ->label('QFTD'),
                Tables\Columns\TextColumn::make('email')
                    ->searchable(),
                    Tables\Columns\TextColumn::make('id')
                    ->searchable(),
                Tables\Columns\TextColumn::make('wallet.total_balance')
                    ->label('Saldo')
                    ->money('BRL'),
                Tables\Columns\TextColumn::make('email_verified_at')
                    ->dateTime()
                    ->toggleable(isToggledHiddenByDefault: true)
                    ->sortable(),
                Tables\Columns\TextColumn::make('created_at')
                    ->label('Data')
                    ->dateTime()
                    ->sortable(),
                Tables\Columns\TextColumn::make('updated_at')
                    ->label('Atualização')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Filter::make('created_at')
                    ->form([
                        DatePicker::make('created_from')->label('Criado a partir de'),
                        DatePicker::make('created_until')->label('Criado até'),
                    ])
                    ->query(function (Builder $query, array $data): Builder {
                        return $query
                            ->when(
                                $data['created_from'],
                                fn (Builder $query, $date): Builder => $query->whereDate('created_at', '>=', $date),
                            )
                            ->when(
                                $data['created_until'],
                                fn (Builder $query, $date): Builder => $query->whereDate('created_at', '<=', $date),
                            );
                    })
                    ->indicateUsing(function (array $data): array {
                        $indicators = [];

                        if ($data['created_from'] ?? null) {
                            $indicators['created_from'] = 'Criado a partir de ' . Carbon::parse($data['created_from'])->toFormattedDateString();
                        }

                        if ($data['created_until'] ?? null) {
                            $indicators['created_until'] = 'Criado até ' . Carbon::parse($data['created_until'])->toFormattedDateString();
                        }

                        return $indicators;
                    })
            ])
            ->actions([
                Tables\Actions\Action::make('details')
                    ->label('Detalhes')
                    ->icon('heroicon-o-chart-bar')
                    ->color('gray')
                    ->action(function(User $user) {
                        return redirect()->to(route('filament.admin.resources.users.detail', ['record' => $user]));
                    }),
                Tables\Actions\ActionGroup::make([
                    Tables\Actions\ViewAction::make(),
                    Tables\Actions\EditAction::make(),
                    Tables\Actions\DeleteAction::make(),
                ]),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->emptyStateActions([
                Tables\Actions\CreateAction::make(),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    /**
     * @return string[]
     */
    public static function getWidgets(): array
    {
        return [
            UserOverview::class,
        ];
    }

    /**
     * @return array|\Filament\Resources\Pages\PageRegistration[]
     */
    public static function getPages(): array
    {
        return [
            'index' => \App\Filament\Admin\Resources\UserResource\Pages\ListUsers::route('/'),
            'create' => \App\Filament\Admin\Resources\UserResource\Pages\CreateUser::route('/create'),
            'edit' => \App\Filament\Admin\Resources\UserResource\Pages\EditUser::route('/{record}/edit'),
            'view' => \App\Filament\Admin\Resources\UserResource\Pages\ViewUser::route('/{record}/view'),
            'detail' => \App\Filament\Admin\Resources\UserResource\Pages\DetailUser::route('/{record}/detail'),
            'password.change' => \App\Filament\Admin\Resources\UserResource\Pages\ChangePasswordUser::route('/{record}/password/change'),
        ];
    }
}
