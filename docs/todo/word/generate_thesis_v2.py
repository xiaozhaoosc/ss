# -*- coding: utf-8 -*-
"""
生成 v2 版本论文 Word 文档
严格按照上海应用技术大学高等学历继续教育格式规定
"""

from docx import Document
from docx.shared import Pt, Cm, Inches, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH, WD_LINE_SPACING
from docx.oxml.ns import qn, nsdecls
from docx.oxml import parse_xml

FONT_SONGTI = '宋体'
FONT_HEITI = '黑体'
FONT_TIMES = 'Times New Roman'

def set_run_font(run, cn_font=FONT_SONGTI, en_font=FONT_TIMES, size=Pt(12), bold=False, italic=False, color=None):
    run.font.size = size
    run.font.bold = bold
    run.font.italic = italic
    if color:
        run.font.color.rgb = color
    run.font.name = en_font
    rpr = run._element.get_or_add_rPr()
    rFonts = rpr.find(qn('w:rFonts'))
    if rFonts is None:
        rFonts = parse_xml(f'<w:rFonts {nsdecls("w")} w:eastAsia="{cn_font}"/>')
        rpr.insert(0, rFonts)
    else:
        rFonts.set(qn('w:eastAsia'), cn_font)

def set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.JUSTIFY, line_spacing=1.5,
                         first_line_indent=None, space_before=Pt(0), space_after=Pt(0),
                         keep_together=False, keep_with_next=False):
    fmt = para.paragraph_format
    fmt.alignment = alignment
    fmt.line_spacing = line_spacing
    fmt.line_spacing_rule = WD_LINE_SPACING.MULTIPLE
    fmt.space_before = space_before
    fmt.space_after = space_after
    if first_line_indent is not None:
        fmt.first_line_indent = first_line_indent
    fmt.keep_together = keep_together
    fmt.keep_with_next = keep_with_next

def add_heading_1(doc, text):
    para = doc.add_paragraph()
    set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.CENTER, space_before=Pt(24), space_after=Pt(12), keep_with_next=True)
    run = para.add_run(text)
    set_run_font(run, cn_font=FONT_HEITI, size=Pt(16), bold=True)
    return para

def add_heading_2(doc, text):
    para = doc.add_paragraph()
    set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.LEFT, space_before=Pt(18), space_after=Pt(6), keep_with_next=True)
    run = para.add_run(text)
    set_run_font(run, cn_font=FONT_HEITI, size=Pt(14), bold=True)
    return para

def add_heading_3(doc, text):
    para = doc.add_paragraph()
    set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.LEFT, space_before=Pt(12), space_after=Pt(6), keep_with_next=True)
    run = para.add_run(text)
    set_run_font(run, cn_font=FONT_HEITI, size=Pt(12), bold=True)
    return para

def add_body(doc, text, indent=True):
    para = doc.add_paragraph()
    fi = Cm(0.74) if indent else None
    set_paragraph_format(para, first_line_indent=fi)
    run = para.add_run(text)
    set_run_font(run, size=Pt(12))
    return para

def add_code(doc, text):
    para = doc.add_paragraph()
    set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.LEFT, first_line_indent=Cm(0), space_before=Pt(6), space_after=Pt(6))
    run = para.add_run(text)
    set_run_font(run, cn_font='Courier New', en_font='Courier New', size=Pt(9))
    return para

def add_caption(doc, text):
    para = doc.add_paragraph()
    set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.CENTER, space_before=Pt(6), space_after=Pt(6))
    run = para.add_run(text)
    set_run_font(run, size=Pt(10.5))
    return para

def add_ref(doc, text):
    para = doc.add_paragraph()
    set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.LEFT, first_line_indent=Cm(0), space_before=Pt(0), space_after=Pt(2))
    run = para.add_run(text)
    set_run_font(run, size=Pt(10.5))
    return para

def add_table_data(doc, caption, headers, rows):
    add_caption(doc, caption)
    table = doc.add_table(rows=1 + len(rows), cols=len(headers))
    table.alignment = WD_ALIGN_PARAGRAPH.CENTER
    for i, h in enumerate(headers):
        cell = table.rows[0].cells[i]
        cell.text = ''
        p = cell.paragraphs[0]
        p.alignment = WD_ALIGN_PARAGRAPH.CENTER
        run = p.add_run(h)
        set_run_font(run, size=Pt(10.5), bold=True)
    for r_idx, row_data in enumerate(rows):
        for c_idx, val in enumerate(row_data):
            cell = table.rows[r_idx + 1].cells[c_idx]
            cell.text = ''
            p = cell.paragraphs[0]
            p.alignment = WD_ALIGN_PARAGRAPH.CENTER
            run = p.add_run(str(val))
            set_run_font(run, size=Pt(10.5))
    tbl = table._tbl
    tblPr = tbl.tblPr if tbl.tblPr is not None else parse_xml(f'<w:tblPr {nsdecls("w")}/>')
    borders = parse_xml(
        f'<w:tblBorders {nsdecls("w")}>'
        f'  <w:top w:val="single" w:sz="12" w:space="0" w:color="000000"/>'
        f'  <w:bottom w:val="single" w:sz="12" w:space="0" w:color="000000"/>'
        f'  <w:insideH w:val="single" w:sz="4" w:space="0" w:color="000000"/>'
        f'  <w:left w:val="none" w:sz="0" w:space="0" w:color="auto"/>'
        f'  <w:right w:val="none" w:sz="0" w:space="0" w:color="auto"/>'
        f'  <w:insideV w:val="none" w:sz="0" w:space="0" w:color="auto"/>'
        f'</w:tblBorders>')
    tblPr.append(borders)
    return table

def blank(doc):
    para = doc.add_paragraph()
    set_paragraph_format(para)

def build():
    doc = Document()
    section = doc.sections[0]
    section.page_width = Cm(21)
    section.page_height = Cm(29.7)
    section.top_margin = Cm(2.54)
    section.bottom_margin = Cm(2.54)
    section.left_margin = Cm(3.17)
    section.right_margin = Cm(3.17)

    # ===== 封面 =====
    para = doc.add_paragraph()
    set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.CENTER, space_before=Pt(72))
    run = para.add_run('上海应用技术大学')
    set_run_font(run, cn_font=FONT_HEITI, size=Pt(26), bold=True)

    para = doc.add_paragraph()
    set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.CENTER, space_after=Pt(12))
    run = para.add_run('SHANGHAI INSTITUTE OF TECHNOLOGY')
    set_run_font(run, cn_font=FONT_TIMES, en_font=FONT_TIMES, size=Pt(14))

    blank(doc)

    para = doc.add_paragraph()
    set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.CENTER)
    run = para.add_run('高等学历继续教育')
    set_run_font(run, cn_font=FONT_HEITI, size=Pt(22), bold=True)

    para = doc.add_paragraph()
    set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.CENTER, space_after=Pt(36))
    run = para.add_run('本科毕业设计（论文）')
    set_run_font(run, cn_font=FONT_HEITI, size=Pt(22), bold=True)

    blank(doc)

    for label, value in [
        ('课题名称：', 'ADHD中小学生（儿童）行为习惯辅助系统设计与实现'),
        ('专    业：', '计算机科学与技术'),
        ('班    级：', '2410420'),
        ('学生学号：', '241042025'),
        ('学生姓名：', '赵轩'),
        ('指导教师：', '薛庆水'),
    ]:
        para = doc.add_paragraph()
        set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.CENTER, space_before=Pt(6), space_after=Pt(6))
        r1 = para.add_run(label)
        set_run_font(r1, size=Pt(16))
        r2 = para.add_run(value)
        set_run_font(r2, size=Pt(16))

    blank(doc)
    blank(doc)
    para = doc.add_paragraph()
    set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.CENTER)
    run = para.add_run('2026年4月8日')
    set_run_font(run, size=Pt(16))

    # ===== 中文摘要 =====
    doc.add_page_break()
    para = doc.add_paragraph()
    set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.CENTER, space_after=Pt(12))
    run = para.add_run('ADHD中小学生（儿童）行为习惯辅助系统设计与实现')
    set_run_font(run, cn_font=FONT_HEITI, size=Pt(16), bold=True)

    para = doc.add_paragraph()
    set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.CENTER, space_before=Pt(12), space_after=Pt(12))
    run = para.add_run('摘  要')
    set_run_font(run, cn_font=FONT_HEITI, size=Pt(16), bold=True)

    # v2 摘要段落
    abs_paragraphs = [
        '注意缺陷多动障碍（Attention Deficit Hyperactivity Disorder, ADHD）是学龄期儿童群体中高发的神经发育障碍类型，其典型临床表征涵盖注意力维持困难、活动量过度以及行为冲动控制不足三个核心维度。受上述症状影响，患儿在学业进展、同伴社交及日常行为规范方面均面临不同程度的适应性困难。既有的干预路径以药物治疗与人工行为矫正为主，但前者伴随显著的生理副作用，后者受制于专业康复资源的稀缺性和家庭执行的可持续性瓶颈。伴随移动互联网与人工智能技术的深度渗透，数字化辅助干预已成为ADHD康复研究领域的前沿方向。然而，现有数字辅助工具普遍存在功能设计泛化的局限：多数系统停留在基础日程管理层面，缺乏针对ADHD患儿认知加工模式的定制化交互方案，在亲子协同干预、动态化激励策略以及行为数据闭环反馈等关键环节上仍有明显不足。',
        '针对上述现实困境，本课题采用软件工程方法论，设计并实现了一套聚焦于ADHD中小学生行为习惯养成的多端协同辅助系统——"小步（Small Steps）"。系统整体采用前后端分离的分层架构，通过三个独立子系统的协同运作——儿童与家长共用的移动端应用（smallsteps-app）、面向平台运营的Web管理后台（smallsteps-ui）、以及承载核心业务逻辑的后端服务（smallsteps-api），构建了一个覆盖渐进式任务拆解、多维度激励反馈、专注力训练以及家庭协同管理的完整数字干预闭环。',
        '在后端架构设计层面，核心服务基于Spring Boot 3.5.9框架与JDK 21运行环境构建。数据持久层集成MyBatis-Plus 3.5.14增强型ORM框架，实现了高效的实体映射与复杂条件查询封装；安全与权限管理层面引入轻量级开源框架Sa-Token 1.44.0，设计了面向管理员、家长、儿童三种差异化角色的细粒度鉴权体系；此外，系统集成Redisson分布式锁组件与Lock4j并发控制框架，以保障高并发场景下的数据一致性与业务原子性。数据库采用PostgreSQL 15进行关系型数据持久化，配合Redis提供会话缓存与高频读写的性能支撑。',
        '在前端设计与实现层面，移动端应用基于UniApp 3.0跨平台框架开发，深度整合Vue 3.5的Composition API编程范式与Pinia 2.x全局状态管理机制，创造性地实现了家长模式与儿童模式在同一应用内的无缝身份切换与差异化视图呈现。UI样式层采用TailwindCSS 3.4原子化CSS方案，满足ADHD儿童界面对高对比度色彩与低认知负荷布局的特殊设计要求。Web管理后台基于Vue 3.5与Element Plus 2.11组件库构建，集成ECharts 5.6数据可视化引擎与VXE-Table高性能表格组件，提供了涵盖用户管理、任务配置、行为数据看板及系统运维监控的全功能图形化管理界面。',
        '系统的设计创新集中体现在两个维度：其一，将生成式大语言模型（LLM）的智能分析能力以旁路服务的形式嵌入后端业务流程，通过定时任务调度机制聚合儿童的多日行为数据，动态生成个性化的"每日寄语"与家长辅导话术建议，有效缓解了重复打卡带来的动机衰减；其二，在交互设计层面系统性地融入认知负荷理论与渐进式辅助理念，通过多模态数据可视化与家庭成员间的角色互动机制，引导家长从传统的"检查者"角色向"陪伴观察者"转型。',
        '经过多轮功能测试与交互可用性验证，系统各业务模块运行稳定，前后端数据交互高效，页面渲染响应流畅，整体满足设计阶段制定的性能基准与业务需求指标。本课题的研发实践不仅为ADHD儿童的日常行为干预提供了一种可落地的轻量化数字工具，也为基于现代前端工程体系与智能后端架构的数字疗法类产品输出了一套具有参考价值的系统设计范式。',
    ]
    for t in abs_paragraphs:
        add_body(doc, t)

    para = doc.add_paragraph()
    set_paragraph_format(para, first_line_indent=Cm(0.74))
    r1 = para.add_run('关键词：')
    set_run_font(r1, cn_font=FONT_HEITI, size=Pt(12), bold=True)
    r2 = para.add_run('注意力缺陷多动障碍；行为干预系统设计；前后端分离架构；Spring Boot 3；UniApp；Vue 3')
    set_run_font(r2, size=Pt(12))

    # ===== 英文摘要 =====
    doc.add_page_break()
    para = doc.add_paragraph()
    set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.CENTER, space_after=Pt(12))
    run = para.add_run('Design and Implementation of ADHD Behavior Support System for Children')
    set_run_font(run, cn_font=FONT_TIMES, en_font=FONT_TIMES, size=Pt(16), bold=True)

    para = doc.add_paragraph()
    set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.CENTER, space_before=Pt(12), space_after=Pt(12))
    run = para.add_run('Abstract')
    set_run_font(run, cn_font=FONT_TIMES, en_font=FONT_TIMES, size=Pt(16), bold=True)

    en_abs = [
        'Attention Deficit Hyperactivity Disorder (ADHD) ranks among the most prevalent neurodevelopmental conditions affecting school-aged children, manifesting through core symptom clusters of sustained inattention, excessive motor activity, and impulsive behavioral regulation deficits. These symptomatic presentations impose substantial adaptive challenges on affected children across academic performance, peer socialization, and adherence to daily behavioral routines.',
        'To address these multifaceted challenges, this research project employs software engineering methodology to design and implement "Small Steps" — a multi-terminal collaborative assistance system specifically targeting behavioral habit cultivation in primary and secondary school students with ADHD. The system adopts a decoupled front-end/back-end layered architecture, operating through three independent yet coordinated subsystems.',
        'At the backend architectural level, the core service infrastructure is constructed upon the Spring Boot 3.5.9 framework operating on JDK 21 runtime. The data persistence layer integrates MyBatis-Plus 3.5.14 enhanced ORM framework, while the security and authorization layer employs the lightweight Sa-Token 1.44.0 framework to implement fine-grained role-based access control across administrator, parent, and child user categories.',
        'The system\'s design innovation is embodied in two principal dimensions: first, the integration of generative Large Language Model (LLM) analytical capabilities as a sidecar service within backend business workflows; second, the systematic incorporation of Cognitive Load Theory and Scaffolding & Fading pedagogical principles into the interaction design layer.',
        'Through multiple rounds of functional testing and interaction usability validation, all system business modules demonstrate stable operation with efficient front-end/back-end data exchange and responsive page rendering performance, meeting the design-phase performance benchmarks and business requirement specifications.',
    ]
    for t in en_abs:
        add_body(doc, t)

    para = doc.add_paragraph()
    set_paragraph_format(para, first_line_indent=Cm(0.74))
    r1 = para.add_run('Keywords: ')
    set_run_font(r1, cn_font=FONT_TIMES, en_font=FONT_TIMES, size=Pt(12), bold=True)
    r2 = para.add_run('ADHD; Behavioral Intervention System Design; Decoupled Architecture; Spring Boot 3; UniApp; Vue 3')
    set_run_font(r2, cn_font=FONT_TIMES, en_font=FONT_TIMES, size=Pt(12))

    # ===== 目录占位 =====
    doc.add_page_break()
    para = doc.add_paragraph()
    set_paragraph_format(para, alignment=WD_ALIGN_PARAGRAPH.CENTER, space_after=Pt(24))
    run = para.add_run('目  录')
    set_run_font(run, cn_font=FONT_HEITI, size=Pt(16), bold=True)
    add_body(doc, '（请在Word中使用"引用→目录"功能自动生成目录）', indent=False)

    # ===== 第1章 绪论 =====
    doc.add_page_break()
    add_heading_1(doc, '1 绪论')
    add_body(doc, '注意力缺陷多动障碍（ADHD）作为儿童发育阶段最为普遍的一类神经行为异常，其核心特征体现为持续性的注意力分配困难、过量的躯体运动以及难以抑制的行为冲动。处于义务教育阶段的患儿因上述症状的交互作用，在学业投入效率、日常生活自理技能培养及家庭亲子关系维护等方面均承受着超出同龄人的适应压力。传统干预体系以药物介入和线下行为训练为两大支柱，但药物副作用、康复资源地域分布失衡以及家庭执行方案难以标准化等结构性问题始终制约着干预效果的可持续性。在此背景下，融合移动计算平台与智能算法的数字化辅助干预（Digital Therapeutics, DTx）逐渐崛起为ADHD研究领域的新范式。然而，当前市面上的辅助应用大多停留在通用型效率工具的层面，缺少面向ADHD患儿独特认知加工模式的深度定制，且在家庭系统层面的协同设计上存在明显短板。本课题正是针对这一现存缺口，从系统设计与工程实现的双重视角出发，提出并落地了一套多端联动的行为习惯养成辅助系统。')

    add_heading_2(doc, '1.1 研究背景')
    add_body(doc, '注意缺陷多动障碍（Attention Deficit Hyperactivity Disorder，简称ADHD），是儿童及青少年时期发病率最高的慢性神经发育类障碍之一。全球流行病学统计数据显示，学龄儿童中ADHD的患病率介于5%至7%之间，部分地区因筛查标准及诊断体系差异，报告的比例更为突出。该障碍的核心临床特征表现为三组与年龄发育水平不相称的行为症候群：注意力持续维持显著困难、运动活动量远超正常水平（即多动），以及行为决策前缺乏充分的后果评估（即冲动）。需要特别指出的是，ADHD并不直接损害患儿的智力功能，但它对执行功能（Executive Function）系统——包含工作记忆容量、情绪调节机制、内在动机激发以及计划组织协调能力——造成了弥散性的功能削弱，由此在日常生活层面引发连锁的适应性障碍。')
    add_body(doc, '在学校教育情境中，ADHD患儿频繁表现出难以维持课堂坐姿、注意力被无关环境刺激轻易牵引等典型行为；在家庭作业环节，严重的任务启动困难与拖延行为构成了家长每日面临的核心痛点，且作业的差错率显著高于同龄群体。在同伴社交维度，由于冲动行为控制能力薄弱，患儿容易在不恰当的社交时机打断他人谈话或产生肢体冲突，导致其在同伴关系网络中遭遇排斥与边缘化。长期持续的受挫体验极易使ADHD患儿衍生出自卑感、焦虑情绪乃至抑郁倾向等继发性心理健康问题。因此，如何借助技术手段为ADHD儿童提供有效的日常行为结构化支持，降低其认知加工负荷，辅助其逐步建立规律化的生活与学习节律，已成为一个兼具社会意义与技术挑战性的议题。')

    add_heading_2(doc, '1.2 数字化行为辅助工具的应用价值与研究目的')
    add_body(doc, '在既有的ADHD临床干预体系中，药物治疗路径虽能在短期内改善核心症状，但其在儿童群体中广泛应用所附带的食欲减退、睡眠节律紊乱、生长发育潜在抑制等副作用风险，持续引发医学界与家长群体的审慎关注。非药物的行为干预技术路线尽管被循证医学体系认定为长期有效的核心干预手段之一，但其实施门槛极高：一方面要求具备专业资质的临床心理工作者全程督导，另一方面高度依赖家长在日常家庭环境中长期保持高度一致、情绪稳定且科学规范的执行质量。')
    add_body(doc, '正是在上述干预困境的推动下，数字化行为辅助工具展现出独特的应用价值。智能手机端应用程序天然具备全时段待命、客观无情绪波动干扰、行为数据自动精准记录等特性。将其引入ADHD家庭干预场景，能够承担起"第三方缓冲介质"的结构性角色。基于上述分析，本课题的核心研究目的在于：设计并实现一套专门面向ADHD中小学生群体的、多端协同的、兼具工程可落地性与心理学理论支撑的行为习惯数字辅助系统。')

    add_heading_2(doc, '1.3 面向ADHD儿童的技术干预需求缺口分析')
    add_body(doc, '尽管移动应用市场上已大量涌现标榜"时间管理"、"日程规划"、"番茄工作法"等功能卖点的效率类应用产品，但当这些面向普通用户群体设计的通用工具被应用于具有特殊脑神经基础的ADHD患儿时，普遍出现多维度的适配失效：')
    add_body(doc, '（1）界面认知负荷过高：通用型效率应用的界面设计通常追求功能齐全，导致信息架构层级深、视觉元素堆叠密集。')
    add_body(doc, '（2）缺乏面向"执行功能障碍"的细粒度任务拆解引导：ADHD患儿的任务启动困难往往根源于他们将一个宏大目标感知为一个不可分解的整体巨石。')
    add_body(doc, '（3）激励反馈机制僵化且以负向关注为主：大多数工具采用冰冷的数据汇总进行反馈，极易激活ADHD患儿本已脆弱的挫折感与习得性无助心理。')
    add_body(doc, '（4）缺少家庭系统层面的协同设计：现有工具几乎将全部设计焦点压在执行端（儿童），完全忽视了对家长的心理赋能与角色引导。')
    add_body(doc, '综合以上缺口分析，当前市场亟需一款真正深入理解ADHD儿童认知行为模式、以降低认知负荷与情感陪伴为核心设计理念、并能在家庭系统层面实现双端协同联动的专业化辅助系统。')

    add_heading_2(doc, '1.4 国内外研究现状与发展趋势')
    add_heading_3(doc, '1.4.1 传统行为干预与认知疗法的局限性')
    add_body(doc, '自二十世纪中后期以来，认知行为疗法（CBT）及各类亲职教育训练计划在ADHD症状改善方面积累了坚实的循证基础。然而，这些方法面临着从受控临床环境向自然家庭情境进行行为泛化时的系统性衰减难题。')

    add_heading_3(doc, '1.4.2 数字疗法在ADHD干预中的探索与发展')
    add_body(doc, '近几年，国际医疗技术领域对数字疗法在神经精神类疾病中的应用开展了深入探索。2020年，美国FDA正式批准了全球首款针对ADHD的处方级数字干预产品EndeavorRx。在国内，面向ADHD群体的数字辅助产品开发尚处于起步阶段与快速探索期的交汇点。')

    add_heading_3(doc, '1.4.3 现有研究不足与本系统的设计突破点')
    add_body(doc, '本课题设计的"小步（Small Steps）"系统核心设计突破体现在三个层面：尊严优先的人本化交互设计理念、融入LLM智能分析的渐进式辅助策略、以及采用现代化全栈工程架构的前瞻性技术选型。')

    add_heading_2(doc, '1.5 主要研究内容与目标')
    add_body(doc, '本课题围绕ADHD中小学生在日常生活与学业场景中面临的实际行为管理困难，运用现代软件工程方法论与前后端分离架构体系，详细论述了一套涵盖移动端（儿童+家长共用）与Web管理后台的"多角色业务闭环"辅助系统的完整研发过程。')

    # ===== 第2章 =====
    doc.add_page_break()
    add_heading_1(doc, '2 系统分析')
    add_body(doc, '在进入详细设计阶段之前，本章从技术可行性论证、功能性需求提取与非功能性质量属性规约三个维度对系统进行全面分析。')

    add_heading_2(doc, '2.1 技术可行性分析与技术选型')
    add_heading_3(doc, '2.1.1 后端核心框架选型 (Spring Boot 3 + MyBatis-Plus)')
    add_body(doc, '系统后端核心服务选用Spring Boot 3.5.9作为基础框架。在数据持久化层面，系统集成了MyBatis-Plus 3.5.14增强型ORM框架。')

    add_heading_3(doc, '2.1.2 移动端CSS框架选型 (TailwindCSS)')
    add_body(doc, '面向移动端的UI样式构建引入了TailwindCSS 3.4原子化CSS框架，采用Utility-First设计范式。')

    add_heading_3(doc, '2.1.3 安全认证框架选型 (Sa-Token)')
    add_body(doc, '系统最终选用了国内开源的高性能轻量级权限认证框架Sa-Token 1.44.0。其核心工程优势在于API设计高度贴合开发者直觉。')

    add_heading_3(doc, '2.1.4 心理学与教育学理论基础')
    add_body(doc, '（1）认知负荷理论（CLT）：在"小步"系统的前端设计中，全面贯彻了"认知卸载"的设计哲学。')
    add_body(doc, '（2）渐进式辅助理论与正向反馈循环机制：源自维果茨基关于"最近发展区"的经典论述。')
    add_body(doc, '（3）系统家庭动力学与家长角色重塑：通过将系统定位为亲子之间的"缓冲介质"，重构家庭动力学结构。')

    add_heading_3(doc, '2.1.5 操作可行性评估')
    add_body(doc, '系统面向ADHD儿童群体设计的交互逻辑严格遵循"零学习成本"原则。')

    add_heading_2(doc, '2.2 系统需求分析')
    add_heading_3(doc, '2.2.1 目标用户群体画像分析')
    add_body(doc, '本系统的核心服务对象构成一个典型的"双核用户架构"：即行为干预的直接接收方（ADHD儿童）与干预实施的辅助管理方（家长或监护人）。')

    add_heading_3(doc, '2.2.2 系统功能性需求')
    add_body(doc, '依据多角色业务流向分析，系统在功能域上清晰划分为儿童移动端、家长移动端以及Web管理后台终端三个子模块。系统的核心业务数据流以"任务"实体为中枢展开闭环运转。')

    add_heading_3(doc, '2.2.3 系统非功能性需求')
    add_body(doc, '（1）性能与响应时延：核心API响应时延控制在200毫秒以内。LLM处理采用异步机制。')
    add_body(doc, '（2）安全性与隐私保护：ADHD属于高度敏感的个人健康隐私范畴。严格依托Sa-Token的RBAC模型。')
    add_body(doc, '（3）可用性与兼容性：跨终端一致性与弱网环境降级能力。')

    # ===== 第3章 =====
    doc.add_page_break()
    add_heading_1(doc, '3 系统总体设计')
    add_body(doc, '系统总体设计是衔接需求分析与编码实现的核心桥梁环节。')

    add_heading_2(doc, '3.1 总体架构设计')
    add_caption(doc, '图 3.1 系统总体架构设计图')
    add_body(doc, '（此处插入系统总体架构图）')

    add_heading_3(doc, '3.1.1 逻辑分层架构设计')
    add_body(doc, '"小步"系统秉持高内聚、低耦合的工程设计准则，采用经典的N层逻辑架构体系。系统自上而下严格划分为表现层、业务逻辑层、数据访问层及基础设施层四个逻辑层次。')

    add_heading_3(doc, '3.1.2 前后端分离协同机制')
    add_body(doc, '系统完全遵循前后端分离范式。前后端之间的数据报文交换统一约定为application/json格式，并通过公共的泛型响应模型（R<T>）进行封装。')

    add_heading_2(doc, '3.2 核心业务模块设计')
    add_heading_3(doc, '3.2.1 用户认证与多角色鉴权模块设计')
    add_body(doc, '系统需服务于"超级管理员、家长、儿童"三类权限差异显著的角色身份，访问安全防线依托Sa-Token框架实现。包括统一登录认证流程、多端账号体系隔离和声明式细粒度权限管控三个层面。')

    add_heading_3(doc, '3.2.2 任务生命周期管理与状态机设计')
    add_body(doc, '"任务"作为贯穿系统全部功能线的核心领域对象，其生命周期管理采用了具有高弹性的有限状态机模型设计。核心状态枚举定义了"待办"、"进行中"、"已完成"和"已过期"四种互斥状态。')

    add_heading_3(doc, '3.2.3 专注模式与时间管理交互机制设计')
    add_body(doc, '专注模块服务于儿童进入指定任务后的沉浸式时间管理体验，包含启动阶段、自然完成路径和中途放弃路径三个核心分支。')

    add_heading_3(doc, '3.2.4 智能数据反馈与LLM辅助生成模块设计')
    add_body(doc, '系统设计了由后端定时任务驱动、连接外部AI服务的旁路智能反馈闭环。包括数据聚合、Prompt构建、远程推理和结果落库与推送四个阶段。')

    add_heading_2(doc, '3.3 数据库设计')
    add_caption(doc, '图 3.2 核心实体关系图')
    add_body(doc, '（此处插入E-R图）')

    add_heading_3(doc, '3.3.1 概念模型设计 (E-R图)')
    add_body(doc, '核心实体包含：用户实体（User）、任务定义实体（Task）、任务执行日志实体（Task Log）和代币流水实体（Reward Log）。')

    add_heading_3(doc, '3.3.2 关键数据表结构设计')
    add_table_data(doc, '表 3.1 系统用户表 (sys_user)',
        ['字段名称', '类型', '长度', '必填', '说明'],
        [['user_id','BIGINT','20','是','主键(雪花算法)'],['dept_id','BIGINT','20','否','所属家庭/机构ID'],
         ['user_name','VARCHAR','64','是','登录账号'],['password','VARCHAR','128','是','BCrypt加密哈希'],
         ['user_type','TINYINT','4','是','1:管理员,2:家长,3:儿童'],['nickname','VARCHAR','64','否','显示昵称'],
         ['coin_balance','INT','11','是','代币余额(默认0)'],['status','TINYINT','4','是','0:正常,1:停用']])
    blank(doc)

    add_table_data(doc, '表 3.2 任务定义表 (ss_task)',
        ['字段名称', '类型', '必填', '说明'],
        [['task_id','BIGINT','是','主键'],['parent_id','BIGINT','否','父任务ID'],
         ['creator_id','BIGINT','是','创建者ID'],['title','VARCHAR','是','任务名称'],
         ['content','TEXT','否','任务指导语'],['prompt_level','INT','是','辅助强度(1-5)'],
         ['reward_amount','INT','是','奖励代币数'],['cycle_type','TINYINT','是','循环类型'],
         ['status','CHAR','是','状态']])
    blank(doc)

    add_table_data(doc, '表 3.3 任务执行日志表 (ss_task_log)',
        ['字段名称', '类型', '说明'],
        [['log_id','BIGINT','主键'],['task_id','BIGINT','关联任务定义ID'],
         ['child_id','BIGINT','执行儿童用户ID'],['target_date','DATE','计划执行日期'],
         ['actual_duration','INT','实际专注时长(秒)'],
         ['status','TINYINT','0:待办,1:进行中,2:已完成,3:已放弃'],['end_time','DATETIME','打卡提交时间']])

    add_heading_3(doc, '3.3.3 Redis缓存结构设计')
    add_body(doc, '系统引入Redis构建全局分布式缓存层，包含会话认证缓存、防并发重复提交锁和行为数据预聚合缓存三个核心策略。')

    # ===== 第4章 =====
    doc.add_page_break()
    add_heading_1(doc, '4 系统详细设计与实现')
    add_body(doc, '本章将以第三章给出的总体架构设计方案为蓝本，逐项展开系统三个子项目的关键技术实现细节。')

    add_heading_2(doc, '4.1 后端服务实现 (smallsteps-api)')
    add_heading_3(doc, '4.1.1 安全认证与路由拦截实现')
    add_body(doc, '安全认证模块基于Sa-Token框架实现。通过WebMvcConfigurer接口将SaInterceptor注册为全局HTTP请求拦截器。多角色鉴权逻辑充分利用Sa-Token的声明式注解。在数据层面的越权防护中，Service层内嵌了"数据归属强校验"逻辑：')
    add_code(doc, '// 获取当前登录家长的userId\nLong parentId = StpUtil.getLoginIdAsLong();\n// 查询亲子绑定关系表\nList<Long> childIds = parentChildMapper.selectChildIdsByParentId(parentId);\n// 构建带有强制in约束的查询条件\nLambdaQueryWrapper<SsTaskLog> wrapper = new LambdaQueryWrapper<>();\nwrapper.in(SsTaskLog::getChildId, childIds);')

    add_heading_3(doc, '4.1.2 任务管理核心业务逻辑实现')
    add_body(doc, '任务的"完成打卡"操作在@Transactional注解标记的事务边界内依次执行幂等性校验、状态合法性校验、日志状态扭转、代币奖励结算和进度更新五个步骤。')

    add_heading_3(doc, '4.1.3 数据看板聚合与智能生成服务实现')
    add_body(doc, '数据看板采用"定时预计算+缓存命中"的异步架构模式。智能寄语生成配置了熔断与降级策略：')
    add_code(doc, 'try {\n    String aiResponse = webClient.post()\n        .uri(llmApiEndpoint)\n        .bodyValue(promptPayload)\n        .retrieve().bodyToMono(String.class)\n        .timeout(Duration.ofSeconds(30)).block();\n    saveLlmMessage(childId, aiResponse);\n} catch (Exception e) {\n    log.warn("LLM服务调用失败，启用降级兜底", e);\n    String fallback = fallbackMessageService.getRandomMessage();\n    saveLlmMessage(childId, fallback);\n}')

    add_heading_2(doc, '4.2 移动端应用实现 (smallsteps-app)')
    add_heading_3(doc, '4.2.1 项目工程化配置与Vue 3生态集成')
    add_body(doc, '项目使用Vite构建工具链，运行时框架为vue@3.5.30 + UniApp 3.0，状态管理采用pinia@2.3。')

    add_heading_3(doc, '4.2.2 基于Pinia的双模式状态管理设计')
    add_body(doc, '通过Pinia Store的模块化设计实现同一应用内"家长模式"与"儿童模式"的承载。核心设计要点在于App的底部导航栏、首页组件和路由导航守卫均通过computed计算属性响应式绑定至currentMode值。')

    add_heading_3(doc, '4.2.3 TailwindCSS驱动的认知减负界面构建')
    add_body(doc, '在色彩体系层面，自定义了面向ADHD群体的"低刺激色板"。在布局策略层面，儿童端页面严格遵循"单列信息流"原则。')

    add_heading_3(doc, '4.2.4 核心交互流实现：任务卡片与番茄钟')
    add_body(doc, '番茄钟页面核心实现要点包括：全屏沉浸态控制、环形进度条Canvas渲染和任务完成庆祝动效。')

    add_heading_2(doc, '4.3 Web管理后台实现 (smallsteps-ui)')
    add_heading_3(doc, '4.3.1 动态路由与管理员权限控制')
    add_body(doc, '后台路由系统采用"静态基础路由+动态权限路由"的混合注册策略。')

    add_heading_3(doc, '4.3.2 数据可视化看板与列表渲染')
    add_body(doc, '管理后台集成ECharts 5.6图表引擎和VXE-Table高性能表格组件。核心看板包含全平台日活趋势折线图、任务完成率分布饼图和高频任务类型排行柱状图。')

    # ===== 第5章 =====
    doc.add_page_break()
    add_heading_1(doc, '5 系统测试与运行验证')
    add_body(doc, '系统测试是软件工程质量保障链路中不可或缺的终态验证环节。')

    add_heading_2(doc, '5.1 测试环境与测试策略')
    add_heading_3(doc, '5.1.1 测试环境说明')
    add_table_data(doc, '表 5.1 测试环境配置',
        ['环境项', '配置详情'],
        [['服务器操作系统','Ubuntu 22.04 LTS'],['JDK版本','OpenJDK 21.0.2'],
         ['数据库','PostgreSQL 15 + Redis 7.2'],['后端框架','Spring Boot 3.5.9'],
         ['移动端测试设备','Android 13 (Xiaomi 14), Android 12 (Samsung A52)'],
         ['浏览器环境','Chrome 120+, Edge 120+'],['网络环境','局域网 + 模拟弱网']])

    add_heading_3(doc, '5.1.2 测试维度规划')
    add_body(doc, '测试工作按照"由内而外、由点及面"的策略分为单元测试、接口集成测试和端到端功能验收测试三个递进维度。')

    add_heading_2(doc, '5.2 核心功能测试用例与结果')
    add_heading_3(doc, '5.2.1 多角色权限隔离测试')
    add_table_data(doc, '表 5.2 权限隔离测试用例',
        ['编号', '测试场景', '预期结果', '实际结果'],
        [['TC-01','儿童角色尝试创建任务','返回403错误码','符合预期'],
         ['TC-02','家长查询非关联儿童数据','返回空数据集','符合预期'],
         ['TC-03','未登录状态访问受保护接口','返回401错误码','符合预期'],
         ['TC-04','管理员Token在App端使用','返回401错误码','符合预期']])

    add_heading_3(doc, '5.2.2 任务全生命周期流转测试')
    add_table_data(doc, '表 5.3 任务流转测试用例',
        ['编号', '测试场景', '预期结果', '实际结果'],
        [['TC-05','家长创建每日循环任务','任务创建成功','符合预期'],
         ['TC-06','儿童启动专注模式','界面进入全屏沉浸态','符合预期'],
         ['TC-07','专注模式自然完成','触发庆祝动画+代币结算','符合预期'],
         ['TC-08','专注模式中途放弃','二次确认+记录时长','符合预期'],
         ['TC-09','代币余额累积与兑换','余额正确累加','符合预期'],
         ['TC-10','重复提交防护','仅第一次请求生效','符合预期']])

    add_heading_3(doc, '5.2.3 专注模式交互防错测试')
    add_table_data(doc, '表 5.4 交互防错测试用例',
        ['编号', '测试场景', '预期结果', '实际结果'],
        [['TC-11','专注中应用切至后台','计时器持续运行','符合预期'],
         ['TC-12','弱网环境下完成任务','本地暂存+自动同步','符合预期'],
         ['TC-13','长按返回键强制退出','弹出二次确认弹窗','符合预期']])

    # ===== 第6章 =====
    doc.add_page_break()
    add_heading_1(doc, '6 总结与展望')

    add_heading_2(doc, '6.1 全文工作回顾')
    add_body(doc, '本课题以ADHD中小学生群体在日常行为管理领域面临的现实困境为研究起点，完成了"小步（Small Steps）"行为习惯辅助系统从需求分析、架构设计到工程实现与测试验证的完整研发流程。')

    add_heading_2(doc, '6.2 系统设计中的关键技术挑战与解决思路')
    add_body(doc, '（1）认知心理学理论到前端UI组件的工程化映射：通过在tailwind.config.js中建立自定义色板与间距规则实现转化。')
    add_body(doc, '（2）LLM外部服务的可靠性治理：通过将LLM调用完全剥离至定时任务异步旁路、配合本地降级话术库的"双保险"策略。')
    add_body(doc, '（3）多角色共存系统中的数据安全边界管控：在接口鉴权与数据层两个层面构建纵深防御体系。')

    add_heading_2(doc, '6.3 现有不足与未来研究方向')
    add_body(doc, '（1）辅助效果的循证评估缺位：尚未能在真实ADHD临床样本群体中开展对照实验。')
    add_body(doc, '（2）个性化智能推荐算法的深化：当前依赖基于规则的Prompt模板，智能化程度有限。')
    add_body(doc, '（3）社交化与同伴激励维度的扩展：可探索匿名化的"同龄伙伴群组挑战"功能。')
    add_body(doc, '（4）无障碍访问的进一步增强：应严格对标WCAG 2.1 AA级标准。')

    # ===== 致谢 =====
    doc.add_page_break()
    add_heading_1(doc, '致谢')
    add_body(doc, '时光荏苒，四载求知旅途行将画上句点。在本毕业设计完成之际，我衷心感激每一位为我提供支持与帮助的师长、同学与家人。')
    add_body(doc, '首先，我要向我的指导教师薛庆水老师致以最诚挚的谢意。在课题研究期间，薛老师在选题方向的把握、技术方案的论证以及论文写作的规范性等方面给予了耐心细致的指导。')
    add_body(doc, '其次，我要感谢上海应用技术大学继续教育学院的全体授课教师。他们在计算机科学与技术专业课程教学中传授的扎实基础知识构成了支撑本毕业设计得以顺利推进的知识根基。')
    add_body(doc, '我还要感谢在开发过程中提供过宝贵反馈意见的同学与朋友们。最后，我要向在整个学业历程中始终无条件支持我的家人表达最深沉的感恩。')
    add_body(doc, '谨以此文，献给所有在成长路上给予我力量的人。')

    # ===== 参考文献 =====
    doc.add_page_break()
    add_heading_1(doc, '参考文献')
    refs = [
        '[1] 中华医学会儿科学分会发育行为学组. 注意缺陷多动障碍诊疗指南[J]. 中华儿科杂志, 2020, 58(3): 188-193.',
        '[2] Polanczyk G V, Willcutt E G, Salum G A, et al. ADHD prevalence estimates across three decades: an updated systematic review and meta-regression analysis[J]. International Journal of Epidemiology, 2014, 43(2): 434-442.',
        '[3] Barkley R A. Executive Functions: What They Are, How They Work, and Why They Evolved[M]. New York: Guilford Press, 2012.',
        '[4] Kollins S H, DeLoss D J, Cañadas E, et al. A novel digital intervention for actively reducing severity of paediatric ADHD (STARS-ADHD): a randomised controlled trial[J]. The Lancet Digital Health, 2020, 2(4): e168-e178.',
        '[5] Sweller J, van Merriënboer J J G, Paas F. Cognitive Architecture and Instructional Design: 20 Years Later[J]. Educational Psychology Review, 2019, 31(2): 261-292.',
        '[6] Vygotsky L S. Mind in Society: The Development of Higher Psychological Processes[M]. Cambridge: Harvard University Press, 1978.',
        '[7] 杜亚松, 苏林雁, 郑毅. 儿童注意缺陷多动障碍的非药物干预研究进展[J]. 中华精神科杂志, 2021, 54(2): 150-155.',
        '[8] Spring官方社区. Spring Boot Reference Documentation[EB/OL]. (2024-11-01)[2025-03-15]. https://docs.spring.io/spring-boot/docs/current/reference/html/.',
        '[9] 苞米豆开源组织. MyBatis-Plus官方文档[EB/OL]. (2024-06-01)[2025-03-15]. https://baomidou.com/pages/24112f/.',
        '[10] Sa-Token开发团队. Sa-Token官方文档[EB/OL]. (2024-09-01)[2025-03-15]. https://sa-token.cc/doc.html.',
        '[11] DCloud. UniApp跨平台开发框架官方文档[EB/OL]. (2024-10-01)[2025-03-15]. https://uniapp.dcloud.net.cn/.',
        '[12] Vue.js团队. Vue.js 3 Documentation[EB/OL]. (2024-12-01)[2025-03-15]. https://vuejs.org/guide/introduction.html.',
        '[13] Element Plus开发团队. Element Plus组件库官方文档[EB/OL]. (2024-08-01)[2025-03-15]. https://element-plus.org/zh-CN/.',
        '[14] TailwindCSS团队. TailwindCSS Documentation[EB/OL]. (2024-10-01)[2025-03-15]. https://tailwindcss.com/docs.',
        '[15] 霍春阳. Vue.js设计与实现[M]. 北京: 人民邮电出版社, 2022.',
        '[16] Sonuga-Barke E J S, Brandeis D, Cortese S, et al. Nonpharmacological Interventions for ADHD: Systematic Review and Meta-Analyses of Randomized Controlled Trials of Dietary and Psychological Treatments[J]. American Journal of Psychiatry, 2013, 170(3): 275-289.',
        '[17] American Psychiatric Association. Diagnostic and Statistical Manual of Mental Disorders (5th ed., Text Revision)[M]. Washington, DC: American Psychiatric Publishing, 2022.',
        '[18] Redis官方社区. Redis Documentation[EB/OL]. (2024-06-01)[2025-03-15]. https://redis.io/documentation.',
        '[19] Apache Software Foundation. Apache ECharts Documentation[EB/OL]. (2024-09-01)[2025-03-15]. https://echarts.apache.org/zh/index.html.',
        '[20] Vue.js团队. Pinia状态管理库官方文档[EB/OL]. (2024-11-01)[2025-03-15]. https://pinia.vuejs.org/zh/.',
    ]
    for r in refs:
        add_ref(doc, r)

    # ===== 附录 =====
    doc.add_page_break()
    add_heading_1(doc, '附  录')
    add_heading_2(doc, '附录A：LLM任务分解Prompt模板')
    add_body(doc, '以下为系统中用于驱动大语言模型生成个性化家长辅导建议的核心Prompt模板示例。')
    add_code(doc, '系统角色设定：\n"你是一位专业的儿童发展心理学顾问，拥有丰富的ADHD儿童家庭干预经验。\n你的语气应当温暖、具有同理心，避免说教与批判。\n请基于以下儿童近期行为数据摘要，为家长拟定一段简短的每日陪伴建议（150字以内）。"')
    add_code(doc, '数据注入模板：\n"儿童昵称：{childNickname}，年龄：{age}岁。\n近7日行为摘要：\n- 日均任务完成率：{avgCompletionRate}%（趋势：{trend}）\n- 日均专注总时长：{avgFocusMinutes}分钟\n- 最常中途放弃的任务类型：{mostAbandonedCategory}\n- 近3日情绪自评均值：{avgMoodScore}/5"')

    # ===== 保存 =====
    out = r'd:\office\jushuang1\github\ss\docs\todo\word\v2_上海应用技术大学高等学历继续教育本科计算机专业毕业论文.docx'
    doc.save(out)
    print(f'论文已生成: {out}')

if __name__ == '__main__':
    build()
