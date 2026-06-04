import re
import json

file_path = r'd:\office\jushuang1\github\ss\答辩\检测\原文\73论文.md'
with open(file_path, 'r', encoding='utf-8') as f:
    text = f.read()

fragments = re.findall(r'<span style="color: blue;">(.*?)</span>', text, re.DOTALL)
print(f'Found {len(fragments)} fragments.')
for i, frag in enumerate(fragments):
    print(f'--- Fragment {i+1} ---\n{frag}\n')
