import {useAuthStore} from '@/store/auth'
export default defineNuxtRouteMiddleware((to) => {
    const token = ref(useCookie('auth_token'))
    const authStore = useAuthStore()
    const router = useRouter()
    if(token.value){
        const user = getUserInfo()
    }
    async function getUserInfo() {
        debugger
            const data = await useAPI('/api/auth/user',{
                headers: { Authorization: `Bearer ${token.value}` }
            })
            .catch(ex => { console.log(ex) })
            authStore.userName = data.username
            console.log(data.username)
        return data
    };

  });