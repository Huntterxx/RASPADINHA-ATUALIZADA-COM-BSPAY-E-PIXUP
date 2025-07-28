<template>



            <div class="flex flex-col items-end fixed right-[20px] bottom-[74px] md:bottom-4 z-100">
  <ul class="mb-3">
    <div class="flex flex-col relative items-center cursor-pointer w-[120px] mt-[20px]">
      <a href="/profile/affiliate">
        <img id="imagem" src="https://cdntoos.gamewwwaap.com/active/ActiveImg2508761698211566.gif" alt="." data-status="loaded" class="w-[120px] h-[120px] opacity-100">
      </a>
      <div class="absolute right-0 top-0 w-[30px] h-[30px]" onclick="fecharImagem()">
        <div class="absolute right-0 top-0 flex justify-center items-center rounded-full bg-[var(--theme-text-color-lighten)] w-[20px] h-[20px] cursor-pointer">  <i class="inline-flex justify-center items-center w-[8px] h-[8px] text-white">  <svg width="1em" height="1em" fill="currentColor" aria-hidden="true" focusable="false" viewBox="0 0 24 24">
              <path fill="none" d="M0 0h24v24H0z"/>
              <path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"/>
            </svg>
          </i>
        </div>
      </div>
    </div>
  </ul>
</div>









<script>
import { fecharImagem } from '@/resources/views/app.blade.php'; // Import the function from the global file

export default {
  methods: {
    fecharImagem, // Make the function available in the component's methods
  },
};
</script>



    <div class="footer pb-32 md:pb-5 mt-5 footer-color p-4 md:p-8">
        <div class="md:w-4/6 2xl:w-4/6 m-auto">
            <div class="grid grid-cols-2 md:grid-cols-3 gap-4">
                <div class="col-span-2 md:col-span-1 flex flex-col">
                    <div class="flex justify-between mb-3">
                        <div class="mr-5">
                            <a v-if="setting" href="/" class="flex ml-2 md:mr-24">
                                <img :src="`/storage/`+setting.software_logo_black" alt="" class="h-10 mr-3 block dark:hidden " />
                                <img :src="`/storage/`+setting.software_logo_white" alt=""  class="h-10 mr-3 hidden dark:block" />
                            </a>
                        </div>
                        <div>
                            <img :src="`/assets/images/+18.png`" width="42" alt="">
                        </div>
                    </div>
                    <div v-if="setting">
                        <div class="">
                            {{ setting.software_description }}
                        </div>

                        <div class="flex  mt-5">
                            <div class="flex pl-2">
                                <a href="" class="text-3xl rosinha">
                                    <i class="fa-brands fa-instagram"></i>
                                </a>
                            </div>
                            <div class="flex pl-2">
                                <a href="" class="text-3xl text-gray-400">

                                </a>
                            </div>
                            <div class="flex pl-2">
                                <a href="" class="text-3xl rosinha">
                                    <i class="fa-brands fa-whatsapp"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="footer-list">
                    <h3 class="text-base md:text-lg text-gray-600 dark:text-white font-bold">{{ $t('USEFUL LINKS') }}</h3>
                    <ul class="list-none mt-5">
                        <li class="transition duration-700 hover:dark:text-white text-gray-600 rosinha hover:text-gray-800 text-[12px]"><a href="">{{ $t('Payment methods') }}</a></li>
                    </ul>
                </div>
                <div class="footer-list">
                    <h3 class="text-base md:text-lg text-gray-600 dark:text-white font-bold">{{ $t('ABOUT US') }}</h3>
                    <ul class="list-none mt-5">
                        <li class="transition duration-700 hover:dark:text-white text-gray-600 rosinha hover:text-gray-800 text-[12px]"><a @click="$router.push('/terms/service')" href="">{{ $t('Service Terms') }}</a></li>
                        <li class="transition duration-700 hover:dark:text-white text-gray-600 rosinha hover:text-gray-800 text-[12px]"><a @click="$router.push('/terms/privacy-policy')" href="">{{ $t('Privacy Policy') }}</a></li>
                        <li class="transition duration-700 hover:dark:text-white text-gray-600 rosinha hover:text-gray-800 text-[12px]"><a @click="$router.push('/terms/bonus')" href="">{{ $t('Bonus Terms') }}</a></li>
                        <li class="transition duration-700 hover:dark:text-white text-gray-600 rosinha hover:text-gray-800 text-[12px]"><a @click="$router.push('/terms/bonus-welcome')" href="">{{ $t('Welcome Bonus') }}</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <hr class="border-t border-gray-200 dark:border-gray-600 mt-5">

    <!--<div v-if="setting" class="mt-5 text-center">
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-center">
        <img :src="`/assets/images/ssl1.png`" width="200" height="200" alt="" class="mr-md-3 mb-md-0 img-fluid" style="max-width: 100%; height: auto; margin: 0 auto;">
        <p class="text-[10px] md:text-[12px]">
            {{ setting.software_name }} is an online entertainment website that offers its users a unique sports betting experience. This website is operated by Superbet88 International N.V., a company registered in Curaçao, under number 1712608, with registered office in Zuikertuintjeweg Z/N (Zuikertuin Tower), Willemstad, Curaçao. an entity duly authorized and licensed by the Government of Curaçao. By accessing, continuing to use, or browsing this website you agree that we may use certain browser cookies to improve your experience whilst using our site. We only use cookies to enhance your experience, and this does not interfere with your privacy.
        </p>
    </div>
</div>-->



        <div v-if="setting" class="mt-5 flex flex-col justify-start ">
            <p class="text-[12px] w-full">© {{ year }} {{ setting.software_name }} {{ $t('All rights reserved') }}.</p>
            <p class="flex text-[10px] md:text-[12px]  w-full">
<!--                <strong>❤️ Developed by</strong>-->
<!--                <a href="https://www.instagram.com/hugosilva/" target="_blank" class="ml-2 dark:text-gray-500 dark:hover:text-white transition duration-700 cursor-pointer">-->
<!--                    hugo silva-->
<!--                </a>-->
            </p>
        </div>
    </div>
</template>

<script>
    import HttpApi from "@/Services/HttpApi.js";
    import {useSettingStore} from "@/Stores/SettingStore.js";

    export default {
        props: [],
        components: {},
        data() {
            return {
                isLoading: false,
                year: new Date().getFullYear(),
                setting: null,
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
            getSetting: function() {
                const _this = this;
                const settingStore = useSettingStore();
                const settingData = settingStore.setting;

                if(settingData) {
                    _this.setting = settingData;
                }
            },
        },
        created() {
            this.getSetting();
        },
        watch: {

        },
    };
</script>

<style scoped>

</style>
