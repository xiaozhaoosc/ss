//package com.kenzhao.smallsteps.common.ai.service;
//
//import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
//import com.kenzhao.smallsteps.common.ai.domain.AiModel;
//import com.kenzhao.smallsteps.common.ai.domain.AiRoute;
//import com.kenzhao.smallsteps.common.ai.mapper.AiModelMapper;
//import com.kenzhao.smallsteps.common.ai.mapper.AiProviderMapper;
//import com.kenzhao.smallsteps.common.ai.mapper.AiRouteMapper;
//import com.kenzhao.smallsteps.common.ai.service.impl.AiRouterServiceImpl;
//import org.junit.jupiter.api.Assertions;
//import org.junit.jupiter.api.BeforeEach;
//import org.junit.jupiter.api.Test;
//import org.mockito.InjectMocks;
//import org.mockito.Mock;
//import org.mockito.MockitoAnnotations;
//
//import java.math.BigDecimal;
//import java.util.Arrays;
//import java.util.List;
//
//import static org.mockito.ArgumentMatchers.any;
//import static org.mockito.Mockito.when;
//
///**
// * AI路由逻辑验证测试
// */
//class AiRouterServiceTest {
//
//    @Mock
//    private AiRouteMapper routeMapper;
//    @Mock
//    private AiModelMapper modelMapper;
//    @Mock
//    private AiProviderMapper providerMapper;
//
//    @InjectMocks
//    private AiRouterServiceImpl routerService;
//
//    @BeforeEach
//    void setUp() {
//        MockitoAnnotations.openMocks(this);
//    }
//
//    @Test
//    void testRoute_ShouldSelectFreeModel_WhenAvailable() {
//        // 1. 模拟路由策略
//        AiRoute mockRoute = new AiRoute();
//        mockRoute.setSceneKey("smart_chat");
//        mockRoute.setStrategy("PRIORITY_LEVEL");
//        when(routeMapper.selectById("smart_chat")).thenReturn(mockRoute);
//
//        // 2. 模拟模型列表 (包含免费的 Flash 和付费的 Pro)
//        AiModel freeModel = new AiModel();
//        freeModel.setId(2001L);
//        freeModel.setName("GLM-4 Flash");
//        freeModel.setIsFreeTier("1"); // Free
//        freeModel.setCostInput(BigDecimal.ZERO);
//        freeModel.setStatus("0");
//
//        AiModel paidModel = new AiModel();
//        paidModel.setId(2002L);
//        paidModel.setName("GLM-4 Pro");
//        paidModel.setIsFreeTier("0"); // Not Free
//        paidModel.setCostInput(BigDecimal.valueOf(10.0));
//        paidModel.setStatus("0");
//
//        List<AiModel> mockModels = Arrays.asList(paidModel, freeModel);
//
//        when(modelMapper.selectList(any(LambdaQueryWrapper.class))).thenReturn(mockModels);
//
//        // 3. 执行路由
//        AiModel selected = routerService.route("smart_chat", 123L);
//
//        // 4. 验证: 应该选中免费模型
//        Assertions.assertNotNull(selected);
//        Assertions.assertEquals("GLM-4 Flash", selected.getName());
//        Assertions.assertEquals("1", selected.getIsFreeTier());
//        System.out.println("Router Selected: " + selected.getName() + " (IsFree: " + selected.getIsFreeTier() + ")");
//    }
//
//    @Test
//    void testRoute_ShouldSelectLowestPrice_WhenNoFreeAvailable() {
//        // 1. 模拟路由策略
//        AiRoute mockRoute = new AiRoute();
//        mockRoute.setSceneKey("analysis");
//        mockRoute.setStrategy("PRIORITY_LEVEL");
//        when(routeMapper.selectById("analysis")).thenReturn(mockRoute);
//
//        // 2. 模拟只有付费模型
//        AiModel expensiveModel = new AiModel();
//        expensiveModel.setId(3001L);
//        expensiveModel.setName("GPT-4");
//        expensiveModel.setCostInput(BigDecimal.valueOf(30.0));
//        expensiveModel.setIsFreeTier("0");
//        expensiveModel.setStatus("0");
//
//        AiModel cheapModel = new AiModel();
//        cheapModel.setId(3002L);
//        cheapModel.setName("GPT-4o-mini");
//        cheapModel.setCostInput(BigDecimal.valueOf(1.0)); // Cheaper
//        cheapModel.setIsFreeTier("0");
//        cheapModel.setStatus("0");
//
//        List<AiModel> mockModels = Arrays.asList(expensiveModel, cheapModel);
//
//        when(modelMapper.selectList(any(LambdaQueryWrapper.class))).thenReturn(mockModels);
//
//        // 3. 执行路由
//        AiModel selected = routerService.route("analysis", 123L);
//
//        // 4. 验证: 应该选中价格最低的
//        Assertions.assertEquals("GPT-4o-mini", selected.getName());
//        System.out.println("Router Selected: " + selected.getName() + " (Price: " + selected.getCostInput() + ")");
//    }
//}
