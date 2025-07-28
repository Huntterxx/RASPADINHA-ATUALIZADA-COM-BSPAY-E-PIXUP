<template>
    <div v-if="isVisible" class="banner">
      <span class="banner-text">Indique o seu código de referência e ganhe comissão!</span>
      <div class="button-group">
        <button @click="close" class="close-btn">x</button>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        isVisible: true, // Controla a visibilidade do banner
      };
    },
    methods: {
      close() {
        this.isVisible = false; // Esconde o banner
        console.log('Banner fechado');
      },
      register() {
        console.log('Botão de registro clicado');
      }
    }
  }
  </script>
  
  <style scoped>
  /* Variáveis e estilos globais */
  :root {
      --ci-secundary-color: #2CB17F; /* Cor verde */
      --title-color: #ffffff;
      --border-radius: .25rem;
      font-family: Inter,sans-serif;
  }
  
  .banner {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background-color: var(--ci-secundary-color);
      color: var(--title-color);
      width: 100%; /* Largura completa */
      height: 50px; /* Altura fixa do banner */
      margin: auto; /* Centraliza o banner horizontalmente */
      padding: 0.25rem;
      box-sizing: border-box;
  }
  
  .banner-text {
      flex: 1 0 auto; /* Permite que o texto cresça e encolha conforme necessário */
      text-align: center; /* Centraliza o texto */
  }
  
  .button-group button {
      background: transparent;
      color: inherit;
      border: none;
      padding: 5px 10px;
      cursor: pointer;
      border-radius: var(--border-radius);
  }
  
  .button-group .close-btn {
      margin-left: auto;
      font-size: 1rem;
  }
  
  button:hover {
      opacity: 0.8;
  }
  
  @media (max-width: 600px) {
      .banner {
          height: 30px; /* Altura reduzida para telas menores */
          font-size: 0.85rem; /* Aumenta o tamanho da fonte */
      }
  }
  </style>