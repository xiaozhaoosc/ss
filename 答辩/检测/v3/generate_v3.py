import os
import re

academic_synonyms = {
    "系统": "平台架构",
    "采用": "依托",
    "提供": "赋予",
    "因为": "鉴于",
    "由于": "因",
    "所以": "故而",
    "因此": "由此可见",
    "需要": "亟待",
    "可以": "能够",
    "进行": "开展",
    "解决": "应对",
    "实现": "落地",
    "帮助": "辅助",
    "非常": "显著",
    "很大": "颇大",
    "问题": "痛点",
    "使用": "运用",
    "应用": "应用实践",
    "包含": "涵盖",
    "包括": "囊括",
    "不仅": "非但",
    "而且": "更兼",
    "对于": "针对",
    "为了": "为",
    "基于": "立足于",
    "设计": "规划设计",
    "不仅...而且": "既...亦",
    "发现": "察觉",
    "主要": "核心",
    "特征": "特质",
    "部分": "环节",
    "方式": "范式",
    "手段": "途径",
    "结果": "成效",
    "表明": "证实",
    "说明": "揭示",
    "此外": "另外",
    "结合": "融合",
    "发展": "演进",
    "目前": "现阶段",
    "当前": "当今",
    "存在": "具备",
    "具备": "兼具",
    "传统": "常规",
    "不足": "局限性",
    "优势": "显著优势",
    "一定": "特定",
    "提升": "拔高",
    "提高": "增强",
    "减少": "削减",
    "降低": "消减",
    "增加": "增添",
    "同时": "与此同时",
    "产生": "孕育",
    "过程": "进程",
    "需求": "核心诉求",
    "目标": "愿景",
    "方法": "策略",
    "策略": "路径",
    "分析": "剖析",
    "评估": "审视",
    "测试": "校验",
    "研究": "探究",
    "探讨": "论证",
    "提出": "构想",
    "构建": "搭建",
    "建立": "确立",
    "通过": "经由",
    "以及": "暨",
    "重要": "关键",
    "核心": "中枢",
    "功能": "职能",
    "模块": "组件",
    "机制": "运作机制",
    "模型": "范式模型",
    "算法": "运算逻辑",
    "架构": "底层架构",
    "框架": "技术底座",
    "开发": "研发",
    "运行": "运转"
}

def rewrite_text(text):
    if not text.strip():
        return text
        
    # Ignore purely English texts
    if re.match(r'^[a-zA-Z0-9\s\.,;:!?\(\)\"-]+$', text.strip()):
        return text
        
    res = text
    # Sort keys by length descending to avoid partial matching of longer words
    for key in sorted(academic_synonyms.keys(), key=len, reverse=True):
        res = res.replace(key, academic_synonyms[key])
        
    # Add punctuation alterations to change sentence fingerprint
    res = res.replace("，", "；")
    res = res.replace("的", "之")
    
    # Clean up awkward "之" grammar
    res = res.replace("之之", "的").replace("之，", "，").replace("之。", "。").replace("之；", "；")
    
    # Alternate punctuation randomly
    parts = res.split("；")
    final_parts = []
    for i, p in enumerate(parts):
        if i % 2 == 0 and i != len(parts)-1:
            final_parts.append(p + "，")
        else:
            if i != len(parts)-1:
                final_parts.append(p + "；")
            else:
                final_parts.append(p)
                
    final_res = "".join(final_parts).replace("，；", "，").replace("；，", "；")
    
    return final_res

def generate_v3():
    input_file = r'd:\office\jushuang1\github\ss\答辩\检测\原文\73论文.md'
    v3_dir = r'd:\office\jushuang1\github\ss\答辩\检测\v3'
    output_file = os.path.join(v3_dir, 'v3.md')
    
    os.makedirs(v3_dir, exist_ok=True)
    
    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()
        
    # Find all blue spans
    pattern = re.compile(r'<span style="color: blue;">(.*?)</span>', re.DOTALL)
    
    def replacer(match):
        original_text = match.group(1)
        new_text = rewrite_text(original_text)
        return new_text
        
    new_content = pattern.sub(replacer, content)
    
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(new_content)
        
    print(f"v3.md has been generated successfully at {output_file}")

if __name__ == "__main__":
    generate_v3()
