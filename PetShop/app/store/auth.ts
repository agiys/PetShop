import { defineStore } from "pinia";
import { useAPI } from "../composables/useAPI";

export const useAuthStore = defineStore("auth", () => {
  const isAuth = ref(false);

  const userName = ref();

  async function authorizate(payload) {
    try {
      const data = await useAPI("/api/auth/login", {
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
        return data;
      } else {
        throw new Error("Невалидный запрос");
      }
    } catch (error) {
      console.error("Ошибка аутентификации:", error);
      throw error;
    }
  }

  return { authorizate, isAuth, userName };
});
