<template>
  <div class="catalog lg:w-4/5 m-auto w-full">
    <div
      class="catalog__wrapper flex justify-between border rounded-lg shadow mb-5"
    >
      <div
        v-for="item in store.category"
        :key="item.id"
        class="card flex flex-col p-4"
      >
        <nuxt-link
          :to="`/catalog/${categoryPages[item.name]}`"
          class="hover:text-orange-500"
        >
          <div class="font-bold text-lg mb-2">{{ item.name }}</div>
        </nuxt-link>
      </div>
    </div>
    <div>
      <Slider />
    </div>
    <div
      class="catalog__wrapper grid md:grid-cols-3 xl:grid-cols-3 gap-5 sm:grid-cols-2 pt-10"
    >
      <div
        v-for="item in sells"
        :key="item.id"
        class="hover:scale-110 bg-white hover:z-50 card flex flex-col p-4 border rounded-lg shadow"
      >
        <div class="text-lg font-bold">
          {{ item.name }}
          <img :src="item.url" class="w-80 h-80" />
        </div>
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">
import { useCatalogStore } from "~/store/catalog";
import { useLoadingStore } from "~/store/loading";
const loadingStore = useLoadingStore();
const store = useCatalogStore();
const categoryPages = {
  "Корма и лакомства": "foods",
  "Шампуни и кондиционеры": "shampoo",
  "Игрушки для животных": "toys",
  "Ошейники и поводки": "collars",
  "Клетки и вольеры": "cells",
}

definePageMeta({
  middleware: "auth",
});

const sells = [
  {
    id: 1,
    name: "Скидка на крома Pro Plan",
    url: "https://zoopt.ru/upload/webp/iblock/b9b/600kh428-_42_.webp",
  },
  {
    id: 2,
    name: "Новинка: Шампунь против запаха",
    url: "https://catalog.detmir.st/media/CHW_NqMybgFJkJa5jG_lak9giRepOjw9qLbITCImfIM=?preset=site_product_gallery_r450",
  },
  {
    id: 2,
    name: "Скидка на игрушки для собак",
    url: "https://api.zapovednik96.ru/upload/iblock/6c6/n7broqrz8h7q5wtxd554v6oum3307t0y.jpg",
  },
];

onMounted(() => {
  getCatalog();
});

const getCatalog = async () => {
  if (store.category.length === 0) {
    try {
      loadingStore.isLoading = true;
      const categories = await store.getCategory();
      store.category = categories;
    } catch (error) {
      console.error("Error fetching categories:", error);
    } finally {
      loadingStore.isLoading = false;
    }
  } else {
    loadingStore.isLoading = false;
  }
};
</script>
