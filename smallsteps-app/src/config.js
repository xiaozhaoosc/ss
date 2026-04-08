// 应用全局配置
export default {
  // baseUrl: 'https://vue.smallsteps.vip/prod-api',
  baseUrl: import.meta.env.VITE_APP_BASE_API || '/ssapi',
  // 应用信息
  appInfo: {
    // 应用名称
    name: "smallsteps-app",
    // 应用版本
    version: "1.2.0",
    // 应用logo
    logo: "/static/logo.png",
    // 官方网站
    site_url: "http://www.smallsteps.com",
    // 政策协议
    agreements: [{
      title: "隐私政策",
      url: "https://smallsteps.vip/protocol.html"
    },
    {
      title: "用户服务协议",
      url: "https://smallsteps.vip/protocol.html"
    }
    ]
  }
}
