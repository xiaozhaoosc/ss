import { defineStore } from 'pinia'

export const useTaskStore = defineStore('task', {
    state: () => ({
        tasks: [],
        currentTask: null,
        focusMode: false
    }),

    getters: {
        todayTasks: (state) => {
            const today = new Date().toDateString()
            return state.tasks.filter(task =>
                new Date(task.date).toDateString() === today
            )
        },

        completedTasks: (state) => {
            return state.tasks.filter(task => task.completed)
        }
    },

    actions: {
        addTask(task) {
            this.tasks.push({
                id: Date.now(),
                ...task,
                completed: false,
                createdAt: new Date()
            })
        },

        updateTask(id, updates) {
            const index = this.tasks.findIndex(t => t.id === id)
            if (index !== -1) {
                this.tasks[index] = { ...this.tasks[index], ...updates }
            }
        },

        deleteTask(id) {
            this.tasks = this.tasks.filter(t => t.id !== id)
        },

        setCurrentTask(task) {
            this.currentTask = task
        },

        toggleFocusMode() {
            this.focusMode = !this.focusMode
        }
    }
})
