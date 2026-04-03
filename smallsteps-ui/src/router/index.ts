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
      path: '/system',
      component: () => import('@/layout/index.vue'),
      redirect: '/system/user',
      name: 'System',
      meta: {
        title: '系统管理',
        icon: 'system'
      },
      children: [
        {
          path: 'user',
          component: () => import('@/views/system/user/index.vue'),
          name: 'User',
          meta: {
            title: '用户管理',
            icon: 'user'
          }
        },
        {
          path: 'role',
          component: () => import('@/views/system/role/index.vue'),
          name: 'Role',
          meta: {
            title: '角色管理',
            icon: 'role'
          }
        },
        {
          path: 'menu',
          component: () => import('@/views/system/menu/index.vue'),
          name: 'Menu',
          meta: {
            title: '菜单管理',
            icon: 'menu'
          }
        },
        {
          path: 'dept',
          component: () => import('@/views/system/dept/index.vue'),
          name: 'Dept',
          meta: {
            title: '部门管理',
            icon: 'dept'
          }
        },
        {
          path: 'post',
          component: () => import('@/views/system/post/index.vue'),
          name: 'Post',
          meta: {
            title: '岗位管理',
            icon: 'post'
          }
        },
        {
          path: 'dict',
          component: () => import('@/views/system/dict/index.vue'),
          name: 'Dict',
          meta: {
            title: '字典管理',
            icon: 'dict'
          }
        },
        {
          path: 'config',
          component: () => import('@/views/system/config/index.vue'),
          name: 'Config',
          meta: {
            title: '配置管理',
            icon: 'config'
          }
        },
        {
          path: 'notice',
          component: () => import('@/views/system/notice/index.vue'),
          name: 'Notice',
          meta: {
            title: '通知公告',
            icon: 'notice'
          }
        },
        {
          path: 'client',
          component: () => import('@/views/system/client/index.vue'),
          name: 'Client',
          meta: {
            title: '客户端管理',
            icon: 'client'
          }
        },
        {
          path: 'tenant',
          component: () => import('@/views/system/tenant/index.vue'),
          name: 'Tenant',
          meta: {
            title: '租户管理',
            icon: 'tenant'
          }
        },
        {
          path: 'tenantPackage',
          component: () => import('@/views/system/tenantPackage/index.vue'),
          name: 'TenantPackage',
          meta: {
            title: '租户套餐',
            icon: 'tenantPackage'
          }
        },
        {
          path: 'oss',
          component: () => import('@/views/system/oss/index.vue'),
          name: 'Oss',
          meta: {
            title: '文件管理',
            icon: 'oss'
          }
        }
      ]
    },
    {
      path: '/monitor',
      component: () => import('@/layout/index.vue'),
      redirect: '/monitor/online',
      name: 'Monitor',
      meta: {
        title: '监控中心',
        icon: 'monitor'
      },
      children: [
        {
          path: 'online',
          component: () => import('@/views/monitor/online/index.vue'),
          name: 'Online',
          meta: {
            title: '在线用户',
            icon: 'online'
          }
        },
        {
          path: 'operlog',
          component: () => import('@/views/monitor/operlog/index.vue'),
          name: 'Operlog',
          meta: {
            title: '操作日志',
            icon: 'operlog'
          }
        },
        {
          path: 'logininfor',
          component: () => import('@/views/monitor/logininfor/index.vue'),
          name: 'Logininfor',
          meta: {
            title: '登录日志',
            icon: 'logininfor'
          }
        },
        {
          path: 'cache',
          component: () => import('@/views/monitor/cache/index.vue'),
          name: 'Cache',
          meta: {
            title: '缓存监控',
            icon: 'cache'
          }
        },
        {
          path: 'admin',
          component: () => import('@/views/monitor/admin/index.vue'),
          name: 'Admin',
          meta: {
            title: '服务监控',
            icon: 'server'
          }
        },
        {
          path: 'snailjob',
          component: () => import('@/views/monitor/snailjob/index.vue'),
          name: 'Snailjob',
          meta: {
            title: '定时任务',
            icon: 'job'
          }
        }
      ]
    },
    {
      path: '/workflow',
      component: () => import('@/layout/index.vue'),
      redirect: '/workflow/processDefinition',
      name: 'Workflow',
      meta: {
        title: '工作流',
        icon: 'workflow'
      },
      children: [
        {
          path: 'processDefinition',
          component: () => import('@/views/workflow/processDefinition/index.vue'),
          name: 'ProcessDefinition',
          meta: {
            title: '流程定义',
            icon: 'process-definition'
          }
        },
        {
          path: 'processInstance',
          component: () => import('@/views/workflow/processInstance/index.vue'),
          name: 'ProcessInstance',
          meta: {
            title: '流程实例',
            icon: 'process-instance'
          }
        },
        {
          path: 'task',
          component: () => import('@/views/workflow/task/taskWaiting.vue'),
          name: 'Task',
          meta: {
            title: '我的任务',
            icon: 'my-task'
          }
        },
        {
          path: 'category',
          component: () => import('@/views/workflow/category/index.vue'),
          name: 'Category',
          meta: {
            title: '流程分类',
            icon: 'category'
          }
        },
        {
          path: 'leave',
          component: () => import('@/views/workflow/leave/index.vue'),
          name: 'Leave',
          meta: {
            title: '请假流程',
            icon: 'leave'
          }
        },
        {
          path: 'spel',
          component: () => import('@/views/workflow/spel/index.vue'),
          name: 'Spel',
          meta: {
            title: '表达式测试',
            icon: 'spel'
          }
        }
      ]
    },
    {
      path: '/tool',
      component: () => import('@/layout/index.vue'),
      redirect: '/tool/gen',
      name: 'Tool',
      meta: {
        title: '工具',
        icon: 'tool'
      },
      children: [
        {
          path: 'gen',
          component: () => import('@/views/tool/gen/index.vue'),
          name: 'Gen',
          meta: {
            title: '代码生成',
            icon: 'code'
          }
        }
      ]
    },
    {
      path: '/demo',
      component: () => import('@/layout/index.vue'),
      redirect: '/demo/demo',
      name: 'Demo',
      meta: {
        title: '示例',
        icon: 'example'
      },
      children: [
        {
          path: 'demo',
          component: () => import('@/views/demo/demo/index.vue'),
          name: 'Demo',
          meta: {
            title: '基础示例',
            icon: 'demo'
          }
        },
        {
          path: 'tree',
          component: () => import('@/views/demo/tree/index.vue'),
          name: 'Tree',
          meta: {
            title: '树示例',
            icon: 'tree'
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
