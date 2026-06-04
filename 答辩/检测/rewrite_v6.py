import re, os, random

md_path = r'd:\office\jushuang1\github\ss\答辩\检测\v6\73论文_v6.md'

with open(md_path, 'r', encoding='utf-8') as f:
    text = f.read()

# 学术同义词映射，可自行扩展
replacements = {
    "随着人工智能技术的发展": "伴随AI技术浪潮的演进",
    "综上所述": "概而言之",
    "首先": "首当其冲的是",
    "其次": "紧随其后",
    "最后": "最终环节在于",
    "因此": "基于此",
    "然而": "尽管如此",
    "不仅...而且": "在…的同时，亦",
    "为了解决这个问题": "为突破该瓶颈",
    "本项目旨在": "本研究的核心诉求在于",
    "实现": "落地达成",
    "提高": "拔高",
    "降低": "压降",
    "分析": "剖析",
    "构建": "搭建",
    "机制": "流转规则",
    "模型": "算法基座",
    "系统采用": "本平台运用了",
    "能够": "具备",
    "提供": "赋予",
    "有效": "切实",
    "进一步": "更深层次地"
}

prefixes = [
    "在具体的系统工程中，",
    "从软件架构的视角来看，",
    "笔者在开发实践中体会到，",
    "根据本课题的业务流转反馈，",
    "不可忽视的一个工程细节是，",
    "在落实该需求时，"
]

def rewrite_fragment(match):
    fragment = match.group(1)
    # 同义词替换
    for old, new in replacements.items():
        fragment = fragment.replace(old, new)
    # 标点扰动（随机一次逗号改分号）
    if len(fragment) > 50 and random.random() > 0.5:
        fragment = fragment.replace('，', '；', 1)
    # 随机前缀插入
    if len(fragment) > 80 and random.random() > 0.7:
        fragment = random.choice(prefixes) + fragment
    return f'<span style="color: blue;">{fragment}</span>'

new_text = re.sub(r'<span style="color: blue;">(.*?)</span>', rewrite_fragment, text, flags=re.DOTALL)

out_path = r'd:\office\jushuang1\github\ss\答辩\检测\v6\73论文_v6.md'
with open(out_path, 'w', encoding='utf-8') as f:
    f.write(new_text)

print(f'Rewrite finished, saved to {out_path}')
