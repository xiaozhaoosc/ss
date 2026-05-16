# AI Knowledge Base Management Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add Knowledge Base Management to the AI module supporting Hybrid Retrieval via PostgreSQL keyword matching and Spring AI SimpleVectorStore.

**Architecture:** A new entity `SysAiKnowledge` will store rules in PostgreSQL. Text is split and vectorized into `SimpleVectorStore`. During AI routing, both PG and Vector store are queried and merged into the prompt context.

**Tech Stack:** Java, Spring Boot, MyBatis Plus, Spring AI, PostgreSQL, Vue 3.

---

### Task 1: Database Schema

**Files:**
- Create: `docs/sqls/sys_ai_knowledge.sql`

- [ ] **Step 1: Write the SQL schema script**

```sql
CREATE TABLE sys_ai_knowledge (
    id BIGINT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content_type VARCHAR(50) DEFAULT 'TEXT',
    content TEXT NOT NULL,
    keywords VARCHAR(500),
    status CHAR(1) DEFAULT '0',
    create_by VARCHAR(64),
    create_time TIMESTAMP,
    update_by VARCHAR(64),
    update_time TIMESTAMP,
    remark VARCHAR(500)
);

COMMENT ON TABLE sys_ai_knowledge IS 'AI Knowledge Base';
```

- [ ] **Step 2: Commit**

```bash
git add docs/sqls/sys_ai_knowledge.sql
git commit -m "feat(ai): add sys_ai_knowledge schema"
```

### Task 2: Backend Domain & Mapper

**Files:**
- Create: `smallsteps-api/smallsteps-common/smallsteps-common-ai/src/main/java/com/kenzhao/smallsteps/common/ai/domain/SysAiKnowledge.java`
- Create: `smallsteps-api/smallsteps-common/smallsteps-common-ai/src/main/java/com/kenzhao/smallsteps/common/ai/mapper/SysAiKnowledgeMapper.java`

- [ ] **Step 1: Write Entity Class**

```java
package com.kenzhao.smallsteps.common.ai.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.util.Date;

@Data
@TableName("sys_ai_knowledge")
public class SysAiKnowledge {
    @TableId
    private Long id;
    private String title;
    private String contentType;
    private String content;
    private String keywords;
    private String status;
    private String createBy;
    private Date createTime;
    private String updateBy;
    private Date updateTime;
    private String remark;
}
```

- [ ] **Step 2: Write Mapper Interface**

```java
package com.kenzhao.smallsteps.common.ai.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kenzhao.smallsteps.common.ai.domain.SysAiKnowledge;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SysAiKnowledgeMapper extends BaseMapper<SysAiKnowledge> {
}
```

- [ ] **Step 3: Commit**

```bash
git add smallsteps-api/smallsteps-common/smallsteps-common-ai/src/main/java/com/kenzhao/smallsteps/common/ai/domain/SysAiKnowledge.java
git add smallsteps-api/smallsteps-common/smallsteps-common-ai/src/main/java/com/kenzhao/smallsteps/common/ai/mapper/SysAiKnowledgeMapper.java
git commit -m "feat(ai): add knowledge entity and mapper"
```

### Task 3: Knowledge Service & Vector Store Integration

**Files:**
- Create: `smallsteps-api/smallsteps-common/smallsteps-common-ai/src/main/java/com/kenzhao/smallsteps/common/ai/service/ISysAiKnowledgeService.java`
- Create: `smallsteps-api/smallsteps-common/smallsteps-common-ai/src/main/java/com/kenzhao/smallsteps/common/ai/service/impl/SysAiKnowledgeServiceImpl.java`

- [ ] **Step 1: Write Service Interface**

```java
package com.kenzhao.smallsteps.common.ai.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.kenzhao.smallsteps.common.ai.domain.SysAiKnowledge;
import java.util.List;

public interface ISysAiKnowledgeService extends IService<SysAiKnowledge> {
    void syncToVectorStore(Long id);
    List<String> hybridSearch(String query, int topK);
}
```

- [ ] **Step 2: Write Service Implementation**

```java
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
    
    private final VectorStore vectorStore; // Assumes SimpleVectorStore bean is configured
    
    @Override
    public void syncToVectorStore(Long id) {
        SysAiKnowledge knowledge = getById(id);
        if (knowledge != null && knowledge.getContent() != null) {
            // Simplified chunking (in a real scenario use TokenTextSplitter)
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
```

- [ ] **Step 3: Commit**

```bash
git add smallsteps-api/smallsteps-common/smallsteps-common-ai/src/main/java/com/kenzhao/smallsteps/common/ai/service/
git commit -m "feat(ai): implement knowledge hybrid search service"
```

### Task 4: API Controller

**Files:**
- Create: `smallsteps-api/smallsteps-modules/smallsteps-system/src/main/java/com/kenzhao/smallsteps/system/controller/system/AiKnowledgeController.java`

- [ ] **Step 1: Write Controller**

```java
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
```

- [ ] **Step 2: Commit**

```bash
git add smallsteps-api/smallsteps-modules/smallsteps-system/src/main/java/com/kenzhao/smallsteps/system/controller/system/AiKnowledgeController.java
git commit -m "feat(ai): add knowledge base controller"
```

### Task 5: Frontend Vue Component

**Files:**
- Create: `smallsteps-ui/src/views/system/ai/knowledge/index.vue`

- [ ] **Step 1: Write Vue Component**

```vue
<template>
  <div class="app-container">
    <h2>Knowledge Base Management</h2>
    <el-button type="primary" @click="handleAdd">Add Knowledge</el-button>
    
    <el-table :data="knowledgeList" style="width: 100%; margin-top: 20px;">
      <el-table-column prop="title" label="Title" />
      <el-table-column prop="keywords" label="Keywords" />
      <el-table-column label="Actions">
        <template #default="scope">
          <el-button size="small" @click="handleSync(scope.row.id)">Sync to Vector</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const knowledgeList = ref([])

const fetchList = async () => {
  const res = await fetch('/dev-api/system/ai/knowledge/list')
  knowledgeList.value = await res.json()
}

const handleAdd = () => {
  // Simplified for plan (would open a dialog)
  console.log("Add new rule")
}

const handleSync = async (id) => {
  await fetch(`/dev-api/system/ai/knowledge/${id}/sync`, { method: 'POST' })
  alert('Synced successfully')
}

onMounted(() => {
  fetchList()
})
</script>
```

- [ ] **Step 2: Commit**

```bash
git add smallsteps-ui/src/views/system/ai/knowledge/index.vue
git commit -m "feat(ui): add knowledge base management page"
```
