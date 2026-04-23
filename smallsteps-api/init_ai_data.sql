INSERT INTO sys_ai_prompt (id, prompt_key, title, content, status, del_flag, create_by, create_time, remark)
VALUES (100, 'EMOTION_ANALYSIS', '儿童情绪分析模板', '你是一个儿童心理专家。请分析以下内容中儿童的情绪状态：
{content}

请严格按照以下JSON格式返回结果，不要有任何其他解释文字：
{
  "emotion": "情绪类型(如：开心、难过、愤怒、焦虑、平静)",
  "level": 情绪强度(1-5 partners的整数),
  "suggestion": "给家长的针对性建议"
}', '0', '0', '1', NOW(), '初始情绪分析模板')
ON CONFLICT (prompt_key) WHERE (del_flag = '0') DO UPDATE SET content = EXCLUDED.content;

INSERT INTO sys_ai_route (scene_key, strategy, default_model_id, create_by, create_time)
VALUES ('TASK_BREAKDOWN', 'PRIORITY_LEVEL', 2001, '1', NOW()),
       ('EMOTION_ANALYSIS', 'PRIORITY_LEVEL', 2001, '1', NOW())
ON CONFLICT (scene_key) DO UPDATE SET default_model_id = EXCLUDED.default_model_id;
