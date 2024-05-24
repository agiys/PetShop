<template>
    <div class="relative w-full">
      <div class="flex overflow-hidden">
        <div
          v-for="(slide, index) in slides"
          :key="index"
          class="min-w-full transition-transform duration-300"
          :style="{ transform: `translateX(-${currentIndex * 100}%)` }"
        >
          <img :src="slide" class="w-full object-cover rounded-3xl" />
        </div>
      </div>
      <button
        class="absolute w-12 h-12 top-1/2 left-1 transform -translate-y-1/2 bg-gray-800 bg-opacity-50 rounded-full text-white p-3 hover:scale-110"
        @click="prevSlide"
      >
        <Icon name="ep:arrow-left-bold" class="hover:scale-125"/>
      </button>
      <button
        class="absolute w-12 h-12 top-1/2 right-1 transform -translate-y-1/2 bg-gray-800 bg-opacity-50 rounded-full text-white p-3 hover:scale-110"
        @click="nextSlide"
      >
      <Icon name="ep:arrow-right-bold" class="hover:scale-125"/>
      </button>
    </div>
  </template>
  
  <script setup lang="ts">
  import { ref, onMounted, onUnmounted } from 'vue';
  
  // Импорт изображений
  import petshopImg from '~/assets/img/sale1.jpg';
  import anotherImg from '~/assets/img/sale2.png';
  import yetAnotherImg from '~/assets/img/sale3.jpg';
  
  const slides = ref([
    petshopImg,
    anotherImg,
    yetAnotherImg
  ]);
  
  const currentIndex = ref(0);
  let intervalId: NodeJS.Timeout;
  
  const prevSlide = () => {
    currentIndex.value =
      currentIndex.value === 0 ? slides.value.length - 1 : currentIndex.value - 1;
  };
  
  const nextSlide = () => {
    currentIndex.value =
      currentIndex.value === slides.value.length - 1 ? 0 : currentIndex.value + 1;
  };
  
  const startAutoSlide = () => {
    intervalId = setInterval(nextSlide, 5000);
  };
  
  const stopAutoSlide = () => {
    clearInterval(intervalId);
  };
  
  onMounted(() => {
    startAutoSlide();
  });
  
  onUnmounted(() => {
    stopAutoSlide();
  });
  </script>
  
  <style scoped>
  .slider-container {
    display: flex;
    overflow: hidden;
    position: relative;
  }
  
  .slide {
    min-width: 100%;
    transition: transform 0.3s ease;
  }
  </style>
  