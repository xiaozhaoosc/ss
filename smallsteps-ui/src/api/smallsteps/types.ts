// 儿童管理
export interface Child {
  childId: number
  parentId: number
  childName: string
  gender: string
  age: number
  birthday: string
  avatar: string
  nickname: string
  createdAt: string
  updatedAt: string
}

// 任务管理
export interface Task {
  taskId: number
  childId: number
  taskName: string
  description: string
  difficulty: number
  starReward: number
  status: string
  createdAt: string
  updatedAt: string
}

// 奖励管理
export interface Reward {
  rewardId: number
  childId: number
  rewardName: string
  starCost: number
  stock: number
  status: string
  createdAt: string
  updatedAt: string
}

// 情绪记录
export interface Emotion {
  emotionId: number
  childId: number
  emotionType: string
  emotionLevel: number
  trigger: string
  createdAt: string
}

// 设备管理
export interface Device {
  deviceId: number
  childId: number
  deviceName: string
  deviceCode: string
  status: string
  createdAt: string
  updatedAt: string
}

// 知识库
export interface Knowledge {
  knowledgeId: number
  title: string
  content: string
  category: string
  createdAt: string
  updatedAt: string
}

// 亲子契约
export interface Contract {
  contractId: number
  childId: number
  parentId: number
  content: string
  status: string
  createdAt: string
  updatedAt: string
}