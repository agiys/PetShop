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
      v-if="cards.length !== 0 && authStore.userName"
      class="catalog__wrapper grid md:grid-cols-3 xl:grid-cols-4 gap-5 sm:grid-cols-2"
    >
      <div
        v-for="item in cards"
        :key="item.id"
        class="hover:scale-110 bg-white hover:z-50 card flex flex-col p-4 border rounded-lg shadow"
      >
        <div class="button-wrapper flex justify-start"></div>
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
        <div class="button-wrapper flex justify-between">
          <div>Количество: {{ item.count }}</div>
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
    <div
      v-else-if="cards.length === 0 && authStore.userName"
      class="flex flex-col justify-center text-2xl font-extrabold gap-4"
    >
      <div class="flex justify-center">Ваша корзина пуста</div>
      <img src="~/assets/img/empty-cart.png" />
    </div>
    <div
      v-else-if="!authStore.userName"
      class="flex flex-col justify-center text-2xl font-extrabold gap-4"
    >
      <div class="flex flex-col items-center gap-3">
        Авторизируйтесь для сохранения корзины
        <UButton
          label="Авторизация"
          size="sm"
          color="primary"
          square
          variant="solid"
          class="flex justify-center w-auto h-auto text-2xl"
          @click.stop="router.push('/login')"
        />
      </div>
      <img src="~/assets/img/empty-cart.png" />
    </div>
    <div class="pagination--wrapper mt-5 flex justify-center">
      <UPagination
        v-if="cards.length !== 0"
        v-model="page"
        :page-count="pageCount"
        :total="pageTotal"
        show-last
        show-first
        color="blue"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { useCatalogStore } from "~/store/catalog";
import { useCartStore } from "~/store/cart";
import { useAuthStore } from "~/store/auth";

const store = useCatalogStore();
const cartStore = useCartStore();
const authStore = useAuthStore();
const router = useRouter();
const categoryPages = {
  "Корма и лакомства": "foods",
  "Шампуни и кондиционеры": "shampoo",
  "Игрушки для животных": "toys",
  "Ошейники и поводки": "collars",
  "Клетки и вольеры": "cells",
};

const cards = computed(() => {
  pageTotal.value = cartStore.cartItems.length;
  return cartStore.cartItems.slice(
    (page.value - 1) * pageCount.value,
    page.value * pageCount.value
  );
});

const page = ref(1);
const pageCount = ref(8);
const pageTotal = ref(cartStore.cartItems.length);

onMounted(() => getCatalog());

const getCatalog = async () => {
  store.category = await store.getCategory();
  cartStore.cartItems = await cartStore.getCart({ user: authStore.userName });
};

definePageMeta({
  middleware: "auth",
});

const deliteItem = async (item) => {
  debugger;
  const response = await cartStore.deliteCartItem(item.cartItemId);
  if (!response) {
    throw new Error("Не удалось удалить");
  }

  if (item.count > 1) {
    item.count -= 1;
  } else {
    cartStore.cartItems = cartStore.cartItems.filter(
      (i) => i.cartItemId !== item.cartItemId
    );
  }
};

const addItem = async (item) => {
  debugger;
  const response = await cartStore.addCartItem(item.id, authStore.userName);
  if (!response) {
    throw new Error("Не удалось добавить");
  }
  item.count += 1;
};

</script>
