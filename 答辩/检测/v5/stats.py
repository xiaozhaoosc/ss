#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""统计分析脚本"""
import re

with open(r'd:\office\jushuang1\github\ss\答辩\检测\原文\14论文.md', 'r', encoding='utf-8') as f:
    t14 = f.read()
with open(r'd:\office\jushuang1\github\ss\答辩\检测\原文\73论文.md', 'r', encoding='utf-8') as f:
    t73 = f.read()

t14_clean = re.sub(r'<span style="color: blue;">', '', t14)
t14_clean = re.sub(r'</span>', '', t14_clean)
t73_clean = re.sub(r'<span style="color: blue;">', '', t73)
t73_clean = re.sub(r'</span>', '', t73_clean)

print(f'14论文(无span): {len(t14_clean)} 字符, {t14_clean.count(chr(10))} 行')
print(f'73论文(无span): {len(t73_clean)} 字符, {t73_clean.count(chr(10))} 行')

blue14 = re.findall(r'<span style="color: blue;">(.*?)</span>', t14, re.DOTALL)
blue73 = re.findall(r'<span style="color: blue;">(.*?)</span>', t73, re.DOTALL)
print(f'14论文蓝色标注: {len(blue14)} 个')
print(f'73论文蓝色标注: {len(blue73)} 个')

blue14_chars = sum(len(b) for b in blue14)
blue73_chars = sum(len(b) for b in blue73)
print(f'14论文蓝色文字: {blue14_chars} 字符 / 总 {len(t14_clean)} = {blue14_chars/len(t14_clean)*100:.1f}%')
print(f'73论文蓝色文字: {blue73_chars} 字符 / 总 {len(t73_clean)} = {blue73_chars/len(t73_clean)*100:.1f}%')
