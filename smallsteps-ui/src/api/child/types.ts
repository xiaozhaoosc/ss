// 儿童任务执行类型
export interface ChildTask {
  taskId?: number
  userId?: number
  title?: string
  description?: string
  status?: string
  rewardPoints?: number
  voiceFeedback?: string
  lightEffect?: string
}

// 儿童成就系统类型
export interface ChildAchievement {
  achievementId?: number
  userId?: number
  achievementName?: string
  description?: string
  shardCount?: number
  starCount?: number
  status?: string
  obtainTime?: string
  rewardInfo?: string
}

// 儿童 AI 伴侣类型
export interface ChildAI {
  responseText?: string
  voiceResponse?: string
  emotionResult?: string
  suggestion?: string
  sceneType?: string
  timestamp?: string
}
