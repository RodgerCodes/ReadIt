import { createWebHistory, createRouter, RouteRecordRaw } from 'vue-router'
import HomeView from '../views/home.vue';

const routes:RouteRecordRaw[] = [
    {path:"/", component:HomeView,}
];


const router = createRouter({
    history:createWebHistory(),
    routes:routes,
})

export default router;