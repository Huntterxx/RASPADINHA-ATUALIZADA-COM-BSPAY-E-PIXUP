<template>
    <div class="item-game-container">
      <div class="item-game text-gray-700 w-full h-auto mr-4 cursor-pointer">
        <RouterLink v-if="game.distribution === 'kagaming'" :to="{ name: 'casinoPlayPage', params: { id: game.id, slug: game.game_code }}">
          <img :src="game.cover" alt="" class="w-full">
        </RouterLink>
        <RouterLink v-else :to="{ name: 'casinoPlayPage', params: { id: game.id, slug: game.game_code }}">
          <img :src="`/storage/`+game.cover" alt="" class="w-full ">
        </RouterLink>
        <div class="flex justify-between w-full text-gray-700 dark:text-gray-400 px-3 py-2">
          
          
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import { RouterLink } from "vue-router";
  
  export default {
    props: ['index', 'game'],
    components: { RouterLink },
    data() {
      return {
        isLoading: false,
        modalGame: null,
        randomNumber: 0
      }
    },
    setup(props) {
      return {};
    },
    computed: {
      randomNumber() {
        return Math.floor(Math.random() * (2000 - 100 + 1)) + 100;
      }
    },
    methods: {},
    created() {},
    watch: {},
  };
  </script>
  
  <style scoped>
  .item-game-container {
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  
  .online-indicator {
    margin-top: 5px;
    color: white; 
  }
  
  .pulse {
    width: 8px;
    height: 8px;
    background-color: #00ff00; 
    border-radius: 50%;
    margin-right: 5px;
    animation: pulse-animation 1s infinite;
    box-shadow: 0 0 5px #00ff00, 0 0 20px #00ff00; 
  }
  
  @keyframes pulse-animation {
    0% {
      transform: scale(1);
    }
    50% {
      transform: scale(1.2);
    }
    100% {
      transform: scale(1);
    }
  }
  </style>
  