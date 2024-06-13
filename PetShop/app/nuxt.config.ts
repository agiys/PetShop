// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
    devtools: { enabled: false },
    modules: [
        '@nuxt/ui',
        '@pinia/nuxt'
    ],
    routeRules: {
        '/api/**': {
            proxy: { to: 'http://localhost:5000/api/**' },
        },
        "^/api/**": {
            proxy: { to: 'http://localhost:5000/api/**' },
        },
    },
    css: ['~/assets/css/main.css'],
    postcss: {
        plugins: {
            tailwindcss: {},
            autoprefixer: {},
        },
    },
    runtimeConfig: {
        public: {
            apiURL: `http://${process.env.NUXT_HOST}:${process.env.API_PORT}` || 'http://localhost:5000',
        },
        appwriteApiKey: '',
    }
})
