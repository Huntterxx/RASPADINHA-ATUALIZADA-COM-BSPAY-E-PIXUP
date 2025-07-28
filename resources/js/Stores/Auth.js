import { defineStore } from "pinia";
import { ref } from "vue";
import axios from 'axios';
import router from '../Router';
import Echo from "laravel-echo";

export const useAuthStore = defineStore("auth", () => {
    const token = ref(localStorage.getItem('token'));
    const user = ref(JSON.parse(localStorage.getItem('user')));
    const isAuth = ref(false);
    const userId = ref(null);
    const setting = ref(null); // Adicionando a propriedade setting

    /**
     * Define o Token no localstorage
     * @param tokenValue
     */
    function setToken(tokenValue) {
        localStorage.setItem('token', tokenValue);
        token.value = tokenValue;
    }

    /**
     * Get Token
     * @returns {UnwrapRef<string> | undefined}
     */
    function getToken() {
        return token?.value;
    }

    /**
     * Set User
     * @param userValue
     */
    function setUser(userValue) {
        if(userValue != null) {
            localStorage.setItem('user', JSON.stringify(userValue));
            user.value = userValue;
        }
    }

    /**
     * Set IsAuth
     * @param auth
     */
    function setIsAuth(auth) {
        isAuth.value = auth;
    }

    /**
     * Set UserId
     * @param id
     */
    function setUserId(id) {
        userId.value = id;
    }

    /**
     * Get UserId
     * @returns {UnwrapRef<string> | null}
     */
    function getUserId() {
        return userId.value;
    }

    /**
     * Check Token
     * @returns {Promise<undefined>}
     */
    async function checkToken() {
        try {
            const tokenAuth = 'Bearer ' + token.value;
            const { data } = await axios.get('/api/auth/verify', {
                headers: {
                    Authorization: tokenAuth
                }
            });

            return data;
        } catch (error) {
            if(error.response.status === 401) {
                logout();
                router.push('/');
            }else{
                console.log(error.response);
            }
        }
    }

    /**
     * Logout
     */
    function logout() {
        localStorage.removeItem('token');
        localStorage.removeItem('user');
        token.value = '';
        user.value = '';
        userId.value = null;
        isAuth.value = false;
    }

    /**
     * Initializing Echo
     */
    function initializingEcho() {
        window.EchoPrivate = new Echo({
            broadcaster: 'pusher',
            key: import.meta.env.VITE_PUSHER_APP_KEY,
            cluster: import.meta.env.VITE_PUSHER_APP_CLUSTER ?? 'mt1',
            wsHost: import.meta.env.VITE_PUSHER_HOST ? import.meta.env.VITE_PUSHER_HOST : `ws-${import.meta.env.VITE_PUSHER_APP_CLUSTER}.pusher.com`,
            wsPort: import.meta.env.VITE_PUSHER_PORT ?? 80,
            forceTLS: false,
            enabledTransports: ['ws', 'wss'],
            disabledTransports: ['sockjs', 'xhr_polling', 'xhr_streaming'],
            authEndpoint: `/api/broadcasting/auth`,
            auth: {
                headers: {
                    'X-CSRF-TOKEN': document.head.querySelector('meta[name="csrf-token"]'),
                    Authorization: `Bearer ${token.value}`
                }
            }
        });
    }

    return {
        token,
        user,
        setToken,
        setUser,
        getToken,
        checkToken,
        logout,
        setIsAuth,
        isAuth,
        initializingEcho,
        setUserId,
        getUserId,
        setting // Adicionando setting à store
    };
});
