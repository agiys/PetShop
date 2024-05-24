import { defineStore } from "pinia";

export const useLoadingStore = defineStore("useLoadingStore", () => {
  const isSaving = ref(false);
  const isLoading = ref(true);

  return { isLoading, isSaving };
});
