<template>
  <div class="invite-banner-container">
    <img src="https://cdntoos.amh777.vip/siteadmin/skin/lobby_asset/2-1-28/web/home/icon_dt_pmd.png?manualVersion=1&version=5042a78ccb" alt="megaphone icon" class="icon icon-megaphone" style="width: 1em; height: 1em;">
    <div class="scrolling-text">
      <p>{{ bannerText }}</p>
    </div>
    <i class="icon icon-email fas fa-envelope"></i>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  props: {
    promotion_text: {
      type: String,
      default: ''
    }
  },
  data() {
    return {
      bannerText: ''
    };
  },
  mounted() {
    axios.get('/api/settings/promotion-texts')
      .then(response => {
        this.bannerText = response.data.promotion_text;
      })
      .catch(error => {
        // Tratamento de erro
        console.error("Erro ao buscar o texto do banner:", error);
        // Definindo um valor padrão ou executando outra ação em caso de erro
        this.bannerText = "Texto padrão do banner";
      });
  }
}
</script>

<style scoped>
.invite-banner-container {
  max-width: 1000px;
  width: 100%;
  height: 30px;
  background-color: var(--carousel-banners-dark);
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  overflow: hidden;
  padding: 0 20px;
  border-radius: 5px;
  margin: 30px auto 0 auto;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.icon {
  font-size: 20px;
  z-index: 2;
}

.icon-megaphone {
  position: absolute;
  left: 20px;
  top: 50%;
  transform: translateY(-50%);
}

.icon-email {
  position: absolute;
  right: 20px;
  top: 50%;
  transform: translateY(-50%);
}

.scrolling-text {
  flex-grow: 1;
  margin: 0 60px;
  white-space: nowrap;
  overflow: hidden;
  color: yellow;
  font-size: 11px;
}

.scrolling-text p {
  display: inline-block;
  animation: scrollText 10s linear infinite;
}

@keyframes scrollText {
  0% {
    transform: translateX(1100px);
  }
  100% {
    transform: translateX(-150%);
  }
}

/* Media query para telas menores */
@media (max-width: 600px) {
  .scrolling-text p {
    /* Ajuste a duração da animação conforme necessário para dispositivos móveis */
    animation: scrollTextMobile 12s linear infinite;
  }

  /* Regra keyframes para telas menores */
  @keyframes scrollTextMobile {
    0% {
      transform: translateX(100%);
    }
    100% {
      transform: translateX(-150%);
    }
  }

  /* Aqui você pode adicionar mais estilos específicos para dispositivos móveis */
}
</style>
