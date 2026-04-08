import { createRouter, createWebHistory } from 'vue-router'
import { useUserStore } from '@/store/modules/user'
import { ElMessage } from 'element-plus'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
NProgress.configure({ showSpinner: false })

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
          meta: {
            title: '首页',
            icon: 'dashboard',
            affix: true
          }
        }
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
    { path: '/:pathMatch(.*)*', redirect: '/404', hidden: true }
  ]

export const dynamicRoutes = []

const router = createRouter({
  history: createWebHistory(import.meta.env.VITE_APP_CONTEXT_PATH),
  routes: constantRoutes
})

router.beforeEach((to, from, next) => {
  NProgress.start()
  if (to.path === '/login') {
    next()
  } else {
    const userStore = useUserStore()
    if (userStore.token) {
      next()
    } else {
      ElMessage.error('请先登录')
      next('/login')
    }
  }
})

router.afterEach(() => {
  NProgress.done()
})

export default router
