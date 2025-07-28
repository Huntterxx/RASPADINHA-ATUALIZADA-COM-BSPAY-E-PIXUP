<template>
    <div class="container">
      <div class="mb-5 mx-4 w-full">
        <div class="gains-slider-container">
          <div class="gains-section">
            <div class="icon-trofeu"><img src="/assets/images/trofeu.webp" alt=""></div>
            <div class="title-gains">
              <h1>ÚLTIMOS <br> GANHOS HOJE</h1>
            </div>
          </div>
          <div class="gains-con">
            <div class="gains-slider">
              <div class="logos-slide">
                <div class="slide-gains" v-for="(gain, index) in gains" :key="index">
                  <img :src="gain.image" :alt="gain.game">
                  <div class="status-gains">
                    <p class="player">{{ gain.player }}</p>
                    <p class="game">{{ gain.game }}</p>
                    <p class="valor">{{ gain.amount }}</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        gains: [
          { player: 'Camila B****', game: 'Fortune Tiger', amount: 'R$ 85,00', image: '/assets/images/games/tigre.webp'},
          { player: 'Guilherme S****', game: 'Big Bass Bonanza', amount: 'R$ 75,50', image: '/assets/images/games/big.png'},
          { player: 'Rafaela O****', game: 'The Dog House', amount: 'R$ 175,00', image: '/assets/images/games/dog.png'},
          { player: 'Hugo L****', game: 'Ganesha Gold', amount: 'R$ 20,00', image: '/assets/images/games/gold.webp'},
          { player: 'Roberta R****', game: 'Prosperity Fortune Tree', amount: 'R$ 55,00', image: '/assets/images/games/tree.webp'},
          { player: 'Fernando P****', game: 'Fruit Party', amount: 'R$ 68,00', image: '/assets/images/games/fruit.png'},
          { player: 'Isabela F****', game: 'Ganesha Fortune', amount: 'R$ 21,00', image: '/assets/images/games/ganesha.webp'},
          { player: 'Gabriela R****', game: 'Gates of Olympus', amount: 'R$ 100,00', image: '/assets/images/games/gates.webp'},
          { player: 'Camila R****', game: 'Fortune Tiger', amount: 'R$ 100,00', image: '/assets/images/games/tigre.webp'},
          { player: 'Thales C****', game: 'Fortune OX', amount: 'R$ 220,00', image: '/assets/images/games/ox.webp'},
          { player: 'Maria A****', game: 'Ganesha Gold', amount: 'R$ 67,50', image: '/assets/images/games/gold.webp'},
          { player: 'Vitor L****', game: 'Sugar Rush', amount: 'R$ 89,00', image: '/assets/images/games/sugar.png' },
          { player: 'Vinícius M****', game: 'The Dog House', amount: 'R$ 77,77', image: '/assets/images/games/dog.png'},
          { player: 'Aline S****', game: 'Fortune Tiger', amount: 'R$ 12,00', image: '/assets/images/games/tigre.webp'},
          { player: 'Priscila L****', game: 'Big Bass Bonanza', amount: 'R$ 95,00', image: '/assets/images/games/big.png'},
          { player: 'Fernanda A****', game: 'Fortune Rabbit', amount: 'R$ 115,00', image: '/assets/images/games/rabbit.webp'},
          { player: 'Hugo L****', game: 'Fortune Mouse', amount: 'R$ 95,00', image: '/assets/images/games/mouse.webp'},
          { player: 'Mariana C****', game: 'Big Bass Bonanza', amount: 'R$ 99,99', image: '/assets/images/games/big.png'},
          { player: 'Rodrigo O****', game: 'Fruit Party', amount: 'R$ 77,77', image: '/assets/images/games/fruit.png'},
          { player: 'Carla S****', game: 'The Dog House', amount: 'R$ 333,33', image: '/assets/images/games/dog.png'},
          { player: 'Renato A****', game: 'Gates of Olympus', amount: 'R$ 123,45', image: '/assets/images/games/gates.webp'},
          { player: 'Fernanda A****', game: 'Ganesha Gold', amount: 'R$ 20,00', image: '/assets/images/games/gold.webp'},
          { player: 'Eduardo S****', game: 'Prosperity Fortune Tree', amount: 'R$ 105,00', image: '/assets/images/games/tree.webp'},
          { player: 'Carla S****', game: 'Fortune OX', amount: 'R$ 85,00', image: '/assets/images/games/ox.webp'},
        ]
      };
    }
  };
  </script>
  
 
<style scoped>
.container {
  display: flex;
  justify-content: center;
}

.gains-slider-container {
  width: 100%;
  max-width: 1200px; /* Defina a largura máxima do container */
  height: auto;
  display: flex;
  justify-content: space-between;
}

.gains-section {
  width: 300px;
  height: 100px;
  background: linear-gradient(90deg, rgba(255, 172, 75, 0.25) 0%, rgba(255, 172, 75, 0) 100%);
  z-index: 10;
  display: flex;
  align-items: center;
  gap: 15px;
  border-top-left-radius: 6px;
  border-bottom-left-radius: 6px;
}

.icon-trofeu img {
  width: 90px;
}

.title-gains h1 {
  color: #fff;
  font-weight: 800;
  font-size: 25px;
}

.gains-con {
  width: calc(100% - 300px);
  overflow: hidden;
}

.gains-slider {
  overflow: hidden;
  padding-left: 300px;
  white-space: nowrap;
  position: relative;
  display: flex;
}

.gains-slider:before,
.gains-slider:after {
  position: absolute;
  top: 0;
  width: 250px;
  height: 100%;
  content: "";
  z-index: 2;
}

.gains-slider:before {
  left: 0;
}

.gains-slider:after {
  right: 0;
}

.gains-slider:hover .logos-slide {
  animation-play-state: paused;
}

.logos-slide {
  display: flex;
  animation: slide 35s infinite linear;
}

.slide-gains {
  background-color: #1e2024;
  margin-right: 15px;
  width: 200px;
  overflow: hidden;
  border-radius: 6px;
  display: flex;
  align-items: center;
  gap: 10px;
  height: 100%;
}

.slide-gains .player {
  font-family: Arial, sans-serif;
  color: #fff;
  font-weight: 500;
  font-size: 12px;
}

.slide-gains .game {
  font-family: Arial, sans-serif;
  color: #fff;
  font-size: 10px;
  margin: 0;
}

.slide-gains img {
  height: 100%;
  border-radius: 6px;
}

.slide-gains .valor {
  font-size: 15px;
  color: #ff0;
}

.logos-slide img {
  height: 100px;
}

@keyframes slide {
  0% {
    transform: translate(0);
  }
  to {
    transform: translate(-100%);
  }
}

@media only screen and (max-width: 600px) {
  .gains-section {
    width: 170px;
    height: 85px;
  }

  .icon-trofeu img {
    width: 60px;
  }

  .title-gains h1 {
    font-size: 14px;
  }

  .gains-slider {
    padding-left: 170px;
  }

  .slide-gains {
    height: 85px;
  }

  .gains-con {
    width: calc(100% - 170px);
    overflow: hidden;
  }
}
</style>
  