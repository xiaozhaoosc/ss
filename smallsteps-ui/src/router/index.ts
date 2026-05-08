import { createRouter, createWebHashHistory } from 'vue-router';
import { useUserStore } from '@/store/modules/user';
import { ElMessage } from 'element-plus';
import NProgress from 'nprogress';
import 'nprogress/nprogress.css';
NProgress.configure({ showSpinner: false });

export const constantRoutes = [
  {
    path: '/login',
    component: () => import('@/views/login.vue'),
    hidden: true
  },
  {
    path: '/register',
    component: () => import('@/views/register.vue'),
    hidden: true
  },
  {
    path: '/401',
    component: () => import('@/views/error/401.vue'),
    hidden: true
  },
  {
    path: '/404',
    component: () => import('@/views/error/404.vue'),
    hidden: true
  },
  {
    path: '/',
    component: () => import('@/layout/index.vue'),
    redirect: '/dashboard',
    children: [
      {
        path: 'dashboard',
        component: () => import('@/views/index.vue'),
        name: 'Dashboard',
        meta: { title: '首页', icon: 'dashboard', affix: true }
      }
      // ,{
      //   path: 'ai/log',
      //   component: () => import('@/views/ai/log/index.vue'),
      //   name: 'AiLog',
      //   meta: { title: 'AI日志', icon: 'log' }
      // },
      // {
      //   path: 'ai/model',
      //   component: () => import('@/views/ai/model/index.vue'),
      //   name: 'AiModel',
      //   meta: { title: 'AI模型', icon: 'model' }
      // },
      // {
      //   path: 'ai/prompt',
      //   component: () => import('@/views/ai/prompt/index.vue'),
      //   name: 'AiPrompt',
      //   meta: { title: 'AI提示词', icon: 'edit' }
      // },
      // {
      //   path: 'ai/route',
      //   component: () => import('@/views/ai/route/index.vue'),
      //   name: 'AiRoute',
      //   meta: { title: 'AI路由', icon: 'guide' }
      // },
      // {
      //   path: 'ai/provider',
      //   component: () => import('@/views/ai/provider/index.vue'),
      //   name: 'AiProvider',
      //   meta: { title: 'AI供应商', icon: 'international' }
      // }
    ]
  },
  {
    path: '/redirect',
    component: () => import('@/layout/index.vue'),
    hidden: true,
    children: [
      {
        path: '/redirect/:path(.*)',
        component: () => import('@/views/redirect/index.vue')
      }
    ]
  },
  {
    path: '/:pathMatch(.*)*',
    component: () => import('@/views/error/404.vue'),
    hidden: true
  }
];

export const dynamicRoutes = [];

const router = createRouter({
  history: createWebHashHistory(import.meta.env.VITE_APP_CONTEXT_PATH),
  routes: constantRoutes
});

export default router;
