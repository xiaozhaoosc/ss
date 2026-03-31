import { createPinia } from 'pinia'

const pinia = createPinia()

export default pinia
export * from './modules/config'
export * from './modules/user'
export * from './modules/dict'
export * from './modules/task'
