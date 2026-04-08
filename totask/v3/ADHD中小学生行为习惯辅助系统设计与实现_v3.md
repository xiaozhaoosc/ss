<div align="center">

# 上海应用技术大学

## 本科毕业设计（论文）

---

<div style="font-size: 22pt; font-weight: bold; margin: 40px 0;">

# ADHD中小学生（儿童）行为习惯辅助系统设计与实现

</div>

---

<div style="display: flex; justify-content: space-between; width: 60%; margin: 0 auto; font-size: 14pt;">

<div style="text-align: left;">

**学&emsp;&emsp;院：** 计算机科学与信息工程学院

**专&emsp;&emsp;业：** 计算机科学与技术

**班&emsp;&emsp;级：** 2410420

**学&emsp;&emsp;号：** 241042025

**姓&emsp;&emsp;名：** 赵轩

**指导教师：** 薛庆水

</div>

</div>

<div style="margin-top: 60px; font-size: 14pt;">

**2026年3月18日**

</div>

</div>

---

## 中文摘要

注意力缺陷多动障碍（Attention Deficit Hyperactivity Disorder，ADHD）是儿童期最常见的神经发育障碍之一，其核心症状包括注意力不集中、多动和冲动，严重影响儿童的学业表现、日常生活自理能力以及家庭关系。传统的药物干预和行为矫正手段存在副作用明显、专业资源分布不均、家庭执行难度大等现实困境，难以惠及广大普通家庭。

针对上述问题，本课题设计并实现了一套融合物联网硬件终端、大语言模型智能微服务与多端协同移动应用的ADHD儿童行为习惯辅助系统。系统以巴克利（Russell A. Barkley）的执行功能理论和"时间外化"理念为核心理论依据，结合认知行为疗法（CBT）和协作解决问题（CPS）模型，利用现代信息技术针对性地解决ADHD儿童"知道但做不到"的知行分离难题。

在系统架构层面，后端基于Spring Boot 3框架构建高可用的RESTful API服务，引入RabbitMQ消息队列实现与Python FastAPI AI微服务的异步解耦，通过WebSocket实现多端数据的实时同步推送。数据库采用PostgreSQL 16，利用其JSONB数据类型灵活存储AI生成的动态结构化数据。前端基于UniApp框架开发覆盖儿童端与家长端的跨平台移动应用，管理员端基于Web后台实现系统运营管理。

在物联网层面，系统设计并实现了基于ESP32-S3芯片的智能硬件玩偶终端，集成WS2812B全彩灯环、MAX98357A音频播报模块和RC522 NFC识别模块，通过MQTT协议与云端EMQX消息代理实现毫秒级的双向实时通信，将"任务开始""专注计时""任务完成"等抽象状态映射为物理环境中的光色变化和语音播报，在儿童的日常生活场景中构建有效的"执行点"干预。

在人工智能层面，系统通过大语言模型（LLM）实现智能任务拆解功能，能够将家长输入的模糊、宏观任务指令（如"做作业""收拾房间"）自动分解为一系列细粒度、可执行的微步骤，并生成游戏化、鼓励性的语音引导文本，从根本上降低儿童执行复杂任务的认知负荷。同时，系统利用LLM对儿童语音树洞数据进行情感分析，周期性生成AI心理画像报告，帮助家长更客观地了解孩子的行为规律。

系统构建了完整的"感知-决策-干预-反馈"数字化行为干预闭环，通过硬件感知层（NFC触发、状态上报）、云端决策层（AI任务规划、奖励计算）、软件展示层（App任务管理、数据可视化）与物理干预层（硬件灯光音效）的有机整合，使系统能够随儿童的行为数据积累而持续优化干预策略。硬件BOM成本控制在百元以内，软件依托云服务部署，整体方案具有较强的普惠性和社会推广价值。

**关键词：** 注意力缺陷多动障碍；物联网；大语言模型；Spring Boot；ESP32

---

## Design and Implementation of a Behavioral Habit Assistance System for Primary and Secondary School Students with ADHD

### Abstract

Attention Deficit Hyperactivity Disorder (ADHD) is one of the most common neurodevelopmental disorders in childhood, with core symptoms including inattention, hyperactivity, and impulsivity, which severely affect children's academic performance, daily living skills, and family relationships. Traditional pharmacological interventions and behavioral correction methods face practical challenges such as significant side effects, uneven distribution of professional resources, and high difficulty in family-based implementation, making them difficult to benefit the broader population of ordinary families.

To address these issues, this thesis designs and implements a behavioral habit assistance system for children with ADHD that integrates IoT hardware terminals, Large Language Model (LLM) intelligent microservices, and multi-platform collaborative mobile applications. The system is grounded in Russell A. Barkley's executive function theory and the concept of "externalizing time," combined with Cognitive Behavioral Therapy (CBT) and Collaborative & Proactive Solutions (CPS) models, leveraging modern information technology to specifically tackle the "knowing but not doing" gap experienced by children with ADHD.

At the system architecture level, the backend is built on the Spring Boot 3 framework to provide highly available RESTful API services, with RabbitMQ message queues introduced to achieve asynchronous decoupling from the Python FastAPI AI microservice, and WebSocket for real-time multi-platform data synchronization. The database employs PostgreSQL 16, leveraging its JSONB data type for flexible storage of dynamically generated structured data from AI modules. The frontend is developed using the UniApp framework for cross-platform mobile applications covering both child and parent interfaces, while the administrator interface is implemented as a web-based management console.

At the IoT level, the system designs and implements an intelligent hardware puppet terminal based on the ESP32-S3 chip, integrating a WS2812B full-color LED ring, a MAX98357A audio playback module, and an RC522 NFC recognition module. Through the MQTT protocol and the cloud-based EMQX message broker, millisecond-level bidirectional real-time communication is achieved, mapping abstract states such as "task start," "focus timing," and "task completion" to light color changes and voice announcements in the physical environment, constructing effective "point-of-performance" interventions in children's daily life scenarios.

At the artificial intelligence level, the system leverages Large Language Models (LLMs) to implement intelligent task decomposition, automatically breaking down vague, macro-level task instructions from parents (such as "do homework" or "tidy up the room") into a series of fine-grained, executable micro-steps, while generating gamified, encouraging voice guidance text, fundamentally reducing the cognitive load for children executing complex tasks. Additionally, the system utilizes LLMs for sentiment analysis of children's voice diary data and periodically generates AI psychological profile reports to help parents more objectively understand their children's behavioral patterns.

The system constructs a complete digital behavioral intervention closed loop of "perception-decision-intervention-feedback" through the organic integration of a hardware perception layer (NFC triggering, status reporting), a cloud decision layer (AI task planning, reward calculation), a software presentation layer (App task management, data visualization), and a physical intervention layer (hardware lighting and sound effects), enabling the system to continuously optimize intervention strategies as children's behavioral data accumulates. The hardware BOM cost is controlled within one hundred yuan, and the software is deployed on cloud services, making the overall solution highly accessible and valuable for social promotion.

**Keywords:** Attention Deficit Hyperactivity Disorder; Internet of Things; Large Language Model; Spring Boot; ESP32

---

## 目录

- [中文摘要](#中文摘要)
- [Design and Implementation of a Behavioral Habit Assistance System for Primary and Secondary School Students with ADHD](#design-and-implementation-of-a-behavioral-habit-assistance-system-for-primary-and-secondary-school-students-with-adhd)
- [第1章 绪论](#第1章-绪论)
  - [1.1 研究背景](#11-研究背景)
  - [1.2 研究目的](#12-研究目的)
  - [1.3 研究意义](#13-研究意义)
  - [1.4 研究现状和发展趋势](#14-研究现状和发展趋势)
    - [1.4.1 引言](#141-引言)
    - [1.4.2 ADHD行为干预理论的研究现状](#142-adhd行为干预理论的研究现状)
    - [1.4.3 支撑技术的应用现状](#143-支撑技术的应用现状)
    - [1.4.4 发展趋势](#144-发展趋势)
    - [1.4.5 总结](#145-总结)
- [第2章 系统分析](#第2章-系统分析)
  - [2.1 可行性分析](#21-可行性分析)
    - [2.1.1 技术可行性](#211-技术可行性)
    - [2.1.2 经济可行性](#212-经济可行性)
    - [2.1.3 操作可行性](#213-操作可行性)
  - [2.2 功能需求分析](#22-功能需求分析)
    - [2.2.1 儿童端（硬件+App）](#221-儿童端硬件app)
    - [2.2.2 家长端（App）](#222-家长端app)
    - [2.2.3 管理员端（Web）](#223-管理员端web)
  - [2.3 性能需求分析](#23-性能需求分析)
    - [2.3.1 实时性指标](#231-实时性指标)
    - [2.3.2 AI处理效率](#232-ai处理效率)
    - [2.3.3 系统承载力](#233-系统承载力)
    - [2.3.4 硬件能效](#234-硬件能效)
  - [2.4 数据需求分析](#24-数据需求分析)
- [第3章 系统设计](#第3章-系统设计)
  - [3.1 系统架构设计](#31-系统架构设计)
    - [3.1.1 接入层](#311-接入层)
    - [3.1.2 业务层](#312-业务层)
    - [3.1.3 中间件层](#313-中间件层)
    - [3.1.4 数据层](#314-数据层)
  - [3.2 系统功能设计](#32-系统功能设计)
  - [3.3 数据库设计](#33-数据库设计)
    - [3.3.1 儿童档案表（ss_child）](#331-儿童档案表ss_child)
    - [3.3.2 任务配置表（ss_task）](#332-任务配置表ss_task)
    - [3.3.3 任务执行记录表（ss_task_log）](#333-任务执行记录表ss_task_log)
    - [3.3.4 奖励配置表（ss_reward）](#334-奖励配置表ss_reward)
    - [3.3.5 星星流水记录表（ss_star_record）](#335-星星流水记录表ss_star_record)
    - [3.3.6 成就定义表（ss_achievement）](#336-成就定义表ss_achievement)
  - [3.4 物联网通信设计](#34-物联网通信设计)
    - [3.4.1 通信协议选型](#341-通信协议选型)
    - [3.4.2 MQTT主题设计](#342-mqtt主题设计)
    - [3.4.3 MQTT消息Payload格式](#343-mqtt消息payload格式)
  - [3.5 服务端核心流程设计](#35-服务端核心流程设计)
    - [3.5.1 任务拆解异步流程](#351-任务拆解异步流程)
    - [3.5.2 IoT任务触发与执行流程](#352-iot任务触发与执行流程)
- [第4章 系统实现](#第4章-系统实现)
  - [4.1 系统登录与鉴权实现](#41-系统登录与鉴权实现)
    - [4.1.1 JWT无状态认证机制实现](#411-jwt无状态认证机制实现)
    - [4.1.2 Spring Security权限体系](#412-spring-security权限体系)
  - [4.2 任务管理模块实现](#42-任务管理模块实现)
    - [4.2.1 任务创建与AI拆解接口](#421-任务创建与ai拆解接口)
    - [4.2.2 AI微服务（Python FastAPI）核心实现](#422-ai微服务python-fastapi核心实现)
    - [4.2.3 任务状态流转机制](#423-任务状态流转机制)
  - [4.3 IoT设备管理模块实现](#43-iot设备管理模块实现)
    - [4.3.1 设备注册与绑定流程](#431-设备注册与绑定流程)
    - [4.3.2 EMQX WebHook处理接口](#432-emqx-webhook处理接口)
    - [4.3.3 EMQX REST API调用封装](#433-emqx-rest-api调用封装)
  - [4.4 积分与成就系统实现](#44-积分与成就系统实现)
    - [4.4.1 星星账户服务实现](#441-星星账户服务实现)
    - [4.4.2 成就达成检测](#442-成就达成检测)
  - [4.5 ESP32-S3硬件端实现](#45-esp32-s3硬件端实现)
    - [4.5.1 固件整体架构](#451-固件整体架构)
    - [4.5.2 WS2812B灯效驱动实现](#452-ws2812b灯效驱动实现)
    - [4.5.3 I2S音频播放实现](#453-i2s音频播放实现)
    - [4.5.4 MQTT客户端实现](#454-mqtt客户端实现)
  - [4.6 前端App关键功能实现](#46-前端app关键功能实现)
    - [4.6.1 UniApp项目结构与状态管理](#461-uniapp项目结构与状态管理)
    - [4.6.2 家长端首页实现](#462-家长端首页实现)
    - [4.6.3 网络请求封装](#463-网络请求封装)
  - [4.7 管理员Web后台实现](#47-管理员web后台实现)
    - [4.7.1 Prompt模板管理模块](#471-prompt模板管理模块)
  - [4.8 系统集成测试要点](#48-系统集成测试要点)
- [第5章 结论与展望](#第5章-结论与展望)
  - [5.1 结论](#51-结论)
  - [5.2 后期展望](#52-后期展望)
- [致谢](#致谢)
- [参考文献](#参考文献)
- [附录A：ESP32-S3 MQTT连接核心代码](#附录aesp32-s3-mqtt连接核心代码)
- [附录B：LLM任务分解Prompt模板](#附录bllm任务分解prompt模板)

---

# 第1章 绪论

## 1.1 研究背景

注意力缺陷多动障碍（Attention Deficit Hyperactivity Disorder，ADHD）是儿童期最常见的神经发育障碍之一，其核心症状包括注意力不集中、多动和冲动。根据全球流行病学数据，全球儿童ADHD患病率约为5%至7%，中国的患病率也在5%至6%左右，这意味着我国有数百万的儿童正在受到ADHD的影响。对于处于中小学阶段的患儿，这些症状严重影响了他们的学习效率、日常生活自理能力以及家庭关系和同伴关系。患有ADHD的儿童往往在课堂上难以集中注意力，频繁出现作业未完成、物品遗失、忘记日程安排等问题，进而导致学业成绩下滑、自我效能感降低，形成恶性循环。

传统的干预手段主要依赖药物治疗（如哌甲酯、安非他明等中枢神经兴奋剂）和线下的行为矫正训练（如认知行为疗法CBT、正强化技术等）。药物治疗虽然能够在短期内有效改善症状，但存在副作用明显（食欲下降、睡眠障碍、情绪波动等）、长期服药依从性差等问题；行为疗法则受限于专业资源的地域分布不均、治疗费用高昂以及家庭执行难度大等现实困境，难以真正惠及广大普通家庭。此外，现有的临床干预方案往往发生在诊室或治疗机构，而非儿童的日常生活场景，与巴克利（Russell Barkley）所强调的"在执行点（Point of Performance）进行干预"的核心理念相悖，导致干预效果难以迁移到真实的家庭和学校环境中。

随着物联网（Internet of Things，IoT）、人工智能（Artificial Intelligence，AI）和移动互联网技术的迅猛发展，数字疗法（Digital Therapeutics，DTx）逐渐成为ADHD干预领域的重要新方向。数字疗法是指通过经过临床验证的软件程序，预防、管理或治疗疾病的新型医学领域。与传统医疗手段相比，数字疗法具有可规模化推广、成本低廉、可在日常场景中持续干预等显著优势。目前，EndeavorRx（由Akili Interactive开发）已成为全球首个获得美国FDA批准用于治疗ADHD的数字疗法产品，证明了该路径的可行性和有效性。

然而，国内现有的ADHD辅助软件大多局限于单一的日程提醒或简单的番茄钟计时功能，缺乏针对ADHD"执行功能障碍"核心痛点的深度定制，且往往缺乏与物理环境的交互，导致用户依从性低，难以形成长期的行为习惯改善效果。同时，随着大语言模型（Large Language Model，LLM）技术的突破，AI在自然语言理解与任务规划方面的能力得到了质的飞跃，为构建真正"懂得儿童需求"的智能辅助系统提供了前所未有的技术基础。

在此背景下，本课题提出并实现一套融合物联网硬件终端、大语言模型智能微服务与多端协同移动应用的ADHD儿童行为习惯辅助系统，旨在通过软硬件协同的方式，将抽象的"时间管理"与"任务执行"能力外化为物理环境中可感知的光与声反馈，结合AI智能降低任务执行门槛，从而帮助ADHD儿童重建行为秩序，缓解家庭教养压力，探索低成本、可推广的数字化ADHD家庭干预新模式。

## 1.2 研究目的

本课题旨在设计并实现一套软硬件结合的"ADHD中小学生（儿童）行为习惯辅助系统"。该系统以巴克利（Russell A. Barkley）的执行功能理论为核心理论依据，结合认知行为疗法（CBT）和协作解决问题（CPS）模型，充分利用计算机技术中物联网、云计算、大语言模型等前沿技术，针对性地解决ADHD儿童"知道但做不到"的知行分离难题。

具体研究目的包括以下几个方面：

（1）构建基于大语言模型（LLM）的智能任务拆解微服务。针对ADHD儿童面对复杂任务时的"启动困难"问题，设计并实现一个能够将家长输入的模糊、宏观任务指令（如"做作业"、"收拾房间"）自动分解为一系列细粒度、可执行微步骤的AI服务，从根本上降低儿童执行复杂任务的认知负荷。同时，利用LLM的情感化语言生成能力，为任务步骤生成游戏化、鼓励性的语音引导文本，提升系统的人文温度与儿童接受度。

（2）设计并实现基于ESP32-S3的物联网硬件终端。根据巴克利"时间外化"理论，研制一款低成本、低功耗的智能硬件玩偶，集成WS2812B全彩灯环、I2S音频播报模块和NFC识别模块。通过MQTT协议与云端服务实时联动，将"任务开始"、"专注计时"、"任务完成"等抽象状态映射为物理环境中的光色变化和语音播报，在儿童的日常生活场景中构建有效的"执行点"干预。

（3）开发多端协同的软件平台。基于Spring Boot 3框架构建高可用的后端服务，引入RabbitMQ消息队列实现与AI微服务的异步解耦；基于UniApp框架开发覆盖儿童端与家长端的跨平台移动应用，实现任务的全生命周期管理、家庭数据实时同步、儿童行为数据可视化看板及AI生成心理画像等核心功能。

（4）构建完整的"感知-决策-干预-反馈"数字化行为干预闭环。通过将硬件感知层（NFC触发、状态上报）、云端决策层（AI任务规划、奖励计算）、软件展示层（App任务管理、数据可视化）与物理干预层（硬件灯光音效）有机整合，形成一套完整的行为塑造闭环，使系统能够随儿童的行为数据积累而持续优化干预策略。

## 1.3 研究意义

本课题的研究意义体现在理论价值和实践价值两个维度：

理论意义方面，本研究系统性地探索了生成式AI（Generative AI）与物联网（IoT）技术在特殊教育辅助领域的融合应用范式。针对ADHD这一具体的神经发育障碍，本文构建了一套完整的软硬件协同系统设计方法论，验证了"环境结构化"理论在计算机辅助系统中的工程可行性。本研究将巴克利执行功能理论中的"时间外化"（Externalizing Time）和"执行点干预"（Point-of-Performance Intervention）两大核心原则转化为可操作的技术规范，为后续类似研究提供了可参考的系统架构和技术选型依据。同时，本研究在提示工程（Prompt Engineering）应用于特殊教育场景方面进行了初步探索，为大语言模型在教育领域的垂直化应用提供了实验性参考。

实践意义方面，本系统的最终形态是一套面向ADHD家庭的低成本、高可用数字化干预工具。在儿童层面，系统通过将复杂任务自动分解为可执行微步骤，有效帮助ADHD儿童克服"启动困难"，提升任务完成率；通过光效和音效的多感官物理反馈，增强儿童的时间感知能力，改善"时间盲区"问题；通过积分奖励和成就徽章等游戏化机制，持续激励儿童形成良好的行为习惯。在家庭层面，系统的行为数据可视化看板和AI生成的心理画像，能够帮助家长更客观地了解孩子的行为规律，减少主观判断带来的亲子摩擦，缓解家长的教养焦虑；智能化的家长操作界面，大幅降低了家长执行行为干预方案的技能门槛。在社会层面，硬件BOM成本控制在百元以内，软件部分依托云服务部署，整体方案的普惠性强，有助于弥合城乡之间、不同经济条件家庭之间在ADHD专业干预资源获取上的不平等差距，具有较高的社会推广价值。

## 1.4 研究现状和发展趋势

### 1.4.1 引言

注意力缺陷多动障碍（ADHD）是儿童期最常见的神经发育障碍之一。随着社会认知的提升和心理学研究的深入，ADHD不再被简单视为儿童的"顽皮"或"管教缺失"，而是被定义为一种涉及执行功能（Executive Function）发育滞后的生理性障碍。传统的干预手段主要包括药物治疗和行为疗法，但在实际家庭场景中，家长往往缺乏专业的行为矫正技能，且药物治疗存在一定的副作用争议。近年来，随着物联网（IoT）、人工智能（AI）及移动互联网技术的爆发，利用计算机技术辅助ADHD儿童进行行为习惯养成，即"数字疗法"（Digital Therapeutics，DTx），已成为跨学科研究的热点。本课题旨在结合心理学权威理论与现代信息技术，设计一套软硬件结合的辅助系统，以下将从理论基础、技术实现及未来趋势三个维度阐述国内外的研究现状。

### 1.4.2 ADHD行为干预理论的研究现状

ADHD的核心困难在于"知行分离"，即儿童知道该做什么，但无法控制自己去执行。针对这一痛点，国内外学者提出了多种行为干预模型，为本系统的功能设计提供了坚实的理论支撑。

（1）执行功能与时间盲区理论

国际著名的ADHD专家Russell A. Barkley博士提出了极具影响力的"执行功能缺陷"理论[1]。他指出，ADHD的本质是自我调节能力的缺失，特别是"对未来的短视"（Time Blindness）。ADHD儿童无法感知时间的流逝，因此无法为了未来的奖励（如期末考试成绩）而控制当下的冲动（如玩游戏）。Barkley强调，干预必须发生在"执行点"（Point of Performance），即行为发生的当下和现场。这一理论是本课题引入硬件终端（ESP32玩偶）和环境锚点（NFC贴纸）的根本依据——通过物理设备的即时反馈，弥补儿童内在执行功能的不足。

（2）协作解决问题（CPS）模型

针对ADHD儿童常见的情绪爆发和对立违抗行为，Ross W. Greene博士提出了"协作解决问题"（Collaborative & Proactive Solutions，CPS）模型[2]。他认为"孩子如果能做好，就会做好"，问题行为是技能滞后的表现，而非主观意愿的对抗。Greene反对强制性的赏罚，主张通过共情、界定问题和邀请协作三个步骤来解决冲突。这一理论指导了本系统中"冷静角"和"树洞"功能的设计。

（3）认知行为疗法（CBT）在ADHD中的应用

认知行为疗法（Cognitive Behavioral Therapy，CBT）是循证心理治疗中针对ADHD的重要干预手段之一。CBT的核心在于识别并修正功能失调的认知模式，通过行为实验和强化正向认知来改善执行功能[3]。本系统的任务完成即时奖励机制正是基于CBT行为强化原则的数字化实现。

（4）本土化的家庭干预策略

由于文化差异，中国家庭在应对ADHD时面临特有的学业压力和亲子沟通挑战。台湾学者高淑芬详细阐述了华人社会中ADHD家庭的困境，并提出了家长与孩子共同成长的理念[4]。国内资深心理师王意中提供了将复杂任务拆解为极小步骤、利用视觉提示管理日常生活等大量极具操作性的微观策略[5]，直接启发了本系统"任务粉碎机"的功能逻辑。Edward M. Hallowell和John J. Ratey从优势视角出发，强调去羞耻化，认为ADHD特质包含创造力[6]，这提示系统交互设计中应多采用鼓励性、游戏化的反馈机制。

### 1.4.3 支撑技术的应用现状

（1）物联网（IoT）与智能硬件技术的研究现状

物联网技术使得物理环境的数字化交互成为可能，其在特殊教育领域的应用正呈现出显著的国内外差异。

在国外，基于"环境辅助生活"（Ambient Assisted Living，AAL）理念的研究较为成熟。研究者倾向于利用可穿戴设备和环境传感器监测ADHD儿童的生理指标及活动量，并通过智能家居系统提供语音提示和日程管理。然而现有系统多侧重被动监测，缺乏实时、游戏化互动。

在国内，王平探讨了基于物联网平台的智能家居控制系统，指出通过传感器和控制器构建家庭中心节点的必要性[7]。陈思凯[8]和董梁玉[9]深入研究了MQTT协议在物联网消息推送中的应用，指出该协议具有轻量级、低带宽占用、支持弱网环境的特点，非常适合移动设备与嵌入式设备之间的实时通信。乐鑫信息科技发布的ESP32-S3技术参考手册显示，该芯片集成了Wi-Fi、蓝牙及强大的AI指令集，成本低廉，支持多种开发框架[10]，是构建家庭教育智能硬件的理想载体。

（2）软件架构与工程方法

李刚在其著作中详细论述了Spring Boot + Vue的全栈开发模式[11]。Spring Boot提供了开箱即用的后端框架，极大简化了企业级应用的配置与部署，适合处理高并发的用户请求和复杂的业务逻辑；Vue.js及其生态（如UniApp）则为前端提供了响应式的数据绑定和跨平台发布能力。张海藩在软件工程经典著作中强调了从需求分析到测试维护的全生命周期管理方法论[12]，是确保本系统从概念走向实用的工程保障。

（3）生成式人工智能（Generative AI）技术

Brown等人发布的关于GPT-3语言模型的研究，标志着AI在自然语言理解与生成方面取得了突破性进展[13]。大语言模型（LLM）具备强大的上下文理解和逻辑推理能力，这为解决ADHD儿童"任务拆解难"的问题提供了全新路径。通过提示工程（Prompt Engineering），可以利用LLM将模糊指令自动转化为结构化、游戏化的执行步骤，这是传统规则引擎无法比拟的。Vaswani等人提出的Transformer架构是现代大语言模型的核心基础[14]，其自注意力机制使模型能够捕获远距离语义依赖，为复杂任务的逐步拆解提供了扎实的模型理论基础。

### 1.4.4 发展趋势

综合上述研究，ADHD辅助系统的发展呈现出以下显著趋势：

（1）从"屏幕交互"向"环境智能"转变：利用IoT技术将交互融入物理空间，让环境本身成为辅助大脑的一部分，减少对屏幕的依赖。

（2）从"通用工具"向"AI自适应干预"升级：依托大语言模型能力，系统将变得更加懂人，能理解儿童情绪、动态调整拆解颗粒度，实现真正意义上的个性化干预。

（3）软硬结合的闭环生态：App（数据管理、家长控制）、云端（AI计算、多端同步）与硬件（现场干预、感官反馈）的深度融合，通过MQTT等协议打通数据孤岛，形成"感知-决策-干预-反馈"的完整闭环。

（4）强调家庭系统的整体支持：干预不仅针对儿童，更需支持家长，利用数据可视化技术缓解家长的焦虑，利用AI辅助家长生成科学的沟通话术，构建支持性的家庭生态系统。

### 1.4.5 总结

综上所述，虽然医学界和心理学界对ADHD的成因及干预策略已有了成熟的理论体系，计算机界在物联网、微服务架构及大模型应用上也积累了丰富的技术成果，但目前市场上仍缺乏将两者深度融合的产品。现有的辅助App往往缺乏物理环境的交互，而单一的教具又缺乏数据的连通性。本课题正是基于这一现状，尝试整合Spring Boot后端架构、UniApp前端技术、ESP32物联网硬件以及LLM大模型技术，构建一个符合Barkley"时间外化"理念和Greene"协作解决"理念的综合干预系统，对"AI+特殊教育"这一新兴领域进行积极探索。

---

# 第2章 系统分析

## 2.1 可行性分析

在正式进入系统设计阶段之前，需要从技术、经济和操作三个维度对本系统进行系统性的可行性论证，以确保项目研究的方向正确、资源合理、目标可达。

### 2.1.1 技术可行性

本系统所采用的各项核心技术均已高度成熟，具备充分的社区支持和工程化落地案例：

后端框架层面，Spring Boot 3作为Java生态中最主流的企业级应用框架，拥有庞大的开发者社区和丰富的文档资料，其自动配置机制和Starter依赖管理模式极大地降低了后端开发的复杂度。结合Spring Security、Spring Data JPA等生态组件，可以快速构建安全、稳定的RESTful API服务和WebSocket实时通信接口。Spring Boot 3进一步引入了对GraalVM Native Image的支持、Jakarta EE 10的完整兼容以及对响应式编程（Reactive Programming）的深度整合，为构建云原生微服务架构提供了强有力的框架支撑。

消息中间件层面，RabbitMQ是业界成熟的AMQP消息代理，在高并发场景下已被大量互联网企业验证其稳定性和可靠性。利用RabbitMQ的直连交换机（Direct Exchange）和主题交换机（Topic Exchange），可以灵活地将任务拆解请求路由至不同的AI Worker队列，实现服务的弹性扩缩容。

AI微服务层面，Python FastAPI是目前性能最优秀的Python异步Web框架之一，其原生支持异步非阻塞I/O，非常适合处理LLM推理这类I/O密集型任务。通过接入支持OpenAI API标准的大语言模型接口（如通义千问、文心一言、GPT-4等），可以快速实现任务拆解和情感分析功能，无需从头训练模型。

物联网硬件层面，ESP32-S3芯片由乐鑫科技生产，国内有完善的供应链和开发者生态。该芯片原生支持Wi-Fi 4（802.11 b/g/n）和Bluetooth 5.0双模通信，内置512KB SRAM和384KB ROM，支持ESP-IDF（基于FreeRTOS的实时操作系统）和Arduino两种开发框架，技术成熟度高。WS2812B可寻址RGB LED灯珠采用单线归零码通信协议，控制简单可靠；I2S数字音频接口支持MAX98357A等Class-D功放芯片，可直接驱动小型扬声器播放音频；RC522 NFC模块支持ISO 14443A标准，可读写Mifare系列NFC卡片和手机NFC标签。这些元器件均为国内成熟的通用电子元器件，工程实现无障碍。

通信协议层面，MQTT 3.1.1协议是物联网领域最主流的轻量级发布/订阅消息协议，由OASIS标准化组织维护。EMQX是国内领先的企业级MQTT消息代理软件，其开源版本即可支持百万级并发连接，完全满足本系统的需求。

前端框架层面，UniApp基于Vue 3的Composition API，支持HBuilderX一键编译到iOS、Android、H5及微信小程序等多个平台，其Easycom组件自动引用机制和uni-ui组件库大幅提升了开发效率。综上，本系统所涉及的全部技术栈均处于成熟、稳定状态，技术可行性充分。

### 2.1.2 经济可行性

本系统的经济可行性主要体现在开发成本和推广成本两个方面。开发阶段可充分利用开源框架和免费的云服务试用额度，将研发成本控制在合理范围内。

硬件终端方面，单套设备的物料清单（BOM）成本估算如下：ESP32-S3开发板（带天线）约30元，WS2812B灯环（12颗）约5元，MAX98357A音频模块约8元，小型扬声器（1W/8Ω）约3元，RC522 NFC读写模块约6元，3D打印外壳（玩偶壳体）约15元，其他零部件（电源管理、连接线材等）约20元，合计单套硬件BOM成本约87元，控制在百元以内，远低于市面上同类教育硬件产品的售价（通常在300-1000元区间）。

软件部分，后端服务可部署于阿里云或腾讯云的低配云服务器（2核4GB内存），月费用约30-50元；数据库PostgreSQL为开源免费软件；EMQX消息代理开源版免费；前端App通过HBuilderX免费打包；大语言模型API调用按Token计费，根据估算，单个家庭每月的API调用费用约在1-5元之间，成本极低。整体运营成本对于目标用户群体（普通中国家庭）而言完全可接受，经济可行性良好。

### 2.1.3 操作可行性

本系统在用户操作层面遵循"零认知负荷"设计原则，全面考虑了ADHD儿童和普通家长的实际使用场景：

对于儿童用户，其主要交互界面是物联网硬件终端（玩偶），通过触摸NFC贴纸触发任务，通过观察灯光颜色感知当前状态，核心交互方式直觉化、无需文字阅读。儿童端App界面采用大字体、高对比度色彩和丰富的图标，单屏信息量严格控制，减少认知负担。

对于家长用户，App界面参照主流社交和教育类App的设计规范，采用底部导航栏结构，将"任务管理"、"今日概览"和"成长看板"三大核心功能置于首页一级入口，操作路径不超过三步。语音输入任务的功能设计，更是将家长的操作成本降至最低。

对于管理员用户，Web管理后台基于成熟的RuoYi框架搭建，提供标准的用户列表、权限配置和系统参数管理界面，符合具有基本IT背景的管理人员的操作习惯。综上，本系统在操作层面充分考虑了不同角色用户的实际能力，操作可行性良好。

## 2.2 功能需求分析

本系统的用户角色分为三类：儿童用户（Children User）、家长用户（Parent User）和管理员用户（Admin User）。以下从各角色视角对系统的功能需求进行详细描述。

### 2.2.1 儿童端（硬件+App）

儿童是系统的核心服务对象，其主要交互界面分为两部分：物联网硬件终端（ESP32玩偶）和儿童端App界面。

物联网硬件终端的功能需求如下：

任务启动感应功能：硬件终端内置NFC读写模块，能够识别预先配置的NFC贴纸（环境锚点）。当儿童将玩偶靠近特定场所的NFC贴纸时（如书桌上的"学习贴"），玩偶通过Wi-Fi向EMQX Broker发布包含设备ID和NFC标签ID的MQTT消息，由服务端解析并触发对应任务的开始指令，同时向该设备推送任务详情（包含当前微步骤文本和语音引导语）。

多感官状态反馈功能：WS2812B灯环根据当前任务状态呈现不同的灯光效果：任务进行中为蓝色呼吸灯，表示"专注模式"；任务完成时为绿色流水灯动画，配合欢呼音效，给予正向情感反馈；任务超时或儿童主动终止任务时，为黄色闪烁，配合温和的提示音；休息和冷静模式下，灯环呈现柔和的粉色或紫色静态光，辅助儿童情绪平复。

语音播报引导功能：通过MAX98357A音频模块和小型扬声器，在任务开始时播报由LLM生成的鼓励性语音引导语；在任务切换时，自动播报下一个微步骤的语音提示；在任务完成时，播报个性化的表扬话语。

倒计时视觉反馈功能：在执行有时间限制的任务时，WS2812B灯环通过逐渐熄灭部分灯珠的方式，直观地呈现剩余时间比例，将抽象的"时间"转化为可视的物理信号，帮助儿童建立时间感知。

儿童端App的功能需求如下：今日任务清单，以卡片式列表展示今日待完成的任务；星星账户与奖励兑换，支持浏览家长配置的奖励列表并发起兑换；成就徽章展示，以可视化徽章墙激励持续行为改善；语音树洞，提供私密的语音录入入口用于表达心情。

### 2.2.2 家长端（App）

家长是系统的主要管理者，其功能需求覆盖任务管理、数据监控和家庭互动三大核心模块。

任务管理模块：支持语音/文字输入模糊指令，由AI自动拆解为微步骤；提供内置常见任务模板库；支持日历视图管理任务时间安排和重复任务配置。

数据监控模块：以仪表盘形式展示今日概览（任务完成率、获得星星数、活跃时段分布）；提供周/月维度的成长看板（趋势图、完成率对比图、星星收支流水）；由LLM周期性生成儿童行为分析报告（AI心理画像）。

情感连接模块：实时接收儿童情绪树洞通知；支持向硬件终端发送亲子鼓励卡；灵活配置奖励商城内容。

### 2.2.3 管理员端（Web）

管理员通过Web管理后台对整个系统进行运营维护管理，主要功能包括：用户管理（账户状态管理、家庭组关系维护）；Prompt模板管理（在线编辑LLM提示词模板，无需修改代码即可优化AI输出质量）；系统参数配置（在线修改关键业务参数，即时生效）；设备管理（查询在线设备状态、发送远程测试指令）；数据统计（平台级用户活跃度、任务量、AI调用量统计）。

注：所有隐私数据（语音树洞、儿童行为画像）需加密存储，且AI生成内容需经过敏感词过滤。

## 2.3 性能需求分析

性能需求是衡量系统可用性与用户体验的重要指标。针对本系统的实时交互与AI处理特性，设定以下性能目标：

### 2.3.1 实时性指标

IoT指令同步延迟：App发出"任务开始"指令到硬件终端灯光亮起的端到端延迟，应在正常网络条件下低于500ms，在弱网条件下低于1500ms。

App接口响应时长：用户在App端发起的常规CRUD操作（查询任务列表、更新任务状态等）的API响应时间P99值应在500ms以内，P95值在300ms以内。

数据实时同步延迟：儿童端完成任务的状态变更推送至家长端界面的延迟应在1秒以内（通过WebSocket长连接实现）。

### 2.3.2 AI处理效率

由于LLM推理存在固有耗时，系统通过异步消息队列（RabbitMQ）进行解耦：任务拆解（生成5-10个微步骤）的平均生成耗时应控制在5至30秒，并立即推送进度反馈；情感分析（单段语音转写+情绪分类）的处理耗时应在3至15秒；AI心理画像可允许最长60秒的后台异步生成时间。

### 2.3.3 系统承载力

服务端应具备单机支持不低于1000个并发活跃用户和500个以上在线IoT长连接设备的能力；数据库在数据量达到100万条任务执行记录时，常用查询接口的响应时间应在500ms以内；EMQX消息代理在承载500个在线MQTT客户端时，消息吞吐量应能维持在每秒5000条以上。

### 2.3.4 硬件能效

ESP32-S3终端在Wi-Fi已连接的待机状态下，整机平均功耗不超过80mA；在执行任务（灯环全亮+音频播放）的工作状态下，峰值电流控制在300mA以内。以3.7V/500mAh锂电池供电，结合日均1至2小时的实际使用时长，充一次电可满足3至5天的正常使用需求。

## 2.4 数据需求分析

本系统的数据需求涵盖以下几个主要类别：

用户与设备数据：包括家长账户信息、儿童档案信息（昵称、年龄、ADHD类型、每日任务配置等）及IoT硬件设备的绑定关系。儿童档案中的个性化配置采用JSONB格式存储，以支持灵活的差异化设置。

任务数据：包括任务配置信息（任务标题、AI拆解后的微步骤序列、奖励设置、语音引导语等）和任务执行记录。任务微步骤序列以JSONB格式存储，每个步骤节点包含步骤序号、步骤描述、建议用时（秒）和对应的语音引导语字段。

积分与奖励数据：包括奖励配置（奖品信息、兑换价格、库存）、星星流水记录（每次获取或消费的明细）。

情绪与AI分析数据：包括语音树洞记录（音频文件存储路径、ASR转写文本、LLM情感分析结果）和周期性AI心理画像报告（以JSON格式存储的结构化分析结果）。系统需支持对上述数据的标准CRUD操作，以及多维度的聚合统计查询。所有涉及儿童隐私的数据均需在存储前进行加密处理，且仅向绑定的家长账号开放访问权限。

---

# 第3章 系统设计

## 3.1 系统架构设计

本系统采用前后端分离、AI微服务化的混合异构架构，整体设计遵循"高内聚、低耦合"的工程原则，划分为接入层、业务层、中间件层和数据层四个横向层次，以及IoT通信链路这一独立的纵向子系统。

### 3.1.1 接入层

接入层是所有外部流量进入系统的唯一入口，由两个核心组件组成：

Nginx反向代理：负责接收来自移动端App（基于UniApp开发）和Web管理后台的HTTP/HTTPS请求，执行SSL卸载（TLS Termination）后，将请求转发至后端Spring Boot应用集群。同时，Nginx配置了基于令牌桶算法的请求限速规则，防止API被恶意访问或意外的高并发冲击。对于WebSocket长连接请求（用于服务端向App推送实时事件），Nginx配置了相应的代理升级指令，确保WebSocket连接的稳定透传。

EMQX MQTT Broker：作为所有IoT设备的连接入口，EMQX负责管理ESP32-S3硬件终端的MQTT长连接生命周期。系统采用主题（Topic）层次化命名规范：设备上行主题（设备向服务端发布消息）格式为"/iot/{deviceId}/up"，服务端下行主题（服务端向指定设备推送指令）格式为"/iot/{deviceId}/down"，系统广播主题格式为"/iot/broadcast"。EMQX通过配置WebHook，将接收到的设备消息实时转发至Spring Boot服务端的HTTP接口，实现IoT消息与业务逻辑的桥接。

### 3.1.2 业务层

业务层由两个异构服务组成，各司其职：

Spring Boot 3应用服务（Java）：承担所有核心业务逻辑，包括用户认证与授权（基于Spring Security + JWT实现无状态认证）、设备绑定与管理、任务的CRUD操作、MQTT指令的封装与下发（通过调用EMQX REST API实现）、奖励与积分系统的原子性计算（利用PostgreSQL事务保证数据一致性）、WebSocket连接管理（维护与App客户端的长连接，用于服务端主动推送通知）。

Python FastAPI AI微服务（Python）：专注于AI推理相关功能，从RabbitMQ队列中消费任务拆解请求和情感分析请求，调用LLM API执行推理，将结构化的AI输出结果通过RabbitMQ的回调队列返回给Spring Boot服务。采用Python语言的主要原因在于其在AI/ML生态的绝对优势，以及对异步编程模型（asyncio）的原生支持，能够高效地处理LLM API的网络I/O等待。

### 3.1.3 中间件层

中间件层提供服务间通信与数据缓存的基础设施支撑：

RabbitMQ消息队列：作为Spring Boot服务与Python AI微服务之间的异步通信总线。当家长提交任务拆解请求时，Spring Boot服务将请求序列化后发布至名为"task.decompose"的消息队列；Python AI Worker从队列中消费该消息，完成LLM推理后，将结果发布至名为"task.decompose.result"的回调队列，Spring Boot服务通过监听该队列获取最终结果，并通过WebSocket推送通知给家长端App。这一异步解耦设计使得LLM的耗时推理不会阻塞主业务线程，系统的整体响应性能得到保障。

Redis缓存：用于存储以下热点数据：已认证用户的JWT Token黑名单（用于实现Token主动失效/登出功能）；儿童当前活跃任务的快照（存储当前正在执行的任务ID和步骤进度，供IoT设备快速查询）；设备在线状态缓存（存储每个设备ID的最后心跳时间戳，用于判断设备是否在线，设置TTL为120秒）。

### 3.1.4 数据层

数据层采用PostgreSQL 16作为唯一的持久化存储，选择其的核心原因在于：其对JSONB（二进制JSON）数据类型的原生支持，以及针对JSONB数据的GIN索引，使得存储和查询AI生成的非结构化数据（如任务微步骤序列、儿童个性化配置）既灵活高效，又保留了关系型数据库的ACID事务保障。同时，PostgreSQL强大的窗口函数和公共表表达式（CTE）能力，使得复杂的行为数据统计查询能够在数据库层面高效完成，避免将大量数据传输到应用层进行处理。

## 3.2 系统功能设计

系统的核心功能模块设计遵循"三端（儿童硬件端/App端、家长App端、管理员Web端）+ 一云（云端服务）"的四层架构。

云端服务核心功能模块划分为：用户与权限管理模块（注册、登录、家庭组绑定）；任务管理模块（任务创建、AI拆解调度、任务状态流转、任务完成确认）；IoT设备管理模块（设备注册、绑定、在线状态监控、指令下发）；奖励与积分模块（星星计算、奖励配置、兑换事务）；成就系统模块（成就定义、达成条件检查、徽章下发）；AI分析模块（任务拆解、情感分析、心理画像生成的调度与结果存储）；数据统计模块（多维度行为数据聚合查询）。

儿童硬件端功能模块：NFC场景锚点触发、MQTT连接与心跳维持、任务状态灯效渲染、音频指引播放、倒计时视觉反馈。

儿童App端功能模块：任务列表展示与进度更新、星星账户与奖励兑换、成就徽章展示、语音树洞录入与情感反馈查看。

家长App端功能模块：任务创建（语音/文字输入+AI拆解）、任务模板管理、今日概览仪表盘、成长看板（数据可视化）、AI心理画像查看、亲子鼓励卡发送、奖励商城管理。

管理员Web端功能模块：用户管理、Prompt模板管理、系统参数配置、IoT设备管理、平台数据统计。

## 3.3 数据库设计

本系统采用高性能的PostgreSQL 16作为核心数据库，在设计中引入了"JSONB结构化扩展"理念。这种设计为非固定步长的任务拆解步骤与个性化配置提供了极大的灵活性，能够完美兼容AI模块生成的动态数据。主要业务核心表设计如下：

### 3.3.1 儿童档案表（ss_child）

儿童档案表存储每位儿童用户的基础信息和个性化配置，是系统中的核心实体表之一。

| 字段名 | 数据类型 | 说明 |
|--------|----------|------|
| id | INT8 | 主键，使用Snowflake算法生成的分布式唯一ID |
| parent_id | INT8 | 外键，关联家长用户ID |
| nickname | VARCHAR(64) | 儿童昵称 |
| avatar_url | VARCHAR(255) | 头像URL |
| age | INT | 年龄 |
| adhd_type | CHAR(1) | ADHD类型：I=注意力不集中型，H=多动冲动型，C=混合型 |
| level | INT | 当前游戏等级，初始值为1 |
| daily_config | JSONB | 每日任务数量上限、专注时长配置等个性化参数 |
| star_balance | INT | 当前可用星星余额，非负约束 |
| create_time | TIMESTAMP | 账户创建时间 |
| update_time | TIMESTAMP | 最后更新时间 |

daily_config字段示例：

```json
{
  "max_daily_tasks": 5,
  "default_focus_minutes": 25,
  "rest_minutes": 5,
  "sound_volume": 70
}
```

### 3.3.2 任务配置表（ss_task）

任务配置表存储每个任务的完整定义，其中最核心的是sub_tasks字段，它以JSONB数组格式存储了AI拆解生成的微步骤序列。

| 字段名 | 数据类型 | 说明 |
|--------|----------|------|
| id | INT8 | 主键 |
| child_id | INT8 | 外键，关联儿童ID |
| title | VARCHAR(128) | 任务标题，由家长输入的原始指令 |
| sub_tasks | JSONB | AI拆解后的微步骤序列 |
| star_reward | INT | 完成全部微步骤的总奖励星星数 |
| voice_prompt | VARCHAR(255) | 任务开始时硬件端播报的总引导语 |
| trigger_nfc_tag | VARCHAR(64) | 触发该任务的NFC标签ID，为空则仅支持App手动触发 |
| schedule_type | CHAR(1) | 排期类型：O=一次性，D=每日重复，W=每周重复 |
| status | CHAR(1) | 任务启用状态：A=启用，D=禁用 |
| created_at | TIMESTAMP | 创建时间 |

sub_tasks字段中每个步骤包含step（序号）、desc（步骤描述）、duration_sec（建议用时）和voice（语音引导语）四个字段。

### 3.3.3 任务执行记录表（ss_task_log）

任务执行记录表是系统行为数据分析的核心数据来源，每次儿童开始执行任务时创建一条记录，任务结束时更新完成状态和奖励快照。

| 字段名 | 数据类型 | 说明 |
|--------|----------|------|
| id | INT8 | 主键 |
| task_id | INT8 | 外键，关联任务配置ID |
| child_id | INT8 | 外键，关联儿童ID |
| start_time | TIMESTAMP | 任务开始时间 |
| finish_time | TIMESTAMP | 任务实际结束时间，未完成则为NULL |
| status | CHAR(1) | 执行结果：F=完成，A=放弃，T=超时 |
| completed_steps | INT | 实际完成的微步骤数量 |
| total_steps | INT | 任务总微步骤数，冗余存储以加速统计 |
| reward_snap | INT | 实际获取的奖励星星数快照 |
| trigger_type | CHAR(1) | 触发方式：N=NFC触发，M=App手动触发 |
| device_id | VARCHAR(64) | 执行该任务的IoT设备ID |

### 3.3.4 奖励配置表（ss_reward）

| 字段名 | 数据类型 | 说明 |
|--------|----------|------|
| id | INT8 | 主键 |
| child_id | INT8 | 外键 |
| name | VARCHAR(128) | 奖品名称，如"看一集动画片" |
| description | VARCHAR(255) | 奖品详情描述 |
| star_cost | INT | 兑换所需星星数 |
| stock | INT | 剩余库存数量，-1代表无限库存 |
| status | CHAR(1) | A=上架，D=下架 |
| icon_url | VARCHAR(255) | 奖品图标URL |

### 3.3.5 星星流水记录表（ss_star_record）

星星流水记录表记录每一笔星星的获取和消费明细，构成儿童的星星账本，支持对星星余额的精确还原与审计。

| 字段名 | 数据类型 | 说明 |
|--------|----------|------|
| id | INT8 | 主键 |
| child_id | INT8 | 外键 |
| amount | INT | 变动额度，正值为获取，负值为消费 |
| balance_snap | INT | 变动后的余额快照，用于快速还原历史余额 |
| reason | VARCHAR(128) | 变动原因描述 |
| source_type | CHAR(1) | 来源类型：T=任务奖励，R=奖励兑换，A=成就奖励，G=家长赠予 |
| ref_id | INT8 | 关联的业务ID |
| create_time | TIMESTAMP | 创建时间 |

### 3.3.6 成就定义表（ss_achievement）

| 字段名 | 数据类型 | 说明 |
|--------|----------|------|
| id | INT8 | 主键 |
| name | VARCHAR(64) | 成就/勋章名称，如"早起的鸟儿" |
| description | VARCHAR(255) | 成就达成条件的文字描述 |
| icon_url | VARCHAR(255) | 成就勋章图标URL |
| condition_type | VARCHAR(32) | 达成条件类型，如TASK_COUNT_TOTAL、CONTINUOUS_DAYS |
| threshold | INT | 触发阈值数值 |
| reward_stars | INT | 成就达成的一次性星星奖励 |
| is_global | BOOLEAN | 是否为全局成就 |

通过上述设计，系统构建了从任务执行、资产获取到情绪反馈的完整数据闭环。JSONB字段的应用确保了系统在处理复杂业务逻辑时，既保留了关系型数据库的严谨性，又具备了对AI动态输出内容的强大承载力。

## 3.4 物联网通信设计

物联网通信是本系统的核心技术亮点之一，负责连接云端数字系统与物理硬件终端，实现毫秒级的双向指令交互。本节从协议选型、主题设计、消息格式和QoS策略四个维度详细阐述IoT通信的设计方案。

### 3.4.1 通信协议选型

本系统选择MQTT（Message Queuing Telemetry Transport）3.1.1协议作为IoT通信协议，选择MQTT的主要原因如下：

轻量级协议开销：MQTT协议头最小仅2字节，而HTTP/1.1的最小请求头通常在数百字节以上。对于ESP32-S3这类内存受限的嵌入式设备，更小的协议开销意味着更低的CPU处理负担和网络带宽占用，在弱网环境下的表现尤为突出。

发布/订阅模型的天然适配性：MQTT的发布/订阅模型与IoT场景的多对多通信需求高度契合。App端作为发布者，向特定设备的下行主题发布控制指令；硬件设备作为发布者，向其上行主题发布状态报告；服务端同时扮演订阅者和发布者的角色，Broker负责所有消息的路由，架构极为简洁。

QoS服务质量保障：MQTT定义了三种服务质量等级：QoS 0（最多一次，无应答确认）；QoS 1（至少一次，需要PUBACK确认，可能重复）；QoS 2（恰好一次，四步握手，不重复不丢失）。本系统对任务控制指令采用QoS 1，确保指令至少被设备接收一次；对设备状态上报采用QoS 0，以最小开销上报心跳；对星星奖励结算通知采用QoS 2，确保关键业务数据的精确一次传递。

遗嘱消息（LWT）机制：MQTT的LWT机制允许设备在注册连接时预先设置"遗嘱消息"，当设备异常断开时，Broker将自动发布该遗嘱消息。本系统利用LWT实现了设备掉线的自动感知：每台ESP32-S3设备连接EMQX时，设置LWT消息发布至"/iot/{deviceId}/status"主题，内容为{"online": false}；正常上线时主动发布{"online": true}至同一主题，服务端订阅该主题实时更新Redis中的设备在线状态缓存。

### 3.4.2 MQTT主题设计

本系统的MQTT主题采用层次化命名规范，各层含义如下：

设备上行主题（D→S）：

- `/iot/{deviceId}/heartbeat`：设备心跳，每30秒发布一次，Payload为设备当前状态JSON。
- `/iot/{deviceId}/event/nfc`：NFC标签扫描事件，Payload包含NFC标签UID，触发对应任务的执行。
- `/iot/{deviceId}/event/task_action`：任务操作事件，Payload包含操作类型（complete_step=完成当前步骤，abandon=放弃任务）和步骤序号。
- `/iot/{deviceId}/status`：设备上下线状态（含LWT遗嘱消息）。

服务端下行主题（S→D）：

- `/iot/{deviceId}/cmd/task_start`：任务开始指令，Payload包含当前任务名称、第一步骤描述、语音文本和灯效配置。
- `/iot/{deviceId}/cmd/next_step`：切换至下一步骤指令，Payload包含步骤序号、步骤描述、语音文本和剩余步骤数。
- `/iot/{deviceId}/cmd/task_end`：任务结束指令，Payload包含结束类型（complete/timeout/forced）和获得星星数。
- `/iot/{deviceId}/cmd/led_ctrl`：独立的灯效控制指令（用于亲子鼓励卡等非任务场景的灯效）。
- `/iot/{deviceId}/cmd/audio_play`：独立的音频播放指令（播放指定的提示音或家长录制的鼓励语音）。

### 3.4.3 MQTT消息Payload格式

所有MQTT消息的Payload均采用UTF-8编码的JSON字符串，以任务开始指令为例：

```json
{
  "cmd": "task_start",
  "task_id": "1234567890",
  "task_title": "做语文作业",
  "step": {
    "seq": 1,
    "desc": "把书包放到书桌旁边",
    "voice": "先把书包放到书桌旁边，准备好啦！",
    "duration_sec": 120
  },
  "total_steps": 5,
  "led": {
    "color": "#0080FF",
    "animation": "breathe",
    "brightness": 80
  },
  "audio": {
    "type": "tts",
    "text": "先把书包放到书桌旁边，准备好啦！",
    "volume": 70
  }
}
```

NFC扫描事件Payload示例：

```json
{
  "event": "nfc_scan",
  "device_id": "esp32s3_abc123",
  "nfc_uid": "04:A3:B2:C1:00:00:00",
  "rssi": -65,
  "battery_pct": 78,
  "timestamp": 1743426960000
}
```

## 3.5 服务端核心流程设计

### 3.5.1 任务拆解异步流程

任务拆解是本系统中涉及组件最多、流程最复杂的核心异步流程，其完整流程如下：

步骤1：家长在App端通过语音或文字输入任务指令，点击"AI智能拆解"按钮，App向Spring Boot服务发起POST /api/tasks/decompose请求。

步骤2：Spring Boot服务接收请求后，立即向App返回HTTP 202 Accepted响应，响应体包含异步任务的tracking_id；同时将任务拆解请求序列化为JSON消息，通过RabbitMQ发布至"task.decompose.queue"队列。

步骤3：Python FastAPI AI Worker从队列消费到该消息，构建包含系统角色提示、用户任务描述和JSON输出格式要求的Prompt，发送给LLM API获取响应，对输出进行JSON解析和合规性校验。

步骤4：AI Worker将校验后的微步骤数组发布至"task.decompose.result.queue"回调队列，消息携带原始请求的tracking_id作为correlationId。

步骤5：Spring Boot服务的RabbitMQ监听器接收到回调消息，根据correlationId找到对应的请求上下文，将AI生成的微步骤数组保存至PostgreSQL数据库，并通过WebSocket向该家长的App客户端推送任务创建完成通知。

步骤6：家长App收到WebSocket通知，自动刷新任务列表，家长在任务详情页查看AI生成的微步骤，进行预览、编辑和确认操作。

### 3.5.2 IoT任务触发与执行流程

当儿童用ESP32玩偶靠近NFC贴纸触发任务时，系统的完整执行流程如下：

步骤1：ESP32-S3的RC522 NFC模块检测到NFC标签，读取标签的UID，通过MQTT发布NFC扫描事件消息至"/iot/{deviceId}/event/nfc"主题。

步骤2：EMQX Broker通过WebHook将该MQTT消息转发至Spring Boot服务的IoT事件处理接口（POST /api/iot/event）。

步骤3：Spring Boot服务接收到NFC扫描事件后，根据nfc_uid查询关联的任务配置，在ss_task_log表中创建新的执行记录，状态为"进行中"；将任务的第一个微步骤封装为task_start指令，通过调用EMQX REST API向设备下行主题发布MQTT消息；同时通过WebSocket向家长App推送"儿童已开始任务"的实时通知。

步骤4：ESP32-S3接收到task_start指令，解析Payload中的灯效和音频配置；灯环切换为蓝色呼吸灯动画，扬声器播报语音引导语，设备进入任务执行状态。

步骤5：儿童完成当前步骤后，按压玩偶顶部的物理确认按钮，设备向"/iot/{deviceId}/event/task_action"主题发布步骤完成事件。

步骤6：服务端接收到步骤完成事件，更新ss_task_log中的completed_steps计数；判断是否还有下一步骤：如有，发布next_step指令，设备播放下一步骤的语音引导；如无（最后一个步骤完成），发布task_end指令（type=complete），设备触发完成庆祝动画和音效，服务端更新执行记录状态为"F"（完成），调用积分结算服务向儿童账户发放星星奖励，并通过WebSocket通知家长App。

---

# 第4章 系统实现

## 4.1 系统登录与鉴权实现

### 4.1.1 JWT无状态认证机制实现

本系统的认证模块基于Spring Security 6框架，采用JWT（JSON Web Token）实现无状态认证。相较于传统的服务端Session认证，JWT认证的令牌由客户端持有，服务端无需维护会话状态，更适合分布式部署场景和移动端应用。

JWT的生成逻辑封装在JwtTokenProvider类中，该类通过@Value注解注入JWT密钥和过期时间配置。生成Token时，系统将用户ID设置为Subject，将用户角色（PARENT/CHILD/ADMIN）作为自定义Claim写入，并设置签发时间和过期时间，最后使用HS512算法进行签名，生成紧凑的JWT字符串返回给客户端。

验证Token时，系统首先通过Jwts.parser()解析Token的签名和有效期，再查询Redis黑名单（用于支持主动登出时Token立即失效的需求）。Spring Security通过自定义JwtAuthenticationFilter（继承自OncePerRequestFilter）在每次HTTP请求进入业务Controller之前执行Token校验：从请求头的"Authorization: Bearer {token}"字段提取Token字符串，验证通过后从Token中解析userId和role，构建UsernamePasswordAuthenticationToken对象并设置到SecurityContextHolder，使后续的权限注解（@PreAuthorize）能够正常工作。

### 4.1.2 Spring Security权限体系

本系统定义了三种用户角色：ROLE_PARENT（家长）、ROLE_CHILD（儿童）和ROLE_ADMIN（管理员），通过Spring Security的方法级权限控制注解@PreAuthorize对各接口进行精细化的权限保护。家长API接口（/api/tasks/**、/api/rewards/**等）仅允许ROLE_PARENT角色访问；儿童API接口（/api/child/tasks/**、/api/stars/**等）仅允许ROLE_CHILD角色访问；管理员API接口（/api/admin/**）仅允许ROLE_ADMIN角色访问。IoT WebHook接口（/api/iot/**）通过IP白名单限制仅允许EMQX服务器的IP地址访问，不使用JWT认证，确保IoT事件处理的低延迟。

## 4.2 任务管理模块实现

### 4.2.1 任务创建与AI拆解接口

任务创建接口（POST /api/tasks）支持两种模式：同步创建（直接指定微步骤，不经过AI）和异步AI拆解（请求AI生成微步骤后由家长确认）。AI拆解模式的实现流程为：家长发起POST /api/tasks/decompose请求，Spring Boot服务立即返回HTTP 202 Accepted响应并携带tracking_id；与此同时，服务将任务拆解请求（包含child_id、taskTitle、childAge等上下文信息）序列化后通过RabbitTemplate发布至RabbitMQ的"task.decompose.queue"队列。消息发布时将tracking_id设置为消息的correlationId属性，作为异步任务的全局追踪标识。

### 4.2.2 AI微服务（Python FastAPI）核心实现

Python AI Worker通过Pika库以阻塞方式监听RabbitMQ队列，采用Python asyncio异步事件循环处理LLM API调用。AI Worker的核心逻辑包含以下步骤：

首先，构建系统角色Prompt，明确告知LLM其身份为"专业的ADHD儿童行为辅导专家，擅长将复杂任务拆解为ADHD儿童能够执行的小步骤"，并在系统Prompt中列出拆解原则（步骤必须单一具体可立即执行、步骤数量3-8个、duration_sec基于儿童年龄合理估算、voice字段语言风格充满鼓励且适合儿童）和输出格式要求（合法的JSON数组，不含其他内容）。

然后，构建用户Prompt，将任务标题、儿童年龄等上下文信息组织为自然语言，明确要求以JSON数组格式输出，每个元素包含desc（步骤描述，不超过20字）、duration_sec（建议用时）和voice（语音引导语，不超过30字）三个字段，并提供一个具体的输出示例以锚定格式。

接着，通过AsyncOpenAI客户端调用LLM API，设置temperature=0.7（平衡创意性与确定性），max_tokens=1000，并在模型支持时启用JSON模式（response_format={"type": "json_object"}）强制结构化输出。

最后，对LLM的响应进行JSON解析和合规性校验（检查每个步骤是否包含必填字段、步骤数量是否在允许范围内）。校验通过后，将微步骤数组作为消息体发布至"task.decompose.result.queue"回调队列，消息携带原始tracking_id作为correlationId，供Spring Boot服务识别并匹配等待中的请求上下文。

### 4.2.3 任务状态流转机制

每个任务配置（ss_task）的生命周期由以下状态构成：DRAFT（草稿，AI拆解中或家长未确认）→ ACTIVE（激活，可被触发）→ DISABLED（禁用，暂时不推送给儿童）→ DELETED（软删除）。

每次任务被触发执行时，系统在ss_task_log表中创建对应的执行记录，执行记录的状态由IN_PROGRESS（进行中）流转至FINISHED（完成）、ABANDONED（放弃）或TIMEOUT（超时）。系统通过Spring的@Scheduled定时任务，每分钟扫描一次处于IN_PROGRESS状态且超过任务配置时长1.5倍时间仍未结束的执行记录，自动将其标记为TIMEOUT状态，并向相关设备下发超时通知指令。

## 4.3 IoT设备管理模块实现

### 4.3.1 设备注册与绑定流程

IoT设备在出厂时已被烧录唯一的设备序列号（deviceId）和初始Wi-Fi配置二维码（该二维码指向设备的AP配网模式入口）。设备的注册绑定流程如下：家长在App中扫描设备外壳上的二维码，App自动跳转至设备绑定页面并提示用户完成Wi-Fi配网；配网成功后，设备通过MQTT连接EMQX，并发布初始化消息至"/iot/{deviceId}/status"主题；服务端接收到初始化消息后，在数据库中创建设备记录，并将其绑定至家长的家庭组；绑定成功后，家长可在App中为设备选择绑定的儿童档案。

### 4.3.2 EMQX WebHook处理接口

EMQX将接收到的设备MQTT消息通过HTTP WebHook转发至Spring Boot服务，对应处理接口（POST /api/iot/event）接收EMQX转发的消息，根据主题中的事件类型（heartbeat/event/nfc/event/task_action/status）调用对应的业务服务进行处理：

心跳处理（handleHeartbeat）：解析Payload中的电量、Wi-Fi信号强度等信息，更新Redis中的设备状态缓存（设置TTL=120秒），将超过120秒未收到心跳的设备标记为离线状态。

NFC扫描处理（handleNfcScan）：根据nfc_uid查询绑定的任务，验证设备归属权和任务可触发状态，创建执行记录，构建task_start指令下发至设备，并通过WebSocket通知家长端。

任务操作处理（handleTaskAction）：处理"完成当前步骤"和"放弃任务"两种操作。完成步骤时更新执行记录的completed_steps，判断是否还有下一步骤，据此下发next_step或task_end指令；放弃任务时将执行记录状态更新为ABANDONED，并下发任务终止灯效指令。

### 4.3.3 EMQX REST API调用封装

服务端通过调用EMQX REST API向特定设备下发MQTT指令，封装为EmqxApiClient类：

该类通过POST /api/v5/publish接口向指定主题发布MQTT消息，请求体包含topic（目标主题）、payload（JSON字符串格式的指令内容）和qos（消息质量等级，任务控制指令使用QoS=1）。为确保消息发布的可靠性，EmqxApiClient配置了WebClient的超时时间（connectTimeout=2秒，responseTimeout=5秒）和重试策略（最多重试2次，间隔500ms）。

## 4.4 积分与成就系统实现

### 4.4.1 星星账户服务实现

星星账户涉及余额的增减操作，必须保证事务的原子性，防止并发场景下的余额异常。本系统通过PostgreSQL的行级锁（SELECT FOR UPDATE，在JPA中通过@Lock(LockModeType.PESSIMISTIC_WRITE)实现）和Spring的@Transactional注解共同保障数据一致性。

发放星星奖励时（earnStars方法）：首先通过行级锁查询儿童档案，确保并发请求的顺序执行；计算新余额并更新ss_child表；创建星星流水记录（ss_star_record），记录变动额度（正值）、新余额快照、变动原因和来源类型，便于后续审计和历史余额还原。

消费星星时（spendStars方法）：在行级锁保护下查询当前余额，若余额不足则抛出InsufficientStarsException业务异常（HTTP 400），阻止兑换请求；余额充足则扣减余额并记录流水（amount为负值）。上述两个方法均通过@Transactional注解保证"更新余额+写入流水"操作的原子性，任意一步失败则整个事务回滚，确保余额与流水的强一致性。

### 4.4.2 成就达成检测

成就系统采用"任务完成后触发检测"的被动触发策略。每次任务完成时，系统调用AchievementService.checkAndAwardAchievements(childId)方法，该方法从数据库查询当前儿童尚未达成的全部成就定义，逐条检查达成条件是否满足：对于TASK_COUNT_TOTAL（累计完成任务数）类型的成就，查询ss_task_log中该儿童的FINISHED记录总数，与threshold比较；对于CONTINUOUS_DAYS（连续完成天数）类型的成就，通过SQL的DATE_TRUNC和LAG窗口函数计算连续有任务完成的自然天数，与threshold比较。

对于首次达成的成就，系统在ss_child_achievement表中插入达成记录，调用StarService.earnStars发放成就奖励星星，并通过WebSocket向家长App和儿童App同步推送成就解锁通知（含成就徽章图片URL和奖励数量），在硬件终端触发特殊的成就庆祝灯效和音效。

## 4.5 ESP32-S3硬件端实现

### 4.5.1 固件整体架构

ESP32-S3固件基于ESP-IDF v5.0开发，采用基于FreeRTOS的多任务架构，主要包含以下几个并行运行的FreeRTOS任务：

WiFiMqttTask（核心网络任务）：负责Wi-Fi连接、MQTT客户端初始化、心跳发布和MQTT消息接收/分发。优先级设为最高（priority=5），确保网络通信的实时响应。

LedControlTask（灯效控制任务）：从LED控制队列（led_cmd_queue）中消费灯效指令，执行灯效渲染（含静态色、呼吸灯、流水灯、倒计时灯等动画效果）。优先级设为中等（priority=3）。

AudioPlayTask（音频播放任务）：从音频播放队列（audio_cmd_queue）中消费音频播放指令，通过I2S接口驱动MAX98357A芯片输出音频，支持播放预存的WAV格式音效和基于HTTP下载的TTS合成音频。优先级设为中等（priority=3）。

NfcScanTask（NFC扫描任务）：持续轮询RC522模块检测NFC标签，检测到标签后将扫描事件提交至MQTT发送队列。优先级设为低（priority=2），每250ms轮询一次。

BatteryMonitorTask（电池监测任务）：每60秒通过ADC读取LiPo电池电压，估算电量百分比，更新全局电量状态，在电量低于20%时触发低电量警告灯效。优先级设为最低（priority=1）。

### 4.5.2 WS2812B灯效驱动实现

WS2812B采用单线归零码通信协议（1-Wire），对时序精度要求极高（0码：高电平0.3us，低电平0.9us；1码：高电平0.9us，低电平0.3us，误差±150ns）。ESP32-S3通过RMT（Remote Control Transceiver）外设驱动灯环，RMT外设内置硬件状态机可以精确输出纳秒级时序的波形，完全满足WS2812B的驱动要求，且不依赖CPU中断，不会因任务调度导致时序抖动。

系统对灯效进行了模块化封装，定义了以下灯效类型：SOLID_COLOR（单色静态光，传入RGB值和亮度参数）；BREATHE（呼吸灯动画，传入颜色、最小亮度、最大亮度和周期参数，通过正弦函数计算每帧的亮度值，以20ms为帧间隔刷新）；FLOW（流水灯动画，灯珠依次点亮/熄灭，用于完成庆祝场景）；COUNTDOWN（倒计时进度灯，根据传入的剩余比例值，点亮对应比例的灯珠数量，其余灯珠熄灭）；FLASH（闪烁灯，用于超时警告和设备配网状态指示）。

### 4.5.3 I2S音频播放实现

MAX98357A是一款支持I2S数字音频输入的Class-D单声道功放芯片，支持8kHz至96kHz的采样率，内置音量控制引脚（SD模式：GAIN引脚通过不同阻值的下拉电阻选择3dB/6dB/9dB/12dB增益）。

ESP32-S3通过I2S外设与MAX98357A连接，I2S接口配置为：采样率44100Hz，16位深度，单声道，标准I2S格式。音频播放支持两种模式：本地音效播放（将短促的音效文件（WAV格式，约100KB以内）存储于ESP32-S3的SPIFFS分区，播放时直接从SPIFFS读取PCM数据流写入I2S发送缓冲区）和TTS语音播报（云端生成的TTS合成语音通过HTTP下载至RAM缓冲区，再通过I2S输出，支持边下载边播放的流式播放模式，减少首次播放前的等待时间）。

### 4.5.4 MQTT客户端实现

使用ESP-IDF内置的esp_mqtt_client组件，在连接成功回调（MQTT_EVENT_CONNECTED）中完成以下初始化操作：订阅本设备的所有下行指令主题（通配符订阅"/iot/{deviceId}/cmd/#"，一次订阅即可接收所有指令类型）；发布设备上线状态消息（{"online": true, "firmware_version": "1.2.0"}）；启动心跳定时器（基于FreeRTOS的xTimerCreate，30秒周期）。

在MQTT_EVENT_DATA回调中，根据主题名称中的指令类型字段，将消息分发至对应的处理函数：task_start指令处理函数解析灯效和音频配置，分别提交至LED控制队列和音频播放队列，并启动任务超时计时器；next_step指令处理函数切换灯效（短暂闪烁一次表示步骤切换），播报下一步骤的语音引导；task_end指令处理函数根据结束类型（complete/timeout）触发不同的庆祝或提示灯效和音效，清空当前任务状态并停止超时计时器；led_ctrl指令处理函数直接解析灯效配置并提交至LED控制队列，用于亲子鼓励卡等独立灯效场景。

## 4.6 前端App关键功能实现

### 4.6.1 UniApp项目结构与状态管理

本系统的UniApp项目采用Vue 3 Composition API + Pinia状态管理库的技术组合。Pinia Store的设计遵循"按业务领域划分"的原则，定义了以下核心Store：useUserStore（当前登录用户信息、角色、JWT Token）；useChildStore（当前操作的儿童档案信息、星星余额）；useTaskStore（今日任务列表、当前进行中任务状态）；useWebSocketStore（WebSocket连接实例、消息监听器注册管理）。

WebSocket连接由useWebSocketStore统一管理，在用户登录成功后自动建立，在登出时关闭。WebSocket Store提供on(event, handler)和off(event, handler)方法，供各页面组件注册和注销特定事件的监听器，实现事件驱动的实时数据更新，避免页面间的强耦合。

### 4.6.2 家长端首页实现

家长端首页（今日概览）通过ECharts图表库（uni-app版本）展示儿童当日的行为数据。今日概览仪表盘使用ECharts的Gauge（仪表盘）图表展示当日任务完成率；活跃时段分布使用热力图（HeatMap）按小时维度展示任务执行的时间分布，帮助家长识别儿童的高效和低效时段。成长看板页面包含：周任务完成趋势折线图（Line Chart，X轴为最近7天日期，Y轴为当天完成任务数）；不同任务类型的完成率对比柱状图（Bar Chart）；星星收支趋势图（Bar Chart，正值为获取，负值为消费，直观展示激励效果）。

### 4.6.3 网络请求封装

系统通过封装uni.request为Promise风格的http工具函数，统一处理以下跨模块关注点：请求拦截（在请求头中自动添加"Authorization: Bearer {token}"）；响应拦截（统一处理HTTP 401未授权响应，自动跳转至登录页；处理业务错误码，弹出友好的错误提示）；Loading状态管理（自动在请求开始时显示加载提示，在请求结束时关闭，避免重复请求）。

## 4.7 管理员Web后台实现

### 4.7.1 Prompt模板管理模块

Prompt模板管理是本系统运营层面的核心功能，使运营人员能够在不修改代码、不重启服务的情况下，通过Web界面直接优化AI服务的Prompt内容。

Prompt模板存储于数据库的ss_prompt_template表中，每条记录包含：模板编码（唯一标识，如TASK_DECOMPOSE_SYSTEM、TASK_DECOMPOSE_USER）、模板内容（TEXT类型，支持Markdown格式）、版本号、启用状态和最后更新时间。

Python AI Worker在启动时从数据库加载所有启用中的Prompt模板，并缓存于内存中（TTL=5分钟）；AI推理时从缓存中获取对应编码的模板内容构建最终Prompt。管理员通过Web界面修改并保存新的模板后，可点击"立即生效"按钮，触发AI Worker的缓存刷新（通过AMQP广播一条cache_refresh命令实现），确保新Prompt在下次AI调用时即时生效，无需重启服务。

Web管理界面使用Monaco Editor（VS Code同款代码编辑器）作为Prompt内容的编辑组件，支持语法高亮（Markdown/Plain Text）、自动补全（内置变量提示，如{task_title}、{child_age}等）和版本对比（Diff视图，直观对比新旧Prompt的差异），极大地提升了运营人员的Prompt编写体验。

## 4.8 系统集成测试要点

在完成各模块的单元开发后，本系统对以下关键集成路径进行了端到端的集成测试：

IoT端到端链路测试：模拟ESP32-S3设备连接EMQX → 发布NFC扫描事件 → EMQX WebHook触发服务端接口 → 服务端创建执行记录并下发task_start指令 → EMQX将指令推送至设备 → 设备灯环亮起 → 家长App收到WebSocket推送通知，验证整条链路的端到端延迟和数据正确性。

AI拆解异步链路测试：家长App发起拆解请求 → Spring Boot发布RabbitMQ消息 → Python AI Worker消费并调用LLM API → AI Worker发布结果至回调队列 → Spring Boot监听回调并保存到数据库 → WebSocket推送通知至家长App，验证异步链路的数据完整性和超时处理机制。

星星账户并发安全测试：通过JMeter模拟10个并发请求同时对同一儿童账户发放星星奖励，验证行级锁机制是否能有效防止并发更新导致的余额丢失问题，检查最终余额是否等于10次奖励之和，流水记录数量是否精确为10条。

---

# 第5章 结论与展望

## 5.1 结论

本课题针对注意力缺陷多动障碍（ADHD）儿童在日常生活中面临的"知行分离"核心困境，设计并实现了一套融合物联网硬件终端、大语言模型智能微服务与多端协同移动应用的行为习惯辅助系统。通过系统的设计、开发与测试，本课题取得了以下主要研究成果：

第一，构建了完整的"感知-决策-干预-反馈"数字化行为干预闭环。系统以巴克利（Russell A. Barkley）的执行功能理论和"时间外化"理念为核心指导，将抽象的时间管理和任务执行能力外化为物理环境中可感知的光色变化与语音播报，在儿童的日常生活场景中实现了有效的"执行点"干预。通过NFC环境锚点触发、MQTT实时通信、多感官物理反馈的协同机制，系统能够在儿童行为发生的当下和现场提供即时、非侵入式的辅助引导，有效弥补了ADHD儿童内在执行功能的不足。

第二，成功将大语言模型技术应用于ADHD儿童的任务拆解场景。系统通过精心设计的Prompt工程，利用LLM将家长输入的模糊、宏观任务指令自动分解为细粒度、可执行的微步骤序列，并生成游戏化、鼓励性的语音引导文本，从根本上降低了儿童面对复杂任务时的认知负荷和启动困难。同时，系统通过RabbitMQ消息队列实现了Spring Boot主服务与Python AI微服务的异步解耦，确保了LLM推理的固有耗时不会阻塞系统的核心业务流程，保障了整体系统的响应性能。

第三，实现了软硬件深度融合的物联网通信架构。系统基于ESP32-S3芯片研制了低成本（BOM成本约87元）、低功耗的智能硬件玩偶终端，集成WS2812B全彩灯环、MAX98357A音频模块和RC522 NFC模块，通过MQTT协议与云端EMQX消息代理实现毫秒级的双向实时通信。系统充分利用了MQTT的QoS服务质量保障、遗嘱消息（LWT）机制和主题层次化命名规范，构建了稳定可靠的IoT通信链路。

第四，设计并实现了完善的游戏化激励体系。系统通过星星积分、奖励兑换和成就徽章三级激励机制，结合CBT行为强化原则，持续激励儿童形成良好的行为习惯。积分系统通过PostgreSQL行级锁和Spring事务管理保障了并发场景下的数据一致性。行为数据可视化看板和AI心理画像报告帮助家长更客观地了解孩子的行为规律，缓解教养焦虑。

第五，验证了"AI+IoT+特殊教育"融合应用的技术可行性。本课题系统性地探索了生成式AI与物联网技术在特殊教育辅助领域的融合应用范式，构建了一套完整的软硬件协同系统设计方法论，为后续类似研究提供了可参考的系统架构和技术选型依据。

## 5.2 后期展望

尽管本系统已实现了预期的核心功能并完成了基本的集成测试验证，但受限于研究时间和开发资源，仍有以下方面值得在后续工作中进一步深化和完善：

第一，临床效果验证与迭代优化。目前系统的功能设计主要基于理论分析和工程实现，尚未进行严格的临床对照试验。后续应与专业的儿童心理医疗机构合作，招募ADHD儿童家庭进行为期3至6个月的对照实验，通过标准化的行为评估量表（如Conners父母评定量表、SNAP-IV量表等）量化评估系统的实际干预效果，并根据实验数据持续优化系统的干预策略和AI Prompt模板。

第二，多模态情绪感知与自适应干预。当前系统的情绪感知主要依赖于儿童主动录入的语音树洞数据，属于被动获取模式。后续可引入计算机视觉技术，通过前置摄像头实时分析儿童的面部表情和肢体动作，结合生理信号传感器（如心率手环）采集的多维度数据，构建更加精准的情绪识别模型。当系统检测到儿童出现注意力涣散、焦虑或沮丧等情绪状态时，能够自动调整任务难度、切换灯效氛围或触发冷静引导流程，实现真正意义上的自适应干预。

第三，大语言模型的持续优化与本地化部署。当前系统的AI推理完全依赖云端LLM API调用，存在网络延迟和持续API费用的问题。随着边缘计算技术的发展，后续可探索在ESP32-S3或配套的边缘计算网关上部署轻量级的本地语言模型（如TinyLlama、Phi-3-mini等），实现离线场景下的基础任务拆解功能，降低对网络的依赖和运营成本。同时，可通过微调（Fine-tuning）技术，使用ADHD教育领域的专业语料对开源模型进行领域适配，提升AI输出的专业性和针对性。

第四，社交功能与同伴支持机制。ADHD儿童不仅需要个体化的行为干预，也需要社交技能的培养和同伴支持。后续可在系统中引入家庭间的社交功能，如"任务挑战赛"（不同家庭的儿童比拼任务完成情况）、"成就分享墙"（展示儿童获得的成就徽章）和"家长交流社区"（分享教养经验和AI生成的沟通话术），构建更加完整的支持性生态系统。

第五，多平台扩展与无障碍设计。当前系统的移动端基于UniApp框架开发，已支持iOS、Android和微信小程序。后续可进一步扩展至智能手表（WearOS/WatchOS）和智能音箱（如小爱同学、天猫精灵）等更多终端形态，使系统能够覆盖更多日常使用场景。同时，应加强无障碍设计（Accessibility），为伴有学习障碍或感觉统合障碍的儿童提供更大的字体、更简洁的界面和语音导航等辅助功能。

---

# 致谢

时光荏苒，四年的大学生活即将画上句号。在本次毕业设计完成之际，我谨向在学业和生活中给予我帮助与支持的师长、同学和家人致以最诚挚的感谢。

首先，我要衷心感谢我的指导教师薛庆水老师。从课题的选题方向、系统架构设计到论文的撰写修改，薛老师始终给予我悉心的指导和耐心的帮助。薛老师严谨的治学态度、深厚的学术功底和务实的工作作风，使我受益匪浅。在系统开发过程中遇到技术瓶颈时，薛老师总能从宏观架构层面给予启发性的建议，帮助我理清思路、突破难关。

其次，我要感谢计算机科学与信息工程学院的各位授课教师。四年来，是你们的辛勤教导为我打下了扎实的专业基础，使我具备了完成本课题所需的软件开发、数据库设计、计算机网络和人工智能等方面的知识与技能。特别感谢在Java程序设计、软件工程和物联网技术等课程中培养的工程实践能力，为本系统的设计与实现提供了直接的技术支撑。

同时，我要感谢与我朝夕相处的同学们。在毕业设计期间，同学们在技术讨论、代码审查和问题排查方面给予了我许多宝贵的帮助和建议。与你们共同学习、共同进步的时光，是我大学生活中最珍贵的回忆。

我还要特别感谢我的家人。感谢父母二十多年来对我的养育之恩和无私付出，是你们的理解、信任与鼓励，给予了我面对困难时坚持不懈的勇气和力量。

最后，感谢在ADHD儿童教育和数字疗法领域默默耕耘的医学工作者、心理学研究者和教育科技从业者。正是你们在各自领域的持续探索和积累，为本课题的理论基础和技术实现提供了丰富的参考和启示。希望本系统的设计与实现能够为ADHD儿童的成长之路贡献一份微薄的力量。

---

# 参考文献

[1] Barkley R A. Taking Charge of ADHD: The Complete, Authoritative Guide for Parents (Third Edition)[M]. New York: Guilford Press, 2020.

[2] Greene R W. The Explosive Child: A New Approach for Understanding and Parenting Easily Frustrated, Chronically Inflexible Children (Sixth Edition)[M]. New York: HarperCollins, 2021.

[3] Beck J S. Cognitive Behavior Therapy: Basics and Beyond (Third Edition)[M]. New York: Guilford Press, 2020.

[4] 高淑芬. 家有过动儿：帮助ADHD孩子快乐成长[M]. 台北市: 心灵工坊文化事业股份有限公司, 2013.

[5] 王意中. 301个过动儿教养秘诀[M]. 台北: 宝瓶文化, 2018.

[6] Hallowell E M, Ratey J J. ADHD 2.0: New Science and Essential Strategies for Thriving with Distraction[M]. New York: Random House, 2021.

[7] 王平. 基于物联网平台的智能家居控制系统设计与实现[J]. 计算机测量与控制, 2021, 29(5): 120-124.

[8] 陈思凯. 基于MQTT协议的物联网消息推送系统设计[J]. 物联网技术, 2022, 12(3): 56-59.

[9] 董梁玉. 轻量级MQTT协议在物联网中的应用研究[J]. 电子技术与软件工程, 2023, (2): 45-48.

[10] 乐鑫信息科技. ESP32-S3 技术参考手册[EB/OL]. https://docs.espressif.com/projects/esp-idf/zh_CN/latest/esp32s3/, 2024.

[11] 李刚. Spring Boot+Vue全栈开发实战[M]. 北京: 电子工业出版社, 2022.

[12] 张海藩, 牟永敏. 软件工程导论(第七版)[M]. 北京: 清华大学出版社, 2020.

[13] Brown T B, Mann B, Ryder N, et al. Language Models are Few-Shot Learners[C]//Advances in Neural Information Processing Systems. 2020, 33: 1877-1901.

[14] Vaswani A, Shazeer N, Parmar N, et al. Attention Is All You Need[C]//Advances in Neural Information Processing Systems. 2017, 30: 5998-6008.

---

# 附录A：ESP32-S3 MQTT连接核心代码

```cpp
/**
 * ESP32-S3 MQTT连接核心代码
 * 基于ESP-IDF v5.0框架
 * 功能：MQTT客户端初始化、连接管理、心跳维持、消息接收与分发
 */

#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/event_groups.h"
#include "esp_system.h"
#include "esp_wifi.h"
#include "esp_event.h"
#include "esp_log.h"
#include "esp_mqtt_client.h"
#include "nvs_flash.h"
#include "cJSON.h"

static const char *TAG = "MQTT_CLIENT";

// MQTT Broker配置
#define MQTT_BROKER_URI    "mqtts://your-emqx-server.com:8883"
#define MQTT_CLIENT_ID     "esp32s3_adhd_001"
#define DEVICE_ID          "esp32s3_adhd_001"

// MQTT主题定义
#define TOPIC_UP_HEARTBEAT     "/iot/" DEVICE_ID "/heartbeat"
#define TOPIC_UP_NFC_EVENT     "/iot/" DEVICE_ID "/event/nfc"
#define TOPIC_UP_TASK_ACTION   "/iot/" DEVICE_ID "/event/task_action"
#define TOPIC_UP_STATUS        "/iot/" DEVICE_ID "/status"
#define TOPIC_DOWN_CMD         "/iot/" DEVICE_ID "/cmd/#"

// 全局MQTT客户端句柄
static esp_mqtt_client_handle_t mqtt_client = NULL;

// 心跳定时器句柄
static TimerHandle_t heartbeat_timer = NULL;

/**
 * @brief 发布设备心跳消息
 *        每30秒由FreeRTOS软件定时器触发
 */
static void publish_heartbeat(TimerHandle_t xTimer)
{
    cJSON *root = cJSON_CreateObject();
    cJSON_AddStringToObject(root, "device_id", DEVICE_ID);
    cJSON_AddNumberToObject(root, "battery_pct", get_battery_percentage());
    cJSON_AddNumberToObject(root, "rssi", esp_wifi_sta_get_rssi());
    cJSON_AddNumberToObject(root, "timestamp", get_timestamp_ms());

    char *json_str = cJSON_PrintUnformatted(root);
    esp_mqtt_client_publish(mqtt_client, TOPIC_UP_HEARTBEAT,
                            json_str, 0, 1, 0); // QoS 1
    cJSON_free(json_str);
    cJSON_Delete(root);

    ESP_LOGI(TAG, "Heartbeat published");
}

/**
 * @brief MQTT事件处理回调函数
 *        处理连接成功、消息接收、断开连接等事件
 */
static esp_err_t mqtt_event_handler_cb(esp_mqtt_event_handle_t event)
{
    switch (event->event_id) {
        case MQTT_EVENT_CONNECTED:
            ESP_LOGI(TAG, "MQTT Connected to broker");

            // 发布设备上线状态
            char online_msg[128];
            snprintf(online_msg, sizeof(online_msg),
                     "{\"online\":true,\"firmware_version\":\"1.2.0\"}");
            esp_mqtt_client_publish(mqtt_client, TOPIC_UP_STATUS,
                                    online_msg, 0, 1, true); // retain

            // 订阅所有下行指令主题（通配符）
            int msg_id = esp_mqtt_client_subscribe(mqtt_client,
                                                   TOPIC_DOWN_CMD, 1); // QoS 1
            ESP_LOGI(TAG, "Subscribed to cmd topic, msg_id=%d", msg_id);

            // 启动心跳定时器（30秒周期）
            if (heartbeat_timer == NULL) {
                heartbeat_timer = xTimerCreate("heartbeat",
                    pdMS_TO_TICKS(30000), pdTRUE, NULL, publish_heartbeat);
                xTimerStart(heartbeat_timer, 0);
            }
            break;

        case MQTT_EVENT_DISCONNECTED:
            ESP_LOGW(TAG, "MQTT Disconnected");
            // 停止心跳定时器
            if (heartbeat_timer != NULL) {
                xTimerStop(heartbeat_timer, 0);
            }
            break;

        case MQTT_EVENT_DATA: {
            // 解析收到的MQTT消息
            char topic[128] = {0};
            char data[1024] = {0};
            strncpy(topic, event->topic, event->topic_len);
            strncpy(data, event->data, event->data_len);

            ESP_LOGI(TAG, "Received msg on topic: %s", topic);
            ESP_LOGI(TAG, "Payload: %.*s", event->data_len, event->data);

            // 根据主题分发指令
            if (strstr(topic, "cmd/task_start")) {
                handle_task_start_cmd(data);
            } else if (strstr(topic, "cmd/next_step")) {
                handle_next_step_cmd(data);
            } else if (strstr(topic, "cmd/task_end")) {
                handle_task_end_cmd(data);
            } else if (strstr(topic, "cmd/led_ctrl")) {
                handle_led_ctrl_cmd(data);
            } else if (strstr(topic, "cmd/audio_play")) {
                handle_audio_play_cmd(data);
            }
            break;
        }

        case MQTT_EVENT_ERROR:
            ESP_LOGE(TAG, "MQTT Error occurred");
            if (event->error_handle->error_type == MQTT_ERROR_TYPE_TCP_TRANSPORT) {
                ESP_LOGE(TAG, "Last error code: 0x%x",
                         event->error_handle->esp_tls_last_esp_err);
            }
            break;

        default:
            break;
    }
    return ESP_OK;
}

/**
 * @brief MQTT事件处理器包装函数
 */
static void mqtt_event_handler(void *handler_args,
                               esp_event_base_t base,
                               int32_t event_id,
                               void *event_data)
{
    mqtt_event_handler_cb((esp_mqtt_event_handle_t)event_data);
}

/**
 * @brief 初始化MQTT客户端并启动连接
 *        配置LWT遗嘱消息，设备异常断开时自动发布离线状态
 */
void mqtt_app_start(void)
{
    // 构建LWT遗嘱消息
    char lwt_msg[64];
    snprintf(lwt_msg, sizeof(lwt_msg), "{\"online\":false}");

    esp_mqtt_client_config_t mqtt_cfg = {
        .broker = {
            .uri = MQTT_BROKER_URI,
        },
        .client = {
            .client_id = MQTT_CLIENT_ID,
            .clean_session = true,
        },
        .credentials = {
            .authentication = {
                .certificate = NULL,  // 使用TLS证书认证
            },
        },
        .session = {
            .last_will = {
                .topic = TOPIC_UP_STATUS,
                .msg = lwt_msg,
                .msg_len = strlen(lwt_msg),
                .qos = 1,
                .retain = true,
            },
        },
        .network = {
            .reconnect_timeout_ms = 5000,  // 自动重连间隔5秒
        },
    };

    mqtt_client = esp_mqtt_client_init(&mqtt_cfg);

    // 注册MQTT事件处理器
    esp_mqtt_client_register_event(mqtt_client, ESP_EVENT_ANY_ID,
                                   mqtt_event_handler, NULL);

    // 启动MQTT客户端
    esp_mqtt_client_start(mqtt_client);

    ESP_LOGI(TAG, "MQTT client started, connecting to broker...");
}
```

---

# 附录B：LLM任务分解Prompt模板

```java
/**
 * LLM任务分解Prompt模板
 * Spring Boot后端服务中的Prompt构建逻辑
 * 用于将家长输入的模糊任务指令转化为ADHD儿童可执行的微步骤序列
 */

package com.adhd.assistant.ai.prompt;

import java.util.Map;

/**
 * 任务拆解系统角色Prompt模板
 * 定义LLM在任务拆解场景中的角色身份、行为准则和输出规范
 */
public class TaskDecomposePromptTemplate {

    /**
     * 系统角色Prompt（System Prompt）
     * 定义AI的角色身份和核心行为准则
     */
    public static final String SYSTEM_PROMPT = """
        你是一位专业的ADHD（注意力缺陷多动障碍）儿童行为辅导专家。
        你擅长将复杂的日常任务拆解为ADHD儿童能够独立执行的极小步骤。

        ## 拆解原则

        1. 每个步骤必须是单一、具体、可立即执行的动作。
           错误示例："整理书包"（太笼统）
           正确示例："把数学课本放进书包"（具体可执行）

        2. 步骤数量控制在3到8个之间，过多会让孩子感到压力。

        3. 每个步骤的预计用时（duration_sec）应根据儿童年龄合理估算：
           - 6-8岁：每个步骤建议60-180秒
           - 9-12岁：每个步骤建议120-300秒
           - 13岁以上：每个步骤建议180-600秒

        4. voice字段（语音引导语）的语言风格要求：
           - 充满鼓励和温暖，使用儿童友好的语言
           - 每句话不超过30个字
           - 可以适当使用拟声词和感叹号增加趣味性
           - 避免使用否定词（如"不要""不能"），改用正面引导

        5. 步骤之间应有清晰的逻辑顺序，遵循时间线或空间线。

        6. 最后一个步骤应包含"完成确认"的正面反馈。

        ## 输出格式要求

        你必须且只能输出一个合法的JSON数组，不要包含任何其他文字说明。
        每个数组元素包含以下三个字段：
        - desc: 步骤描述（不超过20个字）
        - duration_sec: 建议用时（整数，单位：秒）
        - voice: 语音引导语（不超过30个字）
        """;

    /**
     * 用户Prompt模板（User Prompt）
     * 使用占位符，运行时替换为实际的上下文信息
     */
    public static final String USER_PROMPT_TEMPLATE = """
        请将以下任务拆解为适合ADHD儿童执行的微步骤。

        ## 任务信息
        - 任务名称：{task_title}
        - 儿童年龄：{child_age}岁
        - ADHD类型：{adhd_type}

        ## 输出要求
        请以JSON数组格式输出，每个元素包含desc、duration_sec、voice三个字段。

        ## 输出示例
        [
          {
            "desc": "把铅笔和橡皮放在桌面上",
            "duration_sec": 30,
            "voice": "先把铅笔和橡皮拿出来，放在桌上哦！"
          },
          {
            "desc": "打开数学课本翻到第12页",
            "duration_sec": 60,
            "voice": "找到数学课本，翻到第12页，你真棒！"
          }
        ]

        现在请拆解任务：{task_title}
        """;

    /**
     * 构建最终的用户Prompt
     *
     * @param taskTitle 任务标题（家长输入的原始指令）
     * @param childAge  儿童年龄
     * @param adhdType  ADHD类型（I/H/C）
     * @return 填充后的完整用户Prompt
     */
    public static String buildUserPrompt(String taskTitle, int childAge,
                                         String adhdType) {
        String adhdTypeDesc = switch (adhdType) {
            case "I" -> "注意力不集中型（容易走神、遗忘）";
            case "H" -> "多动冲动型（坐不住、易冲动）";
            case "C" -> "混合型（兼具注意力不集中和多动冲动特征）";
            default -> "未指定";
        };

        return USER_PROMPT_TEMPLATE
                .replace("{task_title}", taskTitle)
                .replace("{child_age}", String.valueOf(childAge))
                .replace("{adhd_type}", adhdTypeDesc);
    }

    /**
     * 构建完整的消息列表（用于OpenAI API的messages参数）
     *
     * @param taskTitle 任务标题
     * @param childAge  儿童年龄
     * @param adhdType  ADHD类型
     * @return JSON格式的消息列表字符串
     */
    public static String buildMessages(String taskTitle, int childAge,
                                       String adhdType) {
        return """
            [
              {
                "role": "system",
                "content": %s
              },
              {
                "role": "user",
                "content": %s
              }
            ]
            """.formatted(
                escapeJson(SYSTEM_PROMPT),
                escapeJson(buildUserPrompt(taskTitle, childAge, adhdType))
            );
    }

    /**
     * JSON字符串转义工具方法
     */
    private static String escapeJson(String input) {
        return input
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
```

---

## 附录C：情感分析Prompt模板

```java
/**
 * 情感分析Prompt模板
 * 用于分析儿童"语音树洞"录音转写文本中的情绪状态
 * 输出结构化的情感分析报告，供家长查看和系统调整干预策略
 */
public class EmotionAnalysisPromptTemplate {

    /**
     * 系统角色Prompt
     */
    public static final String SYSTEM_PROMPT = """
        你是一位专业的儿童心理咨询师，专注于ADHD儿童的情绪分析。
        你需要根据儿童表达的文字内容，分析其当前的情绪状态。

        ## 分析维度

        1. 主情绪类别：从以下类别中选择最匹配的1-2个：
           - 开心（愉悦、满足、兴奋）
           - 平静（放松、安宁、专注）
           - 焦虑（紧张、担心、不安）
           - 沮丧（失落、难过、挫败）
           - 愤怒（生气、烦躁、不满）
           - 困惑（迷茫、不确定、无助）

        2. 情绪强度：1-5分（1=轻微，5=强烈）

        3. 情绪触发因素：识别导致该情绪的可能原因

        4. 风险评估：
           - 绿色（正常情绪波动，无需特别关注）
           - 黄色（情绪偏低或偏高，建议家长关注）
           - 红色（可能存在情绪危机，建议及时沟通）

        ## 输出格式要求

        你必须且只能输出一个合法的JSON对象，不要包含任何其他文字说明。
        字段定义：
        - emotion_type: 主情绪类别（字符串）
        - intensity: 情绪强度（整数1-5）
        - trigger: 情绪触发因素描述（不超过50字）
        - risk_level: 风险等级（"green"/"yellow"/"red"）
        - encouragement: 给家长的一段建议性话术（不超过80字，温暖专业）
        - child_response: 如果需要回复孩子，生成一段适合语音播报的鼓励话语（不超过60字）
        """;

    /**
     * 用户Prompt模板
     */
    public static final String USER_PROMPT_TEMPLATE = """
        请分析以下ADHD儿童的语音日记内容。

        ## 儿童信息
        - 昵称：{child_nickname}
        - 年龄：{child_age}岁
        - ADHD类型：{adhd_type}
        - 今日已完成任务数：{completed_tasks}
        - 获取星星数：{stars_earned}

        ## 语音转写内容
        {transcript_text}

        请输出JSON格式的情感分析结果。
        """;

    public static String buildUserPrompt(String childNickname, int childAge,
                                         String adhdType, int completedTasks,
                                         int starsEarned, String transcriptText) {
        return USER_PROMPT_TEMPLATE
                .replace("{child_nickname}", childNickname)
                .replace("{child_age}", String.valueOf(childAge))
                .replace("{adhd_type}", adhdType)
                .replace("{completed_tasks}", String.valueOf(completedTasks))
                .replace("{stars_earned}", String.valueOf(starsEarned))
                .replace("{transcript_text}", transcriptText);
    }
}
```

---

## 附录D：AI心理画像生成Prompt模板

```java
/**
 * AI心理画像（周期性行为分析报告）Prompt模板
 * 系统每周/月自动生成儿童的行为分析报告
 * 帮助家长客观了解孩子的行为规律和进步趋势
 */
public class PsychologicalProfilePromptTemplate {

    /**
     * 系统角色Prompt
     */
    public static final String SYSTEM_PROMPT = """
        你是一位资深的儿童发展心理学专家，擅长通过行为数据分析ADHD儿童的发展趋势。
        你需要根据系统提供的儿童行为数据，生成一份专业、温暖、可操作的心理画像报告。

        ## 报告结构要求

        请生成以下四个板块的内容，每个板块2-4句话：

        ### 1. 整体评估
        - 用积极、客观的语言总结儿童本周/本月的表现
        - 肯定进步，指出需要关注的方面
        - 避免使用负面标签或诊断性语言

        ### 2. 行为趋势分析
        - 分析任务完成率的变化趋势（上升/稳定/下降）
        - 识别高效时段和低效时段
        - 分析任务类型的偏好（哪些任务完成率高）

        ### 3. 情绪状态概览
        - 总结情绪记录的整体倾向
        - 识别情绪波动模式（如特定任务前焦虑）
        - 评估情绪调节能力的进步

        ### 4. 给家长的建议
        - 提供2-3条具体、可操作的家庭干预建议
        - 建议应基于数据，针对性强
        - 语言温暖专业，避免说教

        ## 语言风格要求
        - 使用"小明"代替真实姓名（保护隐私）
        - 语气温暖、鼓励、专业
        - 避免使用医学术语
        - 每段文字不超过100字

        ## 输出格式要求
        输出合法的JSON对象，字段如下：
        - overall: 整体评估文字
        - behavior_trend: 行为趋势分析文字
        - emotion_overview: 情绪状态概览文字
        - parent_advice: 给家长的建议文字
        - highlight: 本周亮点描述（1句话，不超过40字）
        """;

    /**
     * 用户Prompt模板
     */
    public static final String USER_PROMPT_TEMPLATE = """
        请根据以下行为数据，生成{period_type}的心理画像报告。

        ## 儿童信息
        - 昵称：{child_nickname}
        - 年龄：{child_age}岁

        ## 行为数据统计
        - 统计周期：{period_start} 至 {period_end}
        - 总任务数：{total_tasks}
        - 完成任务数：{completed_tasks}
        - 任务完成率：{completion_rate}%
        - 放弃任务数：{abandoned_tasks}
        - 超时任务数：{timeout_tasks}
        - 获取星星总数：{total_stars}
        - 消费星星总数：{spent_stars}
        - 平均每任务用时：{avg_duration}分钟
        - 最活跃时段：{peak_hours}
        - 完成率最高任务类型：{best_task_type}
        - 完成率最低任务类型：{worst_task_type}

        ## 情绪数据统计
        - 语音树洞记录数：{diary_count}
        - 最常见情绪：{top_emotion}
        - 情绪风险事件数：{risk_events}

        ## 成就解锁
        - 本期新解锁成就：{new_achievements}

        请输出JSON格式的心理画像报告。
        """;

    public static String buildUserPrompt(Map<String, String> params) {
        String result = USER_PROMPT_TEMPLATE;
        for (Map.Entry<String, String> entry : params.entrySet()) {
            result = result.replace("{" + entry.getKey() + "}", entry.getValue());
        }
        return result;
    }
}
```

---

## 附录E：亲子鼓励卡生成Prompt模板

```java
/**
 * 亲子鼓励卡Prompt模板
 * 家长可输入简短描述，系统生成温暖鼓励的语音文本
 * 通过硬件终端播放，增强亲子情感连接
 */
public class EncouragementCardPromptTemplate {

    /**
     * 系统角色Prompt
     */
    public static final String SYSTEM_PROMPT = """
        你是一位温暖、有爱心的儿童心理辅导老师。
        你需要根据家长提供的场景描述，生成一段适合通过智能硬件语音播报的鼓励话语。

        ## 生成原则

        1. 话语长度控制在20-40字之间，适合语音播报。
        2. 语气温暖、真诚、有力量，让孩子感受到被爱和被认可。
        3. 使用孩子能理解的语言，避免抽象概念。
        4. 肯定孩子的努力而非仅关注结果。
        5. 可以适当使用孩子的昵称增加亲切感。
        6. 避免说教、命令或施加压力。
        7. 不要提及ADHD、注意力缺陷等标签化词汇。

        ## 输出格式要求
        输出合法的JSON对象：
        - voice_text: 语音播报文本（20-40字）
        - led_suggestion: 建议的灯效类型（"warm_glow"/"celebration"/"rainbow"/"heartbeat"）
        - duration_sec: 建议播报时长（秒，整数）
        """;

    /**
     * 用户Prompt模板
     */
    public static final String USER_PROMPT_TEMPLATE = """
        请为以下场景生成一段鼓励话语。

        ## 场景信息
        - 孩子昵称：{child_nickname}
        - 场景描述：{scenario}
        - 家长想说的话：{parent_message}

        ## 场景类型参考
        - 早晨起床鼓励
        - 开始做作业前的加油
        - 完成任务后的表扬
        - 遇到困难时的安慰
        - 睡前温馨道晚安
        - 考试前的减压鼓励
        - 长时间专注后的肯定

        请输出JSON格式的鼓励卡内容。
        """;

    public static String buildUserPrompt(String childNickname,
                                         String scenario, String parentMessage) {
        return USER_PROMPT_TEMPLATE
                .replace("{child_nickname}", childNickname)
                .replace("{scenario}", scenario)
                .replace("{parent_message}", parentMessage);
    }
}
```

---

## 附录F：家长沟通话术生成Prompt模板

```java
/**
 * 家长沟通话术Prompt模板
 * 基于儿童近期行为数据，为家长生成科学的沟通建议
 * 帮助家长改善亲子沟通，减少冲突
 */
public class ParentCommunicationPromptTemplate {

    /**
     * 系统角色Prompt
     */
    public static final String SYSTEM_PROMPT = """
        你是一位资深的家庭心理咨询师，专注于ADHD儿童家庭的关系建设。
        你需要根据儿童近期的行为数据和情绪状态，为家长生成具体的沟通话术建议。

        ## 核心理念

        基于 Ross W. Greene 的"协作解决问题"（CPS）模型：
        1. 先共情，再解决问题
        2. 孩子如果能做好，就会做好
        3. 问题行为是技能滞后的表现，而非对抗

        ## 话术设计原则

        1. 每条话术应包含：情境描述 + 具体怎么说（直接引语）
        2. 话术长度控制在30-60字
        3. 使用"我"句式代替"你"句式（如"我注意到..."代替"你总是..."）
        4. 先描述观察到的客观事实，再表达感受和需求
        5. 提供选择而非命令（如"你打算先做A还是先做B？"）
        6. 避免否定、批评、威胁或比较

        ## 输出格式要求
        输出合法的JSON数组，每个元素包含：
        - scenario: 适用场景描述（不超过20字）
        - context: 触发情境说明（不超过30字）
        - talk: 具体沟通话术（30-60字，使用引号包裹的直接引语）
        - principle: 背后的心理学原则说明（不超过30字）
        最多生成5条话术。
        """;

    /**
     * 用户Prompt模板
     */
    public static final String USER_PROMPT_TEMPLATE = """
        请根据以下信息，为家长生成沟通话术建议。

        ## 儿童信息
        - 昵称：{child_nickname}
        - 年龄：{child_age}岁
        - ADHD类型：{adhd_type}

        ## 近期行为数据（最近7天）
        - 任务完成率：{completion_rate}%
        - 放弃任务次数：{abandoned_count}次
        - 最常见情绪：{top_emotion}
        - 情绪风险事件：{risk_events}次
        - 语音树洞关键词：{diary_keywords}

        ## 家长描述的困扰
        {parent_concern}

        请输出JSON数组格式的沟通话术建议。
        """;

    public static String buildUserPrompt(String childNickname, int childAge,
                                         String adhdType, String completionRate,
                                         int abandonedCount, String topEmotion,
                                         int riskEvents, String diaryKeywords,
                                         String parentConcern) {
        return USER_PROMPT_TEMPLATE
                .replace("{child_nickname}", childNickname)
                .replace("{child_age}", String.valueOf(childAge))
                .replace("{adhd_type}", adhdType)
                .replace("{completion_rate}", completionRate)
                .replace("{abandoned_count}", String.valueOf(abandonedCount))
                .replace("{top_emotion}", topEmotion)
                .replace("{risk_events}", String.valueOf(riskEvents))
                .replace("{diary_keywords}", diaryKeywords)
                .replace("{parent_concern}", parentConcern);
    }
}
```

---

## 附录G：任务难度动态调整Prompt模板

```java
/**
 * 任务难度动态调整Prompt模板
 * 当系统检测到儿童情绪低落或连续失败时
 * 自动调整后续任务的难度和鼓励策略
 */
public class TaskDifficultyAdjustPromptTemplate {

    /**
     * 系统角色Prompt
     */
    public static final String SYSTEM_PROMPT = """
        你是一位ADHD儿童教育专家，擅长根据儿童的实时状态调整任务难度。
        你的目标是确保儿童在"挑战"和"成功"之间找到最佳平衡点。

        ## 调整策略

        ### 降级策略（当儿童情绪低落或连续失败时）
        1. 减少步骤数量（原3-8个 → 2-4个）
        2. 增加每个步骤的预计用时（降低时间压力）
        3. 简化步骤描述（更短的指令）
        4. 增加鼓励性语音引导的频率
        5. 提高星星奖励倍率（1.5x-2x）

        ### 维持策略（当儿童状态正常时）
        1. 保持当前难度不变
        2. 正常的步骤数量和用时
        3. 标准奖励倍率（1x）

        ### 升级策略（当儿童连续成功且情绪积极时）
        1. 适当增加步骤数量（+1-2个）
        2. 引入轻微的自主决策环节（如"你想先做哪一步？"）
        3. 标准奖励倍率（1x）
        4. 增加成就解锁机会

        ## 输出格式要求
        输出合法的JSON对象：
        - strategy: 调整策略（"downgrade"/"maintain"/"upgrade"）
        - reason: 调整理由（不超过40字）
        - max_steps: 建议最大步骤数（整数）
        - time_multiplier: 用时倍率（浮点数，如1.5表示延长50%）
        - reward_multiplier: 奖励倍率（浮点数，如2.0表示双倍奖励）
        - encouragement_level: 鼓励强度（"low"/"medium"/"high"）
        - opening_voice: 任务开始时的特别鼓励语音（不超过50字）
        """;

    /**
     * 用户Prompt模板
     */
    public static final String USER_PROMPT_TEMPLATE = """
        请根据儿童的实时状态，判断是否需要调整下一个任务的难度。

        ## 儿童实时状态
        - 昵称：{child_nickname}
        - 当前情绪：{current_emotion}（强度：{emotion_intensity}/5）
        - 连续完成任务数：{streak_count}
        - 连续放弃任务数：{abandon_streak}
        - 今日任务完成率：{today_rate}%
        - 最近一次任务结果：{last_result}
        - 当前时间：{current_time}

        ## 下一个待执行任务
        - 任务名称：{next_task_title}
        - 原始步骤数：{original_steps}
        - 原始总用时：{original_duration}秒

        请输出JSON格式的难度调整建议。
        """;

    public static String buildUserPrompt(Map<String, String> params) {
        String result = USER_PROMPT_TEMPLATE;
        for (Map.Entry<String, String> entry : params.entrySet()) {
            result = result.replace("{" + entry.getKey() + "}", entry.getValue());
        }
        return result;
    }
}
```

---

## 附录H：敏感词过滤与内容安全Prompt模板

```java
/**
 * 内容安全审核Prompt模板
 * 对AI生成的所有面向儿童的内容进行安全审核
 * 确保输出内容不包含有害、不当或引发焦虑的信息
 */
public class ContentSafetyPromptTemplate {

    /**
     * 系统角色Prompt
     */
    public static final String SYSTEM_PROMPT = """
        你是一位儿童内容安全审核专家，负责审核面向ADHD儿童的AI生成内容。

        ## 审核标准

        以下类型的内容必须标记为"不通过"：

        1. **标签化语言**：提及"多动症""注意力缺陷""有病""不正常"等可能
           让儿童产生自我否定或羞耻感的内容。

        2. **过度压力**：包含"必须""一定要""否则"等强制性措辞，
           或暗示失败后果严重的内容。

        3. **负面比较**：将孩子与他人比较的内容，如"别的小朋友都能..."。

        4. **不切实际的期望**：超出儿童当前能力范围的要求。

        5. **恐惧诱导**：使用恐吓或威胁性语言来促使行为改变。

        6. **不适当的奖励承诺**：过度物质化的奖励暗示。

        ## 输出格式要求
        输出合法的JSON对象：
        - passed: 是否通过（布尔值true/false）
        - risk_type: 风险类型（"none"/"labeling"/"pressure"/"comparison"/
          "unrealistic"/"fear"/"materialistic"）
        - risk_detail: 风险说明（passed=false时填写，不超过50字）
        - suggestion: 修改建议（passed=false时填写，不超过60字）
        """;

    /**
     * 用户Prompt模板
     */
    public static final String USER_PROMPT_TEMPLATE = """
        请审核以下面向ADHD儿童的AI生成内容。

        ## 内容类型：{content_type}
        ## 目标儿童年龄：{child_age}岁
        ## 待审核内容：
        {content_to_review}

        请输出JSON格式的审核结果。
        """;

    /**
     * content_type可选值：
     * "task_step" - 任务步骤描述
     * "voice_guide" - 语音引导语
     * "encouragement" - 鼓励话语
     * "emotion_response" - 情绪回复
     * "parent_advice" - 家长建议
     */
    public static String buildUserPrompt(String contentType, int childAge,
                                         String contentToReview) {
        return USER_PROMPT_TEMPLATE
                .replace("{content_type}", contentType)
                .replace("{child_age}", String.valueOf(childAge))
                .replace("{content_to_review}", contentToReview);
    }
}
```
