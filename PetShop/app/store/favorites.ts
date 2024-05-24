import { defineStore } from "pinia";
import { useAPI } from "../composables/useAPI";

export const useFavoritesStore = defineStore("favorites", () => {
  const favoritesItems = ref([]);
  const token = ref(useCookie("auth_token"));

  async function getFavorites(user: any) {
    const data = await useAPI("/api/favorites/getfavorites", {
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
    const data = await useAPI("/api/favorites/additem", {
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
    debugger;
    const data = await useAPI("/api/favorites/deleteitem", {
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
