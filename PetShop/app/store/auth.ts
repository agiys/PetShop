import { defineStore } from "pinia";
import { useAPI } from "../composables/useAPI";

export const useAuthStore = defineStore("auth", () => {
  const isAuth = ref(false);

  const userName = ref();

  async function authorizate(payload) {
    try {
      const data = await $fetch("/api/auth/login", {
        credentials: 'include',
        method: "POST",
        body: JSON.stringify(payload),
        headers: {
          "Content-Type": "application/json",
        },
      });
      if (data.username) {
        userName.value = data.username;
      }
      if (data && data.token) {
        const expires = new Date();
        expires.setDate(expires.getDate() + 7);
        document.cookie = `auth_token=${
          data.token
        }; expires=${expires.toUTCString()}; path=/`;

        console.log("Токен сохранен в куки:", data.token);
        return data.username;
      } else {
        throw new Error("Невалидный запрос");
      }
    } catch (error) {
      console.error("Ошибка аутентификации:", error);
      throw error;
    }
  }

  async function register(payload) {
    try {
      const data = await $fetch("/api/auth/register", {
        credentials: 'include',
        method: "POST",
        body: JSON.stringify(payload),
        headers: {
          "Content-Type": "application/json",
        },
      });
      if(data){
        return data;
      }
    } catch (error) {
      console.error("Ошибка регистрации:", error);
      throw error;
    }
  }

  return { authorizate, isAuth, userName,register };
});
