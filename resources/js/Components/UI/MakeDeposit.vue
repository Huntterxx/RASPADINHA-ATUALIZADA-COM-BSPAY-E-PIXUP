<template>
    <button @click.prevent="toggleModalDeposit" type="button" :class="[showMobile === true ? 'hidden md:block' : '', isFull ? 'w-full' : '']" class="depositoclass mr-3 rounded">
        {{ title }}
    </button>

    <div id="modalElDeposit" tabindex="-1" aria-hidden="true" class="fixed top-0 left-0 right-0 z-50 hidden w-full overflow-x-hidden overflow-y-auto md:inset-0 h-screen md:h-[calc(100%-1rem)] max-h-full">
        <div class="relative w-full max-w-2xl max-h-full dark:bg-[#EE7879]">
            <div class="flex flex-col md:justify-between px-6 pb-8 my-auto">
                <div class="flex justify-between items-center modal-header mb-6 mt-6">
                    <div class="flex items-center" style="border-bottom: 2px solid #FECDD3;">
                        <i class="fa-solid fa-mobile-screen-button text-rose-200 mr-2"></i>
                        <h1 class="font-bold text-xl text-rose-200">{{ $t('Depósito on-line') }}</h1>
                    </div>
                    <button @click="closeModal" class="text-white">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>


                <DepositWidget />
            </div>
        </div>
    </div>
</template>

<script>
import {useAuthStore} from "@/Stores/Auth.js";
import DepositWidget from "@/Components/Widgets/DepositWidget.vue";
import {onMounted} from "vue";
import {initFlowbite} from "flowbite";

export default {
    props: ['showMobile', 'title', 'isFull'],
    components: { DepositWidget },
    data() {
        return {
            isLoading: false,
            modalDeposit: null,
        }
    },
    setup(props) {
        onMounted(() => {
            initFlowbite();
        });

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
            onShow: () => {

            },
            onToggle: () => {

            },
        });
    },
    beforeUnmount() {

    },
    methods: {
        toggleModalDeposit: function() {
            this.modalDeposit.toggle();
        },
        closeModal: function() {
            this.modalDeposit.hide();
        },
    },
    created() {

    },
    watch: {

    },
};
</script>

<style scoped>

</style>
