<template>
    <div class="block pt-7">
        <div v-if="(paymentType == null || paymentType === '') && wallet && setting">
            <div class="">
                <ul>
                    <li v-if="setting.digitopay_is_enable" @click="setPaymentMethod('pix', 'digitopay')"
                        class=" bg-white dark:bg-gray-900 cursor-pointer flex justify-between hover:bg-green-700/20 px-4 py-3 mb-3">
                        <div class="flex items-center gap-4">
                            <img :src="`/assets/images/pix.png`" alt="" width="100">
                            <p>DIGITOPAY</p>
                        </div>
                        <div>

                        </div>
                        <div class="flex justify-center items-center text-gray-500 gap-4">
                            <i class="fa-solid fa-chevron-right ml-2"></i>
                        </div>
                    </li>
                    <li v-if="setting.mercadopago_is_enable" @click="setPaymentMethod('pix', 'mercadopago')"
                        class=" bg-white dark:bg-gray-900 cursor-pointer flex justify-between hover:bg-green-700/20 px-4 py-3 mb-3">
                        <div class="flex items-center gap-4">
                            <img :src="`/assets/images/pix.png`" alt="" width="100">
                            <p>MERCADO PAGO</p>
                        </div>
                        <div>

                        </div>
                        <div class="flex justify-center items-center text-gray-500 gap-4">
                            <i class="fa-solid fa-chevron-right ml-2"></i>
                        </div>
                    </li>
                    <li v-if="setting.sharkpay_is_enable" @click="setPaymentMethod('pix', 'sharkpay')"
                        class=" bg-white dark:bg-gray-900 cursor-pointer flex justify-between hover:bg-green-700/20 px-4 py-3 mb-3">
                        <div class="flex items-center gap-4">
                            <img :src="`/assets/images/pix.png`" alt="" width="100">
                            <p>SHARKPAY</p>
                        </div>
                        <div>

                        </div>
                        <div class="flex justify-center items-center text-gray-500 gap-4">
                            <i class="fa-solid fa-chevron-right ml-2"></i>
                        </div>
                    </li>
                    <li v-if="setting.suitpay_is_enable" @click="setPaymentMethod('pix', 'suitpay')"
                        class=" bg-white dark:bg-gray-900 cursor-pointer flex justify-between hover:bg-green-700/20 px-4 py-3 mb-3">
                        <div class="flex items-center gap-4">
                            <img :src="`/assets/images/pix.png`" alt="" width="100">
                            <p>SUITPAY</p>
                        </div>
                        <div>

                        </div>
                        <div class="flex justify-center items-center text-gray-500 gap-4">
                            <i class="fa-solid fa-chevron-right ml-2"></i>
                        </div>
                    </li>
                    <li v-if="setting.stripe_is_enable" @click="setPaymentMethod('stripe', 'stripe')"
                        class="bg-white dark:bg-gray-900 cursor-pointer flex justify-between hover:bg-green-700/20 px-4 py-3 mb-2">
                        <div>
                            <img :src="`/assets/images/stripe.png`" alt="" width="80">
                        </div>
                        <div>

                        </div>
                        <div class="flex justify-center items-center gap-4 text-gray-500">
                            <i class="fa-solid fa-chevron-right ml-2"></i>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <div v-if="paymentType === 'stripe' && publishableKey && setting && setting.stripe_is_enable" class="p-4">

            <stripe-checkout ref="checkoutRef" :pk="publishableKey" :sessionId="sessionId" />
            <div class="flex w-full mt-3 mb-3">

                <div class="w-36 mr-2">

                    <label for="currency" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">{{
                        $t('Currency') }}</label>
                    <select id="currency" v-model="currency"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                        <option value="USD">$ {{ $t('Dollar') }}</option>
                        <option value="BRL">R$ {{ $t('Real') }}</option>
                    </select>
                </div>
                <div class="w-full">
                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">{{ $t('Amount')
                        }}</label>
                    <input type="number" v-model="amount"
                        class="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                        :min="setting.min_deposit" :max="setting.max_deposit" :placeholder="$t('0,00')" required>
                </div>
            </div>

            <button :disabled="!sessionId" @click.prevent="checkoutStripe" class="ui-button-blue rounded w-full">{{
                $t('Pay With Stripe') }}</button>
        </div>
        <div
            v-if="setting && paymentType === 'pix' && (setting.suitpay_is_enable || setting.mercadopago_is_enable || setting.digitopay_is_enable)">
            <div v-if="showPixQRCode && wallet" class="flex flex-col ">
                

                <div class="w-full p-4 -translate-y-8">
                    <div>
                        <p class="font-bold">Valor do Pix a pagar: {{ state.currencyFormat(parseFloat(deposit.amount),
                            wallet.currency) }}</p>
                    </div>
                    <div class="p-3 flex justify-center items-center">
                        <QRCodeVue3 :value="qrcodecopypast" />
                    </div>
                    <div>
                        <p class="font-bold">Código válido por 23 horas.</p>
                    </div>
                    <div class="mt-4">
                        <p class="mb-3">Se preferir, você pode pagá-lo copiando e colando o código abaixo:</p>
                        <input id="pixcopiaecola" type="text" class="input" v-model="qrcodecopypast">
                    </div>

                    <div class="mt-5 w-full flex items-center justify-center">
                        <button @click.prevent="copyQRCode" type="button" class="uiuibuton w-full">
                            <span class="uppercase font-semibold text-sm">{{ $t('Copy code') }}</span>
                        </button>
                    </div>
                </div>
            </div>
            <div v-if="!showPixQRCode">
                <div v-if="setting != null && wallet != null && isLoading === false" class="flex flex-col w-full">
                    <a v-if="setting" href="/" class="flex justify-center items-center p-2 mx-auto">
                        
                    </a>

                    <form class="-translate-y-10" action="" @submit.prevent="submitQRCode">
                        

                        <div class="mt-5">
    <p class="mb-2 text-white">{{ $t('Payment methods') }}</p>
    <div class="relative w-full flex items-center justify-between bg-transparent border border-white-600 rounded p-2">
        <div class="flex w-full items-center">
            <img :src="`/assets/images/pix.png`" alt="" width="100">
            <span class="ml-3 text-white-600">PIX (Quente)</span>
        </div>
        <div class="absolute top-0 right-0 bg-red-500 text-white rounded-full px-2 py-1 text-xs">Quente</div>
        <div class="absolute bottom-0 right-0">
            <img src="#" alt="" width="20">
        </div>
    </div>
</div>

                        

                    

                        

                        <div class="mt-5 item-selected" style="display: flex; flex-wrap: wrap; gap: 5px;">
    <div @click.prevent="setAmount(parseFloat(setting.min_deposit))" class="item"
        :class="{ 'active': selectedAmount === parseFloat(setting.min_deposit) }" style="background-color: #EE7879; border: 1px solid #FFE1C9; flex: 1 0 20%; color: #FFE1C9;">
        <button type="button" style="color: white;">{{ state.currencyFormat(parseFloat(setting.min_deposit), wallet.currency) }}</button>
        <div v-if="selectedAmount === parseFloat(setting.min_deposit)" class="ratio">+{{ setting.initial_bonus }}%</div>
        <img v-if="selectedAmount === parseFloat(setting.min_deposit)" class="img-check"
            :src="`/assets/images/check.webp`" alt="">
    </div>
    <div @click.prevent="setAmount(30.00)" class="item"
        :class="{ 'active': selectedAmount === 30.00 }" style="background-color: #EE7879; border: 1px solid #FFE1C9; flex: 1 0 20%; color: #FFE1C9;">
        <button type="button" style="color: white;">30,00</button>
        <div v-if="selectedAmount === 30.00" class="ratio">+{{ setting.initial_bonus }}%</div>
        <img v-if="selectedAmount === 30.00" class="img-check"
            :src="`/assets/images/check.webp`" alt="">
    </div>
    <div @click.prevent="setAmount(50.00)" class="item"
        :class="{ 'active': selectedAmount === 50.00 }" style="background-color: #EE7879; border: 1px solid #FFE1C9; flex: 1 0 20%; color: #FFE1C9;">
        <button type="button" style="color: white;">50,00</button>
        <div v-if="selectedAmount === 50.00" class="ratio">+{{ setting.initial_bonus }}%</div>
        <img v-if="selectedAmount === 50.00" class="img-check"
            :src="`/assets/images/check.webp`" alt="">
    </div>
    <div @click.prevent="setAmount(100.00)" class="item" 
        :class="{ 'active': selectedAmount === 100.00 }" style="background-color: #EE7879; border: 1px solid #FFE1C9; flex: 1 0 20%; color: #FFE1C9;">
        <button type="button" style="color: white;">100,00</button>
        <div v-if="selectedAmount === 100.00" class="ratio">+{{ setting.initial_bonus }}%</div>
        <img v-if="selectedAmount === 100.00" class="img-check"
            :src="`/assets/images/check.webp`" alt="">
    </div>
    <div @click.prevent="setAmount(300.00)" class="item" 
        :class="{ 'active': selectedAmount === 300.00 }" style="background-color: #EE7879; border: 1px solid #FFE1C9; flex: 1 0 20%; color: #FFE1C9;">
        <button type="button" style="color: white;">300,00</button>
        <div v-if="selectedAmount === 300.00" class="ratio">+{{ setting.initial_bonus }}%</div>
        <img v-if="selectedAmount === 300.00" class="img-check"
            :src="`/assets/images/check.webp`" alt="">
    </div>
    <div @click.prevent="setAmount(500.00)" class="item" 
        :class="{ 'active': selectedAmount === 500.00 }" style="background-color: #EE7879; border: 1px solid #FFE1C9; flex: 1 0 20%; color: #FFE1C9;">
        <button type="button" style="color: white;">500,00</button>
        <div v-if="selectedAmount === 500.00" class="ratio">+{{ setting.initial_bonus }}%</div>
        <img v-if="selectedAmount === 500.00" class="img-check"
            :src="`/assets/images/check.webp`" alt="">
    </div>
    <div @click.prevent="setAmount(1000.00)" class="item" 
        :class="{ 'active': selectedAmount === 1000.00 }" style="background-color: #EE7879; border: 1px solid #FFE1C9; flex: 1 0 20%; color: #FFE1C9;">
        <button type="button" style="color: white;">1000,00</button>
        <div v-if="selectedAmount === 1000.00" class="ratio">+{{ setting.initial_bonus }}%</div>
        <img v-if="selectedAmount === 1000.00" class="img-check"
            :src="`/assets/images/check.webp`" alt="">
    </div>
    <div @click.prevent="setAmount(5000.00)" class="item rosinha" 
        :class="{ 'active': selectedAmount === 5000.00 }" style="background-color: #EE7879; border: 1px solid #FFE1C9; flex: 1 0 20%; color: #FFE1C9;">
        <button type="button" style="color: white;">5000,00</button>
        <div v-if="selectedAmount === 5000.00" class="ratio">+{{ setting.initial_bonus }}%</div>
        <img v-if="selectedAmount === 5000.00" class="img-check"
            :src="`/assets/images/check.webp`" alt="">
    </div>
</div>

<div class="mt-3">


    <div class="w-full flex items-center justify-between bg-transparent rounded py-1">
    <div class="flex w-full">
        <input type="text" v-model="deposit.amount"
            class="appearance-none border border-gray-300 rounded-md bg-transparent w-full text-white placeholder-white"
            :min="setting.min_deposit" :max="setting.max_deposit"
            :placeholder="$t('Mínimo 10, Máximo 50000')" required>
    </div>
</div>

</div>

                        

                        <div class="mt-5 mb-10 w-full flex items-center justify-center">
                            <button type="submit" class="uiuibuton w-full">
                                <span class="uppercase font-semibold text-sm">{{ $t('Deposit') }}</span>
                            </button>
                        </div>
                    </form>
                </div>
                <div v-if="isLoading" role="status" class="absolute -translate-x-1/2 -translate-y-1/2 top-2/4 left-1/2">
                    <svg aria-hidden="true" class="w-8 h-8 text-gray-200 animate-spin dark:text-gray-600 fill-green-600"
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
import { useToast } from "vue-toastification";
import HttpApi from "@/Services/HttpApi.js";
import QRCodeVue3 from "qrcode-vue3";
import { useAuthStore } from "@/Stores/Auth.js";
import { StripeCheckout } from '@vue-stripe/vue-stripe';
import { useSettingStore } from "@/Stores/SettingStore.js";

export default {
    props: ['showMobile', 'title', 'isFull'],
    components: { QRCodeVue3, StripeCheckout },
    data() {
        return {
            isLoading: false,
            minutes: 15,
            seconds: 0,
            timer: null,
            setting: null,
            wallet: null,
            deposit: {
                amount: '',
                cpf: '',
                gateway: '',
                accept_bonus: true
            },
            selectedAmount: 0,
            showPixQRCode: false,
            qrcodecopypast: '',
            idTransaction: '',
            intervalId: null,
            paymentType: null,

            /// stripe
            elementsOptions: {
                appearance: {}, // appearance options
            },
            confirmParams: {
                return_url: null, // success url
            },
            successURL: null,
            cancelURL: null,
            amount: null,
            currency: null,
            publishableKey: null,
            sessionId: null,
            paymentGateway: '',
        }
    },
    setup(props) {
        return {};
    },
    computed: {
        isAuthenticated() {
            const authStore = useAuthStore();
            return authStore.isAuth;
        },
    },
    mounted() {
        this.modalDeposit = new Modal(document.getElementById('modalElDeposit'), {
            placement: 'center',
            backdrop: 'dynamic',
            backdropClasses: 'bg-gray-900/50 dark:bg-gray-900/80 fixed inset-0 z-40',
            closable: true,
            onHide: () => {
                this.paymentType = null;
            },
            onShow: () => {},
            onToggle: () => {},
        });

        // Automatically select "SUITPAY" if it's enabled
        if (this.setting && this.setting.suitpay_is_enable) {
            this.setPaymentMethod('pix', 'suitpay');
        }
    },
    beforeUnmount() {
        clearInterval(this.timer);
        this.paymentType = null;
    },
    methods: {
        getSession: function() {
            const _this = this;
            HttpApi.post('stripe/session', { amount: _this.amount, currency: _this.currency }).then(response => {
                if (response.data.id) {
                    _this.sessionId = response.data.id;
                }
            }).catch(error => {});
        },
        checkoutStripe: function() {
            const _toast = useToast();
            if (this.amount <= 0 || this.amount === '') {
                _toast.error('Você precisa digitar um valor');
                return;
            }

            this.$refs.checkoutRef.redirectToCheckout();
        },
        getPublicKeyStripe: function() {
            const _this = this;
            HttpApi.post('stripe/publickey', {}).then(response => {
                _this.$nextTick(() => {
                    _this.publishableKey = response.data.stripe_public_key;
                    _this.elementsOptions.clientSecret = response.data.stripe_secret_key;
                    _this.confirmParams.return_url = response.data.successURL;
                });

            }).catch(error => {});
        },
        setPaymentMethod: function(type, gateway) {
            if (type === 'stripe') {
                this.getPublicKeyStripe();
            }
            this.paymentType = type;
            this.paymentGateway = gateway;
        },
        openModalDeposit: function() {
            this.modalDeposit.toggle();
        },
        submitQRCode: function(event) {
            const _this = this;
            const _toast = useToast();
            if (_this.deposit.amount === '' || _this.deposit.amount === undefined) {
                _toast.error(_this.$t('You need to enter a value'));
                return;
            }

            _this.deposit.cpf = "472.069.610-45";

            if (parseFloat(_this.deposit.amount) < parseFloat(_this.setting.min_deposit)) {
                _toast.error('O valor mínimo de depósito é de ' + _this.setting.min_deposit);
                return;
            }

            if (parseFloat(_this.deposit.amount) > parseFloat(_this.setting.max_deposit)) {
                _toast.error('O valor máximo de depósito é de ' + _this.setting.min_deposit);
                return;
            }

            _this.deposit.paymentType = _this.paymentType;
            _this.deposit.gateway = _this.paymentGateway;

            _this.isLoading = true;
            HttpApi.post('wallet/deposit/payment', _this.deposit).then(response => {
                _this.showPixQRCode = true;
                _this.isLoading = false;

                _this.idTransaction = response.data.idTransaction;
                _this.qrcodecopypast = response.data.qrcode;

                _this.intervalId = setInterval(function() {
                    _this.checkTransactions(_this.idTransaction);
                }, 5000);

            }).catch(error => {
                Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => {
                    _toast.error(`${value}`);
                });
                _this.showPixQRCode = false;
                _this.isLoading = false;
            });
        },
        checkTransactions: function(idTransaction) {
            const _this = this;
            const _toast = useToast();

            HttpApi.post(_this.paymentGateway + '/consult-status-transaction', { idTransaction: idTransaction }).then(response => {
                _toast.success('Pedido concluído com sucesso');
                clearInterval(_this.intervalId);
                _this.openModalDeposit();
            }).catch(error => {
                Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => {
                    // _toast.error(`${value}`);
                });
            });
        },
        copyQRCode: function(event) {
            const _toast = useToast();
            var inputElement = document.getElementById("pixcopiaecola");
            inputElement.select();
            inputElement.setSelectionRange(0, 99999);  // Para dispositivos móveis

            // Copia o conteúdo para a área de transferência
            document.execCommand("copy");
            _toast.success('Pix Copiado com sucesso');
        },
        setAmount: function(amount) {
            this.deposit.amount = amount;
            this.selectedAmount = amount;
        },
        getWallet: function() {
            const _this = this;
            const _toast = useToast();
            _this.isLoadingWallet = true;

            HttpApi.get('profile/wallet')
                .then(response => {
                    _this.wallet = response.data.wallet;
                    _this.currency = response.data.wallet.currency;
                    _this.isLoadingWallet = false;
                })
                .catch(error => {
                    const _this = this;
                    Object.entries(JSON.parse(error.request.responseText)).forEach(([key, value]) => {
                        _toast.error(`${value}`);
                    });
                    _this.isLoadingWallet = false;
                });
        },
        getSetting: function() {
            const _this = this;
            const settingStore = useSettingStore();
            const settingData = settingStore.setting;

            if (settingData) {
                _this.setting = settingData;
                _this.amount = settingData.max_deposit;

                if (_this.paymentType === 'stripe' && settingData.stripe_is_enable) {
                    _this.getSession();
                }

                // Automatically select "SUITPAY" if it's enabled
                if (_this.setting.suitpay_is_enable) {
                    _this.setPaymentMethod('pix', 'suitpay');
                }
            }
        },
    },
    created() {
        if (this.isAuthenticated) {
            this.getWallet();
            this.getSetting();

            if (this.paymentType === 'stripe') {
                this.getSession();
                this.currency = 'USD';
            }
        }
    },
    watch: {
        amount(oldValue, newValue) {
            if (this.paymentType === 'stripe') {
                this.getSession();
                this.currency = 'USD';
            }
        },
        currency(oldValue, newValue) {
            if (this.paymentType === 'stripe') {
                this.getSession();
            }
        }
    },
};


</script>

<style scoped></style>
