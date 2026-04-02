import request from '@/utils/request';
import { AxiosPromise } from 'axios';

// 任务拆解
export function taskBreakdown(data: {
    taskName: string
    taskDesc: string
    childAge: number
}): AxiosPromise<any> {
    return request({
        url: '/ai/taskBreakdown',
        method: 'POST',
        data: data
    });
}

// 情绪分析
export function emotionAnalysis(data: {
    childId: number
    content: string
}): AxiosPromise<any> {
    return request({
        url: '/ai/emotionAnalysis',
        method: 'POST',
        data: data
    });
}
