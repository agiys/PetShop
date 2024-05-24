<script setup lang="ts">
import {useAuthStore} from '@/store/auth'

const authStore = useAuthStore()
const route = useRoute()
const router = useRouter()
const token = useCookie('auth_token')

const logOut = (() => {
  document.cookie = 'auth_token=;path=/;expires=Thu, 01 Jan 1970 00:00:00 UTC'
    router.push('/login')
    window.location.reload();
})
const logIn =(() => {
  router.push('/login')
})

debugger
</script>

<template>
  <div class="flex gap-4">
    <UButton
      :label="authStore.userName"
      icon="material-symbols:account-circle"
      size="sm"
      square
      v-if="authStore.userName"
      title="Пользователь"
      class="transition ease-in-out delay-150 bg-orange-500 hover:-translate-y-2 hover:scale-150 hover:bg-orange-600 duration-600"
      variant="solid">
    </UButton>
    <UButton
      label="Войти"
      icon="ic:baseline-log-in"
      size="sm"
      @click="logIn()"
      square
      v-if="(!token && route.path !== '/login')"
      title="Войти"
      class="transition ease-in-out delay-150 bg-orange-500 hover:-translate-y-2 hover:scale-150 hover:bg-orange-600 duration-600"
      variant="solid">
    </UButton>
    <UButton
    label="Выйти"
    icon="ic:baseline-logout"
      size="sm"
      v-else-if="(token && route.path !== '/login')"
      square
      @click="logOut()"
      title="Выйти"
      class="transition ease-in-out delay-150 bg-orange-500 hover:-translate-y-2 hover:scale-150 hover:bg-orange-600 duration-600"
      variant="solid"
    />
  </div>
</template>