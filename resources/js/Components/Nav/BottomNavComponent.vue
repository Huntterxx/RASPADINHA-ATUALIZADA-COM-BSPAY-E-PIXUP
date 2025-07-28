<template>
    <div class="flex sm:hidden">
        <div class="fixed z-40 w-full h-16 max-w-lg -translate-x-1/2 border bottom-0 left-1/2" style="background-color: var(--carousel-banners-dark); border: none;">
            <div class="grid h-full max-w-lg grid-cols-5 mx-auto">
                <button @click="$router.push('/')" data-tooltip-target="tooltip-home" type="button" class="inline-flex flex-col items-center justify-center px-5 rounded-l-full hover:bg-gray-50 dark:hover:bg-gray-800 group">
                    <i class="fa-light fa-house-chimney mb-1 text-xl"></i>
                    <span class="text-[12px]">{{ $t('Inicio') }}</span>
                </button>
                <div id="tooltip-home" role="tooltip" class="absolute z-10 invisible inline-block px-3 py-2 text-sm font-medium text-white transition-opacity duration-300 bg-gray-900 rounded-lg shadow-sm opacity-0 tooltip dark:bg-gray-700">
                    {{ $t('Inicio') }}
                    <div class="tooltip-arrow" data-popper-arrow></div>
                </div>
                <button @click="$router.push('/events')" data-tooltip-target="tooltip-casino" type="button" class="inline-flex flex-col items-center justify-center px-5 hover:bg-gray-50 dark:hover:bg-gray-800 group">
                    <i class="fa-light fa-gift mb-1 text-xl"></i>
                    <span class="text-[12px]">{{ $t('Promoção') }}</span>
                </button>
                <div id="tooltip-casino" role="tooltip" class="absolute z-10 invisible inline-block px-3 py-2 text-sm font-medium text-white transition-opacity duration-300 bg-gray-900 rounded-lg shadow-sm opacity-0 tooltip dark:bg-gray-700">
                    {{ $t('Promoção') }}
                    <div class="tooltip-arrow" data-popper-arrow></div>
                </div>
                <div class="flex items-center justify-center">
                    <button @click="$router.push('/profile/affiliate')" data-tooltip-target="tooltip-new" type="button" class="inline-flex flex-col items-center justify-center px-5 rounded-r-full hover:bg-gray-50 dark:hover:bg-gray-800 group">
                        <i class="fa-light fa-share-from-square mb-1 text-xl"></i>
                        <span class="sr-only">{{ $t('Agent') }}</span>
                        <span class="text-[12px]">Agente</span>
                    </button>
                </div>
                <div id="tooltip-new" role="tooltip" class="absolute z-10 invisible inline-block px-3 py-2 text-sm font-medium text-white transition-opacity duration-300 bg-gray-900 rounded-lg shadow-sm opacity-0 tooltip dark:bg-gray-700">
                    {{ $t('Agente') }}
                    <div class="tooltip-arrow" data-popper-arrow></div>
                </div>
                <a href="#" target="_blank" data-tooltip-target="tooltip-sport" type="button" class="inline-flex flex-col items-center justify-center px-5 rounded-r-full hover:bg-gray-50 dark:hover:bg-gray-800 group">
                    <i class="fa-light fa-headset mb-1 text-xl"></i>
                    <span class="text-[12px]">Suporte</span>
                </a>

                <div id="tooltip-sport" role="tooltip" class="absolute z-10 invisible inline-block px-3 py-2 text-sm font-medium text-white transition-opacity duration-300 bg-gray-900 rounded-lg shadow-sm opacity-0 tooltip dark:bg-gray-700">
                    Suporte
                    <div class="tooltip-arrow" data-popper-arrow></div>
                </div>
                <button data-tooltip-target="tooltip-wallet" type="button" class="inline-flex flex-col items-center justify-center px-5 hover:bg-gray-50 dark:hover:bg-gray-800 group">
    <a href="/profile/wallet" class="flex flex-col items-center">
        <i class="fal fa-user mb-1 text-xl"></i>
        <span class="text-[12px]">{{ $t('Perfil') }}</span>
    </a>
</button>





                <div id="tooltip-wallet" role="tooltip" class="absolute z-10 invisible inline-block px-3 py-2 text-sm font-medium text-white transition-opacity duration-300 bg-gray-900 rounded-lg shadow-sm opacity-0 tooltip dark:bg-gray-700">
                    {{ $t('Perfil') }}
                    <div class="tooltip-arrow" data-popper-arrow></div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>

export default {
    props: [],
    components: {},
    data() {
        return {
            isLoading: false,
        }
    },
    setup(props) {
        return {};
    },
    computed: {

    },
    mounted() {

    },
    methods: {
        openModal(modalId) {
            const modal = document.getElementById(modalId);
            if (modal) {
                modal.classList.remove('hidden');
            }
        },
        closeModal(modalId) {
            const modal = document.getElementById(modalId);
            if (modal) {
                modal.classList.add('hidden');
            }
        },
        profileToggle() {
            // Seu código existente para profileToggle, se necessário
        }
    },
    watch: {

    },
};
</script>



<style scoped>
.hidden {
    display: none;
}
</style>
