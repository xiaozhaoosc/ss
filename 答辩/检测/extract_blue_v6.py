import os, re, bs4

# Paths
reports = {
    '14': r'd:\office\jushuang1\github\ss\答辩\检测\ADHD中小学生（儿童）行为习惯辅助系统设计与实现_AIGC统计报告14.html',
    '63': r'd:\office\jushuang1\github\ss\答辩\检测\ADHD中小学生（儿童）行为习惯辅助系统设计与实现_AIGC统计报告63.html',
    '73': r'd:\office\jushuang1\github\ss\答辩\检测\ADHD中小学生儿童行为习惯辅助系统设计与实现_AIGC统计报告73.html'
}

# 目标 md 路径（原文所在）
orig_dir = r'd:\office\jushuang1\github\ss\答辩\检测\原文'

v6_md = r'd:\office\jushuang1\github\ss\答辩\检测\v6\73论文_v6.md'

os.makedirs(os.path.dirname(v6_md), exist_ok=True)

def extract_spans(html_path):
    with open(html_path, 'r', encoding='utf-8') as f:
        soup = bs4.BeautifulSoup(f, 'html.parser')
    # 假设蓝色文字使用 <span style="color: blue;">...</span>
    return [span.get_text(strip=True) for span in soup.find_all('span', style=lambda s: s and 'color: blue' in s.lower())]

def mark_blue(md_path, fragments):
    with open(md_path, 'r', encoding='utf-8') as f:
        content = f.read()
    for frag in fragments:
        # 只替换第一次出现，防止重复误替换
        escaped = re.escape(frag)
        pattern = re.compile(escaped)
        content, n = pattern.subn(f'<span style="color: blue;">{frag}</span>', content, count=1)
    with open(md_path, 'w', encoding='utf-8') as f:
        f.write(content)

# 处理每个报告：在对应原文 md 中标蓝，并同步到 v6 md
for key, html_path in reports.items():
    spans = extract_spans(html_path)
    orig_md = os.path.join(orig_dir, f'{key}论文.md')
    if os.path.exists(orig_md):
        mark_blue(orig_md, spans)
    # 同步到 v6 目标稿件（统一参考库）
    if os.path.exists(v6_md):
        mark_blue(v6_md, spans)

print('蓝色标记完成')
