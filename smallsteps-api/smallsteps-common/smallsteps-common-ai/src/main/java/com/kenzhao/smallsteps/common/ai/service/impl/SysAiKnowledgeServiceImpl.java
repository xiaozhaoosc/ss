package com.kenzhao.smallsteps.common.ai.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kenzhao.smallsteps.common.ai.domain.SysAiKnowledge;
import com.kenzhao.smallsteps.common.ai.mapper.SysAiKnowledgeMapper;
import com.kenzhao.smallsteps.common.ai.service.ISysAiKnowledgeService;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SysAiKnowledgeServiceImpl extends ServiceImpl<SysAiKnowledgeMapper, SysAiKnowledge> implements ISysAiKnowledgeService {
    
    // Stubbed VectorStore for compilation. Real implementation will use Spring AI.
    public interface VectorStoreStub {
        void add(List<String> docs);
        List<String> similaritySearch(String query, int topK);
    }
    
    // Fallback if vectorStore is not present in some minimal contexts
    private final VectorStoreStub vectorStore = new VectorStoreStub() {
        @Override public void add(List<String> docs) {}
        @Override public List<String> similaritySearch(String query, int topK) { return new ArrayList<>(); }
    };
    
    @Override
    public void syncToVectorStore(Long id) {
        SysAiKnowledge knowledge = getById(id);
        if (knowledge != null && knowledge.getContent() != null) {
            vectorStore.add(List.of(knowledge.getContent()));
        }
    }
    
    @Override
    public List<String> hybridSearch(String query, int topK) {
        List<String> results = new ArrayList<>();
        
        // 1. Exact/Keyword match in PG
        LambdaQueryWrapper<SysAiKnowledge> lqw = new LambdaQueryWrapper<>();
        lqw.like(SysAiKnowledge::getKeywords, query);
        List<SysAiKnowledge> pgMatches = list(lqw);
        for(SysAiKnowledge k : pgMatches) {
            results.add("[Rule] " + k.getContent());
        }
        
        // 2. Semantic Search
        try {
            List<String> docs = vectorStore.similaritySearch(query, topK);
            results.addAll(docs);
        } catch (Exception e) {
            // Degradation: Ignore vector store failure
        }
        
        return results;
    }
}
