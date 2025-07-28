<x-filament-panels::page>
    <style>
        @keyframes border-color-animation {
            0% { border-color: #7f3cb9; }
            25% { border-color: #9356c8; }
            50% { border-color: #ba93dc; }
            75% { border-color: #c4a3e1; }
            100% { border-color: #7f3cb9; }
        }
    </style>
    <!-- CARREGAR PROVEDORES E JOGOS  EVERGAME-->
    <div class="w-full p-4 bg-gray-500 shadow-lg" style="background-color: #51515163; border-radius: 20px; border: 5px solid; animation: border-color-animation 4s infinite;">
        <h2 class="mb-5 text-3xl">GalaxsysGaming </h2>
        
        
        <br>
        <div class="flex justify-between w-full gap-4">
            <div class="flex flex-col gap-4 w-full justify-between">
                <button wire:click="loadProviderEvergame" style="border-radius: 10px" class="bg-primary-600 px-3 py-2 w-full text-center">
                    <div wire:loading wire:target="loadProviderEvergame">Carregando Provedores</div>
                    <div wire:loading.remove wire:target="loadProviderEvergame">Carregar Provedores</div>
                </button>

            </div>
            <button wire:click="loadGamesEvergame" style="border-radius: 10px; overflow: hidden; position: relative; background-color: #7f3cb9" class="bg-primary-500 px-3 py-2 w-full">
                <div style="flex flex-col gap-4 w-full justify-between; color: #ffffff;">
                    <div wire:loading wire:target="loadGamesEvergame">
                        <div style="display: flex; align-items: center;">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="display: block; shape-rendering: auto; animation-play-state: running; animation-delay: 0s; max-width: 32px; margin-right: 8px;" width="32px" height="32px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
                                <path fill="none" stroke="#ffffff" stroke-width="8" stroke-dasharray="42.76482137044271 42.76482137044271" d="M24.3 30C11.4 30 5 43.3 5 50s6.4 20 19.3 20c19.3 0 32.1-40 51.4-40 C88.6 30 95 43.3 95 50s-6.4 20-19.3 20C56.4 70 43.6 30 24.3 30z" stroke-linecap="round" style="transform: scale(0.8); transform-origin: 50px 50px 0px; animation-play-state: running; animation-delay: 0s;">
                                    <animate attributeName="stroke-dashoffset" repeatCount="indefinite" dur="1s" keyTimes="0;1" values="0;256.58892822265625" style="animation-play-state: running; animation-delay: 0s;"></animate>
                                </path>
                            </svg>
                            <span style="white-space: nowrap;">Carregando Jogos...</span>
                        </div>
                    </div>
                    <div wire:loading.remove wire:target="loadGamesEvergame">
                        Carregar Jogos
                    </div>
                </div>
            </button>

        </div>
    </div>


    <div class="w-full p-4 bg-gray-500 shadow-lg" style="background-color: #51515163; border-radius: 20px;">
        <h2 class="mb-5 text-3xl">World Slot</h2>
        <hr style="border-color: #4b4b4b8c;padding-bottom: 10px">
        <div class="flex justify-between w-full gap-4">
            <div class="flex flex-col gap-4 w-full justify-between">
                <button style="border-radius: 10px;" wire:click="loadProvider('slot')" class="bg-primary-600 px-3 py-2 w-full text-center">
                    <div wire:loading wire:target="loadProvider('slot')">Carregando Provedores</div>
                    <div wire:loading.remove wire:target="loadProvider('slot')">Carregar Provedor (Slot)</div>
                </button>
                <button style="border-radius: 10px;" wire:click="loadProvider('casino')" class="bg-primary-600 px-3 py-2 w-full">
                    <div wire:loading wire:target="loadProvider('casino')">Carregando Provedores</div>
                    <div wire:loading.remove wire:target="loadProvider('casino')">Carregar Provedor (Casino)</div>
                </button>
                <button style="border-radius: 10px;" wire:click="loadProvider('pachinko')" class="bg-primary-600 px-3 py-2 w-full">
                    <div wire:loading wire:target="loadProvider('pachinko')">Carregando Provedores</div>
                    <div wire:loading.remove wire:target="loadProvider('pachinko')">Carregar Provedor (Pachinko)</div>
                </button>
            </div>
            <button style="border-radius: 10px;" wire:click="loadGames" class="bg-primary-500 px-3 py-2 w-full">
                <div wire:loading wire:target="loadGames">Carregando Jogos</div>
                <div wire:loading.remove wire:target="loadGames">Carregar Jogos</div>
            </button>
        </div>
    </div>


    <div class="w-full p-4 bg-gray-500 shadow-lg" style="background-color: #51515163; border-radius: 20px">
        <h2 class="mb-5 text-3xl">Atualizações</h2>
        <hr style="border-color: #4b4b4b8c;padding-bottom: 10px">

        @if($output)
            <div class="p-4">
                <code>
                    {!! $output !!}
                </code>
            </div>
        @endif

        <div class="flex justify-between w-full gap-4 mb-3">
            <button style="border-radius: 10px;" wire:click="runMigrate" class="bg-primary-600 px-3 py-2 w-full text-center">
                <div wire:loading wire:target="runMigrate">Rodando as migrações</div>
                <div wire:loading.remove wire:target="runMigrate">Rodar as Migrações</div>
            </button>
        </div>
        <br>
        <div class="flex justify-between w-full gap-4 mb-3">
            <button style="border-radius: 10px;" wire:click="runMigrateWithSeed" class="bg-primary-600 px-3 py-2 w-full text-center">
                <div wire:loading wire:target="runMigrateWithSeed">Rodando as migrações com seed</div>
                <div wire:loading.remove wire:target="runMigrateWithSeed">Rodar as Migrações com Seed</div>
            </button>
        </div>

        <br>
        <br>

        <form wire:submit="submit" class="mt-5">
            {{ $this->form }}

            <br>
            <x-filament::button type="submit" form="submit" class="w-full">
                Carregar Arquivo
            </x-filament::button>
        </form>
    </div>



</x-filament-panels::page>
