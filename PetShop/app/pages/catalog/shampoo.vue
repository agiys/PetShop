<template>
  <div class="catalog lg:w-4/5 m-auto w-full">
    <div
      class="catalog__wrapper flex justify-around border rounded-lg shadow mb-5"
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
    <div
      class="catalog__wrapper grid md:grid-cols-3 xl:grid-cols-4 gap-5 sm:grid-cols-2"
    >
      <div
        v-for="item in cards"
        :key="item.id"
        class="hover:scale-110 bg-white hover:z-50 card flex flex-col p-4 border rounded-lg shadow"
        :ref="(el) => cartItemsRefs.set(item.id, el)"
      >
        <div class="button-wrapper flex justify-start">
          <UButton
            v-if="item.isFavorite"
            icon="material-symbols:heart-minus"
            size="sm"
            color="red"
            square
            title="Убрать из избранного"
            variant="solid"
            @click.stop="deliteFavorite(item.favoritesItemId)"
            class="w-8 h-8"
          />
          <UButton
            v-if="!item.isFavorite"
            icon="material-symbols:heart-plus"
            size="sm"
            color="primary"
            square
            title="Добавить в избранное"
            @click.stop="addFavorite(item.id)"
            variant="solid"
            class="w-8 h-8"
          />
        </div>
        <nuxt-link
          :to="`/card/${item.id}?user=${authStore.userName}`"
          class="no-underline"
        >
          <div class="img--wrapper flex justify-center">
            <img v-if="item.image_url" :src="item.image_url" class="max-w-60 max-h-60" />
            <img v-else src="~/assets/img/img-no-found.png" class="max-w-60 max-h-60">
          </div>
          <div class="font-bold text-lg mb-2">{{ item.name }}</div>
          <div class="text-gray-700 text-lg font-bold">Цена: {{ item.price }}</div>
        </nuxt-link>
        <div class="button-wrapper flex justify-end">
          <UButton
            v-if="!item.cartItemId || item.cartItemCount === 0"
            icon="material-symbols:shopping-cart"
            size="sm"
            color="primary"
            square
            @click.stop="addToCart(item, authStore.userName)"
            title="Добавить в корзину"
            variant="solid"
            class="w-8 h-8"
          />
        </div>
        <div
          v-if="item.cartItemId && item.cartItemCount >= 1"
          class="button-wrapper flex justify-between"
        >
          <div>Количество: {{ item.cartItemCount }}</div>
          <div>
            <UButton
              icon="ic:baseline-add"
              size="sm"
              color="primary"
              square
              title="Добавить в корзину"
              variant="solid"
              class="w-8 h-8"
              @click.stop="addItem(item)"
            />
            <UButton
              icon="ic:baseline-minus"
              size="sm"
              color="primary"
              square
              title="Убрать из корзины"
              variant="solid"
              class="w-8 h-8"
              @click.stop="deliteItem(item)"
            />
          </div>
        </div>
      </div>
    </div>
    <div class="pagination--wrapper mt-5 flex justify-center">
      <UPagination
      v-if="store.response.length !== 0"
        v-model="page"
        :page-count="pageCount"
        :total="pageTotal"
        show-last
        show-first
        color="blue"
      />
      <div v-else class="text-2xl font-bold flex flex-col items-center gap-5">
        Товар отсутсвует =(
        <img  src="~/assets/img/no-product.jpeg">
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useCatalogStore } from "~/store/catalog";
import { useCartStore } from "~/store/cart";
import { useAuthStore } from "~/store/auth";
import { useFavoritesStore } from "~/store/favorites";

const store = useCatalogStore();
const cartStore = useCartStore();
const authStore = useAuthStore();
const favoritesStore = useFavoritesStore();
const router = useRouter();
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

const cards = computed(() => {
  pageTotal.value = store.response.length;
  return store.response.slice(
    (page.value - 1) * pageCount.value,
    page.value * pageCount.value
  );
});

const page = ref(1);
const pageCount = ref(8);
const pageTotal = ref(store.response.length);

onMounted(() => getCatalog());

const getCatalog = async () => {
  store.category = await store.getCategory();
  debugger;
  if (authStore.userName) {
    store.response = await store.getAuthCatalog("2", authStore.userName);
  } else {
    store.response = await store.getCatalog("2");
  }
};

const addFavorite = async (catalogItemId) => {
  if (!authStore.userName) {
    await router.push("/favorites");
    window.location.reload();
  }
  const response = await favoritesStore.addFavoritesItem(
    catalogItemId,
    authStore.userName
  );
  if (response) {
    const item = store.response.find((item) => item.id === catalogItemId);
    debugger;
    if (item) {
      item.isFavorite = true;
      item.favoritesItemId = response.favoritesItemId;
    }
  }
};

const deliteFavorite = async (favoritesItemId) => {
  const response = await favoritesStore.deliteFavoritesItem(favoritesItemId);
  if (response) {
    const item = store.response.find(
      (item) => item.favoritesItemId === favoritesItemId
    );
    if (item) {
      item.isFavorite = false;
      item.favoritesItemId = null;
    }
  }
};

const cartItemsRefs = new Map();

const addToCart = async (item) => {
  if (authStore.userName) {
    const response = await cartStore.addCartItem(item.id, authStore.userName);
    if (response) {
      const cartItemRef = cartItemsRefs.get(item.id);
      cartItemRef.classList.add("flash");
      cartItemRef.addEventListener(
        "animationend",
        () => {
          cartItemRef.classList.remove("flash");
        },
        { once: true }
      );
      debugger;
      item.cartItemId = response.cartItemId;
      item.cartItemCount = response.cartItemCount;
    }
  } else {
    await router.push("/cart");
    window.location.reload();
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
  item.cartItemCount += 1;
};
</script>

<style scoped>
@keyframes flash {
  0% {
    background-color: orange;
  }
  100% {
    background-color: transparent;
  }
}

.flash {
  animation: flash 0.5s ease-in-out;
}
</style>
