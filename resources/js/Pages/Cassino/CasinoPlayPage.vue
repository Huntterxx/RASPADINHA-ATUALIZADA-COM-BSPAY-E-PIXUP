<template>
    <GameLayout>
        <LoadingComponent :isLoading="isLoading">
            <div class="text-center">
                <span>{{ $t('Quase lá...') }}</span>
            </div>
        </LoadingComponent>
        <div class="game-screen" id="game-screen">
            <fullscreen v-model="fullscreen" :page-only="true">
                <div v-if="showButton && game.game_type === 'live' && game.distribution === 'evergame'"
                    class="game-full fullscreen-wrapper flex items-center justify-center">
                    <button @click.prevent="openModal(gameUrl)" type="button"
                        class="py-2.5 px-5 me-2 mb-2 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-100 dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700">
                        Clique para começar
                    </button>
                </div>
                <iframe :src="gameUrl" class="game-full"></iframe>
            </fullscreen>
        </div>
        <div v-if="undermaintenance" class="flex flex-col items-center justify-center text-center py-24">
            <h1 class="text-2xl mb-4">JOGO EM MANUTENÇÃO</h1>
            <img :src="`/assets/images/work-in-progress.gif`" alt="" width="400">
        </div>
        <a @click.prevent="$router.push('/')">
            <button class="scroll-top-btn"></button>
        </a>



    </GameLayout>
</template>

<script>
import { initFlowbite, Tabs, Modal } from 'flowbite';
import { RouterLink, useRoute, useRouter } from "vue-router";
import { useAuthStore } from "@/Stores/Auth.js";
import { component } from 'vue-fullscreen';
import LoadingComponent from "@/Components/UI/LoadingComponent.vue";
import GameLayout from "@/Layouts/GameLayout.vue";
import HttpApi from "@/Services/HttpApi.js";

import {
    defineComponent,
    toRefs,
    reactive,
} from 'vue';

export default {
    props: [],
    components: {
        GameLayout,
        LoadingComponent,
        RouterLink,
        component
    },
    data() {
        return {
            isLoading: true,
            game: null,
            modeMovie: true,
            gameUrl: null,
            token: null,
            gameId: null,
            tabs: null,
            undermaintenance: false,
        }
    },
    setup() {
        const router = useRouter();
        const state = reactive({
            fullscreen: true,
            pageOnly: false,
        })
        function togglefullscreen() {
            console.log("CLICOU");
            state.fullscreen = !state.fullscreen
        }

        return {
            ...toRefs(state),
            togglefullscreen,
            router
        }
    },
    computed: {
        userData() {
            const authStore = useAuthStore();
            return authStore.user;
        },
        isAuthenticated() {
            const authStore = useAuthStore();
            return authStore.isAuth;
        },
    },
    mounted() {

        const userAgent = navigator.userAgent.toLowerCase();
        const isSafari = userAgent.includes('safari') && !userAgent.includes('chrome');
        const isSamsungInternet = userAgent.includes('samsung') && userAgent.includes('safari') && !userAgent.includes('chrome');
        const isIOS = userAgent.includes('iphone') || userAgent.includes('ipad');

        if (isSafari || isSamsungInternet || isIOS) {
            this.showButton = true;
        }




    },
    methods: {
        loadingTab: function () {
            const tabsElement = document.getElementById('tabs-info');
            if (tabsElement) {
                const tabElements = [
                    {
                        id: 'default',
                        triggerEl: document.querySelector('#default-tab'),
                        targetEl: document.querySelector('#default-panel'),
                    },
                    {
                        id: 'descriptions',
                        triggerEl: document.querySelector('#description-tab'),
                        targetEl: document.querySelector('#description-panel'),
                    },
                    {
                        id: 'reviews',
                        triggerEl: document.querySelector('#reviews-tab'),
                        targetEl: document.querySelector('#reviews-panel'),
                    },
                ];

                const options = {
                    defaultTabId: 'default',
                    activeClasses: 'text-green-600 hover:text-green-600 dark:text-green-500 dark:hover:text-green-400 border-green-600 dark:border-green-500',
                    inactiveClasses: 'text-gray-500 hover:text-gray-600 dark:text-gray-400 border-gray-100 hover:border-gray-300 dark:border-gray-700 dark:hover:text-gray-300',
                    onShow: () => {

                    },
                };

                const instanceOptions = {
                    id: 'default',
                    override: true
                };

                /*
                * tabElements: array of tab objects
                * options: optional
                * instanceOptions: optional
                */
                this.tabs = new Tabs(tabsElement, tabElements, options, instanceOptions);
            }
        },
        openModal(gameUrl) {
            window.open(gameUrl);
        },

        getGame: async function () {
            const _this = this;

            return await HttpApi.get('games/single/' + _this.gameId)
                .then(async response => {
                    if (response.data?.action === 'deposit') {
                        _this.$nextTick(() => {
                            _this.router.push({ name: 'profileDeposit' });
                        });

                    }

                    const game = response.data.game;
                    _this.game = game;

                    // if(game.distribution == 'evergame') {
                    //     window.open(response.data.gameUrl)
                    // }

                    _this.gameUrl = response.data.gameUrl;
                    _this.token = response.data.token;
                    _this.isLoading = false;

                    _this.$nextTick(() => {
                        _this.loadingTab();
                    });
                })
                .catch(error => {

                    _this.isLoading = false;
                    _this.undermaintenance = true;
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
        toggleFavorite: function () {
            const _this = this;
            return HttpApi.post('games/favorite/' + _this.game.id, {})
                .then(response => {
                    _this.getGame();
                    _this.isLoading = false;
                })
                .catch(error => {
                    _this.isLoading = false;
                });
        },
        toggleLike: async function () {
            const _this = this;
            return await HttpApi.post('games/like/' + _this.game.id, {})
                .then(async response => {
                    await _this.getGame();
                    _this.isLoading = false;
                })
                .catch(error => {
                    _this.isLoading = false;
                });
        }
    },
    async created() {
        if (this.isAuthenticated) {
            const route = useRoute();
            this.gameId = route.params.id;


            await this.getGame();
        } else {
            this.router.push({ name: 'login', params: { action: 'openlogin' } });
        }
    },
    watch: {


    },
};
</script>

<style>
.game-screen {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}

.game-screen .game-full {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}

.game-footer {
    border-bottom-left-radius: 8px;
    border-bottom-right-radius: 8px;
}

.scroll-top-btn {
    position: fixed;
    top: 20px;
    left: 20px;
    background-color: rgba(169, 169, 169, 0.7);
    /* Cor cinza semi-transparente */
    color: #fff;
    border: none;
    border-radius: 50%;
    /* Deixa o botão redondo */
    padding: 10px;
    /* Reduzido o padding para ajustar ao ícone */
    cursor: pointer;
    z-index: 1000;
}

.scroll-top-btn:hover {
    background-color: rgba(169, 169, 169, 0.9);
    /* Cor cinza semi-transparente mais escura ao passar o mouse */
}

/* Adiciona um ícone de casa usando FontAwesome (ou outro conjunto de ícones) */
.scroll-top-btn::before {
    content: "\f015";
    /* Unicode do ícone de casa */
    font-family: FontAwesome;
    /* Define a fonte para FontAwesome */
    font-size: 20px;
    /* Tamanho do ícone */
    line-height: 1;
    /* Ajusta a altura da linha para centralizar verticalmente */
    vertical-align: middle;
    /* Alinha o ícone verticalmente */
}
</style>
