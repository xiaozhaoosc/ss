ADHD中小学生（儿童）行为习惯辅助系统设计与实现

摘要：注意缺陷多动障碍（ADHD）以注意力维持困难、活动过度及行为冲动为核心表现，是学龄期儿童较为常见的神经发育性障碍。当前主流药物干预存在副作用争议，线下行为矫正的执行门槛也相当高，大多数普通家庭难以长期坚持。本文基于数字化辅助干预这一思路，围绕认知减负、亲子协同与动态激励等实际需求，设计并实现了一套面向ADHD中小学生的行为习惯辅助系统——"小步（Small Steps）"。系统整体采用前后端分离架构，后端选用Spring Boot 3与MyBatis-Plus，通过Sa-Token完成多角色鉴权，数据层以PostgreSQL存储业务数据、Redis承担缓存与防重提交；移动端基于UniApp与Vue 3实现儿童端与家长端的双模式切换。系统在集成大语言模型（LLM）方面做了一定探索，利用儿童的历史打卡数据自动生成个性化的激励话术，引导家长逐步从"督促者"转变为"陪伴者"。整体工程实践覆盖需求分析、架构设计、编码联调至Docker部署的完整流程。

关键词：注意力缺陷多动障碍；行为干预；Spring Boot 3；UniApp；Vue 3


Design and Implementation of a Behavior Habit Support System for Children with ADHD

Abstract: Attention deficit hyperactivity disorder (ADHD) is a relatively common neurodevelopmental condition among school-age children, primarily characterized by difficulties in sustaining attention, excessive activity, and impulsivity. Mainstream pharmacological interventions carry ongoing controversies regarding side effects, while offline behavioral training demands a level of professional consistency that most families find difficult to sustain over the long term. This study takes a digital-assisted intervention approach and, in response to practical needs including cognitive load reduction, parent-child coordination, and adaptive motivation, designs and implements a comprehensive behavioral habit support system for elementary and middle school students with ADHD, named "Small Steps." The system adopts a front-end/back-end separation architecture: the backend is built on Spring Boot 3 and MyBatis-Plus, with Sa-Token handling multi-role authentication, PostgreSQL managing core business data, and Redis serving as the caching and idempotency layer. The mobile application is developed using UniApp and Vue 3, enabling dynamic switching between child and parent interface modes. The system also explores the integration of large language models (LLMs), leveraging children's historical task records to automatically generate personalized motivational messages and gradually guide parents toward a companionship-oriented role rather than a supervisory one. The full engineering cycle—from requirements analysis and architectural design through coding and Docker deployment—is documented throughout.

Keywords: ADHD; Behavioral Intervention; Spring Boot 3; UniApp; Vue 3


1 绪论

注意力缺陷多动障碍（ADHD）是学龄期儿童中较为常见的神经发育障碍。核心症状体现在注意力维持困难、活动水平偏高以及行为冲动控制不足等方面。对于正处于中小学阶段的患儿而言，这些表现带来的影响是多层面的——课堂专注困难、生活自理能力薄弱、家庭关系趋于紧张。主流干预手段包括药物治疗和线下行为矫正，但药物副作用争议持续存在，线下矫正受专业资源稀缺与经济成本的双重限制，也并非所有家庭都能长期坚持。随着移动互联网与人工智能技术的成熟，数字化辅助工具逐渐进入这一领域，但现有应用多停留在基础的日程提醒层面，针对ADHD儿童认知与行为特点的系统性设计仍较欠缺。

1.1 研究背景

注意缺陷多动障碍（Attention Deficit Hyperactivity Disorder，简称ADHD）在全球学龄儿童中的患病率约为5%至7%[1]，部分地区调查数据更高。其核心症状区别于一般意义上的"好动"：相较于同龄人，ADHD儿童的注意力维持能力存在神经发育层面的劣势，同时伴有工作记忆容量偏低、情绪调节困难、计划执行能力受限等"执行功能"方面的问题[2]，而这些通常不会明显影响儿童的智力水平本身。

在实际的学习和生活场景中，上述症状带来的困难超出了外界通常的预期。课堂上持续走神、容易受外部刺激打断，是最常见的外在表现；到了完成家庭作业的环节，任务启动难、过程频繁中断、难以自主拆解步骤，往往会让家长和儿童都陷入消耗性的拉锯。社交层面，冲动控制不足容易导致插话或肢体冲突，进而引发同伴排斥。长期处于反复受挫的环境下，儿童产生低自尊、焦虑甚至抑郁情绪的比例明显偏高[3]。如何在日常生活中切实减轻这类儿童的认知负担，帮助其逐步建立可持续的行为习惯，是一个具有实际紧迫性的问题。

1.2 研究目的

当前主流的ADHD干预路径大致分为两类。药物方面，以利他林为代表的中枢兴奋剂对核心症状有一定短期效果，但在儿童群体中的长期应用争议较大——食欲减退、睡眠质量下降以及对生长发育的潜在影响，令不少家长持谨慎态度。行为干预方面，以家长管理培训（Parent Management Training，PMT）为代表的方案在循证研究中表现出较好的长期效果，但落地的前提条件颇高：需要专业治疗师持续指导，更需要家长在日常生活中长期且稳定地执行具体策略——而现实中，大多数家长本身承受的工作与生活压力已经不小，缺乏心理学专业背景，在日复一日的督促中极易积累情绪耗竭。其最终结果往往是儿童问题未能有效改善，亲子关系先行破裂，陷入相互消耗的循环[4]。

正是在这个现实矛盾下，数字化辅助工具呈现出相当的应用价值。移动应用程序具备全天候可用、情绪稳定、记录精确的特点，引入ADHD干预场景后，可以充当亲子之间的中间层：通过游戏化机制和即时正向反馈，为多巴胺分泌相对不足的ADHD儿童提供高频的激励刺激，将日常任务转化为更有参与感的活动；同时分担家长部分监督压力，减少因直接督促引发的亲子摩擦，让家长有余力投入情感陪伴而非任务管控。

本文的研究目的在于，在这个方向上做一次具体的工程实践——设计并实现一套真正针对ADHD儿童认知与行为特征的辅助系统，而非简单地把通用任务管理工具套用在这个群体上。

1.3 研究意义

当前市面上以"日程管理""时间追踪""番茄钟"为主打的效率类应用虽然数量不少，但将其用于ADHD儿童时普遍暴露出几个适配问题：

第一，界面认知负荷偏高。通用效率工具往往追求功能覆盖的完整性，界面层级深、菜单选项多。对于执行功能本身已存在障碍的ADHD儿童而言，这类信息密度容易在使用之前就触发回避反应。

第二，任务粒度太粗。"写作业"作为一个整体性指令，对ADHD儿童几乎等同于无效——他们需要的是"拿出数学课本""翻到第47页"这类可直接执行的单步操作，而通用工具很少提供这种逐层拆解的引导机制。

第三，反馈方式缺乏情感温度。"今日有2项任务未完成"这类聚焦于失败的统计反馈，对ADHD儿童本就脆弱的自我效能感是反向强化。这类群体更需要的是对已完成部分的正向确认，而不是对未完成项的频繁提示。

第四，家长侧被忽视。现有工具几乎把干预压力完全压在儿童一方，既不为家长提供可操作的策略引导，也没有家庭协同层面的整体设计。

综合而言，针对国内ADHD中小学家庭的实际需求，设计一套在认知负荷控制、亲子协同、动态激励等维度上有针对性的辅助系统，是本研究的核心出发点。
