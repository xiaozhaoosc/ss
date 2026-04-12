# AI 自动路由与多模型故障转移 Implementation Plan

> **Goal:** 构建一个具备故障转移 (Failover) 和自动路由功能的 AI 客户端服务，支持在 GLM-4.7-Flash、Kimi K2.5、Llama 3.1 和 Qwen 3.5 之间进行权重切换。

**架构设计:**
1. **AiClientFactory**: 维护一个模型优先级列表。
2. **Failover Service**: 如果当前模型调用失败，自动触发 `switch to next` 逻辑。
3. **实现:** 使用 Spring Boot 的 `RestTemplate` 或 `WebClient` 进行请求转发。

**优先级路由序列:**
1. `glm-4.7-flash` (BigModel)
2. `moonshotai/kimi-k2.5` (NVIDIA)
3. `meta/llama-3.1-70b-instruct` (NVIDIA)
4. `qwen/qwen3.5-122b-a10b` (NVIDIA)

---

### Task 1: 定义 AI 模型配置项与服务接口
**Files:**
- Modify: `smallsteps-api/smallsteps-modules/smallsteps-ai/src/main/resources/application.yml`
- Create: `smallsteps-api/smallsteps-modules/smallsteps-ai/src/main/java/com/kenzhao/smallsteps/ai/config/AiModelProperties.java`

- [ ] **Step 1: 在 application.yml 中配置模型 API Key**

```yaml
ai:
  models:
    glm:
      url: https://open.bigmodel.cn/api/paas/v4
      key: f2649c2b4bef47b099bf63a63ce135e4.kpn7Es4gyg3dawQk
      model: glm-4.7-flash
    nvidia:
      url: https://integrate.api.nvidia.com/v1
      key: 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
      models:
        - moonshotai/kimi-k2.5
        - meta/llama-3.1-70b-instruct
        - qwen/qwen3.5-122b-a10b
```

---

### Task 2: 实现路由调度器与故障转移机制
**Files:**
- Create: `smallsteps-api/smallsteps-modules/smallsteps-ai/src/main/java/com/kenzhao/smallsteps/ai/service/impl/SmartAiClient.java`

- [ ] **Step 1: 实现核心路由与重试逻辑**

```java
// 核心逻辑简述：维护一个有序列表，执行 execute 任务，catch 异常则 poll 下一个，直到列表为空。
public String askAi(String prompt) {
    List<ModelConfig> queue = getModelPriorityList();
    for (ModelConfig cfg : queue) {
        try {
            return callModel(cfg, prompt);
        } catch (Exception e) {
            log.error("Model {} failed, switching...", cfg.getId());
        }
    }
    throw new RuntimeException("All AI models failed");
}
```

---

### Task 3: 替换原 AI 实现
- [ ] **Step 1:** 将 `AiServiceImpl` 中的 Mock 调用替换为 `SmartAiClient.askAi()` 调用。

---

### 验收标准:
- **高可用**: 模拟一个无效的 GLM Key，验证系统是否自动切换至 Kimi。
- **一致性**: 无论使用哪个模型，任务步骤拆解的结果格式必须符合前端 `Step 1, 2, 3` 的预期。

Respond with DONE when complete.