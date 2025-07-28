<template>
    <div class="floating-button" v-if="showButton">
      <img :src="iconSrc" alt="Botão" @click="redirectToSpinPage">
      <button @click="closeButton">×</button>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        showButton: true,
        iconSrc: '/assets/images/roleta.gif'
      };
    },
    methods: {
      closeButton() {
        this.showButton = false;
      },
      redirectToSpinPage() {
        const currentDomain = window.location.origin;
        window.location.href = `${currentDomain}/landing/spin`;
      }
    }
  };
  </script>
  
  <style scoped>
  .floating-button {
    position: fixed;
    bottom: 80px;
    right: 20px;
  }
  
  .floating-button img {
    width: 65px; 
    height: 65px; 
    cursor: pointer;
  }
  
  .floating-button button {
    position: absolute;
    top: -10px;
    right: -10px;
    background-color: red;
    color: white;
    width: 20px;
    height: 20px;
    border: none;
    border-radius: 50%;
    cursor: pointer;
  }
  </style>
  