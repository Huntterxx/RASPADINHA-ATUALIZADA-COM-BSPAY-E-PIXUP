<template>
    <BaseLayout>
        <div class="container mx-auto p-4 mt-20 relative  min-h-[calc(100vh-565px)]">
            <div v-if="wallet && !isLoading" class="grid grid-cols-1 md:grid-cols-3 gap-0 md:gap-4">
                <div v-if="isShowForm" class="col-span-1 bg-gray-100 rounded-bl-lg rounded-br-lg mb-3"
                    style="background-color: #DF6061;">
                    <div class="flex flex-col w-full p-5 rounded-lg" style="background-color: #c94f50;">
                        <div class="invite-bg ">
                            <h1 class="text-white tex-lg md:text-2xl font-bold">{{ $t('CONVIDAR') }}:</h1>

                            <!--                            <div class="mt-5">-->
                            <!--                                <p class="mb-1 text-white tex-sm md:text-base"><strong class="text-yellow-400">$1,000.00</strong> {{ $t('REFERRAL REWARDS') }}</p>-->
                            <!--                                <p class="mb-1 text-white tex-sm md:text-base"><strong class="text-yellow-400">{{ state.currencyFormat(parseFloat(userData.affiliate_cpa), wallet.currency) }}%</strong> {{ $t('COMMISSION REWARDS') }}</p>-->
                            <!--                            </div>-->
                        </div>
                    </div>

                    <div
                        class="p-4 pinkzin border border-red-600 rounded-lg shadow w-full mb-3 flex justify-between items-center">
                        <div class="flex items-center">
                            <img src="https://img2.thethsdnadagvx.com/gpmaster/1.png" alt="Medalha" class="w-16 h-16">
                            <div class="ml-3">
                                <h2 class="text-rose-300">Minha Identidade</h2>
                                <div class="flex items-center">
                                    <span class="text-white">{{ userId }}</span>
                                    <button @click.prevent="copyId" class="ml-2 text-rose-200 focus:outline-none">
                                        <i class="fa-duotone fa-copy"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="flex items-center">
                            <div class="mr-3 flex flex-col items-center">
                                <button @click.prevent="opemModalWithdrawal" type="button"
                                    class="botaobluezin1 py-2 px-4 h-full flex items-center justify-center"
                                    style="border-radius: 5px;">
                                    {{ $t('Receber') }}
                                </button>
                                <h2 class="text-yellow-300 text-base mt-2">{{
                                    state.currencyFormat(parseFloat(wallet.refer_rewards), wallet.currency) }}</h2>
                            </div>
                        </div>
                    </div>







                    <div class="mt-3">


                        <div class="p-4 pinkzin border border-red-600 rounded-lg shadow w-full mb-3">
                            <div class="header flex justify-between mb-3">
                                <h2 class="text-white font-semibold">{{ $t('Informações da promoção') }}</h2>

                            </div>
                            <hr class="border-rose-200 mb-3">
                            <div class="flex justify-between mb-3">
                                <img src="https://worldgamesbr.com.br/wp-content/uploads/2024/06/Design-sem-nome-49.png"
                                    alt="QR Code" class="w-24 h-24"
                                    style="border: 1px solid #FDDFC7; padding: 2px; border-radius: 3px;">
                                <div class="flex flex-col w-full ml-3">
                                    <div class="flex justify-between items-center">
                                        <h2 class="text-white">{{ $t('Link exclusivo') }}</h2>
                                        <button @click.prevent="copyLink" type="submit"
                                            class="text-rose-200 focus:outline-none focus:ring-0">
                                            <i class="fa-duotone fa-share-nodes text-xl"></i>
                                        </button>
                                    </div>
                                    <div class="relative w-full border border-white-300 rounded-lg p-3 mt-2">
                                        <input type="text" id="referenceLink"
                                            class="block w-full z-20 text-sm text-rose-200 bg-transparent focus:outline-none"
                                            style="border: none;" :placeholder="$t('Link de Referência')"
                                            v-model="referencelink" readonly>
                                        <button @click.prevent="copyLink" type="submit"
                                            class="absolute top-0 end-0 py-2 px-4 text-rose-200 bg-transparent focus:outline-none">
                                            <i class="fa-duotone fa-copy text-xl"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>





                    </div>
                </div>
                <div v-else class="relative flex flex-col items-center justify-center text-center p-6">
                    <div v-if="!isLoadingGenerate" class="">
                        <p class="text-white">
                            {{ $t('Clique no botão abaixo para se tornar um colaborador') }}
                        </p>
                        <div class="mt-5 w-full">
                            <button @click.prevent="generateCode" type="button" class="ui-button-violet w-full">
                                {{ $t('Generate the code') }}
                            </button>
                        </div>
                    </div>

                    <div v-if="isLoadingGenerate" role="status"
                        class="absolute -translate-x-1/2 -translate-y-1/2 top-2/4 left-1/2">
                        <svg aria-hidden="true"
                            class="w-8 h-8 text-gray-200 animate-spin dark:text-gray-600 fill-green-600"
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
                <div class="col-span-2 w-full">

                    <div class="p-4 pinkzin border border-red-600 rounded-lg shadow w-full mb-3">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-0 md:gap-4">
                            <div class="w-full">
                                <div class="header flex justify-between mb-3">
                                    <div class="flex items-center">
                                        <img :src="`/assets/images/network.a415d3eb.png`" alt="" width="28">
                                        <h2 class="ml-3 text-white font-semibold">{{ $t('COMISSÃO') }}</h2>
                                    </div>
                                    <div class="flex items-center">
                                        <h1 class="text-yellow-300 font-bold text-2xl">{{
                                            userData.affiliate_revenue_share_fake ?
                                                userData.affiliate_revenue_share_fake : userData.affiliate_revenue_share }}%
                                        </h1>
                                    </div>
                                </div>

                                <hr class="border-rose-200">

                                <div class="header flex justify-between">
                                    <div class="flex items-center">
                                        <img :src="`/assets/images/discount.bf090f3a.png`" alt="" width="28">
                                        <h2 class="ml-3 text-white font-semibold">{{ $t('BAÚ DO TESOURO') }}</h2>
                                    </div>
                                    <div class="flex items-center">
                                        <h1 class="text-yellow-300 font-bold text-2xl">{{
                                            state.currencyFormat(parseFloat(userData.affiliate_cpa), wallet.currency) }}
                                        </h1>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!--<div class="flex shadow pinkzin dark:border-gray-700 w-full rounded-lg">
                        <div class="p-4">
                            <img :src="`/assets/images/indique.png`" alt="" class="mr-3">
                        </div>
                        <div class="flex flex-col justify-center  p-4">
                            <h1 class="text-2xl font-bold mb-3">Painel Avançado</h1>
                            <p class="text-gray-500">Nossa plataforma dispõe de um painel de afiliados avançado, permitindo que você visualize detalhes sobre ganhos e perdas. Além disso, oferece a capacidade de adicionar subafiliados.</p>
                            <a href="/affiliate/login" class="mt-4 text-green-500 font-bold">Clique aqui para acessar</a>
                        </div>
                    </div>-->
                    <div class="p-4 pinkzin border border-red-600 rounded-lg shadow w-full mb-3">

                        <div class="header flex justify-between mb-3">
                            <div class="flex items-center">
                                <h1 class="text-white font-semibold">TOTAL DE SUBORDINADOS</h1>
                            </div>
                            <div class="flex items-center">
                                <h1 class="text-yellow-300 text-base">{{ indications }}</h1>
                            </div>
                        </div>
                        <hr class="border-rose-200">
                        <div class="header flex justify-between mb-3 mt-3">
                            <div class="flex items-center">
                                <h1 class="text-white font-semibold">TOTAL DEPÓSITOS</h1>
                            </div>
                            <div class="flex items-center">
                                <h1 class="text-yellow-300 text-base">{{ fdepositedCount }}</h1>
                            </div>
                        </div>
                        <hr class="border-rose-200">

                        <div class="header flex justify-between mb-3 mt-3">
                            <div class="flex items-center">
                                <h1 class="text-white font-semibold">PRIMEIROS DEPÓSITOS</h1>
                            </div>
                            <div class="flex items-center">
                                <h1 class="text-yellow-300 text-base">{{ uniqueStatusCount }}</h1>
                            </div>
                        </div>
                        <hr class="border-rose-200">

                        <div class="header flex justify-between mt-3 mb-1">
                            <div class="flex items-center">
                                <h1 class="text-white font-semibold">TOTAL DEPOSITADO</h1>
                            </div>
                            <div class="flex items-center">
                                <h1 class="text-yellow-300 text-base">{{ state.currencyFormat(parseFloat(amount),
                                    wallet.currency) }}</h1>
                            </div>
                        </div>
                    </div>
                    <div class="p-4 pinkzin border border-red-600 rounded-lg shadow w-full mb-3">

                        <div class="header flex justify-between mb-3">
                            <div class="flex items-center">
                                <h1 class="text-white font-semibold">TOTAL DE INDICADOS DOS SUB-AFILIADOS</h1>
                            </div>
                            <div class="flex items-center">
                                <h1 class="text-yellow-300 text-base">{{ totalregistrations }}</h1>
                            </div>
                        </div>
                        <hr class="border-rose-200">
                        <div class="header flex justify-between mb-3 mt-3">
                            <div class="flex items-center">
                                <h1 class="text-white font-semibold">TOTAL DEPÓSITOS DOS INDICADOS</h1>
                            </div>
                            <div class="flex items-center">
                                <h1 class="text-yellow-300 text-base">{{ state.currencyFormat(parseFloat(totalafdeposit),
                                    wallet.currency) }}</h1>
                            </div>
                        </div>
                        <hr class="border-rose-200">

                        <div class="header flex justify-between mb-3 mt-3">
                            <div class="flex items-center">
                                <h1 class="text-white font-semibold">TOTAL DE SAQUES DOS INDICADOS</h1>
                            </div>
                            <div class="flex items-center">
                                <h1 class="text-yellow-300 text-base">{{ state.currencyFormat(parseFloat(totalafwithdrawal),
                                    wallet.currency) }}</h1>
                            </div>
                        </div>
                        <hr class="border-rose-200">
                    </div>




                    <!-- PARTE DOS BAUS AQUI -->


                    <div class="container1">
                        <div style="display: flex;">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg" style="margin-right: 8px;">
                                <path d="M2 7V9H22V7H2ZM22 10H2V20H22V10ZM20 18H4V12H20V18ZM10 14V16H14V14H10Z"
                                    fill="currentColor" />
                            </svg>
                            <h1 class="ml-3 mb-10">BAÚS GALAXSYS</h1>
                        </div>
                        <div class="chest-container">
                            <!-- Baú 1 -->
                            <div class="chest">
                                <img id="chest-image-1"
                                    src="https://js.ooojoga.com/siteadmin/skin/lobby_asset/common/common/event/tghd_img_bx3.png"
                                    alt="Baú Fechado">
                                <span>5 pessoas</span>
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8 5L15 12L8 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                    <path d="M15 5L22 12L15 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                </svg>
                            </div>
                            <!-- Baú 2 -->
                            <div class="chest">
                                <img id="chest-image-2"
                                    src="https://js.ooojoga.com/siteadmin/skin/lobby_asset/common/common/event/tghd_img_bx3.png"
                                    alt="Baú Fechado">
                                <span>10 pessoas</span>
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8 5L15 12L8 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                    <path d="M15 5L22 12L15 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                </svg>
                            </div>
                            <!-- Baú 3 -->
                            <div class="chest">
                                <img id="chest-image-3"
                                    src="https://js.ooojoga.com/siteadmin/skin/lobby_asset/common/common/event/tghd_img_bx3.png"
                                    alt="Baú Fechado">
                                <span>15 pessoas</span>
                            </div>
                            <!-- Baú 4 -->
                            <div class="chest">
                                <img id="chest-image-4"
                                    src="https://js.ooojoga.com/siteadmin/skin/lobby_asset/common/common/event/tghd_img_bx3.png"
                                    alt="Baú Fechado">
                                <span>20 pessoas</span>
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8 5L15 12L8 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                    <path d="M15 5L22 12L15 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                </svg>
                            </div>
                            <!-- Baú 5 -->
                            <div class="chest">
                                <img id="chest-image-5"
                                    src="https://js.ooojoga.com/siteadmin/skin/lobby_asset/common/common/event/tghd_img_bx3.png"
                                    alt="Baú Fechado">
                                <span>25 pessoas</span>
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8 5L15 12L8 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                    <path d="M15 5L22 12L15 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                </svg>
                            </div>
                            <!-- Baú 6 -->
                            <div class="chest">
                                <img id="chest-image-6"
                                    src="https://js.ooojoga.com/siteadmin/skin/lobby_asset/common/common/event/tghd_img_bx3.png"
                                    alt="Baú Fechado">
                                <span>30 pessoas</span>
                            </div>
                            <!-- Baú 7 -->
                            <div class="chest">
                                <img id="chest-image-4"
                                    src="https://js.ooojoga.com/siteadmin/skin/lobby_asset/common/common/event/tghd_img_bx3.png"
                                    alt="Baú Fechado">
                                <span>35 pessoas</span>
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8 5L15 12L8 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                    <path d="M15 5L22 12L15 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                </svg>
                            </div>
                            <!-- Baú 8 -->
                            <div class="chest">
                                <img id="chest-image-5"
                                    src="https://js.ooojoga.com/siteadmin/skin/lobby_asset/common/common/event/tghd_img_bx3.png"
                                    alt="Baú Fechado">
                                <span>40 pessoas</span>
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8 5L15 12L8 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                    <path d="M15 5L22 12L15 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                </svg>
                            </div>
                            <!-- Baú 9 -->
                            <div class="chest">
                                <img id="chest-image-6"
                                    src="https://js.ooojoga.com/siteadmin/skin/lobby_asset/common/common/event/tghd_img_bx3.png"
                                    alt="Baú Fechado">
                                <span>45 pessoas</span>
                            </div>
                            <!-- Baú 10 -->
                            <div class="chest">
                                <img id="chest-image-4"
                                    src="https://js.ooojoga.com/siteadmin/skin/lobby_asset/common/common/event/tghd_img_bx3.png"
                                    alt="Baú Fechado">
                                <span>50 pessoas</span>
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8 5L15 12L8 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                    <path d="M15 5L22 12L15 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                </svg>
                            </div>
                            <!-- Baú 11 -->
                            <div class="chest">
                                <img id="chest-image-5"
                                    src="https://js.ooojoga.com/siteadmin/skin/lobby_asset/common/common/event/tghd_img_bx3.png"
                                    alt="Baú Fechado">
                                <span>60 pessoas</span>
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8 5L15 12L8 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                    <path d="M15 5L22 12L15 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                </svg>
                            </div>
                            <!-- Baú 12 -->
                            <div class="chest">
                                <img id="chest-image-6"
                                    src="https://js.ooojoga.com/siteadmin/skin/lobby_asset/common/common/event/tghd_img_bx3.png"
                                    alt="Baú Fechado">
                                <span>70 pessoas</span>
                            </div>

                            <!-- Baú 13 -->
                            <div class="chest">
                                <img id="chest-image-4"
                                    src="https://js.ooojoga.com/siteadmin/skin/lobby_asset/common/common/event/tghd_img_bx3.png"
                                    alt="Baú Fechado">
                                <span>80 pessoas</span>
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8 5L15 12L8 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                    <path d="M15 5L22 12L15 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                </svg>
                            </div>
                            <!-- Baú 14 -->
                            <div class="chest">
                                <img id="chest-image-5"
                                    src="https://js.ooojoga.com/siteadmin/skin/lobby_asset/common/common/event/tghd_img_bx3.png"
                                    alt="Baú Fechado">
                                <span>90 pessoas</span>
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8 5L15 12L8 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                    <path d="M15 5L22 12L15 19" stroke="white" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                </svg>
                            </div>
                            <!-- Baú 15 -->
                            <div class="chest">
                                <img id="chest-image-6" :src="chestImage" alt="Baú Fechado">
                                <span>100 pessoas</span>
                            </div>

                        </div>
                    </div>



                </div>
            </div>





            <div v-else role="status" class="absolute -translate-x-1/2 -translate-y-1/2 top-2/4 left-1/2 h-full mt-16">
                <div class="text-center flex flex-col justify-center items-center">
                    <svg aria-hidden="true" class="w-8 h-8 text-gray-200 animate-spin dark:text-gray-600 fill-green-600"
                        viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path
                            d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
                            fill="currentColor" />
                        <path
                            d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
                            fill="currentFill" />
                    </svg>
                    <span class="mt-3">{{ $t('Loading') }}...</span>
                </div>
            </div>
        </div>

        <!-- MODAL RECOMPENSAS DE REFERÊNCIA -->
        <div id="referenceRewardsEl" tabindex="-1" aria-hidden="true"
            class="fixed left-0 right-0 top-0 z-50 hidden h-[calc(100%-1rem)] max-h-full w-full overflow-y-auto overflow-x-hidden p-4 md:inset-0">
            <div class="relative max-h-full w-full max-w-2xl">
                <!-- Modal content -->
                <div class="relative rounded-lg bg-white shadow dark:bg-gray-700">

                    <!-- Modal header -->
                    <div class="flex justify-between p-4 dark:bg-gray-600 rounded-t-lg">
                        <h1>{{ $t('Referral Reward Rules') }}</h1>
                        <button class="" @click.prevent="toggleReferenceRewards">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                    </div>

                    <!-- Modal body -->
                    <div class="w-full flex justify-center p-4">
                        <div class="flex items-center">
                            <div class="l"></div>
                            <div class="text-white px-3">
                                Regras de Desbloqueio
                            </div>
                            <div class="r"></div>
                        </div>


                    </div>
                </div>
            </div>
        </div>

        <!-- MODAL RECOMPENSAS POR COMISSÃO -->
        <div id="commissionRewardsEl" tabindex="-1" aria-hidden="true"
            class="fixed left-0 right-0 top-0 z-50 hidden h-[calc(100%-1rem)] max-h-full w-full overflow-y-auto overflow-x-hidden p-4 md:inset-0">
            <div class="relative max-h-full w-full max-w-2xl">
                <!-- Modal content -->
                <div class="relative rounded-lg bg-white shadow dark:bg-gray-700">

                    <!-- Modal header -->
                    <div class="flex justify-between p-4 dark:bg-gray-600 rounded-t-lg">
                        <h1>Regras de recompensas por comissão</h1>
                        <button class="" @click.prevent="toggleCommissionRewards">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                    </div>

                    <!-- Modal body -->
                    <div class="flex flex-col  w-full justify-center p-4">
                        <div class="flex items-center text-center w-full justify-center">
                            <div class="l"></div>
                            <div class="text-white px-3">
                                Taxas de comissões
                            </div>
                            <div class="r"></div>
                        </div>

                        <div class="mt-5">
                            <ul>
                                <li class="flex dark:bg-gray-800 shadow rounded-lg aposta-1 w-full p-4 mb-3">
                                    <div>
                                        <h1 class="font-mono text-4xl font-bold">7%</h1>
                                        <p class="text-gray-400 text-sm"><strong class="text-gray-400">Jogo:</strong> Os
                                            Jogos Originais</p>
                                    </div>
                                </li>
                                <li class="flex dark:bg-gray-800 shadow rounded-lg aposta-2 w-full p-4 mb-3">
                                    <div>
                                        <h1 class="font-mono text-4xl font-bold">7%</h1>
                                        <p class="text-gray-400 text-sm"><strong class="text-gray-400">Jogo:</strong>
                                            slots de terceiros, cassino ao vivo</p>
                                    </div>
                                </li>
                                <li class="flex dark:bg-gray-800 shadow rounded-lg aposta-3 w-full p-4 mb-3">
                                    <div>
                                        <h1 class="font-mono text-4xl font-bold">25%</h1>
                                        <p class="text-gray-400 text-sm"><strong class="text-gray-400">Jogo:</strong>
                                            Esportes</p>
                                    </div>
                                </li>
                            </ul>
                        </div>

                        <div class="mt-5 ml-4">
                            <ul class="list-outside list-disc">
                                <li class="mb-3">
                                    Em qualquer ambiente público (por exemplo, universidades, escolas, bibliotecas e
                                    espaços de escritório), apenas uma comissão pode ser paga para cada usuário,
                                    endereço IP, dispositivo eletrônico, residência, número de telefone, método de
                                    cobrança, endereço de e-mail e computador e IP endereço compartilhado com outras
                                    pessoas.
                                </li>
                                <li class="mb-3">
                                    Nossa decisão de fazer uma aposta será baseada inteiramente em nosso critério depois
                                    que um depósito for feito e uma aposta for feita com sucesso.
                                </li>
                                <li class="mb-3">
                                    As comissões podem ser retiradas em nossa carteira CREDK interna do painel a
                                    qualquer momento. (Veja a extração de sua comissão no painel e visualize o saldo na
                                    carteira).
                                </li>
                                <li class="mb-3">
                                    Apoiamos a maioria das moedas no mercado.
                                </li>
                                <li class="mb-3">
                                    O sistema calcula a comissão a cada 24 horas.
                                </li>
                            </ul>
                        </div>

                        <div class="mt-5 w-full border dark:border-gray-500 p-4 rounded">
                            Se você tiver alguma dúvida sobre nossas regras, por favor <a href=""
                                class="text-green-500 font-bold"> Contate-nos </a>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- MODAL SAQUE -->
        <div id="withdrawalEl" tabindex="-1" aria-hidden="true"
            class="fixed left-0 right-0 top-0 z-50 hidden h-[calc(100%-1rem)] max-h-full w-full overflow-y-auto overflow-x-hidden p-4 md:inset-0">
            <div class="relative max-h-full w-full max-w-2xl">
                <!-- Modal content -->
                <div class="relative rounded-lg bg-white shadow dark:bg-gray-700">

                    <!-- Modal header -->
                    <div class="flex justify-between p-4 dark:bg-gray-600 rounded-t-lg">
                        <h1>Regras de recompensas por comissão</h1>
                        <button class="" @click.prevent="opemModalWithdrawal">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                    </div>

                    <!-- Modal body -->
                    <div class="flex flex-col  w-full justify-center p-4">
                        <form action="" @submit.prevent="makeWithdrawal">
                            <div class="dark:text-gray-400 mb-3">
                                <label for="">Valor do Saque</label>
                                <input v-model="withdrawalForm.amount" type="number" class="input"
                                    placeholder="Valor do saque" required>
                                <span v-if="wallet" class="text-sm italic">Saldo: {{
                                    state.currencyFormat(parseFloat(wallet?.refer_rewards), wallet?.currency) }}</span>
                            </div>

                            <div class="dark:text-gray-400 mb-3">
                                <label for="">Chave Pix</label>
                                <input v-model="withdrawalForm.pix_key" type="text" class="input"
                                    placeholder="Digite a sua Chave pix" required>
                            </div>

                            <div class="dark:text-gray-400 mb-3">
                                <label for="">Tipo de Chave</label>
                                <select v-model="withdrawalForm.pix_type" name="type_document" class="input" required>
                                    <option value="">Selecione uma chave</option>
                                    <option value="document">CPF/CNPJ</option>
                                    <option value="email">E-mail</option>
                                    <option value="phoneNumber">Telefone</option>
                                    <option value="randomKey">Chave Aleatória</option>
                                </select>
                            </div>

                            <button type="submit"
                                class="mt-5 w-full bg-green-800 text-white hover:bg-green-600 px-4 py-2 transition duration-700">
                                Solicitar agora <i class="fa-regular fa-arrow-right ml-2"></i>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </BaseLayout>
</template>


<script>

import BaseLayout from "@/Layouts/BaseLayout.vue";
import { Modal } from 'flowbite';
import HttpApi from "@/Services/HttpApi.js";
import { useToast } from "vue-toastification";
import { useAuthStore } from "@/Stores/Auth.js";
import { useRouter } from "vue-router";

export default {
    components: { BaseLayout },
    setup() {
        const router = useRouter();
        const authStore = useAuthStore();
        const toast = useToast();

        const userId = authStore.user ? authStore.user.id : '';

        return {
            router,
            authStore,
            toast,
            userId
        };
    },
    data() {
        return {
            isLoading: false,
            referenceRewards: null,
            commissionRewards: null,
            isShowForm: false,
            isLoadingGenerate: false,
            code: '',
            urlCode: '',
            referencecode: '',
            referencelink: '',
            wallet: null,
            indications: 0,
            fdepositedCount: 0,
            uniqueStatusCount: 0,
            amount: 0,
            totalafwithdrawal:0,
            totalafdeposit:0,
            totalregistrations:0,
            histories: null,
            withdrawalModal: null,
            withdrawalForm: {
                amount: 0,
                pix_key: '',
                pix_type: '',
            },
            chestImage: 'https://js.ooojoga.com/siteadmin/skin/lobby_asset/common/common/event/tghd_img_bx3.png', // Estado inicial da imagem do baú
        };
    },
    computed: {
        userData() {
            return this.authStore.user;
        }
    },
    mounted() {
        this.referenceRewards = new Modal(document.getElementById('referenceRewardsEl'), {
            placement: 'center',
            backdrop: 'dynamic',
            backdropClasses: 'bg-gray-900/50 dark:bg-gray-900/80 fixed inset-0 z-40',
            closable: true,
            onHide: () => { },
            onShow: () => { },
            onToggle: () => { },
        });

        this.commissionRewards = new Modal(document.getElementById('commissionRewardsEl'), {
            placement: 'center',
            backdrop: 'dynamic',
            backdropClasses: 'bg-gray-900/50 dark:bg-gray-900/80 fixed inset-0 z-40',
            closable: true,
            onHide: () => { },
            onShow: () => { },
            onToggle: () => { },
        });

        this.withdrawalModal = new Modal(document.getElementById('withdrawalEl'), {
            placement: 'center',
            backdrop: 'dynamic',
            backdropClasses: 'bg-gray-900/50 dark:bg-gray-900/80 fixed inset-0 z-40',
            closable: false,
            onHide: () => { },
            onShow: () => { },
            onToggle: () => { },
        });

        this.checkAndGenerateCode(); // Carrega o código inicial e verifica o bônus
    },
    methods: {
        copyId() {
            navigator.clipboard.writeText(this.userId);
            this.toast.success('ID copiado!');
        },
        copyCode(event) {
            const inputElement = document.getElementById("referenceCode");
            inputElement.select();
            inputElement.setSelectionRange(0, 99999);  // Para dispositivos móveis

            // Copia o conteúdo para a área de transferência
            document.execCommand("copy");
            this.toast.success(this.$t('Code copied successfully'));
        },
        copyLink(event) {
            const inputElement = document.getElementById("referenceLink");
            inputElement.select();
            inputElement.setSelectionRange(0, 99999);  // Para dispositivos móveis

            // Copia o conteúdo para a área de transferência
            document.execCommand("copy");
            this.toast.success(this.$t('Link copied successfully'));
        },
        checkAndGenerateCode() {
            const _this = this;
            _this.isLoadingGenerate = true;

            HttpApi.get('profile/affiliates/')
                .then(response => {
                    if (response.data.code !== '' && response.data.code !== undefined && response.data.code !== null) {
                        _this.isShowForm = true;
                        _this.code = response.data.code;
                        _this.referencecode = response.data.code;
                        _this.urlCode = response.data.url;
                    } else {
                        _this.generateCode(); // Gera o código automaticamente se ainda não existir
                    }

                    _this.indications = response.data.indications;
                    _this.amount = response.data.amount;
                    _this.fdepositedCount = response.data.fdepositedCount;
                    _this.uniqueStatusCount = response.data.uniqueStatusCount;
                    _this.referencelink = response.data.url;
                    _this.wallet = response.data.wallet;
                    _this.withdrawalForm.amount = response.data.wallet.refer_rewards;
                    _this.totalafdeposit = response.data.totalafdeposit;
                    _this.totalafwithdrawal = response.data.totalafwithdrawal;
                    _this.totalregistrations = response.data.totalregistrations;

                    _this.isLoadingGenerate = false;

                    // Verifica o bônus e atualiza a imagem do baú, se necessário
                    if (response.data.bonusTriggered) {
                        _this.chestImage = 'https://worldgamesbr.com.br/wp-content/uploads/2024/05/open.png';
                    }
                })
                .catch(error => {
                    _this.isShowForm = false;
                    _this.isLoadingGenerate = false;
                });
        },
        generateCode() {
            const _this = this;
            _this.isLoadingGenerate = true;

            HttpApi.get('profile/affiliates/generate')
                .then(response => {
                    if (response.data.status) {
                        _this.getCode();
                    }

                    _this.isLoadingGenerate = false;
                })
                .catch(error => {
                    .catch(error => {
                    try {
                        Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => {
                            _toast.error(`${value}`);
                        });
                    } catch (e) {
                        _toast.error(error.request.responseText);
                    }
                });
                    _this.isLoadingGenerate = false;
                });
        },
        getCode() {
            const _this = this;
            _this.isLoadingGenerate = true;

            HttpApi.get('profile/affiliates/')
                .then(response => {
                    if (response.data.code !== '' && response.data.code !== undefined && response.data.code !== null) {
                        _this.isShowForm = true;
                        _this.code = response.data.code;
                        _this.referencecode = response.data.code;
                        _this.urlCode = response.data.url;
                    }

                    _this.indications = response.data.indications;
                    _this.amount = response.data.amount;
                    _this.fdepositedCount = response.data.fdepositedCount;
                    _this.uniqueStatusCount = response.data.uniqueStatusCount;
                    _this.referencelink = response.data.url;
                    _this.wallet = response.data.wallet;
                    _this.withdrawalForm.amount = response.data.wallet.refer_rewards;

                    _this.isLoadingGenerate = false;

                    // Verifica o bônus e atualiza a imagem do baú, se necessário
                    if (response.data.bonusTriggered) {
                        _this.chestImage = 'https://worldgamesbr.com.br/wp-content/uploads/2024/05/open.png';
                    }
                })
                .catch(error => {
                    _this.isShowForm = false;
                    _this.isLoadingGenerate = false;
                });
        },
        toggleCommissionRewards(event) {
            this.commissionRewards.toggle();
        },
        toggleReferenceRewards(event) {
            this.referenceRewards.toggle();
        },
        opemModalWithdrawal() {
            this.withdrawalModal.toggle();
        },
        makeWithdrawal: async function () {
            const _this = this;

            _this.isLoading = true;

            HttpApi.post('profile/affiliates/request', _this.withdrawalForm)
                .then(response => {
                    _this.opemModalWithdrawal();

                    _this.toast.success(_this.$t(response.data.message));
                    _this.isLoading = false;
                    _this.router.push({ name: 'profileWallet' });
                })
                .catch(error => {
                    .catch(error => {
                    try {
                        Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => {
                            _toast.error(`${value}`);
                        });
                    } catch (e) {
                        _toast.error(error.request.responseText);
                    }
                });
                    _this.isLoading = false;
                });
        }
    }
};

</script>

<style scoped></style>
