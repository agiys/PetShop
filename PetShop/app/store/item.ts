import { defineStore } from "pinia";
import { useAPI } from "../composables/useAPI";

export const useItemStore = defineStore("item", () => {
  const category = ref([]);
  const response = ref([]);

  async function getItem(id: string, userName: string) {
    debugger;
    const data = await $fetch(`/api/catalog/getitem/${id}?user=${userName}`, {
      credentials: 'include',
      method: "GET",
    }).catch((ex) => {
      console.log(ex);
    });

    return data;
  }

  async function getCategory() {
    const data = await $fetch("/api/catalog/getcategory",{credentials: 'include'}).catch((ex) => {
      console.log(ex);
    });
    return data;
  }

  return { category, getItem, response, getCategory };
});
