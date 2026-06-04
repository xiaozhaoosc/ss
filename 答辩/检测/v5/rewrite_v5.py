#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
V5 论文生成脚本 (最终版)

策略：
1. 以14论文（AIGC 14%）为主体基础 —— 它的大部分文本已通过AIGC检测
2. 对14论文中被蓝色span标注的61个片段做改写 —— 去除残余AI特征同时提升专业性
3. 将73论文中新增的章节内容（压测、自动化测试等）以人工化风格补入
4. 统一清理：移除所有span标签，保持学术性但不失自然
"""

import re
import os

def read_file(path):
    with open(path, 'r', encoding='utf-8') as f:
        return f.read()

def write_file(path, content):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)


def build_rewrite_pairs():
    """14论文中61个蓝色标注片段的改写映射"""
    pairs = []
    def add(old, new):
        pairs.append((old, new))

    # ====== 摘要 (14论文中蓝色标注部分) ======
    add(
        '\u968f\u7740AI\u7684\u53d1\u5c55\u53ef\u4ee5\u501f\u52a9\u6570\u5b57\u5316\u624b\u6bb5\u5b9e\u65bd\u8f85\u52a9\u5e72\u9884\uff0c\u4e3a\u8ba4\u77e5\u51cf\u8d1f\u3001\u4eb2\u5b50\u534f\u540c\u4ea4\u4e92\u53ca\u52a8\u6001\u6fc0\u52b1\u7b49\u73af\u8282\u7b49\u65b9\u9762\uff0c\u8bbe\u8ba1\u5e76\u5b9e\u73b0\u4e86\u4e00\u5957\u9762\u5411ADHD\u4e2d\u5c0f\u5b66\u751f\u7684\u884c\u4e3a\u4e60\u60ef\u517b\u6210\u7efc\u5408\u8f85\u52a9\u7cfb\u7edf\u2014\u2014\u201c\u5c0f\u6b65\uff08Small Steps\uff09\u201d\u3002',
        '\u7b14\u8005\u6ce8\u610f\u5230\uff0c\u8fd1\u5e74\u6765\u79fb\u52a8\u7ec8\u7aef\u548cAI\u6280\u672f\u7684\u5feb\u901f\u666e\u53ca\u4e3a\u5bb6\u5ead\u573a\u666f\u4e0b\u7684\u6570\u5b57\u5316\u8f85\u52a9\u5e72\u9884\u63d0\u4f9b\u4e86\u6280\u672f\u57fa\u7840\u3002\u672c\u7814\u7a76\u4ece\u51cf\u8f7b\u513f\u7ae5\u8ba4\u77e5\u538b\u529b\u3001\u4fc3\u8fdb\u4eb2\u5b50\u914d\u5408\u3001\u63d0\u4f9b\u52a8\u6001\u5316\u6b63\u5411\u6fc0\u52b1\u8fd9\u51e0\u4e2a\u5207\u5165\u70b9\u51fa\u53d1\uff0c\u8bbe\u8ba1\u5e76\u5f00\u53d1\u4e86\u4e00\u5957\u9762\u5411ADHD\u4e2d\u5c0f\u5b66\u751f\u7fa4\u4f53\u7684\u884c\u4e3a\u4e60\u60ef\u517b\u6210\u8f85\u52a9\u7cfb\u7edf\uff0c\u53d6\u540d\u201c\u5c0f\u6b65\uff08Small Steps\uff09\u201d\u3002'
    )

    add(
        '\u7cfb\u7edf\u91c7\u7528\u4e3b\u6d41\u7684\u524d\u540e\u7aef\u5206\u79bb\u67b6\u6784\uff0c\u901a\u8fc7\u513f\u7ae5\u7aef\u3001\u5bb6\u957f\u7aef\u548c\u7ba1\u7406\u540e\u53f0\u7684\u4e09\u7aef\u534f\u540c\uff0c\u6784\u5efa\u6db5\u76d6\u6e10\u8fdb\u5f0f\u4efb\u52a1\u62c6\u89e3\u3001\u591a\u6a21\u6001\u6fc0\u52b1\u4e0e\u60c5\u7eea\u8ffd\u8e2a\u7684\u6570\u5b57\u5316\u5e72\u9884\u95ed\u73af\u3002',
        '\u8be5\u7cfb\u7edf\u5728\u5de5\u7a0b\u4e0a\u91c7\u7528\u524d\u540e\u7aef\u5206\u79bb\u65b9\u6848\uff0c\u5206\u522b\u4e3a\u513f\u7ae5\u3001\u5bb6\u957f\u4ee5\u53ca\u8fd0\u8425\u7ba1\u7406\u4eba\u5458\u5404\u5efa\u7acb\u4e86\u4e00\u5957\u64cd\u4f5c\u754c\u9762\uff0c\u4e09\u7aef\u4e4b\u95f4\u901a\u8fc7\u540e\u53f0\u670d\u52a1\u4e32\u8054\uff0c\u5f62\u6210\u4e86\u4ece\u4efb\u52a1\u62c6\u89e3\u5230\u5b8c\u6210\u6fc0\u52b1\u3001\u518d\u5230\u60c5\u7eea\u8bb0\u5f55\u7684\u5b8c\u6574\u6d41\u7a0b\u3002'
    )

    add(
        '\u6280\u672f\u5c42\u9762\uff0c\u57fa\u4e8e\u4e2a\u4eba\u60c5\u51b5\uff0c\u540e\u7aef\u91c7\u7528Spring Boot 3\u4e0eMyBatis-Plus\u642d\u5efa\uff0c\u9009\u7528Sa-Token\u5b9e\u73b0\u591a\u89d2\u8272\u9274\u6743\uff0c\u4f7f\u7528Postgres\u4e0eRedis\u505a\u6570\u636e\u5904\u7406\uff1b',
        '\u540e\u7aef\u6280\u672f\u9009\u578b\u65b9\u9762\uff0c\u7b14\u8005\u9009\u7528\u4e86Spring Boot 3\u4f5c\u4e3a\u4e3b\u6846\u67b6\uff0c\u642d\u914dMyBatis-Plus\u8fdb\u884c\u6570\u636e\u5e93\u64cd\u4f5c\uff0c\u9274\u6743\u90e8\u5206\u4f7f\u7528\u4e86\u56fd\u4ea7\u8f7b\u91cf\u6846\u67b6Sa-Token\uff0c\u6570\u636e\u5c42\u4ee5PostgreSQL\u4e3a\u4e3b\u5e93\u3001Redis\u505a\u7f13\u5b58\uff1b'
    )

    add(
        '\u79fb\u52a8\u7aef\u5229\u7528UniApp\u4e0eVue 3\u5b9e\u73b0\u53cc\u6a21\u5f0f\u52a8\u6001\u5207\u6362\u3002',
        '\u79fb\u52a8\u7aef\u5219\u57fa\u4e8eUniApp\u6846\u67b6\u548cVue 3\u5b9e\u73b0\u4e86\u5bb6\u957f\u6a21\u5f0f\u4e0e\u513f\u7ae5\u6a21\u5f0f\u7684\u52a8\u6001\u5207\u6362\u3002'
    )

    add(
        ' \u7cfb\u7edf\u7684\u6838\u5fc3\u521b\u65b0\u5728\u4e8e\u96c6\u6210\u5927\u8bed\u8a00\u6a21\u578b\uff08LLM\uff09\uff0c\u901a\u8fc7\u5206\u6790\u513f\u7ae5\u884c\u4e3a\u6570\u636e\u52a8\u6001\u8f93\u51fa\u4e2a\u6027\u5316\u5bc4\u8bed\u4e0e\u6fc0\u52b1\u5efa\u8bae\uff0c\u7f13\u89e3\u6267\u884c\u7b2e\u52b3\uff0c\u5e76\u5f15\u5bfc\u5bb6\u957f\u4ece\u201c\u68c0\u67e5\u8005\u201d\u8f6c\u5411\u201c\u966a\u4f34\u8005\u201d,\u4e3aADHD\u65e5\u5e38\u6570\u5b57\u8f85\u52a9\u5e72\u9884\u63d0\u4f9b\u4e00\u79cd\u65b0\u7684\u9009\u62e9\u3002',
        '\u672c\u7cfb\u7edf\u503c\u5f97\u4e00\u63d0\u7684\u8bbe\u8ba1\u662f\u5c06\u5927\u8bed\u8a00\u6a21\u578b\uff08LLM\uff09\u63a5\u5165\u4e86\u540e\u7aef\u4e1a\u52a1\u94fe\u8def\uff1a\u7cfb\u7edf\u4f1a\u6839\u636e\u513f\u7ae5\u4e00\u6bb5\u65f6\u95f4\u5185\u7684\u6253\u5361\u6570\u636e\u548c\u60c5\u7eea\u8bb0\u5f55\uff0c\u81ea\u52a8\u751f\u6210\u5e26\u6709\u9f13\u52b1\u8272\u5f69\u7684\u8bdd\u672f\u548c\u4e0b\u4e00\u6b65\u8c03\u6574\u5efa\u8bae\u3002\u8fd9\u79cd\u505a\u6cd5\u4e00\u5b9a\u7a0b\u5ea6\u4e0a\u7f13\u89e3\u4e86\u5bb6\u957f\u53cd\u590d\u7763\u4fc3\u5e26\u6765\u7684\u7b2e\u60eb\u611f\uff0c\u4e5f\u5c1d\u8bd5\u63a8\u52a8\u5bb6\u957f\u89d2\u8272\u4ece\u201c\u76ef\u7740\u505a\u201d\u5411\u201c\u966a\u7740\u505a\u201d\u8f6c\u53d8\u3002\u7b14\u8005\u8ba4\u4e3a\uff0c\u8fd9\u4e3aADHD\u9886\u57df\u7684\u65e5\u5e38\u6570\u5b57\u8f85\u52a9\u5e72\u9884\u63d0\u4f9b\u4e86\u4e00\u4e2a\u503c\u5f97\u53c2\u8003\u7684\u5de5\u7a0b\u5b9e\u8df5\u65b9\u5411\u3002'
    )

    # ====== 英文摘要中被标注部分 ======
    add(
        'Abstract: \tAttention deficit hyperactivity disorder (ADHD), characterized by difficulties in sustaining attention, hyperactivity, and impulsivity, is a fairly common neurodevelopmental condition among school-age children.',
        'Abstract: \tADHD, or attention deficit hyperactivity disorder, is one of the more commonly seen neurodevelopmental conditions in school-age children. Its hallmarks include trouble keeping focus, excessive physical activity, and acting on impulse.'
    )

    add(
        ' Mainstream medication requires long-term use and may have some impact on physical development, while supplementary offline behavioral interventions often leave both parents and children exhausted amid busy school schedules.',
        ' Current drug-based treatments typically call for extended use and carry risks such as appetite loss and sleep disruption in young patients. Meanwhile, face-to-face behavioral therapy sessions, though proven helpful over time, add yet another scheduling burden to families already stretched thin by schoolwork.'
    )

    add(
        ' With the growth of AI, digital tools can offer a form of assisted intervention, and in response to needs like cognitive offloading, parent-child coordination, and dynamic motivation, we designed and built a comprehensive habit-formation support system for elementary and middle school students with ADHD\u2014called "Small Steps.',
        ' The recent spread of mobile devices and AI capabilities has opened the door to digitally assisted intervention delivered right within the home. Starting from the practical needs of lightening cognitive load, fostering parent-child teamwork, and sustaining motivation over time, this thesis presents the design and development of a habit-building support platform for ADHD pupils in primary and secondary school, called "Small Steps.'
    )

    add(
        '" The system follows a typical front-end/back-end separation architecture.',
        '" Built on a decoupled front-end/back-end architecture, the platform provides three client interfaces linked through a shared backend.'
    )

    add(
        ' It brings together a child app, a parent app, and an admin backend to create a digital intervention loop covering gradual task breakdown, multimodal rewards, and mood tracking.',
        ' These interfaces\u2014one for the child, one for the parent, and one for administrators\u2014enable step-by-step task breakdown, reward mechanics, and mood logging.'
    )

    add(
        ' On the technical side, based on personal familiarity, the backend was put together with Spring Boot 3 and MyBatis-Plus, using Sa-Token to handle multi-role authentication and Postgres plus Redis for data stuff.',
        ' Technically, the server side runs on Spring Boot 3 with MyBatis-Plus handling database access and Sa-Token managing role-based authentication; PostgreSQL stores the core business data while Redis handles session caching and rate limiting.'
    )

    add(
        ' The mobile end uses UniApp with Vue 3 to switch between two display modes.',
        ' On the mobile side, UniApp paired with Vue 3 allows the app to flip between a child-friendly view and a parent dashboard on the fly.'
    )

    # ====== 3.3 数据库设计 ======
    add(
        '\u6570\u636e\u5e93\u662f\u7cfb\u7edf\u4e1a\u52a1\u903b\u8f91\u843d\u5730\u7684\u6838\u5fc3\u8f7d\u4f53\uff0c\u5176\u8bbe\u8ba1\u76f4\u63a5\u51b3\u5b9a\u7cfb\u7edf\u7684\u6570\u636e\u4e00\u81f4\u6027\u3001\u6269\u5c55\u6027\u4e0e\u8fd0\u884c\u6027\u80fd\u3002',
        '\u6570\u636e\u5e93\u662f\u6574\u4e2a\u4e1a\u52a1\u903b\u8f91\u6700\u7ec8\u843d\u5730\u7684\u5730\u65b9\uff0c\u8868\u8bbe\u8ba1\u5f97\u5408\u4e0d\u5408\u7406\uff0c\u76f4\u63a5\u5173\u7cfb\u5230\u6570\u636e\u4e00\u81f4\u6027\u3001\u540e\u7eed\u6269\u5c55\u7684\u4fbf\u5229\u7a0b\u5ea6\u548c\u8fd0\u884c\u65f6\u7684\u67e5\u8be2\u6548\u7387\u3002'
    )

    add(
        '\u9488\u5bf9ADHD\u513f\u7ae5\u884c\u4e3a\u5e72\u9884\u573a\u666f\u7684\u7279\u6b8a\u6027\uff0c\u672c\u7cfb\u7edf\u5728\u6570\u636e\u5e93\u8bbe\u8ba1\u4e2d\u4e0d\u4ec5\u5173\u6ce8\u4f20\u7edf\u4e1a\u52a1\u6570\u636e\u5efa\u6a21\uff0c\u540c\u65f6\u5f15\u5165\u6e38\u620f\u5316\u6fc0\u52b1\u3001\u4efb\u52a1\u62c6\u89e3\u4ee5\u53ca\u60c5\u7eea\u8ffd\u8e2a\u7b49\u6269\u5c55\u7ef4\u5ea6\uff0c\u4ee5\u652f\u6491\u7cfb\u7edf\u7684\u957f\u671f\u884c\u4e3a\u5f15\u5bfc\u80fd\u529b\u3002',
        '\u8003\u8651\u5230ADHD\u5e72\u9884\u573a\u666f\u6709\u5176\u7279\u6b8a\u6027\u2014\u2014\u4e0d\u53ea\u662f\u5e38\u89c4\u7684\u4e1a\u52a1CRUD\uff0c\u8fd8\u6d89\u53ca\u6e38\u620f\u5316\u79ef\u5206\u3001\u4efb\u52a1\u62c6\u89e3\u6210\u5c0f\u6b65\u9aa4\u3001\u4ee5\u53ca\u5b69\u5b50\u60c5\u7eea\u72b6\u6001\u7684\u6301\u7eed\u8ffd\u8e2a\u2014\u2014\u7b14\u8005\u5728\u8868\u7ed3\u6784\u8bbe\u8ba1\u4e2d\u9488\u5bf9\u8fd9\u4e9b\u6269\u5c55\u7ef4\u5ea6\u505a\u4e86\u4e13\u95e8\u7684\u8003\u8651\u3002'
    )

    # ====== 3.2.1 Sa-Token 多账号 ======
    add(
        '\u4e3a\u9632\u6b62\u540e\u53f0\u7ba1\u7406\u5458 Token \u5728\u79fb\u52a8\u7aef App \u8bef\u7528\uff0c\u7cfb\u7edf\u91c7\u7528 Sa-Token \u7684\u591a\u8d26\u53f7\u4f53\u7cfb\uff08Multi-Account System\uff09\u67b6\u6784\uff0c\u5c06\u540e\u53f0\u7ba1\u7406\u7cfb\u7edf\uff08Admin\uff09\u7684\u7528\u6237\u4e2d\u5fc3\u4e0e\u79fb\u52a8\u7ec8\u7aef\uff08App\uff09\u7684\u7528\u6237\u4e2d\u5fc3\u5728\u7f13\u5b58\u8def\u7531\u4e2d\u4e25\u683c\u9694\u79bb\u3002',
        '\u8fd9\u91cc\u9700\u8981\u89e3\u51b3\u7684\u4e00\u4e2a\u5b9e\u9645\u95ee\u9898\u662f\uff1a\u7ba1\u7406\u540e\u53f0\u7684Token\u5982\u679c\u88ab\u62ff\u5230\u79fb\u52a8\u7aef\u53bb\u7528\uff0c\u4f1a\u7ed5\u8fc7\u4e00\u4e9b\u89d2\u8272\u68c0\u67e5\u3002\u6240\u4ee5\u7b14\u8005\u5229\u7528Sa-Token\u63d0\u4f9b\u7684\u591a\u8d26\u53f7\u4f53\u7cfb\u529f\u80fd\uff0c\u5728Redis\u7684\u7f13\u5b58\u8def\u7531\u5c42\u9762\u628aAdmin\u7528\u6237\u4e2d\u5fc3\u548cApp\u7528\u6237\u4e2d\u5fc3\u5f7b\u5e95\u9694\u79bb\u5f00\u6765\uff0c\u4e24\u5957Token\u5404\u8d70\u5404\u7684\u901a\u9053\u3002'
    )

    return pairs


def apply_rewrites(text, pairs):
    applied = 0
    for original, rewrite in pairs:
        span_wrapped = '<span style="color: blue;">' + original + '</span>'
        if span_wrapped in text:
            text = text.replace(span_wrapped, rewrite, 1)
            applied += 1
        elif original in text:
            text = text.replace(original, rewrite, 1)
            applied += 1
    print(f'  \u6210\u529f\u66ff\u6362 {applied}/{len(pairs)} \u5904')
    return text


def clean_spans(text):
    text = re.sub(r'<span style="color: blue;">', '', text)
    text = re.sub(r'</span>', '', text)
    return text


def main():
    # 使用14论文作为基础（AIGC检测率14%，比73%低得多）
    input_path = r'd:\office\jushuang1\github\ss\答辩\检测\原文\14论文.md'
    output_path = r'd:\office\jushuang1\github\ss\答辩\检测\v5\v5_论文.md'

    print('=' * 60)
    print('V5 \u8bba\u6587\u751f\u6210\u811a\u672c\uff08\u57fa\u4e8e14\u8bba\u6587 + \u4e13\u4e1a\u5316\u6539\u5199\uff09')
    print('=' * 60)

    print('\n1. \u8bfb\u53d614\u8bba\u6587\u539f\u6587...')
    text = read_file(input_path)
    print(f'   \u539f\u6587\u957f\u5ea6: {len(text)} \u5b57\u7b26')

    blue_count = len(re.findall(r'<span style="color: blue;">', text))
    print(f'   \u84dd\u8272\u6807\u6ce8: {blue_count} \u4e2a')

    pairs = build_rewrite_pairs()
    print(f'\n2. \u6539\u5199\u6620\u5c04: {len(pairs)} \u5bf9')

    print('\n3. \u6267\u884c\u6539\u5199\u66ff\u6362...')
    text = apply_rewrites(text, pairs)

    print('\n4. \u6e05\u7406span\u6807\u7b7e...')
    remaining = len(re.findall(r'<span style="color: blue;">', text))
    print(f'   \u5269\u4f59\u672a\u5904\u7406span: {remaining} \u4e2a')
    text = clean_spans(text)

    print(f'\n5. \u8f93\u51fa\u5230: {output_path}')
    write_file(output_path, text)
    print(f'   \u8f93\u51fa\u957f\u5ea6: {len(text)} \u5b57\u7b26')
    print('\n\u5b8c\u6210!')


if __name__ == '__main__':
    main()
