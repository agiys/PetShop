<script setup>
import { useLoadingStore } from '~/store/loading'
const loadingStore = useLoadingStore()
onMounted(()=> {
  loadingStore.isLoading=false
})
</script>

<template>
    <div id="modals" />
    <Header /> 
    <div class="pt-24 h-screen w-full flex" v-if="loadingStore.isLoading">
      <img src="/assets/img/loading/Мигающие квадраты.gif" alt="loading..." class="flex w-1/12 m-auto content-center"/>
    </div>
    <div class="pt-24 h-screen w-full flex" v-else-if="loadingStore.isSaving">
      <img src="/assets/img/loading/11.gif" alt="loading..." class="flex w-1/12 m-auto content-center"/>
    </div>
    <div class="pt-24" v-else>
      <slot />
</div>
<MainFooter/>
</template>