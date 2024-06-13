import { defineStore } from "pinia";
import { useAPI } from "../composables/useAPI";

export const useFavoritesStore = defineStore("favorites", () => {
  const favoritesItems = ref([]);
  const token = ref(useCookie("auth_token"));

  async function getFavorites(user: any) {
    const data = await $fetch("/api/favorites/getfavorites", {
      credentials: 'include',
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ User: user }),
    }).catch((ex) => {
      console.log(ex);
    });
    return data;
  }

  async function addFavoritesItem(catalogId: any, userName: any) {
    debugger;
    const data = await $fetch("/api/favorites/additem", {
      credentials: 'include',
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token.value}`,
      },
      body: JSON.stringify({ CatalogId: catalogId, UserName: userName }),
    }).catch((ex) => {
      console.log(ex);
    });
    return data;
  }

  async function deliteFavoritesItem(favoriteItemId: any) {
    const data = await $fetch("/api/favorites/deleteitem", {
      credentials: 'include',
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token.value}`,
      },
      body: JSON.stringify(favoriteItemId),
    }).catch((ex) => {
      console.log(ex);
    });
    return data;
  }

  return {
    getFavorites,
    favoritesItems,
    addFavoritesItem,
    deliteFavoritesItem,
  };
});
