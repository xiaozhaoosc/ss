import os
import re

out_dir = r'd:\office\jushuang1\github\ss\答辩\检测\v20p'
os.makedirs(out_dir, exist_ok=True)

def extract_blue(filepath, outpath):
    if not os.path.exists(filepath):
        print(f'Missing: {filepath}')
        return
    with open(filepath, 'r', encoding='utf-8') as f:
        text = f.read()
    spans = re.findall(r'<span style="color: blue;">(.*?)</span>', text, re.DOTALL)
    with open(outpath, 'w', encoding='utf-8') as f:
        f.write(f'# Extracted {len(spans)} blue spans from {os.path.basename(filepath)}\n\n')
        for i, s in enumerate(spans):
            f.write(f'--- Fragment {i+1} ---\n{s.strip()}\n\n')
    print(f'Extracted {len(spans)} spans to {outpath}')

base_dir = r'd:\office\jushuang1\github\ss\答辩\检测\原文'
extract_blue(os.path.join(base_dir, '14论文.md'), os.path.join(out_dir, '14_blue.md'))
extract_blue(os.path.join(base_dir, '63论文.md'), os.path.join(out_dir, '63_blue.md'))
extract_blue(os.path.join(base_dir, '73论文.md'), os.path.join(out_dir, '73_blue.md'))
