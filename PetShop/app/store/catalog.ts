import { defineStore } from "pinia";
import { useAPI } from "../composables/useAPI";

export const useCatalogStore = defineStore("catalog", () => {
  const category = ref([]);
  const response = ref([]);

  async function getCatalog(id: string) {
    debugger;
    const data = await useAPI(`/api/catalog/getcatalog/${id}`).catch((ex) => {
      console.log(ex);
    });
    return data;
  }

  async function getAuthCatalog(id, userName) {
    debugger;
    const data = await useAPI(
      `/api/catalog/getauthcatalog/${id}?user=${userName}`
    ).catch((ex) => {
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

  return { category, getCatalog, response, getCategory, getAuthCatalog };
});
