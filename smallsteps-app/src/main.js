import { createSSRApp } from 'vue'
import App from './App'
import pinia from './store'

// 解决 H5 环境下 showLoading 和 hideLoading 不配对导致的控制台警告
if (typeof uni !== 'undefined') {
  let isDisplayingLoading = false
  const originalShow = uni.showLoading
  const originalHide = uni.hideLoading

  uni.showLoading = function (options) {
    isDisplayingLoading = true
    if (originalShow) {
      return originalShow.call(uni, options)
    }
  }

  uni.hideLoading = function () {
    if (isDisplayingLoading) {
      isDisplayingLoading = false
      if (originalHide) {
        return originalHide.call(uni)
      }
    }
  }
}


// #ifndef VUE3
import Vue from 'vue'
import './uni.promisify.adaptor'
Vue.config.productionTip = false
App.mpType = 'app'
const app = new Vue({
  ...App
})
app.$mount()
// #endif

import { install } from './plugins'

// #ifdef VUE3
export function createApp() {
  const app = createSSRApp(App)
  app.use(pinia)
  app.use(install)
  return {
    app
  }
}
// #endif
