// 家长成长观察类型
export interface ParentGrowth {
  recordId?: number;
  userId?: number;
  date?: string;
  emotionState?: string;
  emotionScore?: number;
  abilityDataList?: Array<{
    abilityType?: string;
    abilityScore?: number;
  }>;
  observation?: string;
  growthTrackDataList?: Array<{
    date?: string;
    emotionScore?: number;
    taskCompletionRate?: number;
    pointsEarned?: number;
  }>;
}

// 家长辅助工具类型
export interface ParentTool {
  toolId?: number;
  toolType?: string;
  toolName?: string;
  toolConfig?: string;
  firstAidConfig?: string;
  guideType?: string;
  guideTitle?: string;
  guideContent?: string;
  templateId?: number;
  templateName?: string;
  templateContent?: string;
}
