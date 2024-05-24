/*import { useFetch } from "#app"

type useFetchType = typeof useFetch

// wrap useFetch with configuration needed to talk to our API
export const useAPI: useFetchType = (path, options = {}) => {
    const config = useRuntimeConfig()

    // modify options as needed
    options.baseURL = config.public.apiURL
    options.server = false
    return useFetch(path, options)
}
/*/
export const useAPI = (url: string, options = {}) => {
    const config = useRuntimeConfig()
    return $fetch.create({ baseURL: config.public.apiURL })(url, options)
}
/**/