/**
 * PRD Validation Test Data
 * Based on 需求文档 Section 2.2.1 - Target user groups
 */

export const PROD_ACCOUNTS = {
  parent1: {
    username: 'parent_zhang',
    password: 'admin123',
  },
  parent2: {
    username: 'parent_li',
    password: 'admin123',
  },
  child1: {
    username: 'child_xiaoming',
    password: 'admin123',
  },
  child2: {
    username: 'child_xiaohong',
    password: 'admin123',
  },
  admin: {
    username: 'admin',
    password: 'admin123',
  },
};

export const PRD_TASK = {
  title: '[PRD测试] 整理书包',
  description: '按照PRD要求的结构化任务创建流程测试',
  rewardPoints: 10,
};

export const PRD_ROUTES = {
  app: {
    login: '/#/pages/login/index',
    childHome: '/#/pages/child/home/index',
    parentDashboard: '/#/pages/parent/dashboard/index',
    taskCreator: '/#/pages/parent/task-creator/index',
    rewardConfig: '/#/pages/parent/reward-config/index',
  },
  admin: {
    login: '/webadminss/login',
    dashboard: '/webadminss/index',
    userManagement: '/webadminss/system/user',
  },
  api: {
    base: 'http://10.8.0.1:8081/ssapi',
    login: '/ssapi/login',
    parentTask: '/ssapi/parent/task',
    childTask: '/ssapi/child/task',
    childScore: '/ssapi/child/score',
  },
};
