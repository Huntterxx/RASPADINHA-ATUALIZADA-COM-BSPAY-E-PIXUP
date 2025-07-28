<template>
    <BaseLayout>
        <div v-if="setting != null" class="md:w-4/6 2xl:w-4/6 mx-auto mt-20">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div class="col-span-1 hidden md:block">
                    <WalletSideMenu />
                </div>
                <div class="relative col-span-2">
                    <!-- Nova estrutura baseada na imagem -->
                    <div class="flex items-center bgperfil1 p-4 shadow-lg">
                        <img src="https://worldgamesbr.com.br/wp-content/uploads/2024/06/img_txn23.png" alt="User Avatar" class="w-16 h-16 rounded-full border-2 border-gray-200">
                        <div class="ml-4">
                            <div class="flex items-center">
                                <span class="text-rose-200">Conta:</span>
                                <span class="ml-2 text-white">{{ userData.name }}</span>
                            </div>
                            <div class="flex items-center mt-2">
                                <span class="text-rose-200">ID:</span>
                                <span class="ml-2 text-white">{{ userId }}</span>
                                <button @click="copyId" class="ml-2 text-rose-200">
                                    <i class="far fa-copy"></i>
                                </button>
                            </div>
                            <div class="flex items-center mt-2">
                                <span class="text-rose-200">Saldo:</span>
                                <span class="ml-2 text-white">{{ state.currencyFormat(Number(wallet.balance) + Number(wallet.balance_withdrawal), wallet.currency) }}</span>
                            </div>
                        </div>
                    </div>
                    <!-- Fim da nova estrutura -->
                    
                    <!-- Ícones de Saque, Depósito e Juros na mesma linha -->
                    <div v-if="!isLoadingWallet" class="flex justify-around p-4 bgperfil1">
                        
                        <a @click.prevent="$router.push('/profile/withdraw')" href="" class="flex flex-col items-center">
                            <div class="text-lg mb-2">
                                <i class="fas fa-money-bill-wave"></i>
                            </div>
                            <div class="flex flex-col items-center">
                                <h1 class="text-sm">{{ $t('Saque') }}</h1>
                            </div>
                        </a>
                        <a @click.prevent="$router.push('/profile/deposit')" href="" class="flex flex-col items-center">
                            <div class="text-lg mb-2">
                                <i class="fas fa-wallet"></i>
                            </div>
                            <div class="flex flex-col items-center">
                                <h1 class="text-sm">{{ $t('Depósito') }}</h1>
                            </div>
                        </a>
                        <a @click.prevent="$router.push('/')" href="" class="flex flex-col items-center">
                            <div class="text-lg mb-2">
                                <i class="fas fa-piggy-bank"></i>
                            </div>
                            <div class="flex flex-col items-center">
                                <h1 class="text-sm">{{ $t('Juros') }}</h1>
                            </div>
                        </a>
                    </div>
                    <!-- Fim da nova estrutura dos ícones -->
                    <hr class="border-rose-200">
                    <!-- Novas categorias -->
                    <div class="p-4 bgperfil2">
                        <a @click.prevent="$router.push('/profile/affiliate')" href="" class="flex items-center p-2 border-b border-rose-200">
                            <i class="fas fa-bullhorn text-rose-200 text-xl mr-4"></i>
                            <span class="text-lg text-white">{{ $t('Convidar') }}</span>
                        </a>
                        <a @click.prevent="$router.push('#')" href="" class="flex items-center p-2 border-b border-rose-200">
                            <i class="fas fa-user text-rose-200 text-xl mr-4"></i>
                            <span class="text-lg text-white">{{ $t('Detalhes da Conta') }}</span>
                        </a>
                        <a @click.prevent="$router.push('/profile/transactions')" href="" class="flex items-center p-2 border-b border-rose-200">
                            <i class="fas fa-file-alt text-rose-200 text-xl mr-4"></i>
                            <span class="text-lg text-white">{{ $t('Relatório de Saque') }}</span>
                        </a>
                        <a @click.prevent="$router.push('#')" href="" class="flex items-center p-2 border-b border-rose-200">
                            <i class="fas fa-shield-alt text-rose-200 text-xl mr-4"></i>
                            <span class="text-lg text-white">{{ $t('Recorde de Aposta') }}</span>
                        </a>
                        <a @click.prevent="$router.push('#')" href="" class="flex items-center p-2 border-b border-rose-200">
                            <i class="fas fa-gift text-rose-200 text-xl mr-4"></i>
                            <span class="text-lg text-white">{{ $t('Bônus de Sugestão') }}</span>
                        </a>
                        <a @click.prevent="$router.push('#')" href="" class="flex items-center p-2 border-b border-rose-200">
                            <i class="fas fa-question-circle text-rose-200 text-xl mr-4"></i>
                            <span class="text-lg text-white">{{ $t('FAQ') }}</span>
                        </a>
                        <a @click.prevent="logoutAccount" href="#"
                            class="flex items-center p-2 block px-4 py-2 text-sm text-gray-700 hover:bg-rose-100 dark:hover:text-white"
                            role="menuitem">
                            <i class="fas fa-sign-out-alt text-rose-200 text-xl mr-4"></i>
                            <span class="text-lg text-white">{{ $t('Sair') }}</span>
                        </a>

                    </div>
                    <!-- Fim das novas categorias -->

                    <div v-if="isLoadingWallet" role="status" class="absolute -translate-x-1/2 -translate-y-1/2 top-2/4 left-1/2">
                        <svg aria-hidden="true" class="w-8 h-8 text-gray-200 animate-spin dark:text-gray-600 fill-green-600" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="currentColor"/>
                            <path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="currentFill"/>
                        </svg>
                        <span class="sr-only">{{ $t('Loading') }}...</span>
                    </div>
                </div>
            </div>
        </div>
    </BaseLayout>
</template>






<script>

import { RouterLink, useRouter } from "vue-router";
import BaseLayout from "@/Layouts/BaseLayout.vue";
import WalletSideMenu from "@/Pages/Profile/Components/WalletSideMenu.vue";
import { useToast } from "vue-toastification";
import { useAuthStore } from "@/Stores/Auth.js";
import { useSettingStore } from "@/Stores/SettingStore.js";
import HttpApi from "@/Services/HttpApi.js";

export default {
    components: { WalletSideMenu, BaseLayout, RouterLink },
    data() {
        return {
            isLoading: false,
            isLoadingWallet: true,
            wallet: null,
            mywallets: null,
            setting: null,
        }
    },
    setup() {
        const authStore = useAuthStore();
        const settingStore = useSettingStore();
        const toast = useToast();
        const router = useRouter();
        
        const userId = authStore.user ? authStore.user.id : '';  // Usar o mesmo sistema de ID da AFFILIATEPAGE
        
        return {
            authStore,
            settingStore,
            toast,
            userId,  // Retornar o userId para usar nos métodos
            router   // Retornar o router para usar no método logoutAccount
        };
    },
    computed: {
        userData() {
            return this.authStore.user;
        },
        // Remover o método userId aqui, pois agora ele é obtido no setup
    },
    mounted() {
        this.getWallet();
        this.getMyWallet();
        this.getSetting();
    },
    methods: {
        // Remover o método hashCode, pois não é mais necessário
        copyId() {
            navigator.clipboard.writeText(this.userId);  // Usar o userId do setup
            this.toast.success("ID copiado!");
        },
        setWallet(id) {
            this.isLoadingWallet = true;

            HttpApi.post('profile/mywallet/' + id, {})
                .then(response => {
                    this.getMyWallet();
                    this.isLoadingWallet = false;
                    window.location.reload();
                })
                .catch(error => {
                    try {
                        Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => {
                            this.toast.error(`${value}`);
                        });
                    } catch (e) {
                        this.toast.error(error.request.responseText);
                    }
                    this.isLoadingWallet = false;
                });
        },
        getWallet() {
            this.isLoadingWallet = true;

            HttpApi.get('profile/wallet')
                .then(response => {
                    this.wallet = response.data.wallet;
                    this.isLoadingWallet = false;
                })
                .catch(error => {
                    try {
                        Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => {
                            this.toast.error(`${value}`);
                        });
                    } catch (e) {
                        this.toast.error(error.request.responseText);
                    }
                    this.isLoadingWallet = false;
                });
        },
        getMyWallet() {
            HttpApi.get('profile/mywallet')
                .then(response => {
                    this.mywallets = response.data.wallets;
                })
                .catch(error => {
                    try {
                        Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => {
                            this.toast.error(`${value}`);
                        });
                    } catch (e) {
                        this.toast.error(error.request.responseText);
                    }
                });
        },
        getSetting() {
            const settingData = this.settingStore.setting;

            if (settingData) {
                this.setting = settingData;
            }

            this.isLoading = false;
        },
        rolloverPercentage(balance) {
            return Math.max(0, ((balance / 100) * 100).toFixed(2));
        },
        logoutAccount() {
            const authStore = useAuthStore();
            const _toast = useToast();

            HttpApi.post('auth/logout', {})
                .then(response => {
                    authStore.logout();
                    this.router.push('/');  // Redirecionar para a página inicial

                    _toast.success(this.$t('You have been successfully disconnected'));
                })
                .catch(error => {
                    Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => {
                        console.log(value);
                        //_toast.error(`${value}`);
                    });
                });
        }
    }
};




</script>

<style scoped>

</style>
