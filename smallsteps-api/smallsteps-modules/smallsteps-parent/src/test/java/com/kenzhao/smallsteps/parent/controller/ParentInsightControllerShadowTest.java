package com.kenzhao.smallsteps.parent.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.satoken.utils.LoginHelper;
import com.kenzhao.smallsteps.system.domain.vo.SysUserVo;
import com.kenzhao.smallsteps.system.service.ISysUserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * 影子观察者情绪趋势 API 测试
 */
@ExtendWith(MockitoExtension.class)
public class ParentInsightControllerShadowTest {

    @InjectMocks
    private ParentInsightController controller;

    @Mock
    private ISysUserService userService;

    @Mock
    private com.kenzhao.smallsteps.child.service.IChildEmotionService childEmotionService;

    @BeforeEach
    void setUp() {
        // 在每个测试前清除登录状态
        // LoginHelper 需要根据实际实现进行适当处理
    }

    /**
     * TC-B01: 跨天数据聚合测试
     * 验证 shadow-trend 接口返回正确的数据结构
     */
    @Test
    public void testGetShadowEmotionTrend_ReturnsAggregatedData() {
        // 准备测试数据 - 模拟7天的情绪统计数据
        List<Map<String, Object>> mockData = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            mockData.add(Map.of(
                "date", "2026-04-" + String.format("%02d", 22 + i),
                "avgMood", 3.5 + (Math.random() * 1.0),
                "frustrationCount", (int) (Math.random() * 5)
            ));
        }

        // Mock 行为
        when(childEmotionService.getShadowEmotionStats(anyLong(), anyInt())).thenReturn(mockData);
        when(userService.selectUserById(anyLong())).thenReturn(createMockChildUser(1L));
        // 模拟登录用户的部门ID
        // 需要根据 LoginHelper 的实际实现进行 mock

        // 执行测试
        R<List<Map<String, Object>>> result = controller.getShadowEmotionTrend(1L, null, null, 7);

        // 验证结果
        assertNotNull(result);
        assertEquals(200, result.getCode());
        assertNotNull(result.getData());
        assertEquals(7, result.getData().size());

        // 验证每个数据点的结构
        for (Map<String, Object> dayData : result.getData()) {
            assertTrue(dayData.containsKey("date"), "数据点应包含 date 字段");
            assertTrue(dayData.containsKey("avgMood"), "数据点应包含 avgMood 字段");
            assertTrue(dayData.containsKey("frustrationCount"), "数据点应包含 frustrationCount 字段");

            // 验证 avgMood 范围 (1-5)
            double avgMood = ((Number) dayData.get("avgMood")).doubleValue();
            assertTrue(avgMood >= 1 && avgMood <= 5, "avgMood 应在 1-5 范围内");

            // 验证 frustrationCount 非负
            int frustrationCount = ((Number) dayData.get("frustrationCount")).intValue();
            assertTrue(frustrationCount >= 0, "frustrationCount 应非负");
        }
    }

    /**
     * TC-B02: 权限隔离测试
     * 验证 Parent A 无法访问 Parent B 孩子的数据
     */
    @Test
    public void testGetShadowEmotionTrend_UnauthorizedAccess() {
        // Mock 用户数据 - 孩子属于不同部门
        SysUserVo childUser = createMockChildUser(100L);
        childUser.setDeptId(200L); // 孩子属于部门 200
        when(userService.selectUserById(100L)).thenReturn(childUser);

        // Mock 登录用户属于部门 100（与孩子不同）
        // 需要根据 LoginHelper 的实际实现进行处理

        // 执行测试 - 尝试访问不属于自己部门的孩子数据
        R<List<Map<String, Object>>> result = controller.getShadowEmotionTrend(100L, null, null, 7);

        // 验证返回无权访问
        assertNotNull(result);
        assertEquals(500, result.getCode()); // 或根据实际错误码
        assertTrue(result.getMsg().contains("无权访问"), "应返回无权访问错误");
    }

    /**
     * 测试 childId 参数为空的情况
     */
    @Test
    public void testGetShadowEmotionTrend_NullChildId() {
        // 执行测试 - 不提供 childId
        R<List<Map<String, Object>>> result = controller.getShadowEmotionTrend(null, null, null, 7);

        // 验证返回错误
        assertNotNull(result);
        assertEquals(500, result.getCode());
        assertTrue(result.getMsg().contains("未选择儿童"), "应返回未选择儿童错误");
    }

    /**
     * 测试 days 参数默认值
     */
    @Test
    public void testGetShadowEmotionTrend_DefaultDays() {
        // Mock 行为
        when(childEmotionService.getShadowEmotionStats(anyLong(), eq(7))).thenReturn(new ArrayList<>());
        when(userService.selectUserById(anyLong())).thenReturn(createMockChildUser(1L));

        // 执行测试 - 不提供 days 参数
        R<List<Map<String, Object>>> result = controller.getShadowEmotionTrend(1L, null, null, null);

        // 验证调用了默认值 7
        verify(childEmotionService).getShadowEmotionStats(eq(1L), eq(7));
    }

    /**
     * 创建模拟的儿童用户对象
     */
    private SysUserVo createMockChildUser(Long userId) {
        SysUserVo user = new SysUserVo();
        user.setUserId(userId);
        user.setDeptId(100L); // 默认部门 ID
        return user;
    }
}
