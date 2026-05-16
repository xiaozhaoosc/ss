# AI Knowledge Base Management (Hybrid Retrieval) Design

## 1. Overview
The goal of this feature is to add "Knowledge Base Management" (知识库管理) to the existing AI Management module in the `smallsteps-api` and `smallsteps-ui`. It will utilize a **Hybrid Retrieval** approach (PostgreSQL exact/keyword matching + Spring AI `SimpleVectorStore` semantic search) to provide context for AI tasks such as children's emotion analysis.

## 2. Architecture & Components

### 2.1 Backend (Spring Boot & Spring AI)
- **PostgreSQL Entity (`SysAiKnowledge`)**:
  - Purpose: Stores structured knowledge, rules (e.g., Crisis Protocol rules), keywords, and metadata.
  - Fields: `id`, `title`, `content_type` (TEXT, MARKDOWN, PDF), `content`, `keywords`, `status`, `create_time`, `update_time`.
- **Vector Store (`SimpleVectorStore`)**:
  - Purpose: A lightweight, file-backed vector database provided by Spring AI to store document embeddings.
  - Storage: Saved locally as `vector_store.json`.
- **Services**:
  - `AiKnowledgeService`: Handles CRUD operations, document parsing (via `TokenTextSplitter`), and embedding generation.
  - `AiRouterService` (Update): Modified to perform the hybrid query (fetching from both PG and Vector Store) before calling the LLM.

### 2.2 Frontend (Vue 3 / smallsteps-ui)
- **Knowledge Base Management Page**:
  - Path: `src/views/system/ai/knowledge/index.vue`
  - Features: List view of existing knowledge items, Add/Edit forms, File Upload (Markdown/TXT/PDF), and a "Sync to Vector Store" button for manual triggers.

## 3. Data Flow

### 3.1 Ingestion Flow
1. Admin user adds text or uploads a file via the Knowledge Base Management UI.
2. The raw text and metadata are saved to the `sys_ai_knowledge` table in PostgreSQL.
3. An async event triggers document processing:
   - The text is split into chunks using `TokenTextSplitter`.
   - Embeddings are generated using the configured OpenAI/AI model.
   - Chunks and embeddings are saved to `SimpleVectorStore`.

### 3.2 Retrieval Flow
1. An AI task (e.g., Task Breakdown, Emotion Analysis) requests generation.
2. **Hybrid Search**:
   - **Step A**: Query `sys_ai_knowledge` using SQL keyword/regex matching for strict rules.
   - **Step B**: Query `SimpleVectorStore` for top-K semantically similar chunks based on the user's prompt.
3. The results from Step A and Step B are merged, deduplicated, and injected into the `{context}` variable of the `AiPrompt`.
4. The final prompt is sent to the LLM.

## 4. Error Handling & Degradation
- **Embedding Failures**: If the external Embedding API times out or fails, the system will log the error and support manual retry from the UI.
- **Retrieval Degradation**: If `SimpleVectorStore` is unavailable or fails to load, the system gracefully degrades to only using PostgreSQL keyword matching. This ensures critical rules (e.g., Crisis Protocol) are always enforced.

## 5. Testing Strategy
- **Unit Tests**: Test the hybrid retrieval logic to ensure PG results and Vector results are merged correctly.
- **Mocking**: Mock the Embedding API in unit tests to verify the chunking and saving logic without incurring API costs.
- **Integration Tests**: Verify the `SimpleVectorStore` correctly persists to and loads from the local JSON file.