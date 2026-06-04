import re
import json

file_path = r'd:\office\jushuang1\github\ss\答辩\检测\原文\73论文.md'
output_path = r'd:\office\jushuang1\github\ss\答辩\检测\v3\spans.json'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# match all text inside <span style="color: blue;">...</span>
spans = re.findall(r'<span style="color: blue;">(.*?)</span>', content, flags=re.DOTALL)

with open(output_path, 'w', encoding='utf-8') as f:
    json.dump(spans, f, ensure_ascii=False, indent=2)

print(f"Extracted {len(spans)} spans.")
