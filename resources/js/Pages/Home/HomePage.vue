<template>
    <BaseLayout>
        <LoadingComponent :isLoading="isLoading">
            <div class="text-center">
                <span>{{ $t('') }}</span>
            </div>
        </LoadingComponent>

        <div v-if="!isLoading" class=""
            style="background: url(https://worldgamesbr.com.br/wp-content/uploads/2024/05/bg_pattern_tile.png) repeat;"
            data-v-app="">

            <!-- Banners carousel -->
            <div class="pb-4">
                <div class="md:w-4/6 2xl:w-4/6 mx-auto px-4 pt-4">
                    <div class="">
                        <Carousel v-bind="settings" :breakpoints="breakpoints" ref="carouselBanner">
                            <Slide v-for="(banner, index) in banners" :key="index">
                                <div class="carousel__item rounded w-full">
                                    <a :href="banner.link" class="w-full h-full bg-blue-800 rounded">
                                        <img :src="`/storage/` + banner.image" alt="" class="h-full w-full rounded">
                                    </a>
                                </div>
                            </Slide>

                            
                        </Carousel>
                    </div>
                </div>
            </div>
            <div>
                <div class='md:w-4/6 2xl:w-4/6 mx-auto'>
                    
                    <JackpotCounter></JackpotCounter>
                    <InviteBanner></InviteBanner>
                </div>
            </div>
            <div class='md:w-4/6 2x1:w-4/6 mx-auto carousel-banners rounded-lg p-4 mt-4'>
                <!-- Searchbar action 
                <div class="mb-5 cursor-pointer w-full">
                    <div class="flex">
                        <div class="relative w-full">
                            <input @click.prevent="toggleSearch" type="search" readonly
                                class="block dark:focus:border-green-500 p-2.5 w-full z-20 text-sm text-gray-900 rounded-e-lg input-color-primary border-none focus:outline-none dark:border-s-gray-800  dark:border-gray-800 dark:placeholder-gray-400 dark:text-white "
                                placeholder="Nome do jogo | Provedor" required>

                            <button type="submit" class="absolute top-0 end-0 h-full p-2.5 text-sm font-medium text-white rounded-e-lg
                                 dark:bg-[#1C1E22] ">
                                <svg class="w-4 h-4" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                                    viewBox="0 0 20 20">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                        stroke-width="2" d="m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z" />
                                </svg>
                                <span class="sr-only">Search</span>
                            </button>
                        </div>
                    </div>
                </div> -->

                <!-- categories -->
                <div v-if="categories" class="category-list -translate-y-2.5" style="border-bottom: 1px solid #FFC5C7; padding-bottom: 3px;">
                    <div class="flex px-2 gap-5 justify-center"
                        style="max-height: 50px; overflow-x: auto; overflow-y: hidden;">
                        <div class="flex flex-row items-center justify-center w-full"
                            style="flex: 1; min-width: 100%; white-space: nowrap;">
                            <RouterLink
                                :to="{ name: 'casinosAll', params: { provider: 'all', category: category.slug } }"
                                v-for="(category, index) in categories"
                                class="flex flex-col justify-center items-center text-center text-white"
                                style="flex: 1; min-width: 50px;">
                                <div class="flex items-center justify-center">
                                    <img :src="`/storage/` + category.image" alt="" width="30" height="30" />
                                </div>
                                <p class="mt-1 text-sm">{{ $t(category.name) }}</p>
                            </RouterLink>
                        </div>
                    </div>


                </div>

            </div>





            <div class='md:w-4/6 2x1:w-4/6 mx-auto p-4 mb-1 -translate-y-5'>
                <div v-if="featured_games">
                    <div class="w-full flex justify-between items-center mb-2 pt-2">
                        <!-- Adiciona a imagem ao lado esquerdo do cabeçalho -->
                        <div class="flex items-center space-x-2">
                            <img src="/assets/images/fire.png" alt="Ícone de fogo" class="w-6 h-6" />
                            <h2 style="color: white;">Popular</h2>
                        </div>
                    </div>

                    <div class="grid grid-cols-3 md:grid-cols-6 gap-1 mb-3">
                        <CassinoGameCard v-for="(game, index) in featured_games" :index="index" :title="game.game_name"
                            :cover="game.cover" :gamecode="game.game_code" :type="game.distribution" :game="game" />
                    </div>
                </div>



                <div class="mt-10">
                    <Carousel v-bind="settingsRecommended" :breakpoints="breakpointsRecommended"
                        ref="carouselSubBanner">
                        <Slide v-for="(banner, index) in bannersHome" :key="index">
                            <div class="carousel__item  min-h-[60px] md:min-h-[150px] rounded-2xl w-full mr-4">
                                <a :href="banner.link" class="w-full h-full rounded-2xl">
                                    <img :src="`/storage/` + banner.image" alt="" class="h-full w-full rounded-2xl">
                                </a>
                            </div>
                        </Slide>

                        <template #addons>
                            <Pagination />
                        </template>
                    </Carousel>
                </div>

                <div class="mt-5">
                    <ShowProviders v-for="(provider, index) in providers" :provider="provider" :index="index" />
                </div>
            </div>
        </div>

        <div class="floating-icon">
        <img src="https://worldgamesbr.com.br/wp-content/uploads/2024/05/Design-sem-nome.png" alt="Rocket Icon"/>
        <p style="text-align: center; font-size: 8px; color: white;">Topo</p>
        </div>
        
    

        <!--<ButtonSpin></ButtonSpin>-->
    </BaseLayout>
</template>

<script>
import { Carousel, Navigation, Pagination, Slide } from 'vue3-carousel';
import { onMounted, ref } from "vue";

import BaseLayout from "@/Layouts/BaseLayout.vue";
import MakeDeposit from "@/Components/UI/MakeDeposit.vue";
import { RouterLink, useRoute } from "vue-router";
import { useAuthStore } from "@/Stores/Auth.js";
import CassinoGameCard from "@/Pages/Cassino/Components/CassinoGameCard.vue";
import HttpApi from "@/Services/HttpApi.js";
import ShowCarousel from "@/Pages/Home/Components/ShowCarousel.vue";
import { useSettingStore } from "@/Stores/SettingStore.js";
import LoadingComponent from "@/Components/UI/LoadingComponent.vue";
import ShowProviders from "@/Pages/Home/Components/ShowProviders.vue";
import { searchGameStore } from "@/Stores/SearchGameStore.js";
import CustomPagination from "@/Components/UI/CustomPagination.vue";
import LastWinnersComponent from "@/Components/UI/LastWinnersComponent.vue";
import JackpotCounter from "@/Components/UI/JackpotCounter.vue";
import ButtonSpin from "@/Components/UI/ButtonSpin.vue";
import InviteBanner from '@/Components/UI/InviteBanner.vue';
export default {
    props: [],
    components: {
        CustomPagination,
        Pagination,
        ShowProviders,
        LoadingComponent,
        ShowCarousel,
        CassinoGameCard,
        Carousel,
        Navigation,
        Slide,
        MakeDeposit,
        BaseLayout,
        RouterLink,
        LastWinnersComponent,
        JackpotCounter,
        ButtonSpin,
        InviteBanner,
    },
    data() {
        return {
            isLoading: true,

            /// banners settings
            settings: {
                itemsToShow: 1,
                snapAlign: 'center',
                autoplay: 6000,
                wrapAround: true
            },
            breakpoints: {
                700: {
                    itemsToShow: 1,
                    snapAlign: 'center',
                },
                1024: {
                    itemsToShow: 1,
                    snapAlign: 'center',
                },
            },

            settingsRecommended: {
                itemsToShow: 2,
                snapAlign: 'start',
            },
            breakpointsRecommended: {
                700: {
                    itemsToShow: 3,
                    snapAlign: 'center',
                },
                1024: {
                    itemsToShow: 3,
                    snapAlign: 'start',
                },
            },

            /// banners
            banners: null,
            bannersHome: null,

            settingsGames: {
                itemsToShow: 2.5,
                snapAlign: 'start',
            },
            breakpointsGames: {
                700: {
                    itemsToShow: 3.5,
                    snapAlign: 'center',
                },
                1024: {
                    itemsToShow: 6,
                    snapAlign: 'start',
                },
            },
            providers: null,

            featured_games: null,
            categories: null,
        }
    },
    setup(props) {
        const ckCarouselOriginals = ref(null)

        onMounted(() => {

        });

        return {
            ckCarouselOriginals
        };
    },
    computed: {
        searchGameStore() {
            return searchGameStore();
        },
        userData() {
            const authStore = useAuthStore();
            return authStore.user;
        },
        isAuthenticated() {
            const authStore = useAuthStore();
            return authStore.isAuth;
        },
        setting() {
            const settingStore = useSettingStore();
            return settingStore.setting;
        }
    },
    mounted() {

    },
    methods: {
        getCasinoCategories: async function () {
            const _this = this;
            await HttpApi.get('categories')
                .then(response => {
                    _this.categories = response.data.categories;
                })
                .catch(error => {
                    try {
                        Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => {
                            // You might want to display these errors to the user, e.g., using a toast notification
                            // _toast.error(`${value}`);
                        });
                    } catch (e) {
                        // Handle cases where the error response is not valid JSON
                        // _toast.error(error.request.responseText);
                    }
                });
        },
        toggleSearch: function () {
            this.searchGameStore.setSearchGameToogle();
        },
        getBanners: async function () {
            const _this = this;

            try {
                const response = await HttpApi.get('settings/banners');
                const allBanners = response.data.banners;

                _this.banners = allBanners.filter(banner => banner.type === 'carousel');
                _this.bannersHome = allBanners.filter(banner => banner.type === 'home');
            } catch (error) {
                console.error(error);
            } finally {

            }
        },
        getAllGames: async function () {
            const _this = this;
            return await HttpApi.get('games/all')
                .then(async response => {
                    if (response.data !== undefined) {
                        _this.providers = response.data.providers;
                        _this.isLoading = false;
                    }
                })
                .catch(error => {
                    try {
                        Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => {
                            console.log(`${value}`);
                        });
                    } catch (e) {
                        console.log(error.request.responseText);
                    }
                    _this.isLoading = false;
                });
        },
        getFeaturedGames: async function () {
            const _this = this;
            return await HttpApi.get('featured/games')
                .then(async response => {


                    _this.featured_games = response.data.featured_games;
                    _this.isLoading = false;
                })
                .catch(error => {
                    try {
                        Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => {
                            console.log(`${value}`);
                        });
                    } catch (e) {
                        console.log(error.request.responseText);
                    }
                    _this.isLoading = false;
                });
        },
        initializeMethods: async function () {
            await this.getCasinoCategories();
            await this.getBanners();
            await this.getAllGames();
            await this.getFeaturedGames();
        }

    },
    async created() {
        await this.initializeMethods();
    },
    watch: {


    },



};
</script>
