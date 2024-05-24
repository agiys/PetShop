<template>
  <div class="item lg:w-4/5 m-auto w-full">
    <div
      class="catalog--wrapper flex justify-around border rounded-lg shadow mb-5"
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
    <div class="item--wrapper flex justify-center mt-6">
      <div v-if="store.response">
        <img
          v-if="store.response.image_url"
          :src="store.response.image_url"
          class="max-w-xl max-h-xl"
        />
        <img
          v-else
          src="~/assets/img/img-no-found.png"
          class="max-w-xl max-h-xl"
        />
        <h1 class="font-bold text-2xl mb-4">{{ store.response.name }}</h1>
        <p class="text-gray-700">{{ store.response.description }}</p>
        <div class="text-gray-700 text-lg font-bold">Цена: {{ store.response.price }}</div>
      </div>
      <div v-else>
        <p>Элемент не найден...</p>
      </div>
    </div>
    <div class="button--wrapper flex gap-4 justify-end">
      <UButton
        v-if="store.response.isFavorite"
        icon="material-symbols:heart-minus"
        size="sm"
        color="red"
        square
        label="Убрать из избранного"
        title="Убрать из избранного"
        variant="solid"
        @click.stop="deliteFavorite(store.response)"
        class="w-8 h-8"
      />
      <UButton
        v-if="!store.response.isFavorite"
        icon="material-symbols:heart-plus"
        size="sm"
        color="primary"
        square
        label="Добавить в избранное"
        title="Добавить в избранное"
        @click.stop="addFavorite(store.response)"
        variant="solid"
        class="w-8 h-8"
      />
      <UButton
        v-if="!store.response.cartItemId || store.response.cartItemCount === 0"
        icon="material-symbols:shopping-cart"
        size="sm"
        color="primary"
        square
        @click.stop="addItem(store.response)"
        title="Добавить в корзину"
        label="В корзину"
        variant="solid"
        class="w-8 h-8"
      />
      <div
        v-if="store.response.cartItemId && store.response.cartItemCount >= 1"
        class="button-wrapper flex justify-between"
      >
        <div>Количество: {{ store.response.cartItemCount }}</div>
        <div>
          <UButton
            icon="ic:baseline-add"
            size="sm"
            color="primary"
            square
            title="Добавить в корзину"
            variant="solid"
            class="w-8 h-8"
            @click.stop="addItem(store.response)"
          />
          <UButton
            icon="ic:baseline-minus"
            size="sm"
            color="primary"
            square
            title="Убрать из корзину (1 элемент)"
            variant="solid"
            class="w-8 h-8"
            @click.stop="deliteItem(store.response)"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useItemStore } from "~/store/item";
import { useAuthStore } from "~/store/auth";
import { useCartStore } from "~/store/cart";
import { useFavoritesStore } from "~/store/favorites";

const store = useItemStore();
const cartStore = useCartStore();
const favoritesStore = useFavoritesStore();
const authStore = useAuthStore();
const route = useRoute();

const categoryPages = {
  "Корма и лакомства": "foods",
  "Шампуни и кондиционеры": "shampoo",
  "Игрушки для животных": "toys",
  "Ошейники и поводки": "collars",
  "Клетки и вольеры": "cells",
};
definePageMeta({
  middleware: "auth",
});

onMounted(() => getItem());

const getItem = async () => {
  debugger;
  const id = route.params.id as string;
  store.response = await store.getItem(id, authStore.userName);
  store.category = await store.getCategory();

  console.log(store.response);
};

const addFavorite = async (item) => {
  debugger;
  const response = await favoritesStore.addFavoritesItem(
    item.id,
    authStore.userName
  );
  if (response) {
    item.isFavorite = true;
    item.favoritesItemId = response.favoritesItemId;
  }
};

const deliteFavorite = async (item) => {
  const response = await favoritesStore.deliteFavoritesItem(
    item.favoritesItemId
  );
  if (response) {
    item.isFavorite = false;
    item.favoritesItemId = null;
  }
};

const deliteItem = async (item) => {
  debugger;
  const response = await cartStore.deliteCartItem(item.cartItemId);
  if (!response) {
    throw new Error("Не удалось удалить");
  }
  item.cartItemCount -= 1;
};

const addItem = async (item) => {
  debugger;
  const response = await cartStore.addCartItem(item.id, authStore.userName);
  if (!response) {
    throw new Error("Не удалось добавить");
  }
  item.cartItemId = response.cartItemId;
  item.cartItemCount = response.cartItemCount;
};
</script>
