4 系统实现

本章是系统的核心工程实践部分。在前述需求分析与架构设计的基础上，深入三个工程模块的实现细节：smallsteps-api（后端层）、smallsteps-app（移动端层）以及smallsteps-ui（管理后台层）。结合关键代码片段与接口设计说明，展示系统从设计文档到可运行代码的具体过程。

4.1 系统登录

4.2 后端统筹与接口实现 (smallsteps-api)

后端工程基于Spring Boot 3的Maven多模块体系构建，分为API定义、Service业务逻辑与统一配置管理，承载整个系统的核心计算逻辑。

4.2.1 安全认证与路由拦截的实现

用户发起登录请求时，系统调用SysUserServiceImpl层的验证逻辑。笔者在这里选择了Sa-Token而非传统的JWT手动拼接，主要原因是：手写JWT需要自行处理Token的生成、解析、续期、踢下线等逻辑，繁琐且容易出错；Sa-Token将这些封装为框架级能力，调用一句StpUtil.login(user.getId())即可完成登录会话的建立。框架在背后自动向Redis写入当前用户的登录状态与过期时间戳，并在HTTP响应头中下发以satoken为键名的凭据标识。

为防止核心业务接口被未授权访问，后端实现了一个SaTokenConfigure配置类，注册了Sa-Token的全局拦截器SaInterceptor：

```java
@Configuration
public class SaTokenConfigure implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new SaInterceptor(handle -> StpUtil.checkLogin()))
            .addPathPatterns("/ssapi/**")
            .excludePathPatterns("/ssapi/public/login", "/ssapi/public/register");
    }
}
```

这段配置保证了除公开登录注册接口外，所有/ssapi/前缀的请求在到达Controller业务逻辑前，都必须经过Redis中Token的比对校验，完成第一层鉴权。

4.2.2 结构化任务与分发系统的业务逻辑实现

任务系统的核心操作涉及多表写入，数据一致性的要求较高。以"家长为儿童当天新建任务"为例：这个操作需要同时向任务模板表（ss_parent_task）插入源数据，并在任务日志表（ss_task_log）中预生成当日的待办占位记录。如果网络中断导致第一步成功但第二步失败，就会出现"任务存在但儿童端看不到"的数据不一致问题。因此，整个Service方法使用了Spring的@Transactional(rollbackFor = Exception.class)注解进行事务包裹，任何环节异常都会触发全局回滚。

针对家长端"查看儿童近一周任务"这类复合查询需求，使用MyBatis-Plus的QueryWrapper构建条件：

```java
QueryWrapper<TaskDailyLog> wrapper = new QueryWrapper<>();
wrapper.eq("child_id", currentChildId)
       .between("target_date", startDate, endDate)
       .orderByDesc("target_date");
return taskDailyLogMapper.selectList(wrapper);
```

这段代码屏蔽了SQL拼接的细节，也自然规避了SQL注入风险。

任务打卡完成后触发积分结算，同样需要在一个事务内同时完成余额更新和流水写入：

```java
@Service
public class ScoreServiceImpl implements IScoreService {
    @Autowired
    private ChildScoreMapper childScoreMapper;
    @Autowired
    private ScoreHistoryMapper scoreHistoryMapper;

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void addPoints(Long userId, int points, Long taskId, String reason) {
        // 1. 更新积分余额
        ChildScore score = childScoreMapper.selectOne(
            new QueryWrapper<ChildScore>().eq("user_id", userId));
        score.setBalance(score.getBalance() + points);
        score.setTotalEarned(score.getTotalEarned() + points);
        childScoreMapper.updateById(score);

        // 2. 写入积分流水
        ScoreHistory history = new ScoreHistory();
        history.setUserId(userId);
        history.setAmount(points);
        history.setType("1");  // 1-增加
        history.setSourceId(taskId);
        history.setReason(reason);
        scoreHistoryMapper.insert(history);

        // 3. 触发勋章检查
        achievementService.checkAndUnlockBadges(userId, score.getTotalEarned());
    }
}
```

@Transactional注解保证了余额更新与流水写入的原子性。配合Redis的SETNX分布式锁（详见5.2.3节压测数据），可以有效防止高并发或网络重试场景下的重复结算。

4.2.3 智能数据生成的后端处理

大语言模型的集成是本系统工程上最不确定的部分——外部API可能限流、超时、偶尔返回格式异常的内容，这些都需要在设计上提前考虑到。

笔者在实现AI寄语生成时采取了以下几项保障措施：

首先，整个调用链路放在独立的定时任务中异步执行，与用户实时请求完全解耦，避免LLM的响应延迟影响App的正常使用。

其次，在调用LLM前，系统从数据库获取对应儿童近十天的行为摘要，将儿童真实姓名替换为通用称谓（脱敏处理），然后与管理后台预配置的Prompt模板拼合，发送至AI接口。

最关键的是降级逻辑：

```java
@Slf4j
@RequiredArgsConstructor
@Service
public class AiServiceImpl implements IAiService {

    private final IAiRouterService aiRouterService;
    private final SmartAiClient smartAiClient;
    private final AiPromptMapper aiPromptMapper;
    private final ISysAiKnowledgeService sysAiKnowledgeService;

    @Override
    public List<Map<String, String>> taskBreakdown(String taskName, String taskDesc, int childAge) {
        try {
            AiModel aiModel = aiRouterService.route("TASK_BREAKDOWN", null);
            if (aiModel == null) {
                return getMockTaskBreakdown(taskName, taskDesc, childAge);
            }
            // ... 构建prompt，调用模型 ...
            String response = smartAiClient.askAi(prompt, aiModel, "TASK_BREAKDOWN", null);
            if (response == null || response.trim().isEmpty()) {
                return getMockTaskBreakdown(taskName, taskDesc, childAge);
            }
            return parseTaskBreakdownResponse(response);
        } catch (Exception e) {
            log.error("Error in task breakdown for task: {}", taskName, e);
            return getMockTaskBreakdown(taskName, taskDesc, childAge);
        }
    }
}
```

当AI接口调用失败时，系统从本地预设的通用安抚话术库中随机提取内容返回，保证家长端始终有内容展示，不会出现白屏或报错。这条降级路径在开发阶段测试时触发过几次，验证确实有效。


4.3 移动端应用框架与页面实现 (smallsteps-app)

移动端是ADHD儿童与家长直接交互的核心载体，基于UniApp 3.0与Vue 3构建[15]。

4.3.1 基础项目配置与Vue 3生态集成

项目的package.json中接入了适配UniApp的vite构建工具，保证热重载的实时性和构建效率。利用Vue 3的Composition API（<script setup>），将业务逻辑内聚组织，代码结构比Options API更清晰。例如在需要监听应用切回前台（onShow）重刷数据的首页文件中，只需声明式地写onShow(() => { fetchLatestTask() })即可，不需要在生命周期中手动管理各种状态。

4.3.2 状态管理在双模式切换中的应用

双模式（家长模式/儿童模式）是应用的核心特性。用户身份标志统一托管于Pinia全局Store中，而不是在各组件间层层传递Props。后端验证成功后，Token与用户类型写入authStore，底部TabBar组件或路由鉴权层只需判断authStore.currentUserType，即可在瞬间完成底栏切换——由家长模式的"数据看板、任务分发"变为儿童模式的"我的奖章、开始专注"。

这个切换动作在实测中约需50到80毫秒，用户几乎感知不到延迟，整体体验接近原生。

App登录界面如图4.1所示：

图4.1 app登录

4.3.3 TailwindCSS支持下的响应式页面构建

基于ADHD儿童界面需要减少文字、多用包容性色块的设计原则，项目深度集成了TailwindCSS。开发者不再需要在各个.vue文件中单独维护<style>代码，以任务卡片为例：

```html
<view class="flex items-center justify-between p-4 mb-3 bg-white rounded-2xl shadow-sm hover:shadow-md transition">
```

这种原子化结构可以直接搭建出兼顾圆角阴影和移动端尺寸适应的卡片组件，且样式即开即用，改动后实时预览，迭代效率明显。

4.3.4 核心交互流程实现（任务卡片与专注模式）

专注模式（FocusMode.vue）是整个应用交互难度最高的模块。计时核心用原生setInterval实现，配合Vue 3响应式的countdownLeft变量绑定环形进度条的数据源。

用户点击"开始"后：系统屏蔽顶部原生导航栏，通过uni.setKeepScreenOn()保持屏幕常亮，阻断自动熄屏。专注过程中，应用监听安卓物理返回键与左滑返回事件：

```javascript
onBackPress((options) => {
    if (isFocusing.value) {
        uni.showModal({ title: '确认放弃?', content: '现在退出专注将失去当前奖励碎片' });
        return true; // 拦截返回操作
    }
});
```

这个拦截设计的动机很直接：ADHD儿童误触返回键的概率较高，如果一次误触直接终止任务，对儿童的挫败感打击很大，也会让家长对系统失去信任。弹窗确认的代价是多一步操作，但换来的是任务的安全感。

任务界面如图4.2所示，洞察页面如图4.3所示，家长中心如图4.4所示：

图4.2 任务

图4.3 洞察

图4.4 家长中心


4.4 Web管理后台终端实现 (smallsteps-ui)

管理后台基于Vue 3 + Element Plus独立部署，作为整个干预生态的数据管理中枢。

4.4.1 管理员登录与权限控制

管理后台掌握较高权限（账号封禁、全系统日志获取），仅靠后端接口鉴权还不够——还需要前端的动态路由机制配合。管理员登录后，应用首先请求后台菜单树，系统据此只挂载该管理员权限范围内的侧边栏路由。即使普通家长端用户知晓后台URL并尝试直接访问，也会被前端的路由守卫检测出无关联Token，重定向至公共登录页，无法渲染任何管理界面。

管理后台登录界面如图4.5所示：

图4.5 管理后台登录

4.4.2 后台数据图表与列表渲染实现

平台运营数据分析（如每日打卡总次数监控）使用ECharts配合Element Plus的组件体系实现。管理后台构建了涵盖近30天的柱状图与平滑折线统计图。每次数据更新时，组件内通过Vue 3的watch捕捉API返回的新时序JSON数据集，在ECharts图表对象内触发setOption()方法完成图表重绘，页面主题支持动态调整。

系统监控如图4.6所示，首页运营数据如图4.7所示：

图4.6 系统监控

图4.7 首页运营数据


4.5 本章小结

本章从内到外展示了系统的核心技术实现。后端层面，阐述了Spring Boot结合MyBatis-Plus保障数据库事务一致性的方案，展示了AI聚合链路的具体实现及降级策略。移动端层面，说明了UniApp与Pinia配合实现双模式秒级切换与数据持久同步的方案，以及专注模式对意外中断的拦截处理机制。管理后台层面，概述了动态路由权限控制与ECharts数据可视化的实现。整个实现过程中积累的踩坑记录与关键设计决策，为后续测试章节的问题溯源提供了依据。
