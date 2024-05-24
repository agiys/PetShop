<template>
  <div class="login-wrapper flex justify-center mt-40 mb-40">
    <div class="form-wrapper flex-col w-1/4 max-w-96">
      <img src="~/assets/img/welcome.png">
      <p class="pb-4 font-extrabold font-sans text-xl">Авторизация</p>
      <UFormGroup
        v-slot="{ error }"
        :error="user.login.length < 5 && 'Введите логин'"
      >
        <UInput
          v-model="user.login"
          type="text"
          class=""
          placeholder="Логин"
          :trailing-icon="
            error ? 'i-heroicons-exclamation-triangle-20-solid' : undefined
          "
        />
      </UFormGroup>
      <UFormGroup
        v-slot="{ error }"
        :error="user.password.length < 3 && 'Введите пароль'"
        class="pt-4"
      >
        <UInput
          v-model="user.password"
          type="password"
          placeholder="Пароль"
          :trailing-icon="
            error ? 'i-heroicons-exclamation-triangle-20-solid' : undefined
          "
        />
      </UFormGroup>
      <div v-if="isError" class="text-red-500">
        Логин/пароль введен не верно
      </div>
      <div class="button-wrapper flex w-full justify-center gap-4 pt-4">
        <UButton
          label="Войти"
          @click="signIn"
          class=""
          color="primary"
          :disabled="!isValid"
        />
        <UButton
          label="Назад"
          @click="router.push('/')"
          class=""
          color="primary"
        />
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">
import { useAuthStore } from "@/store/auth";

const router = useRouter();
const user = reactive({
  login: "",
  password: "",
});

const isValid = computed(() => {
  return user.login.length >= 5 && user.password.length >= 3;
});

const authStore = useAuthStore();
const resp = ref();
const isError = ref(false);

const signIn = async () => {
  try {
    resp.value = await authStore.authorizate({
      login: user.login,
      password: user.password,
    });
    console.log(resp.value);
    if (resp.value) {
      router.push("/");
    } else {
      isError.value = true;
    }
  } catch (error) {
    console.error("Ошибка аунтефикации:", error);
    isError.value = true;
  }
};
</script>
