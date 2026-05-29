# 架构决策记录 (ADR-023): H5 底部自定义导航图标高保真重构与防碎治理

*   **状态**: 获批并实施已部署 (Approved & Implemented)
*   **日期**: 2026-05-29
*   **关联实体**: [[_index_wiki]], [[CHRONICLE]], [[ADR-022-Database-Achievement-Id-Constraint-Fix.md]]

---

## 1. 决策背景 (Context)

在“Small Steps”移动端 App 生态的 H5 部署中，为了杜绝原生 TabBar 与高定制化页面（例如儿童端的游戏化奖杯房、家长端的毛玻璃卡片）发生排版冲突，`App.vue` 在初始化时显式地调用了 `uni.hideTabBar()` 进行强制原生隐藏，并在所有核心业务页面中统一以自定义底栏组件 `<bottom-nav>` 来呈现底部导航栏。
但在前期的粗糙配置下，自定义底栏组件 `bottom-nav.vue` 中家长端各 Tab 的图标直接采用了纯文本 Emoji 字符（如 `🏠`, `📝`, `📊`, `👤`）进行暴力渲染：
```javascript
{ path: '/pages/parent/dashboard/index', icon: '🏠', label: '首页' }
```

### 痛点与 Bug 爆发
1. **多平台渲染分裂与空白乱码**：在部分中低端安卓系统、精简版 H5 浏览器或特定的微信 Webview 中，由于本地字库的缺失或版本过旧，直接渲染 Emoji 会导致**图标显示为一个破碎的空白框（如 `□`）或彻底不显示**。
2. **极大的视觉降级**：Emoji 字符的色彩、线条跟“Small Steps”精心打磨的多感官光影美学、毛玻璃微交互以及专业 ADHD 界面风格发生了强烈的视觉对立，严重破坏了产品的艺术高度与高端尊贵感。
3. **已备资源闲置**：项目在 `/static/images/tabbar/` 目录下原本就保存着由顶级设计师专门打造并切图的高清 Tabbar PNG 图标资源（例如 `home.png` / `home_.png` 等选中与未选中的精细高精度设计图），由于该组件的设计未打通而遭致闲置。

---

## 2. 方案对比与决策 (Alternatives & Decision)

### 方案 A：引入在线 WebFont (如 Material Icons) 或在线 CDN 图标
*   *缺点*：需要依赖稳定的互联网连接。在弱网打卡、设备局域网离线预览时，会因为网络字体文件未下载完成，导致图标长时间显示为 “history”、 “storefront” 等冰冷的英文单词占位符，带来断层般的差评体验。

### 方案 B：重构自定义底栏为“动静双模高清本地图像导航” (选定方案)
*   *方案*：
    1. 修改 `<bottom-nav>` 模版，当配置的 `icon` 路径以 `/static` 或 `/` 开头时，自动采用 `<image>` 标签以 `aspectFit` 渲染。
    2. 其他情况自动 Fallback 回退为普通 `<text>` 渲染，以保障高内聚与对其他历史分支的完全兼容性。
    3. 全面激活 `/static/images/tabbar/` 下的 8 个高清 PNG 本地切图文件，并在 `computed` 计算属性 `navItems` 中，分别绑定 `icon`（默认灰色图标）与 `activeIcon`（高亮选中图标）。
    4. 采用响应式绑定 `:src="currentPath === item.path ? item.activeIcon : item.icon"` 实现极速无延迟的选中态视觉切换，并加上平滑的 CSS 缩放微交互动画。
*   *优点*：100% 离线可用，图标显示精确到像素级，彻底打通了全链路的视觉精美度与跨端一致性。

---

## 3. 具体实施细节 (Implementation Details)

我们在 [bottom-nav.vue](file:///home/ken4zhao/Documents/office/jushuang1/github/ss/smallsteps-app/src/components/common/bottom-nav/bottom-nav.vue) 中完成了该 UI Bug 的高保真治理：

### 3.1 模板支持双模适配
```html
      <view class="icon-wrapper">
        <template v-if="item.icon.startsWith('/') || item.icon.startsWith('static/')">
          <image 
            class="icon-img" 
            :src="currentPath === item.path ? item.activeIcon : item.icon" 
            mode="aspectFit"
          ></image>
        </template>
        <template v-else>
          <text class="icon">{{ item.icon }}</text>
        </template>
        <view v-if="item.badge" class="badge">{{ item.badge }}</view>
      </view>
```

### 3.2 导航配置重塑
将 Emoji 废弃并绑定至高保真切图路径：
```javascript
const navItems = computed(() => {
  if (props.mode === 'parent') {
    return [
      { 
        path: '/pages/parent/dashboard/index', 
        icon: '/static/images/tabbar/home.png', 
        activeIcon: '/static/images/tabbar/home_.png',
        label: '首页' 
      },
      { 
        path: '/pages/parent/task-creator/index', 
        icon: '/static/images/tabbar/work.png', 
        activeIcon: '/static/images/tabbar/work_.png',
        label: '任务' 
      },
      { 
        path: '/pages/parent/insights/index', 
        icon: '/static/images/tabbar/setting.png', 
        activeIcon: '/static/images/tabbar/setting_.png',
        label: '洞察' 
      },
      { 
        path: '/pages/parent/profile/index', 
        icon: '/static/images/tabbar/mine.png', 
        activeIcon: '/static/images/tabbar/mine_.png',
        label: '我的', 
        badge: null 
      }
    ]
  } else {
      // ...
```

### 3.3 CSS 微动画补强
```css
.icon-img {
  width: 24px;
  height: 24px;
  display: block;
  transition: transform 0.3s ease;
}
```

---

## 4. 架构与产品影响 (Consequences)

1.  **像素级完美呈现**：底栏图标彻底告别了低端的系统自带 Emoji，代之以与 App 主色调（毛玻璃、治愈系蓝绿）高度协调、精致细腻的高清切图，达成了极致高端的艺术质感。
2.  **100% 渲染鲁棒性**：图标图片完全随 H5 静态工程本地打包部署，不依赖网络字体下载，在任何浏览器与移动终端上均能确保 100% 毫无偏差、绝不破碎地正确显示。
3.  **零响应延迟**：选中高亮直接通过前端双图片源切换与本地静态缓存解析，没有任何网络交互开销，过渡极其丝滑。
