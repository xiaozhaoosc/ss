package com.kenzhao.smallsteps.common.ai.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.kenzhao.smallsteps.common.ai.domain.SysAiKnowledge;
import java.util.List;

public interface ISysAiKnowledgeService extends IService<SysAiKnowledge> {
    void syncToVectorStore(Long id);
    List<String> hybridSearch(String query, int topK);
}
