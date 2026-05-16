package com.kenzhao.smallsteps.common.ai.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.common.ai.domain.SysAiKnowledge;
import com.kenzhao.smallsteps.common.ai.mapper.SysAiKnowledgeMapper;
import com.kenzhao.smallsteps.common.ai.service.impl.SysAiKnowledgeServiceImpl;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

/**
 * 知识库混合检索逻辑测试
 */
class SysAiKnowledgeServiceTest {

    @Mock
    private SysAiKnowledgeMapper knowledgeMapper;

    @InjectMocks
    private SysAiKnowledgeServiceImpl knowledgeService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testHybridSearch_ShouldCombinePgAndVectorResults() {
        // 1. Mock 数据库返回的固定规则
        SysAiKnowledge rule = new SysAiKnowledge();
        rule.setId(100L);
        rule.setKeywords("危机");
        rule.setContent("如果检测到自伤意图，立即切换到家长紧急指引模式。");

        when(knowledgeMapper.selectList(any(LambdaQueryWrapper.class)))
            .thenReturn(Arrays.asList(rule));

        // 2. 执行混合检索 (VectorStore目前为Stub返回空，因此主要验证数据库返回结果是否被正确包装)
        List<String> results = knowledgeService.hybridSearch("发生危机情况怎么处理", 3);

        // 3. 验证结果
        Assertions.assertNotNull(results);
        Assertions.assertTrue(results.size() >= 1);
        Assertions.assertTrue(results.get(0).startsWith("[Rule]"));
        Assertions.assertTrue(results.get(0).contains("家长紧急指引模式"));
        
        System.out.println("Hybrid Search Results: " + results);
    }
}
