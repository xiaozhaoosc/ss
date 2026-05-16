package com.kenzhao.smallsteps.common.ai.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kenzhao.smallsteps.common.ai.domain.SysAiKnowledge;
import com.kenzhao.smallsteps.common.ai.mapper.SysAiKnowledgeMapper;
import com.kenzhao.smallsteps.common.ai.service.ISysAiKnowledgeService;
import org.springframework.ai.document.Document;
import org.springframework.ai.vectorstore.SearchRequest;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SysAiKnowledgeServiceImpl extends ServiceImpl<SysAiKnowledgeMapper, SysAiKnowledge> implements ISysAiKnowledgeService {
    
    // Fallback if vectorStore is not present in some minimal contexts, but typically @RequiredArgsConstructor injects it.
    private final VectorStore vectorStore;
    
    @Override
    public void syncToVectorStore(Long id) {
        SysAiKnowledge knowledge = getById(id);
        if (knowledge != null && knowledge.getContent() != null) {
            // Simplified chunking for the implementation plan
            Document doc = new Document(knowledge.getContent(), Map.of("knowledgeId", id));
            vectorStore.add(List.of(doc));
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
            List<Document> docs = vectorStore.similaritySearch(SearchRequest.query(query).withTopK(topK));
            results.addAll(docs.stream().map(Document::getContent).collect(Collectors.toList()));
        } catch (Exception e) {
            // Degradation: Ignore vector store failure
        }
        
        return results;
    }
}
