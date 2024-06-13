import { defineStore } from "pinia";
import { useAPI } from "../composables/useAPI";

export const useCatalogStore = defineStore("catalog", () => {
  const category = ref([]);
  const response = ref([]);

  async function getCatalog(id: string) {
    debugger;
    const data = await $fetch(`/api/catalog/getcatalog/${id}`,{credentials: 'include'}).catch((ex) => {
      console.log(ex);
    });
    return data;
  }

  async function getAuthCatalog(id, userName) {
    debugger;
    const data = await $fetch(
      `/api/catalog/getauthcatalog/${id}?user=${userName}`
    ,{credentials: 'include'}).catch((ex) => {
      console.log(ex);
    });
    return data;
  }

  async function getCategory() {
    debugger;
    const data = await $fetch("/api/catalog/getcategory",{credentials: 'include'}).catch((ex) => {
      console.log(ex);
    });
    return data;
  }

  return { category, getCatalog, response, getCategory, getAuthCatalog };
});
