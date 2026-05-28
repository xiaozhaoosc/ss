package com.kenzhao.smallsteps;

import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import com.kenzhao.smallsteps.common.ai.domain.AiRoute;
import com.kenzhao.smallsteps.common.ai.mapper.AiModelMapper;
import com.kenzhao.smallsteps.common.ai.mapper.AiRouteMapper;
import com.kenzhao.smallsteps.common.ai.service.IAiRouterService;
import com.kenzhao.smallsteps.common.ai.service.impl.SmartAiClient;
import org.springframework.boot.SpringApplication;
import org.springframework.context.ConfigurableApplicationContext;

import java.util.List;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicLong;

public class MainAppTest {
    
    public static void main(String[] args) {
        System.out.println("==================================================");
        System.out.println(">>> [INFO] 正在以独立应用程序方式启动 Spring 容器进行 AI 诊断...");
        System.out.println("==================================================");
        
        System.setProperty("spring.profiles.active", "dev");
        ConfigurableApplicationContext context = SpringApplication.run(SmallStepsApplication.class, args);
        
        try {
            System.out.println("\n>>> Spring 容器加载成功！开始运行诊断测试...");
            
            AiModelMapper aiModelMapper = context.getBean(AiModelMapper.class);
            AiRouteMapper aiRouteMapper = context.getBean(AiRouteMapper.class);
            IAiRouterService aiRouterService = context.getBean(IAiRouterService.class);
            SmartAiClient smartAiClient = context.getBean(SmartAiClient.class);
            
            List<AiModel> models = aiModelMapper.selectList(null);
            System.out.println("发现已注册的模型数: " + models.size());
            for (AiModel m : models) {
                System.out.printf("  - ID: %d | Name: %s | Code: %s | Status: %s | Provider: %d\n",
                    m.getId(), m.getName(), m.getModelCode(), m.getStatus(), m.getProviderId());
            }

            System.out.println("\n>>> [INFO] 检查当前路由策略策略...");
            List<AiRoute> routes = aiRouteMapper.selectList(null);
            for (AiRoute r : routes) {
                System.out.printf("  - Scene: %s | Default Model: %d | Strategy: %s\n",
                    r.getSceneKey(), r.getDefaultModelId(), r.getStrategy());
            }

            System.out.println("\n>>> [INFO] 测试 BUDDY_CHAT 场景路由...");
            AiModel buddyModel = aiRouterService.route("BUDDY_CHAT", 10001L);
            System.out.printf("  - BUDDY_CHAT 路由的目标模型: %s (ID: %d, Code: %s)\n",
                buddyModel.getName(), buddyModel.getId(), buddyModel.getModelCode());

            System.out.println("\n>>> [INFO] 测试 TASK_BREAKDOWN 场景路由...");
            AiModel breakdownModel = aiRouterService.route("TASK_BREAKDOWN", 10001L);
            System.out.printf("  - TASK_BREAKDOWN 路由的目标模型: %s (ID: %d, Code: %s)\n",
                breakdownModel.getName(), breakdownModel.getId(), breakdownModel.getModelCode());

            System.out.println("\n>>> [INFO] 开始对目标模型进行首字响应速度 (TTFT) 测试...");
            runPerformanceTest(smartAiClient, buddyModel, "BUDDY_CHAT", "你好，我是Leo，我今天有点不开心。");
            
        } catch (Exception e) {
            System.err.println(">>> 运行测试时发生异常:");
            e.printStackTrace();
        } finally {
            System.out.println("\n>>> 诊断结束，正在关闭 Spring 容器...");
            context.close();
            System.out.println("==================================================");
        }
    }

    private static void runPerformanceTest(SmartAiClient smartAiClient, AiModel model, String sceneKey, String prompt) throws Exception {
        System.out.println("\n--------------------------------------------------");
        System.out.printf("正在测试模型 [%s] (%s)...\n", model.getName(), model.getModelCode());
        
        CountDownLatch latch = new CountDownLatch(1);
        long startTime = System.currentTimeMillis();
        AtomicLong firstTokenTime = new AtomicLong(0);
        AtomicLong totalTokens = new AtomicLong(0);

        smartAiClient.askAiStream(prompt, model, sceneKey, 10001L, new SmartAiClient.StreamCallback() {
            @Override
            public void onChunk(String chunk) {
                if (firstTokenTime.get() == 0) {
                    firstTokenTime.set(System.currentTimeMillis());
                    System.out.printf("\n>>> [TTFT] 首字返回耗时: %d 毫秒\n", (firstTokenTime.get() - startTime));
                    System.out.print("流式输出内容: ");
                }
                System.out.print(chunk);
                totalTokens.addAndGet(chunk.length());
            }

            @Override
            public void onComplete() {
                long totalTime = System.currentTimeMillis() - startTime;
                System.out.println("\n>>> [COMPLETE] 对话生成完成!");
                System.out.printf("  - 首字耗时 (TTFT): %d 毫秒\n", (firstTokenTime.get() - startTime));
                System.out.printf("  - 总生成耗时: %d 毫秒\n", totalTime);
                System.out.printf("  - 预估字数: %d\n", totalTokens.get());
                latch.countDown();
            }

            @Override
            public void onError(Throwable error) {
                System.err.println("\n>>> [ERROR] 模型调用出错: " + error.getMessage());
                error.printStackTrace();
                latch.countDown();
            }
        });

        // 最多等 60 秒
        if (!latch.await(60, TimeUnit.SECONDS)) {
            System.err.println("\n>>> [TIMEOUT] 模型响应超时!");
        }
        System.out.println("--------------------------------------------------");
    }
}
