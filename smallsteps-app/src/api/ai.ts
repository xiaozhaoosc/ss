import request from '@/utils/request'

// 任务拆解
export function taskBreakdown(data: {
    taskName: string
    taskDesc: string
    childAge: number
}) {
    return request({
        url: '/ai/taskBreakdown',
        method: 'POST',
        data: data
    })
}

// 情绪分析
export function emotionAnalysis(data: {
    childId: number
    content: string
}) {
    return request({
        url: '/ai/emotionAnalysis',
        method: 'POST',
        data: data
    })
}
