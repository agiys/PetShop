import { defineStore } from "pinia";
import { useAPI } from "../composables/useAPI";

export const useItemStore = defineStore("item", () => {
  const category = ref([]);
  const response = ref([]);

  async function getItem(id: string, userName: string) {
    debugger;
    const data = await useAPI(`/api/catalog/getitem/${id}?user=${userName}`, {
      method: "GET",
    }).catch((ex) => {
      console.log(ex);
    });

    return data;
  }

  async function getCategory() {
    debugger;
    const data = await useAPI("/api/catalog/getcategory").catch((ex) => {
      console.log(ex);
    });
    return data;
  }

  return { category, getItem, response, getCategory };
});
