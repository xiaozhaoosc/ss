/**
* 显示消息提示框
* @param content 提示的标题
*/
export function toast(content) {
  uni.showToast({
    icon: 'none',
    title: content
  })
}

/**
* 显示模态弹窗
* @param content 提示的标题
*/
export function showConfirm(content) {
  return new Promise((resolve, reject) => {
    uni.showModal({
      title: '提示',
      content: content,
      cancelText: '取消',
      confirmText: '确定',
      success: function(res) {
        resolve(res)
      }
    })
  })
}

/**
* 参数处理
* @param params 参数
*/
export function tansParams(params) {
  let result = ''
  for (const propName of Object.keys(params)) {
    const value = params[propName]
    var part = encodeURIComponent(propName) + "="
    if (value !== null && value !== "" && typeof (value) !== "undefined") {
      if (typeof value === 'object') {
        for (const key of Object.keys(value)) {
          if (value[key] !== null && value[key] !== "" && typeof (value[key]) !== 'undefined') {
            let params = propName + '[' + key + ']'
            var subPart = encodeURIComponent(params) + "="
            result += subPart + encodeURIComponent(value[key]) + "&"
          }
        }
      } else {
        result += part + encodeURIComponent(value) + "&"
      }
    }
  }
  return result
}

/**
* 获取完整的头像 URL，包含 API 前缀拼接、跨域 blob 过滤及默认机器人头像兜底
* @param {string} avatar 头像路径
*/
export function getAvatarUrl(avatar) {
  if (!avatar) {
    return '/static/images/avatar/robot_default.png'
  }
  
  // 过滤非当前源的 blob，防止加载跨域本地资源报错
  if (avatar.startsWith('blob:')) {
    if (typeof window !== 'undefined' && !avatar.startsWith(`blob:${window.location.origin}`)) {
      return '/static/images/avatar/robot_default.png'
    }
    return avatar
  }

  if (avatar.startsWith('http://') || avatar.startsWith('https://')) {
    return avatar
  }
  
  // 拼接 API 基础路径
  const base = import.meta.env.VITE_APP_BASE_API || '/ssapi'
  let url = base + avatar
  
  // 替换连续的斜杠，保留 http:// 或 https:// 协议头中的双斜杠
  if (url.includes('://')) {
    const protocolIndex = url.indexOf('://') + 3
    url = url.substring(0, protocolIndex) + url.substring(protocolIndex).replace(/\/+/g, '/')
  } else {
    url = url.replace(/\/+/g, '/')
  }
  return url
}