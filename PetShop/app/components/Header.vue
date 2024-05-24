<script setup lang="ts">
const router = useRouter()
</script>

<template>
  <div
    class="w-full lg:w-4/5 lg:left-20 lg:right-20 flex py-5 px-16 fixed top-0 left-0 right-0 bg-white z-40 shadow-md m-auto justify-between items-center rounded-md translate-y-0"
  >
    <div class="flex flex-row items-center gap-4">
      <a href="http://localhost:3000/" class="font-extrabold"
        ><img src="/assets/img/petshop.png" class="w-12 cursor-pointer" alt=""
      /></a>
      <div class="grid">
        <a
          href="http://localhost:3000/"
          class="text-orange-500 font-extrabold text-2xl"
          >Pet</a
        >
        <a
          href="http://localhost:3000/"
          class="text-orange-500 font-extrabold text-2xl ml-8"
          >Shop</a
        >
      </div>
    </div>
    <div>
    </div>
    <div class="button--wrapper flex gap-4">
      <a href="http://localhost:3000/favorites">
      <UButton
    icon="solar:bag-heart-bold"
    size="sm"
    color="primary"
    square
    label="Избранное"
    title="Добавить в избранное"
    variant="solid"
    class=""
  />
</a>
  <a href="http://localhost:3000/cart">
      <UButton
    icon="solar:cart-3-bold"
    size="sm"
    color="primary"
    square
    label="Корзина"
    variant="solid"
    class=""
  />
</a>
  <MainNav/>
    </div>
  </div>
</template>
