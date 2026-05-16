package com.kenzhao.smallsteps.system.controller.system;

import com.kenzhao.smallsteps.common.ai.domain.SysAiKnowledge;
import com.kenzhao.smallsteps.common.ai.service.ISysAiKnowledgeService;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;
import java.util.List;

@RestController
@RequestMapping("/system/ai/knowledge")
@RequiredArgsConstructor
public class AiKnowledgeController {
    
    private final ISysAiKnowledgeService aiKnowledgeService;
    
    @GetMapping("/list")
    public List<SysAiKnowledge> list() {
        return aiKnowledgeService.list();
    }
    
    @PostMapping
    public void add(@RequestBody SysAiKnowledge knowledge) {
        aiKnowledgeService.save(knowledge);
    }
    
    @PostMapping("/{id}/sync")
    public void sync(@PathVariable Long id) {
        aiKnowledgeService.syncToVectorStore(id);
    }
}
