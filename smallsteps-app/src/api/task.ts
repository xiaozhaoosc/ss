import request from '@/utils/request'

export interface ParentTask {
    taskId?: number
    userId?: number
    title: string
    description?: string
    icon?: string
    difficulty?: number
    rewardPoints?: number
    status?: string // '0' normal, '1' stopped
    createTime?: string
    updateTime?: string
}

export interface TaskQuery {
    pageNum?: number
    pageSize?: number
    title?: string
    status?: string
}

// List
export function listTask(query: TaskQuery) {
    return request({
        url: '/parent/task/list',
        method: 'GET',
        data: query
    })
}

// Get
export function getTask(taskId: number) {
    return request({
        url: '/parent/task/' + taskId,
        method: 'GET'
    })
}

// Add
export function addTask(data: ParentTask) {
    return request({
        url: '/parent/task',
        method: 'POST',
        data: data
    })
}

// Update
export function updateTask(data: ParentTask) {
    return request({
        url: '/parent/task',
        method: 'PUT',
        data: data
    })
}

// Delete
export function delTask(taskIds: number | number[]) {
    return request({
        url: '/parent/task/' + taskIds,
        method: 'DELETE'
    })
}
