# 论文 Word 自动化生成流水线

> **归入**: [[_index_wiki]] → 研发文档  
> **标签**: #论文 #自动化 #docx

## 背景

毕业论文需要严格遵循上海应用技术大学的格式规范（黑体/宋体/Times New Roman 字体层级、三线表、A4 页面设置等）。手动在 Word 中排版效率极低且容易遗漏格式细节，因此建立了基于 `python-docx` 的自动化生成流水线。

## 技术方案

```
论文_v2.md / 论文_v4.md  (Markdown 源稿)
        │
        ▼
generate_thesis_v2.py / generate_thesis.py  (Python 格式化脚本)
        │
        ▼
v2_xxx.docx / v4_xxx.docx  (符合学校规范的 Word 文档)
        │
        ▼
Word 手动步骤:  ① 插入截图  ② 自动目录  ③ 页眉页脚
```

## 核心设计决策

### 字体映射
- 中文正文: `宋体` → `w:eastAsia="宋体"`
- 英文正文: `Times New Roman` → `w:ascii`
- 标题: `黑体` → `w:eastAsia="黑体"`
- 代码: `Courier New`

### 三线表实现
通过 `w:tblBorders` XML 直接注入，仅保留 `top`(12磅)、`bottom`(12磅)、`insideH`(4磅) 三条线。

## 相关链接
- [[2026-04-14]] (执行日志)
- [[System-Architecture]]
- 论文源文件: `docs/todo/word/`
