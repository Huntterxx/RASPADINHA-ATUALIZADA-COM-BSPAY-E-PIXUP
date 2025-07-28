<template>
    <div v-if="isLoading" class="is-loading-component w-full h-[calc(100vh-60px)] z-[999999]">
      <div class="text-center flex-col">
        <div class="absolute grid -translate-x-1/2 -translate-y-1/2 top-2/4 left-1/2">
          <div class="text-center mx-auto mb-5">
            <!-- Exiba a imagem de carregamento aqui -->
            <img src="/assets/images/loading.png" alt="Loading image" class="mx-auto text-gray-200 dark:text-gray-600 is-loading-data" />
          </div>
          <slot></slot>
        </div>
      </div>
    </div>
  </template>
  
  <style>
    .is-loading-component{
      position: fixed;
      top: 0;
      bottom: 0;
      left: 0;
      right: 0;
      width: 100vw;
      height: 100vh;
      background-color: rgba(255, 255, 255, 0.8);
      z-index: 999999;
      display: flex;
      justify-content: center;
      align-items: center;
    }
  
    .is-loading-data {
      animation: breathe 2s ease-in-out infinite;
    }
  
    @keyframes breathe {
      0% {
        transform: scale(1);
      }
      50% {
        transform: scale(1.1);
      }
      100% {
        transform: scale(1);
      }
    }
  </style>
  
  <script>
    export default {
      props: {
        isLoading: {
          type: Boolean,
          required: true
        }
      },
      components: {},
      data() {
        return {
    
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
    
      },
      watch: {
    
      },
    };
  </script>