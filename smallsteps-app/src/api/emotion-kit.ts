import request from '@/utils/request'

export interface EmotionKit {
    kitId?: number
    childId?: number
    emotionType?: string // 1: happy, 2: sad, 3: angry, 4: anxious, 5: neutral
    content?: string
    mediaUrl?: string
    status?: string
}

export function listEmotionKits(childId: number) {
    return request({
        url: `/parent/emotion-kit/child/${childId}`,
        method: 'GET'
    })
}

export function addEmotionKit(data: EmotionKit) {
    return request({
        url: '/parent/emotion-kit',
        method: 'POST',
        data: data
    })
}

export function updateEmotionKit(data: EmotionKit) {
    return request({
        url: '/parent/emotion-kit',
        method: 'PUT',
        data: data
    })
}

export function deleteEmotionKit(kitId: number) {
    return request({
        url: `/parent/emotion-kit/${kitId}`,
        method: 'DELETE'
    })
}
