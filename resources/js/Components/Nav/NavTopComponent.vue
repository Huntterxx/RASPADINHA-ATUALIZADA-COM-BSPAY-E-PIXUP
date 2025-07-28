<template>

    <nav class="fixed navbar top-0 z-50 w-full navtop-color border-none custom-box-shadow">
        <!-- <topbar></topbar>-->
        <div class="px-3 lg:px-5 lg:pl-3 nav-menu">
            <div class="flex items-center justify-between">
                <div class="flex items-center justify-start py-3">
                    <button @click.prevent="toggleMenu" type="button"
                        class="inline-flex items-center p-2 text-sm text-gray-500 rounded-lg sm:hidden focus:outline-none dark:text-gray-400">
                        <span class="sr-only">Open sidebar</span>
                        <svg :class="{ 'rotate-180': isMenuOpen }" class="w-6 h-6 transition-transform duration-300"
                            aria-hidden="true" fill="#FFC5C7" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path
                                d="M1.62517 14.0283C1.36457 14.0283 1.11456 13.9247 0.930296 13.7405C0.746027 13.5562 0.642431 13.3063 0.642431 13.0457C0.642431 12.7851 0.746027 12.5351 0.930296 12.3509C1.11456 12.1666 1.36457 12.0631 1.62517 12.0631H8.17569C8.43629 12.0631 8.68589 12.1666 8.87016 12.3509C9.05443 12.5351 9.15803 12.7851 9.15803 13.0457C9.15803 13.3063 9.05443 13.5562 8.87016 13.7405C8.68589 13.9247 8.43629 14.0283 8.17569 14.0283H1.62517ZM11.7144 13.6008C11.6228 13.5095 11.5501 13.4011 11.5005 13.2816C11.4509 13.1622 11.4254 13.0342 11.4254 12.9048C11.4254 12.7755 11.4509 12.6475 11.5005 12.528C11.5501 12.4086 11.6228 12.3001 11.7144 12.2088L14.0014 9.92107H1.62517C1.36457 9.92107 1.11456 9.81755 0.930296 9.63328C0.746027 9.44901 0.642431 9.19909 0.642431 8.9385C0.642431 8.6779 0.746027 8.42798 0.930296 8.24371C1.11456 8.05944 1.36457 7.95592 1.62517 7.95592H14.0014L11.7144 5.66814C11.5298 5.48356 11.4262 5.23321 11.4262 4.97216C11.4262 4.71111 11.5298 4.46075 11.7144 4.27616C11.899 4.09157 12.1495 3.98787 12.4105 3.98787C12.6715 3.98787 12.922 4.09157 13.1066 4.27616L17.0703 8.24005C17.1619 8.33133 17.2346 8.4398 17.2842 8.55924C17.3338 8.67867 17.3594 8.80671 17.3594 8.93603C17.3594 9.06536 17.3338 9.19341 17.2842 9.31284C17.2346 9.43228 17.1619 9.54075 17.0703 9.63203L13.1066 13.5959C13.0153 13.6875 12.9066 13.7602 12.7871 13.8098C12.6677 13.8594 12.5398 13.8849 12.4105 13.8849C12.2812 13.8849 12.1529 13.8594 12.0335 13.8098C11.914 13.7602 11.8057 13.6875 11.7144 13.5959V13.6008ZM1.62517 5.82208C1.36457 5.82208 1.11456 5.71856 0.930296 5.5343C0.746027 5.35003 0.642431 5.10011 0.642431 4.83951C0.642431 4.57891 0.746027 4.32899 0.930296 4.14472C1.11456 3.96045 1.36457 3.85693 1.62517 3.85693H8.17569C8.43629 3.85693 8.68589 3.96045 8.87016 4.14472C9.05443 4.32899 9.15803 4.57891 9.15803 4.83951C9.15803 5.10011 9.05443 5.35003 8.87016 5.5343C8.68589 5.71856 8.43629 5.82208 8.17569 5.82208H1.62517Z">
                            </path>
                        </svg>
                    </button>

                    <a v-if="setting" href="/" class="flex ml-2 md:mr-24">
                        <div class="hidden sm:block">
                            <img :src="`/storage/${setting.software_logo_black}`" alt="Logo Black"
                                class="h-8 mr-3 block dark:hidden" />
                            <img :src="`/storage/${setting.software_logo_white}`" alt="Logo White"
                                class="h-8 mr-3 hidden dark:block" />
                        </div>
                        <div class="block sm:hidden">
                            <img :src="`/storage/${setting.software_favicon}`" class="h-10 mr-6" alt="Favicon" />
                        </div>
                    </a>
                    <a v-else href="/" class="flex ml-2 md:mr-24">
                        <div class="hidden sm:block">
                            <img src="https://worldgamesbr.com.br/wp-content/uploads/2024/06/1787844216616329218-1.png"
                                alt="Default Logo Black" class="h-8 mr-3 block dark:hidden" />
                            <img src="https://worldgamesbr.com.br/wp-content/uploads/2024/06/1787844216616329218-1.png"
                                alt="Default Logo White" class="h-8 mr-3 hidden dark:block" />
                        </div>
                        <div class="block sm:hidden">
                            <img src="https://worldgamesbr.com.br/wp-content/uploads/2024/06/1787844216616329218-1.png"
                                class="h-10 mr-6" alt="Default Favicon" />
                        </div>
                    </a>

                </div>
                <div class="hidden md:block">

                </div>
                <div v-if="!simple" class="flex items-center py-3">

                    <div v-if="!isAuthenticated" class="flex ml-5">
                        <button @click.prevent="loginToggle" class="crieihj">{{ $t('Log in') }}</button>
                        <button @click.prevent="registerToggle" class="ui-button-blue ml-3 mr-3 rounded">{{
                            $t('Registro') }}</button>
                    </div>


                    <div v-if="isAuthenticated" class="flex items-center">
                        <WalletBalance />
                        <MakeDeposit :showMobile="false" :title="$t('Deposit')" />



                        <div class="flex items-center ml-3">
                            <div>
                                <button type="button"
                                    class="flex text-sm bg-gray-800 rounded-full focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600"
                                    aria-expanded="false" data-dropdown-toggle="dropdown-user">
                                    <span class="sr-only">Open user menu</span>
                                    <img class="w-8 h-8 rounded-full"
                                        :src="userData?.avatar ? '/storage/' + userData.avatar : `/assets/images/profile.jpg`"
                                        alt="">
                                </button>
                            </div>
                            <div class="z-50 hidden my-4 text-base list-none bg-white divide-y divide-gray-100 rounded shadow dark:bg-gray-700 dark:divide-gray-600"
                                id="dropdown-user">
                                <div class="px-4 py-3" role="none">
                                    <p class="text-sm text-gray-900 dark:text-white" role="none">
                                        {{ userData?.name }}
                                    </p>
                                    <p class="text-sm font-medium text-gray-900 truncate dark:text-gray-300"
                                        role="none">
                                        ID: {{ userId }}
                                    </p>

                                </div>
                                <ul class="py-1" role="none">
                                    <li>
                                        <RouterLink :to="{ name: 'home' }" active-class="link-active"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600 dark:hover:text-white">
                                            <span class="w-8 h-8 mr-3">
                                                <i class="fa-duotone fa-house"></i>
                                            </span>
                                            {{ $t('Dashboard') }}
                                        </RouterLink>
                                    </li>


                                    <li>
                                        <RouterLink :to="{ name: 'profileWithdraw' }" active-class="profile-menu-active"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600 dark:hover:text-white">
                                            <span class="w-8 h-8 mr-3">
                                                <i class="fa-light fa-money-bill-transfer"></i>
                                            </span>
                                            {{ $t('Withdraw') }}
                                        </RouterLink>
                                    </li>

                                    <li>
                                        <a href="#" @click.prevent="profileToggle"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600 dark:hover:text-white"
                                            role="menuitem">
                                            <span class="w-8 h-8 mr-3">
                                                <i class="fa-regular fa-id-card-clip"></i>
                                            </span>
                                            {{ $t('My Profile') }}
                                        </a>
                                    </li>
                                    <li>
                                        <a @click.prevent="logoutAccount" href="#"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600 dark:hover:text-white"
                                            role="menuitem">
                                            <span class="w-8 h-8 mr-3">
                                                <i class="fa-duotone fa-right-from-bracket"></i>
                                            </span>
                                            {{ $t('Sign out') }}
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <transition name="fade">
            <div v-if="showSearchMenu" class="fixed top-0 left-0 right-0 bottom-0 flex items-center justify-center ">
                <div @click="toggleSearch" class="absolute inset-0 carousel_banners opacity-50 cursor-pointer"></div>

                <!-- Start searchbar action -->
                <div class="search-menu p-4 sm:ml-64">

                    <div class="mb-5 w-full">
                        <div class="md:w-4/6 2xl:w-4/6 mx-auto">
                            <div class="flex flex-col">
                                <div class="relative w-full">
                                    <input type="search" v-model="searchTerm"
                                        class="block dark:focus:border-green-500 p-2.5 w-full z-20 text-sm text-gray-900 input-color-primary rounded-lg border focus:outline-none dark:border-gray-600 dark:placeholder-gray-400 dark:text-white "
                                        placeholder="Nome do jogo | Provedor" required>

                                    <button v-if="searchTerm.length > 0" @click.prevent="clearData" type="button"
                                        class="absolute top-0 end-0 h-full p-2.5 text-sm font-medium text-white rounded-e-lg dark:bg-[#1C1E22] ">
                                        <span class="">Recusar</span>
                                    </button>
                                </div>
                                <div class="text-center mt-4">
                                    <p>A pesquisa requer pelo menos 3 caracteres</p>
                                </div>
                            </div>

                            <div v-if="!isLoadingSearch" class="mt-8 grid grid-cols-3 md:grid-cols-6 gap-4 py-5">
                                <CassinoGameCard v-if="games" v-for="(game, index) in games?.data" :index="index"
                                    :title="game.game_name" :cover="game.cover" :gamecode="game.game_code"
                                    :type="game.distribution" :game="game" />
                            </div>
                            <div v-else
                                class="relative items-center block max-w-sm p-6 bg-white border border-gray-100 rounded-lg shadow-md dark:bg-gray-800 dark:border-gray-800 dark:hover:bg-gray-700">
                                <h5
                                    class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white opacity-20">
                                    Noteworthy technology acquisitions 2021</h5>
                                <p class="font-normal text-gray-700 dark:text-gray-400 opacity-20">Here are the biggest
                                    enterprise technology acquisitions of 2021 so far, in reverse chronological order.
                                </p>
                                <div role="status" class="absolute -translate-x-1/2 -translate-y-1/2 top-2/4 left-1/2">
                                    <svg aria-hidden="true"
                                        class="w-8 h-8 text-gray-200 animate-spin dark:text-gray-600 fill-blue-600"
                                        viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path
                                            d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
                                            fill="currentColor" />
                                        <path
                                            d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
                                            fill="currentFill" />
                                    </svg>
                                    <span class="sr-only">Loading...</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End searchbar action -->


            </div>
        </transition>

    </nav>

    <div id="modalElAuth" tabindex="-1" aria-hidden="true"
        class="fixed top-0 left-0 right-0 z-50 hidden w-full overflow-x-hidden overflow-y-auto md:inset-0 h-screen md:h-[calc(100%-1rem)] max-h-full">
        <div class="relative w-full max-w-3xl max-h-full bg-base rounded-lg shadow-lg">
            <div class="flex md:justify-between">
                <!-- <div class="w-full p-0 hidden md:block">
                    <img :src="`/assets/images/loading.png`" alt="" class="w-full h-full">
                </div>-->
                <div class="w-full relative p-5">
                    <div v-if="isLoadingLogin"
                        class="absolute top-0 left-0 right-0 bottom-0 bg-white/70 dark:bg-gray-800/70 z-[999]">
                        <div role="status" class="absolute -translate-x-1/2 -translate-y-1/2 top-2/4 left-1/2">
                            <svg aria-hidden="true"
                                class="w-10 h-10 mr-2 text-gray-200 animate-spin dark:text-gray-600 fill-green-600"
                                viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
                                    fill="currentColor" />
                                <path
                                    d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
                                    fill="currentFill" />
                            </svg>
                            <span class="sr-only">Loading...</span>
                        </div>
                    </div>

                    <form @submit.prevent="loginSubmit" method="post" action="" class="">
                        <div class="flex justify-between mb-6">
                            <h5 class="mb-3 font-bold text-xl">{{ $t('Log in') }}</h5>
                            <a @click.prevent="loginToggle" href="">
                                <i class="fa-solid fa-xmark"></i>
                            </a>
                        </div>

                        <div class="relative mb-3"
                            style="border: 1px solid #FFC5C7; border-radius: 10px; color: #FFC5C7;">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3.5 pointer-events-none">
                                <i class="fa-regular fa-user text-success-emphasis"></i>
                            </div>
                            <input type="text" name="name" v-model="loginForm.email" class="input-group"
                                :placeholder="$t('Nome de Usuário')" style="color: white;" required>
                        </div>

                        <div class="relative mb-6"
                            style="border: 1px solid #FFC5C7; border-radius: 10px; color: #FFC5C7;">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3.5 pointer-events-none">
                                <i class="fa-regular fa-lock text-success-emphasis"></i>
                            </div>
                            <input required :type="typeInputPassword" v-model="loginForm.password" name="password"
                                class="input-group pr-[40px]" :placeholder="$t('Digite sua senha')">
                            <button type="button" @click.prevent="togglePassword"
                                class="absolute inset-y-0 right-0 flex items-center pr-3.5 ">
                                <i v-if="typeInputPassword === 'password'" class="fa-regular fa-eye"></i>
                                <i v-if="typeInputPassword === 'text'" class="fa-sharp fa-regular fa-eye-slash"></i>
                            </button>
                        </div>
                        <a href="/forgot-password" class="text-white text-sm">{{ $t('Forgot password') }}</a>

                        <div class="mt-3 w-full">
                            <button type="submit" class="botaobluezin rounded w-full mb-3">
                                {{ $t('Log in') }}
                            </button>
                        </div>
                        <p class="text-sm text-gray-500 dark:text-gray-300 mb-6">Novo por aqui? <a href=""
                                @click.prevent="hideLoginShowRegisterToggle"><strong>Criar conta</strong></a></p>
                    </form>

                    <!-- <div class="login-wrap mt-5">
                        <div class="line-text">
                            <div class="l"></div>
                            <div class="t">{{ $t('Log in directly with') }}</div>
                            <div class="l"></div>
                        </div>

                        <div class="social-group mt-3">
                            <a :href="redirectSocialTo()" class="text-green-700 hover:text-white border border-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium text-sm px-5 py-2.5 text-center mr-2 mb-2 dark:border-blue-500 dark:text-blue-500 dark:hover:text-white dark:hover:bg-blue-600 dark:focus:ring-blue-800">
                                <i class="fa-brands fa-google"></i>
                            </a>
                        </div>
                    </div>-->
                </div>
            </div>
        </div>
    </div>

    <div id="modalElRegister" tabindex="-1" aria-hidden="true"
        class="fixed top-0 left-0 right-0 z-50 hidden w-full overflow-x-hidden overflow-y-auto md:inset-0 h-screen md:h-[calc(100%-1rem)] max-h-full">
        <div class="relative w-full max-w-3xl max-h-full bg-base rounded-lg shadow-lg">
            <div v-if="isLoadingRegister"
                class="absolute top-0 left-0 right-0 bottom-0 bg-white/70 dark:bg-gray-800/70 z-[999]">
                <div role="status" class="absolute -translate-x-1/2 -translate-y-1/2 top-2/4 left-1/2">
                    <svg aria-hidden="true"
                        class="w-10 h-10 mr-2 text-gray-200 animate-spin dark:text-gray-600 fill-blue-600"
                        viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path
                            d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
                            fill="currentColor" />
                        <path
                            d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
                            fill="currentFill" />
                    </svg>
                    <span class="sr-only">Loading...</span>
                </div>
            </div>

            <div class="flex md:justify-between h-full">
                <!-- <div class="w-full p-0 hidden md:block dark:bg-[#1A1C1F]">
                    <img :src="`/assets/images/loading.png`" alt="" class="w-full h-full">
                </div>-->

                <div class="w-full relative p-5 m-auto">


                    <form @submit.prevent="registerSubmit" method="post" action="" class="">
                        <div class="flex justify-between mb-6">
                            <h5 class="mb-3 font-bold text-xl" style="color:#FFC5C7">{{ $t('Registre sua conta') }}</h5>
                            <a @click.prevent="registerToggle" href="">
                                <i class="fa-solid fa-xmark"></i>
                            </a>
                        </div>

                        <div class="relative mb-3"
                            style="border: 1px solid #FFC5C7; border-radius: 10px; color: #FFC5C7;">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3.5 pointer-events-none">
                                <i class="fa-regular fa-user text-success-emphasis"></i>
                            </div>
                            <input type="text" name="name" v-model="registerForm.email" class="input-group"
                                :placeholder="$t('Nome de Usuário')" style="color: white;" required>
                        </div>

                        <!--<div class="relative mb-3" style="border: 1px solid #7DB39E; border-radius: 10px; color: #7DB39E;">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3.5 pointer-events-none">
                                <i class="fa-regular fa-envelope text-success-emphasis"></i>
                            </div>
                            <input type="email" name="email" v-model="registerForm.email" class="input-group"
                                :placeholder="$t('Digite seu Email')" required>
                        </div>

                         <div class="relative mb-3">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3.5 pointer-events-none">
                                <i class="fa-light fa-address-card text-
                                success-emphasis"></i>
                            </div>
                            <input type="text"
                                   name="cpf"
                                   v-model="registerForm.cpf"
                                   class="input-group"
                                   :placeholder="$t('Enter cpf')"
                                   required
                            >
                        </div>-->

                        <div class="relative mb-3"
                            style="border: 1px solid #FFC5C7; border-radius: 10px; color: #FFC5C7;">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3.5 pointer-events-none">
                                <i class="fa-regular fa-lock text-success-emphasis"></i>
                            </div>
                            <input :type="typeInputPassword" name="password" v-model="registerForm.password"
                                class="input-group pr-[40px] text-green-200" :placeholder="$t('Senha')" required>
                            <button type="button" @click.prevent="togglePassword"
                                class="absolute inset-y-0 right-0 flex items-center pr-3.5 ">
                                <i v-if="typeInputPassword === 'password'" class="fa-regular fa-eye"></i>
                                <i v-if="typeInputPassword === 'text'" class="fa-sharp fa-regular fa-eye-slash"></i>
                            </button>
                        </div>

                        <div class="relative mb-3"
                            style="border: 1px solid #FFC5C7; border-radius: 10px; color: #FFC5C7;">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3.5 pointer-events-none">
                                <i class="fa-regular fa-id-card text-success-emphasis"></i>
                            </div>
                            <input type="text" name="name" v-model="registerForm.name" class="input-group"
                                :placeholder="('Preencha o nome verdadeiro e torne-o conveniente')"
                                style="color: white;" required>
                        </div>

                        <!--<div class="relative mb-3">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3.5 pointer-events-none">
                                <i class="fa-regular fa-lock text-success-emphasis"></i>
                            </div>
                            <input :type="typeInputPassword"
                                   name="password_confirmation"
                                   v-model="registerForm.password_confirmation"
                                   class="input-group pr-[40px]"
                                   :placeholder="$t('Confirm the Password')"
                                   required
                            >
                            <button type="button" @click.prevent="togglePassword" class="absolute inset-y-0 right-0 flex items-center pr-3.5">
                                <i v-if="typeInputPassword === 'password'" class="fa-regular fa-eye"></i>
                                <i v-if="typeInputPassword === 'text'" class="fa-sharp fa-regular fa-eye-slash"></i>
                            </button>
                        </div>-->
                        <!-- <div class="relative mb-3">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3.5 pointer-events-none">
                                <i class="fa-regular fa-phone"></i>
                            </div>
                            <input type="text"
                                   name="phone"
                                   v-maska
                                   data-maska="[
                                    '(##) ####-####',
                                    '(##) #####-####'
                                  ]"
                                   v-model="registerForm.phone"
                                   class="input-group"
                                   :placeholder="$t('Enter your phone')"
                                   required
                            >
                        </div>-->
                        <div class="mb-3 mt-5">
                            <button @click.prevent="isReferral = !isReferral" type="button"
                                class="flex justify-between w-full">
                                <p>{{ $t('Enter Referral/Promo Code') }}</p>
                                <div class="">
                                    <i v-if="isReferral" class="fa-solid fa-chevron-up"></i>
                                    <i v-if="!isReferral" class="fa-solid fa-chevron-down"></i>
                                </div>
                            </button>
                            <div v-if="isReferral" class="relative mb-3 mt-1">
                                <div class="absolute inset-y-0 left-0 flex items-center pl-3.5 pointer-events-none">
                                    <i class="fa-regular fa-user text-success-emphasis"></i>
                                </div>
                                <input type="text" name="name" v-model="registerForm.reference_code" class="input-group"
                                    :placeholder="$t('Code')">
                            </div>
                        </div>

                            <div class="mb-3 mt-5">

                                <label class="ant-checkbox-wrapper custom-checkbox" :class="[customClasses]">
                                    <span class="ant-checkbox" :class="{ 'ant-checkbox-checked': isChecked }">
                                        <input type="checkbox" class="ant-checkbox-input" v-model="isChecked">
                                        <span class="ant-checkbox-inner"></span>
                                    </span>
                                    <span style="color: white;">
                                        <span>
                                            Tenho 18 anos, li e concordo com
                                            <span :data-user-agreement="true" style="color: #FFE1C9;">《Contrato do
                                                usuário》</span>
                                        </span>
                                    </span>
                                </label>





                            </div>



                            <!--<div class="mb-3 mt-11">
                            <div class="flex">
                                <input id="link-checkbox" v-model="registerForm.term_a" name="term_a" required type="checkbox" value="" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
                                <label for="link-checkbox" class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-300">{{ $t('I agree to the User Agreement & confirm I am at least 18 years old') }}</label>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="flex items-center">
                                <input id="link-checkbox-b" v-model="registerForm.agreement" name="term_b" required type="checkbox" value="" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
                                <label for="link-checkbox-b" class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-300">{{ $t('I agree with the') }} <a href="#" class="text-blue-600 dark:text-blue-500 hover:underline">{{ $t('terms and conditions') }}</a>.</label>
                            </div>
                        </div>-->

                            <div class="mt-5 w-full">
                                <button type="submit" class="botaobluezin rounded w-full mb-3">
                                    {{ $t('Register') }}
                                </button>
                            </div>
                    </form>

                    <div class="p-4 flex justify-around text-white rosinha">
                        <a href="#" class="hover:underline">Suporte</a>
                        <a href="#" class="hover:underline">Jogar Grátis</a>
                        <a href="#" class="hover:underline" @click="loginToggle">Login Agora</a>
                    </div>


                    <!--<div class="login-wrap mt-5">
                        <div class="line-text">
                            <div class="l"></div>
                            <div class="t">{{ $t('Register with your social networks') }}</div>
                            <div class="l"></div>
                        </div>

                        <div class="social-group mt-3">
                            <a :href="redirectSocialTo()" class="text-blue-700 hover:text-white border border-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium text-sm px-5 py-2.5 text-center mr-2 mb-2 dark:border-blue-500 dark:text-blue-500 dark:hover:text-white dark:hover:bg-blue-600 dark:focus:ring-blue-800">
                                <i class="fa-brands fa-google"></i>
                            </a>
                        </div>
                    </div>-->
                </div>
            </div>
        </div>
    </div>

    <div id="modalProfileEl" tabindex="-1" aria-hidden="true"
        class="fixed top-0 left-0 right-0 z-50 hidden w-full overflow-x-hidden overflow-y-auto md:inset-0 h-screen md:h-[calc(100%-1rem)] max-h-full flex items-center justify-center">
        <div class="relative w-full max-w-2xl md:max-w-lg max-h-full bg-white dark:bg-gray-900 rounded-lg shadow-lg">
            <div v-if="!isLoadingProfile" class="flex flex-col">

                <!-- PROFILE HEADER -->
                <div class="flex justify-between w-full p-4">
                    <h1 class="text-2xl font-bold">{{ $t('User data') }}</h1>
                    <button @click.prevent="profileToggle" type="button" class="text-2xl">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>

                <!-- PROFILE BODY -->
                <div v-if="profileUser != null" class="flex flex-col w-full p-4 bgperfil rounded-lg text-white">
                    <!-- PROFILE INFO -->
                    <div class="flex items-center justify-between w-full">
                        <div class="text-center flex flex-col justify-center items-center">
                            <div class="relative">
                                <img class="w-24 h-24 p-1 rounded-full ring-2 ring-gray-300"
                                    :src="profileUser.avatar || 'https://worldgamesbr.com.br/wp-content/uploads/2024/06/img_txn23.png'"
                                    alt="Profile Picture">
                            </div>
                            <div class="mt-2">
                                <span>Conta: {{ profileUser.username }}</span>
                                <span class="block">ID: {{ userId }} <i @click="copyId"
                                        class="fa-duotone fa-copy cursor-pointer"></i></span>
                            </div>
                        </div>
                        <div class="flex flex-col items-center">
                            <div class="flex items-center space-x-1">
                                <span>🇧🇷</span>
                                <span>{{ profileUser.currency }}</span>
                            </div>
                            <div>
                                <span class="text-xl font-bold">{{ profileUser.balance }}</span>
                            </div>
                        </div>
                    </div>

                    <div class="py-3 text-center">
                        <p>ingressou {{ profileUser.dateHumanReadable }}</p>
                    </div>

                    <!-- PROFILE MENU -->
                    <ul class="mt-4">
                        <li>
                            <RouterLink :to="{ name: 'profileDeposit' }" active-class="profile-menu-active"
                                class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600 dark:hover:text-white">
                                <span class="w-8 h-8 mr-3">
                                    <i class="fa-regular fa-money-bill-trend-up"></i>
                                </span>
                                {{ $t('Deposit') }}
                            </RouterLink>
                        </li>
                        <li>
                            <RouterLink :to="{ name: 'profileWithdraw' }" active-class="profile-menu-active"
                                class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600 dark:hover:text-white">
                                <span class="w-8 h-8 mr-3">
                                    <i class="fa-light fa-money-bill-transfer"></i>
                                </span>
                                {{ $t('Withdraw') }}
                            </RouterLink>
                        </li>
                    </ul>
                </div>


            </div>
            <div v-if="isLoadingProfile" class="flex flex-col w-full h-full">
                <div role="status" class="absolute -translate-x-1/2 -translate-y-1/2 top-2/4 left-1/2">
                    <svg aria-hidden="true" class="w-8 h-8 text-gray-200 animate-spin dark:text-gray-600 fill-blue-600"
                        viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path
                            d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
                            fill="currentColor" />
                        <path
                            d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
                            fill="currentFill" />
                    </svg>
                    <span class="sr-only">{{ $t('Loading') }}...</span>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { RouterLink, useRoute } from "vue-router";
import { sidebarStore } from "@/Stores/SideBarStore.js";
import { Modal } from 'flowbite';
import { useAuthStore } from "@/Stores/Auth.js";
import { useToast } from "vue-toastification";
import { useRouter } from 'vue-router';
import WalletBalance from "@/Components/UI/WalletBalance.vue";
import HttpApi from "@/Services/HttpApi.js";
import MakeDeposit from "@/Components/UI/MakeDeposit.vue";
import { useSettingStore } from "@/Stores/SettingStore.js";
import { searchGameStore } from "@/Stores/SearchGameStore.js";
import CassinoGameCard from "@/Pages/Cassino/Components/CassinoGameCard.vue";

export default {
    props: ['simple'],
    components: { CassinoGameCard, MakeDeposit, WalletBalance, RouterLink },
    data() {
        return {
            isLoadingLogin: false,
            isLoadingRegister: false,
            isReferral: false,
            modalAuth: null,
            modalRegister: null,
            modalProfile: null,
            typeInputPassword: 'password',
            readonly: false,
            profileUser: null,
            loginForm: {
                email: '',
                password: '',
            },
            registerForm: {
                name: '',
                email: '',
                password: '',
                password_confirmation: '',
                reference_code: '',
                term_a: false,
                agreement: false,
            },
            avatarUrl: '/assets/images/account.svg',
            isLoadingProfile: false,
            profileName: '',
            sumBets: 0,
            totalBets: 0,
            totalEarnings: 0,
            showSearchMenu: false,
            games: null,
            searchTerm: '',
            isLoadingSearch: true,
        }
    },
    setup() {
        const router = useRouter();
        const route = useRoute();
        return {
            router,
            route
        };
    },
    computed: {
        searchGameDataStore() {
            return searchGameStore();
        },
        searchGameMenu() {
            const search = searchGameStore();
            return search.getSearchGameStatus;
        },
        sidebarMenuStore() {
            return sidebarStore();
        },
        isAuthenticated() {
            const authStore = useAuthStore();
            return authStore.isAuth;
        },
        userData() {
            const authStore = useAuthStore();
            return authStore.user;
        },
        setting() {
            const authStore = useSettingStore();
            return authStore.setting;
        }
    },
    unmounted() { },
    mounted() {
        this.modalProfile = new Modal(document.getElementById('modalProfileEl'), {
            placement: 'center',
            backdrop: 'dynamic',
            backdropClasses: 'bg-gray-700 bg-opacity-50 dark:bg-opacity-80 fixed inset-0 z-40',
            closable: false,
            onHide: () => { },
            onShow: () => { },
            onToggle: () => { },
        });
        this.modalAuth = new Modal(document.getElementById('modalElAuth'), {
            placement: 'center',
            backdrop: 'dynamic',
            closable: false,
            onHide: () => { },
            onShow: () => { },
            onToggle: () => { },
        });
        this.modalRegister = new Modal(document.getElementById('modalElRegister'), {
            placement: 'center',
            backdrop: 'dynamic',
            backdropClasses: 'bg-gray-700 bg-opacity-50 dark:bg-opacity-80 fixed inset-0 z-40',
            closable: false,
            onHide: () => { },
            onShow: () => { },
            onToggle: () => { },
        });
        if (!this.isAuthenticated && this.route.path === '/') {
            this.modalRegister.show();
        }

        if (this.route.query.code) {
            this.registerForm.reference_code = this.route.query.code;
            this.modalRegister.show();
        }
    },
    methods: {
        toggleSearch: function () {
            this.searchGameDataStore.setSearchGameToogle();
        },
        redirectSocialTo: function () {
            return '/auth/redirect/google'
        },
        like: async function (id) {
            const _this = this;
            const _toast = useToast();
            await HttpApi.post('/profile/like/' + id, {})
                .then(response => {
                    _this.getProfile();
                    _toast.success(_this.$t(response.data.message));
                })
                .catch(error => {
                    Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => {
                        _toast.error(`${value}`);
                    });
                });
        },
        updateName: async function (event) {
            const _this = this;
            _this.isLoadingProfile = true;
            await HttpApi.post('/profile/updateName', { name: _this.profileName })
                .then(response => {
                    _this.isLoadingProfile = false;
                })
                .catch(error => {
                    const _this = this;
                    Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => { });
                    _this.isLoadingProfile = false;
                });
        },
        togglePassword: function () {
            if (this.typeInputPassword === 'password') {
                this.typeInputPassword = 'text';
            } else {
                this.typeInputPassword = 'password';
            }
        },
        loginSubmit: function (event) {
            const _this = this;
            const _toast = useToast();
            _this.isLoadingLogin = true;
            const authStore = useAuthStore();
            HttpApi.post('auth/login', _this.loginForm)
                .then(async response => {
                    await new Promise(r => {
                        setTimeout(() => {
                            authStore.setToken(response.data.access_token);
                            authStore.setUser(response.data.user);
                            authStore.setIsAuth(true);
                            _this.loginForm = {
                                email: '',
                                password: '',
                            }
                            _this.modalAuth.toggle();
                            _toast.success(_this.$t('You have been authenticated, welcome!'));
                            _this.isLoadingLogin = false;
                        }, 1000)
                    });
                })
                .catch(error => {
                    const _this = this;
                    Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => {
                        _toast.error(`${value}`);
                    });
                    _this.isLoadingLogin = false;
                });
        },
        registerSubmit: async function (event) {
            const _this = this;
            const _toast = useToast();
            _this.isLoadingRegister = true;
            const authStore = useAuthStore();
            await HttpApi.post('auth/register', _this.registerForm)
                .then(response => {
                    if (response.data.access_token !== undefined) {
                        authStore.setToken(response.data.access_token);
                        authStore.setUser(response.data.user);
                        authStore.setIsAuth(true);
                        _this.registerForm = {
                            name: '',
                            email: '',
                            password: '',
                            password_confirmation: '',
                            reference_code: '',
                            term_a: false,
                            agreement: false,
                        }
                        _this.modalRegister.toggle();
                        _this.router.push({ name: 'profileDeposit' });
                        _toast.success(_this.$t('Your account has been created successfully'));
                    }
                    _this.isLoadingRegister = false;
                })
                .catch(error => {
                    Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => {
                        _toast.error(`${value}`);
                    });
                    _this.isLoadingRegister = false;
                });
        },
        logoutAccount: function () {
            const authStore = useAuthStore();
            const _toast = useToast();
            HttpApi.post('auth/logout', {})
                .then(response => {
                    authStore.logout();
                    this.router.push({ name: 'home' });
                    _toast.success(this.$t('You have been successfully disconnected'));
                })
                .catch(error => {
                    Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => {
                        console.log(value);
                    });
                });
        },
        hideLoginShowRegisterToggle: function () {
            this.modalAuth.toggle();
            this.modalRegister.toggle();
        },
        toggleMenu: function () {
            this.sidebarMenuStore.setSidebarToogle();
        },
        loginToggle: function () {
            this.modalAuth.toggle();
        },
        registerToggle: function () {
            this.modalRegister.toggle();
        },
        profileToggle: function () {
            this.modalProfile.toggle();
        },
        openFileInput() {
            this.$refs.fileInput.click();
        },
        async handleFileChange(event) {
            const file = event.target.files[0];
            const formData = new FormData();
            formData.append('avatar', file);
            const reader = new FileReader();
            reader.onload = () => {
                this.avatarUrl = reader.result;
            };
            reader.readAsDataURL(file);
            await HttpApi.post('/profile/upload-avatar', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            }).then(response => {
                console.log('Avatar atualizado com sucesso', response.data);
            })
                .catch(error => {
                    console.error('Erro ao atualizar avatar', error);
                });
        },
        getProfile: async function () {
            const _this = this;
            _this.isLoadingProfile = true;
            await HttpApi.get('/profile/')
                .then(response => {
                    _this.sumBets = response.data.sumBets;
                    _this.totalBets = response.data.totalBets;
                    _this.totalEarnings = response.data.totalEarnings;
                    const user = response.data.user;
                    if (user?.avatar != null) {
                        _this.avatarUrl = '/storage/' + user.avatar;
                    }
                    _this.profileName = user.name;
                    _this.profileUser = user;
                    _this.isLoadingProfile = false;
                })
                .catch(error => {
                    const _this = this;
                    Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => { });
                    _this.isLoadingProfile = false;
                });
        },
        getSearch: async function () {
            const _this = this;
            await HttpApi.get('/search/games?searchTerm=' + this.searchTerm)
                .then(response => {
                    _this.games = response.data.games;
                    _this.isLoadingSearch = false;
                })
                .catch(error => {
                    const _this = this;
                    Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => { });
                    _this.isLoadingSearch = false;
                });
        },
        clearData: async function () {
            this.searchTerm = '';
            await this.getSearch();
        }
    },
    async created() {
        if (this.isAuthenticated) {
            await this.getProfile();
        }
    },
    watch: {
        searchTerm(newValue, oldValue) {
            this.getSearch();
        },
        async searchGameMenu(newValue, oldValue) {
            await this.getSearch();
            this.showSearchMenu = !this.showSearchMenu;
        },
    },
};
</script>


<style scoped>
.rotate-180 {
    transform: rotate(180deg);
}
</style>
