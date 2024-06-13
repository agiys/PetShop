import { defineStore } from "pinia";
import { useAPI } from "../composables/useAPI";

export const useCartStore = defineStore("cart", () => {
  const cartItems = ref([]);
  const token = ref(useCookie("auth_token"));

  async function getCart(payload: any) {
    const data = await $fetch("/api/cart/getcart", {
      credentials: 'include',
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ User: payload.user }),
    }).catch((ex) => {
      console.log(ex);
    });
    return data;
  }

  async function deliteCartItem(cartItemId: any) {
    debugger;
    const data = await $fetch("/api/cart/deletecartitem", {
      credentials: 'include',
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token.value}`,
      },
      body: JSON.stringify(cartItemId),
    }).catch((ex) => {
      console.log(ex);
    });
    return data;
  }
  async function addCartItem(catalogId: any, userName: any) {
    debugger;
    const data = await $fetch("/api/cart/addcartitem", {
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

  return { getCart, cartItems, deliteCartItem, addCartItem };
});
