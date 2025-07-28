<template>
    <div class="jackpot-container">
      <img src="/assets/images/jack.png" alt="Jackpot" class="jackpot-image">
      <div class="jackpot-number">
        <b>{{ formattedValue }}</b>
      </div>
    </div>
  </template>
  <script>
  export default {
  data() {
    return {
      value: 1000,
      targetValue: 100357346.27,
      updateInterval: 10000, // 5 segundos em milissegundos
    };
  },
  computed: {
    formattedValue() {
      return this.value.toLocaleString('en-US', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2,
      });
    },
  },
  methods: {
    countUp() {
      const increment = (this.targetValue - this.value) / 100;
      this.value += increment > 1000 ? Math.min(increment, 123456.78) : Math.max(increment, -123456.78);

      if (Math.abs(this.value - this.targetValue) < 1) {
        this.value = this.targetValue;
        this.startSecondaryCountUp(); // Inicie a contagem secundária
      } else {
        requestAnimationFrame(this.countUp);
      }
    },
    startSecondaryCountUp() {
      this.targetValue += 500; // Aumente o targetValue em 500
      this.countUpInterval = setInterval(this.countUp, this.updateInterval); // Inicie o intervalo de atualização
    },
    updateTargetValue() {
      const min = 123456.78; // Aqui você usar pra ser o maximo e minimo que vai aparecer
      const max = 987654.32;
      this.targetValue = Math.random() * (max - min) + min;
      this.countUp();
    },
  },
  mounted() {
    this.countUp();
    setInterval(this.updateTargetValue, 30 * 60 * 1000); // Aqui tu configura o tempo pra atualizar
  },
  beforeDestroy() {
    clearInterval(this.countUpInterval); // Limpe o intervalo quando o componente for destruído
  },
};
  </script>
  
  
  <style scoped>
    @import url('https://fonts.googleapis.com/css2?family=Abril+Fatface&display=swap');

  .jackpot-container {
    position: relative;
    width: 100%; 
    max-width: 1140px; 
    margin: 0 auto; 
    height: auto; 
}
  .jackpot-image {
    width: 100%; 
    display: block; 
    height: auto; 
}
  .jackpot-number {
    position: absolute;
    top: 62%; 
    left: 50%; 
    transform: translate(-50%, -50%); 
    font-size: 4.5vw; 
    color: #FFFA63; 
    letter-spacing: 0.05em; 
    max-width: 100%;
    text-align: center;
    font-family: "Abril Fatface", serif;
    font-weight: 400;
    font-style: normal;
  }
  </style>