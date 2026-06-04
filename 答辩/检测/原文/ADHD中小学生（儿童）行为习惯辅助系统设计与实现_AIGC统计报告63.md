上海应用技术大学
SHANGHAI INSTITUTE OF TECHNOLOGY

高等学历继续教育
本科毕业设计（论文）
课题名称：ADHD中小学生（儿童）行为习惯辅助
系统设计与实现
专    业：       计算机科学与技术
班    级：            2410420
学生学号：            241042025
学生姓名：            赵轩
指导教师：            薛庆水
2026年4月22日
ADHD中小学生（儿童）行为习惯辅助系统设计与实现
　　<span style="color: blue;">摘要：	注意缺陷多动障碍（Attention Deficit Hyperactivity Disorder, ADHD）是学龄期儿童较为普遍的神经发育性障碍，核心表现为注意力维持困难、活动过度及行为冲动。</span><span style="color: blue;">当前主流的药物调控与线下行为矫正在副作用风险、执行一致性等方面存在不足。</span><span style="color: blue;">借助数字化手段实施辅助干预已成新趋势，但现有软件在认知减负定制、亲子协同交互及动态激励等环节仍存短板。</span><span style="color: blue;"> 针对上述不足，设计并实现了一套面向ADHD中小学生的行为习惯养成综合辅助系统——“小步（Small Steps）”。</span><span style="color: blue;">系统采用前后端分离架构，通过儿童端、家长端和管理后台的协同，构建涵盖渐进式任务拆解、多模态激励与情绪追踪的数字化干预闭环。</span><span style="color: blue;">技术层面，后端基于Spring Boot 3与MyBatis-Plus搭建，选用Sa-Token实现多角色鉴权，采用Postgres与Redis管理数据；</span><span style="color: blue;">移动端利用UniApp与Vue 3实现双模式动态切换，通过TailwindCSS进行界面渲染。</span><span style="color: blue;"> 系统的核心创新在于集成大语言模型（LLM），通过分析儿童行为数据动态输出个性化寄语与激励建议，缓解执行疲劳，并引导家长从“检查者”转向“陪伴者”。</span><span style="color: blue;">测试表明，系统运行稳定且交互流畅，为ADHD日常数字辅助干预提供了可落地的工程实践方案。</span>
关键词： 注意力缺陷多动障碍；行为干预；Spring Boot 3；UniApp；Vue 3
　　Design and Implementation of ADHD Behavior Support System for Children
　　<span style="color: blue;">Abstract: 	Attention Deficit Hyperactivity Disorder (ADHD) is a prevalent neurodevelopmental disorder among school-age children, primarily characterized by difficulties in sustaining attention, hyperactivity, and impulsivity.</span><span style="color: blue;"> Current mainstream pharmacological and offline behavioral interventions have limitations in side effect risks and execution consistency.</span><span style="color: blue;"> Software-assisted intervention has become a new trend, but existing tools still lack customized cognitive load reduction, parent-child synergy, and dynamic motivation.</span><span style="color: blue;"> Addressing these shortcomings, “Small Steps”, a comprehensive behavioral habit-building support system for ADHD students, is designed and implemented.</span><span style="color: blue;"> Using a front-end and back-end separation architecture, the system operates across child, parent, and management terminals to create a closed-loop digital intervention encompassing progressive task breakdown, multimodal motivation, and emotion tracking.</span><span style="color: blue;"> Technically, the backend is built with Spring Boot 3 and MyBatis-Plus, integrated with Sa-Token for multi-role authentication, and utilizes Postgres and Redis for data management.</span><span style="color: blue;"> The mobile application uses UniApp and Vue 3 for dynamic dual-mode switching and TailwindCSS for interface rendering.</span><span style="color: blue;"> The system’s core innovation lies in integrating Large Language Models (LLM) to dynamically generate personalized messages and motivation strategies based on behavioral data.</span><span style="color: blue;"> This aims to alleviate execution fatigue and shift the parents’ role from “inspectors” to “companions”.</span><span style="color: blue;"> Tests show that the system is stable and user-friendly, providing a practical engineering paradigm for daily ADHD digital interventions.</span>
　　Keywords:	ADHD; Behavioral Intervention; Spring Boot 3; UniApp; Vue 3
目  录1	绪论11.1	研究背景11.2	研究目的11.3	研究意义21.4	研究现状和发展趋势31.4.1	传统行为干预与认知疗法的局限31.4.2	数字疗法与应用程序在 ADHD 干预中的发展31.4.3	现状总结与本系统的突破点31.5	开发相关技术51.5.1	后端技术栈 (Spring Boot 3, MyBatis-Plus)51.5.2	前端与 CSS 框架技术 (UniApp 与 TailwindCSS)51.5.3	权限管理技术 (Sa-Token)61.6	主要研究内容61.7	各章主要内容62	系统分析82.1	可行性分析82.1.1	技术可行性82.1.2	操作可行性82.1.3	理论指导可行性82.2	系统需求分析92.2.1	目标用户群体分析92.2.2	系统功能需求102.2.3	非功能性需求分析142.3	本章小结153	系统设计163.1	总体架构设计163.1.1	架构演进与逻辑分层设计163.1.2	前后端分离协同架构173.2	核心业务模块设计173.2.1	用户认证与鉴权模块设计 (基于 Sa-Token)173.2.2	任务管理与流程设计183.2.3	专注模式与时间管理机制设计183.2.4	智能辅助生成与数据反馈模型设计193.3	数据库设计193.3.1	设计原则与总体架构193.3.2	概念模型设计 (E-R模型)203.3.3	关系型数据库结构详述243.3.4	缓存策略与 Redis 结构设计293.4	本章小结294	系统实现304.1	系统登录304.2	后端统筹与接口实现 (smallsteps-api)304.2.1	安全认证与路由拦截的实现细节304.2.2	结构化任务与分发系统的业务逻辑实现314.2.3	数据看板聚合与智能数据生成的后端处理314.3	移动端应用框架与页面实现 (smallsteps-app)324.3.1	基础项目配置与 Vue 3 生态集成324.3.2	状态管理在双模式切换中的应用324.3.3	TailwindCSS 支持下的响应式页面构建344.3.4	核心交互流程实现 (任务卡片、番茄钟交互)344.4	Web 管理后台终端实现 (smallsteps-ui)384.4.1	管理员系统登录与权限控制384.4.2	后台数据图表与列表渲染实现384.5	本章小结395	系统测试405.1	测试环境与策略构建405.1.1	测试环境说明405.1.2	测试维度设计405.2	核心业务功能测试405.2.1	多角色权限与路由测试用例405.2.2	任务生命周期状态扭转测试415.3	本章小结416	总结与展望426.1	总结426.2	系统存在的不足与未来研究展望42致谢44参考文献45附  录46
1绪论
　　<span style="color: blue;">注意力缺陷多动障碍（ADHD）是儿童期最常见的神经发育障碍之一，其核心症状包括注意力不集中、多动和冲动。</span><span style="color: blue;">对于处于中小学阶段的患儿，这些症状严重影响了他们的学习效率、日常生活自理能力以及家庭关系。</span><span style="color: blue;">传统的干预手段主要依赖药物治疗和线下的行为矫正训练，但存在副作用明显、费用高昂、资源地域分布不均等问题。</span><span style="color: blue;">随着物联网（IoT）和人工智能（AI）技术的快速发展，数字疗法（Digital Therapeutics， DTx）逐渐成为ADHD干预的新趋势。</span><span style="color: blue;">然而，目前的辅助软件大多局限于单一的日程提醒或简单的番茄钟功能，缺乏针对ADHD“执行功能障碍”核心痛点的深度定制，且往往缺乏物理环境的交互，导致用户依从性低，难以形成长期的行为习惯。</span>
1.1研究背景
　　注意缺陷多动障碍（Attention Deficit Hyperactivity Disorder，简称 ADHD），俗称多动症，是儿童及青少年期最为常见的一种慢性神经发育障碍。<span style="color: blue;">在全球范围内，ADHD 的发病率居高不下。</span><span style="color: blue;">根据流行病学调查数据，全球学龄儿童中 ADHD 的患病率约为 5% 至 7%[1]，而在某些特定区域这一比例甚至更高。</span><span style="color: blue;">该障碍的核心临床症状主要表现为与年龄和发育水平不相符的注意力难以集中、活动过度（多动）以及行为冲动。</span><span style="color: blue;">这些症状不仅对患儿的智力发展无直接阻碍，但极其严重地削弱了他们的执行功能（Executive Function），如工作记忆、情绪调节、内在动机和计划组织能力[2]。</span>
　　<span style="color: blue;">在日常家庭生活和学校教育场景中，ADHD 儿童面临着巨大的生存和适应挑战。</span><span style="color: blue;">在学习方面，患儿常难以在课堂上保持坐姿，难以安静地听讲，注意力极易被外界无关刺激分散；</span><span style="color: blue;">在课后作业环节，他们通常表现出严重的拖延症，难以独立规划任务步骤，且作业错误率较高。</span><span style="color: blue;">在社交互动方面，由于控制冲动能力较弱，他们可能会在不适当的场合插嘴、打断他人对话，甚至引发肢体冲突，导致其在同伴关系中常遭受排斥和孤立。</span><span style="color: blue;">长期处于不断受挫的环境中，极易导致 ADHD 患儿衍生出低自尊、焦虑、抑郁等继发性心理障碍[3]。</span><span style="color: blue;">因此，如何有效地为 ADHD 儿童提供日常行为支持，降低他们的认知负荷，帮助其建立规律的生活学习习惯，是一个亟待解决的社会性难题。</span>
1.2研究目的
　　<span style="color: blue;">在传统的干预模式中，ADHD 的治疗主要分为药物治疗与行为干预两大类。</span><span style="color: blue;">药物干预（如盐酸哌甲酯等中枢神经系统兴奋剂）虽能在一定程度上迅速缓解核心症状，但在儿童群体中的广泛应用始终伴随着争议，其可能带来的食欲减退、失眠、生长发育抑制等副作用令许多家庭望而却步。</span><span style="color: blue;">人工行为干预（Parent Management Training, PMT 等）虽被公认为长期有效的干预手段，但其实施门槛极高，不仅需要专业的临床心理医师介入，更极大地依赖于家长长期、高度一致且科学的日常执行。</span><span style="color: blue;">然而，现实情况中，许多家长自身也承受着巨大的生活与工作压力，加之部分家长缺乏专业的心理学知识，在长期的“督促-反抗”拉锯战中，极易产生情绪失控，进而导致家庭关系紧张，陷入恶性循环的“相互消耗”之中[4]。</span>
　　<span style="color: blue;">在此背景下，数字化行为辅助工具（Digital Therapeutics & Behavior Assistance Tools）应运而生并彰显出极高的应用价值。</span><span style="color: blue;">数字化工具，尤其是基于智能手机的应用程序（App），具有全天候待命、客观无情绪波动、数据记录精准等特性。</span><span style="color: blue;">将其引入 ADHD 家庭干预中，可以扮演一个“第三方介质”的角色。</span><span style="color: blue;">一方面，它通过游戏化的方式和即时反馈机制，为多巴胺分泌偏低的 ADHD 儿童提供高频的正向刺激，将枯燥的日常任务转化为趣味挑战；</span><span style="color: blue;">另一方面，系统分担了家长“监工”的角色，减少了亲子间直接的言语摩擦，使家长能够将精力更多地投入到情感支持和陪伴中，从而有助于修复和改善家庭动力学（Family Dynamics）。</span>
1.3研究意义
　　尽管应用市场上已存在大量宣称具有“日程管理”、“时间追踪”、“番茄工作法”等功能的效率类 App，但这些通用工具在面对具有特殊脑神经基础的 ADHD 患儿时，往往表现出严重的水土不服：
1. 认知负荷过高：通用 App 的界面往往由于功能堆砌而显得极其复杂，充斥着各种图表、文字说明和层级繁多的菜单。对于执行功能受损的 ADHD 儿童而言，这是一种灾难性的视觉和认知噪音。
2. 缺乏颗粒度任务拆解：ADHD 儿童难以启动任务，往往是因为他们看到的是一个“庞大且不可战胜”的整体（如“做作业”）。通用工具极少提供强制性的、细颗粒度的前置拆解引导，导致辅助失效。
3. 僵化的反馈机制：多数工具采用冰冷的数据总结（如“你今天有 2 个任务未完成”），这种负向关注极易触发 ADHD 患儿的挫折感和习得性无助。他们需要的是包容失败、庆祝每一个微小进步（Small Steps）的即时温暖反馈。
4. 单边视角缺失：市面上的工具往往将焦点全盘压在执行者（儿童）身上，缺乏对于家长端心态干预的辅导机制，未能在家庭系统层面进行协同作战规划。
综上所述，当前市场迫切需要一款真正懂 ADHD儿童心理特性、强调情感陪伴、以降低认知负荷为核心设计理念的双端协同辅助系统，这也是立项的核心诉求。
1.4研究现状和发展趋势
1.4.1传统行为干预与认知疗法的局限
　　<span style="color: blue;">注意力缺陷多动障碍（Attention Deficit Hyperactivity Disorder, ADHD）是儿童期最常见的神经发育障碍之一。</span><span style="color: blue;">随着社会认知的提升和心理学研究的深入，ADHD 不再被简单视为儿童的“顽皮”或“管教缺失”，而是被定义为一种涉及执行功能（Executive Function）发育滞后的生理性障碍。</span><span style="color: blue;">传统的干预手段主要包括药物治疗和行为疗法，但在实际家庭场景中，家长往往缺乏专业的行为矫正技能，且药物治疗存在一定的副作用争议。</span><span style="color: blue;">近年来，随着物联网（IoT）、人工智能（AI）及移动互联网技术的爆发，利用计算机技术辅助ADHD儿童进行行为习惯养成，即“数字疗法”（Digital Therapeutics, DTx），已成为跨学科研究的热点。</span>本课题旨在结合心理学权威理论与现代信息技术，设计一套软硬件结合的辅助系统，以下将从理论基础、技术实现及未来趋势三个维度阐述国内外的研究现状。
　　长久以来，认知行为疗法（CBT）及代币经济系统（Token Economy）被广泛应用于ADHD的行为重塑中[5]。然而，受限于时空条件，治疗室内的干预效果泛化至自然家庭环境时往往大打折扣。家长作为非专业执行者，难以长时间维持奖惩标准的一致性，导致干预效果难以为继。这凸显了引入标准化、自动化技术辅助手段以维持干预一致性的必要性。
1.4.2数字疗法与应用程序在 ADHD 干预中的发展
　　<span style="color: blue;">近年来，国际前沿医疗机构及技术公司开始积极探索数字疗法（Digital Therapeutics, DTx）在神经精神类疾病中的应用[6]。</span><span style="color: blue;">2020年，美国食品和药物管理局（FDA）批准了全球首款针对 ADHD 的处方视频游戏 EndeavorRx[7]，这标志着游戏化数字干预正式被医疗界认可。</span><span style="color: blue;">在软件应用领域，诸多欧美国家的研发团队开发了旨在增强时间感知、提供日程规划的辅助系统。</span><span style="color: blue;">例如，运用智能手表震动提示来增强儿童的时间锚点意识。</span><span style="color: blue;"> 在国内，对于 ADHD 数字辅助软件的研发尚处于起步和快速发展期阶段。</span><span style="color: blue;">市面上的辅助手段多以在线问卷量表评估、知识付费课程以及基础维度的打卡工具为主。</span><span style="color: blue;">虽然部分开发者尝试引入积分奖励系统，但在交互细节和针对神经多样性群体（Neurodiversity）的定制化研究上仍显稚嫩。</span>
1.4.3现状总结与本系统的突破点
　　<span style="color: blue;">综合国内外的研究和应用现状，可以看出，利用移动互联网平台提供行为干预辅助已经成为大势所趋，但针对国内 ADHD 中小学群体，依然缺乏一套深度契合患者特质的家庭化解决方案。</span><span style="color: blue;"> “小步（Small Steps）”系统正是在这一背景下提出的。</span><span style="color: blue;">与现有系统的核心差异及突破点在于：</span>
　　<span style="color: blue;">极致的尊严优先化设计：抛弃了居高临下的“监督感”，一切交互设计基于“平辈陪伴者”的视角，不过度暴露任务失败带来的惩罚感。</span>
　　<span style="color: blue;">渐进式脱敏与脚手架结构（Scaffolding）：不仅提供日常提醒，更核心的是引入大语言模型（LLM）的智能分析，通过分析其完成任务的关键卡点，提供逐步退出（Fading）的辅助建议策略，最终目标是实现儿童独立自主。</span>
　　<span style="color: blue;"> 技术栈与架构的前瞻性重构：采用 Vue 3.0 与 Spring Boot 3 等现代化微服务工程化体系进行全栈开发，使用 UniApp 解决跨终端兼容问题。</span><span style="color: blue;">通过严谨的全链路数据追踪，将行为数据可视化呈现，打破了传统黑盒化的人工干预模式。</span>
　　<span style="color: blue;">综上所述，围绕 ADHD 中小学生面临的实际生活与学习困难，针对现存辅助工具的不足，运用现代计算机技术与软件工程架构，详细论述并实现了一套涵盖移动端（儿童+家长）与管理后端的“多角色业务闭环”辅助系统。</span><span style="color: blue;">在工程开发与理论验证两个维度设定了如下核心研究目标：</span>
　　<span style="color: blue;">核心理论映射到前端实现：如何将心理学中“降低认知负荷”、“代币奖励”、“及时正向反馈”等抽象概念，通过前端框架 UniApp 技术转化为具体可用的系统 UI 组件与交互流（如番茄钟、微小动效、色彩语言）。</span>
　　<span style="color: blue;">前后端分离架构下的安全性与高效性验证：深入探讨如何利用 Spring Boot 3 与 Sa-Token 技术，在保证系统高并发访问能力的前提下，实现细粒度的角色鉴权设计，并利用 Redis 提供可靠的多端状态维持与缓存支撑。</span>
　　<span style="color: blue;">基于大模型驱动的智能化反哺：研究如何在后端系统中稳定且低延迟地接入 LLM (大语言模型) 服务，基于儿童长周期的历史行为数据、多维度打卡状态，自动化生成个性化的寄语与针对性任务建议，探索 AI 技术在数字行为辅助领域的实践范式。</span>
　　<span style="color: blue;">全面的系统工程化与部署落地：完整展示从需求分析、数据库表设计架构、API 接口定义到最终前后端集成及基于 Docker 的 DevOps 部署的一整套软件工程闭环工作流。</span>
　　<span style="color: blue;">此外，本研究还将重点考察系统在实际家庭作业场景下的生态效度与用户体验接受度。</span><span style="color: blue;">在硬件交互层的远期演进上，本系统预留了面向 ESP32 嵌入式平台的语音交互扩展接口。</span><span style="color: blue;">区别于常规生物传感监测的被动采集模式，本研究将探索基于 ESP32-S3 模组的离线语音唤醒与低延迟流式对话方案，赋予系统一个具备实体感应的“物理伙伴”形态。</span><span style="color: blue;">通过部署轻量化 TTS 引擎与情感语音编码策略，ESP32 终端将被塑造为置于书桌一隅的静默陪伴实体，在无需屏幕介入的场景下，仅通过拟声反馈、呼吸灯效与短句鼓励完成对 ADHD 儿童执行意图的微弱锚定。</span><span style="color: blue;">此举旨在利用边缘计算优势降低云端隐私传输风险，同时以“非侵入式陪伴者”的角色缓解儿童面对复杂 UI 界面时的认知负荷。</span><span style="color: blue;">长远来看，软硬融合的语音交互框架将推动系统从单纯的数字化工具向具身智能伙伴演化，为神经多样性群体在家庭微环境中构建一个稳定、一致且具有温度感的“第二调节者”。</span>
1.5开发相关技术
本系统（小步 Small Steps）的研发在工程实施与理论指导两个方面均进行了严谨的选型与考量。在工程方面，采用了当前行业内成熟且极具前瞻性的前后端技术栈。本系统基于标准的 B/S（Browser/Server）与 C/S（Client/Server 移动端）混合演进的前后端分离架构，通过 RESTful API 进行松耦合的数据通讯。
1.5.1后端技术栈 (Spring Boot 3, MyBatis-Plus)
　　<span style="color: blue;">系统核心服务端选用了 Spring Boot 3.5.9 框架。</span><span style="color: blue;">作为 Java 生态中最为主流的微服务构建基础，Spring Boot 3 在依赖管理、自动配置和内置服务器方面具有无可比拟的优势。</span><span style="color: blue;">选择 3.x 版本主要是基于其对 JDK 17 的原生支持以及对 Spring Framework 6 的平滑集成，这为引入 AOT（Ahead-of-Time）编译优化与更高的运行效能提供了可能。</span><span style="color: blue;">在系统中，Spring Boot 承载了诸如全局异常处理、跨域资源共享（CORS）配置、以及统一响应结构封装等核心职责。</span>
　　<span style="color: blue;">在数据持久层，系统集成了 MyBatis-Plus 增强型 ORM 框架。</span><span style="color: blue;">考虑到系统中存在大量围绕“任务流转”与“用户状态统计”的复杂查询需求，直接使用传统的 MyBatis 会导致大量的样板代码（Boilerplate Code），而全自动的 JPA 又在复杂多表联查时缺乏足够的 SQL 定制化灵活性。</span><span style="color: blue;">MyBatis-Plus 完美地折中了这一矛盾，其内置的通用 Mapper 和条件构造器（Wrapper）大幅减少了基础单表 CRUD 的 XML 编写量，同时通过代码生成器引擎（AutoGenerator）极大地提高了数据库表到实体类（Entity）的映射效率，保证了项目快速迭代过程中的数据持久层质量[8]。</span>
1.5.2前端与 CSS 框架技术 (UniApp 与 TailwindCSS)
<span style="color: blue;">移动端选型方面，UniApp 3.0 框架可一次编写实现多平台（Android、H5、小程序等）的适配输出，Vue 3 生态的 Composition API 和 Pinia 状态管理工具链亦已趋于稳定，极大地提升了跨端开发效率。</span>
　　<span style="color: blue;">系统在 UI 渲染层引入了 TailwindCSS 原子化 CSS 框架。</span><span style="color: blue;">在传统的开发模式中，开发者经常需要为各种特定的卡片或按钮编写极易产生冲突的 BEM 命名规范的 CSS 文件。</span><span style="color: blue;">TailwindCSS 采用 Utility-First（效用优先）的理念，将诸如 flex、pt-4、text-center、rounded-lg 等原子类直接嵌在 HTML/Vue 模板中。</span><span style="color: blue;"> 针对 ADHD 儿童的界面设计对颜色对比度（如 text-gray-800 vs bg-white）、微小动画（如 transition-all duration-300 ease-in-out）有着极高的严苛要求。</span><span style="color: blue;">使用 TailwindCSS 使得开发者能够直接在 Vue 模板中速构并微调这些视觉呈现，彻底消除了“修改一处 CSS，影响全局布局”的样式污染风险。</span><span style="color: blue;">同时，其通过 PostCSS 构建工具在生产环境只会打包用到的类名，确保了移动端安装包及网页首屏加载的极小提及。</span>
1.5.3权限管理技术 (Sa-Token)
　　<span style="color: blue;">在安全防御与权限隔离层面，考虑到系统同时服务于“管理员、家庭主账号（家长）、附属子账号（儿童）”这一复杂结构，Spring Security 虽然功能强大但配置过于繁琐，学习曲线陡峭。</span><span style="color: blue;">因此，系统最终选用了国内开源的高性能轻量级权限认证框架 Sa-Token。</span>
　　<span style="color: blue;">Sa-Token 的核心优势在于其 API 极度贴合人类直觉，仅需 StpUtil.</span><span style="color: blue;">login(id) 一行代码即可完成会话登录。</span><span style="color: blue;">在此之上，系统利用其内置的拦截器引擎（Interceptor Engine）结合自定义注解（如 @RequiresRoles(“PARENT”)），优雅地实现了细粒度的接口方法级鉴权。</span><span style="color: blue;">此外，配合 Redis，Sa-Token 实现了 Token 的无状态分布式校验、同一端多账号踢出控制以及敏感操作的二次认证机制，以极低的代码侵入性构筑了坚实的安全壁垒。</span>
1.6主要研究内容
　　<span style="color: blue;">围绕 ADHD 中小学生面临的实际生活与学习困难，针对现存辅助工具的不足，运用现代计算机技术与软件工程架构，详细论述并实现了一套涵盖移动端（儿童+家长）与管理后端的“多角色业务闭环”辅助系统。</span><span style="color: blue;">在工程开发与理论验证两个维度设定了如下核心研究目标：</span>
　　<span style="color: blue;">核心理论映射到前端实现：如何将心理学中“降低认知负荷”、“代币奖励”、“及时正向反馈”等抽象概念，通过前端框架 UniApp 技术转化为具体可用的系统 UI 组件与交互流（如番茄钟、微小动效、色彩语言）。</span>
　　<span style="color: blue;">前后端分离架构下的安全性与高效性验证：深入探讨如何利用 Spring Boot 3 与 Sa-Token 技术，在保证系统高并发访问能力的前提下，实现细粒度的角色鉴权设计，并利用 Redis 提供可靠的多端状态维持与缓存支撑。</span>
　　<span style="color: blue;">基于大模型驱动的智能化反哺：研究如何在后端系统中稳定且低延迟地接入 LLM (大语言模型) 服务，基于儿童长周期的历史行为数据、多维度打卡状态，自动化生成个性化的寄语与针对性任务建议，探索 AI 技术在数字行为辅助领域的实践范式。</span>
　　<span style="color: blue;">全面的系统工程化与部署落地：完整展示从需求分析、数据库表设计架构、API 接口定义到最终前后端集成及基于 Docker 的 DevOps 部署的一整套软件工程闭环工作流。</span>
1.7各章主要内容
　　<span style="color: blue;">本文后续内容组织如下：第2章从可行性分析、系统需求分析两个角度奠定系统建设基础；</span><span style="color: blue;">第3章阐述系统总体架构设计、业务模块设计与数据库设计；</span><span style="color: blue;">第4章描述系统登录 、后端统筹与接口实现、移动端应用框架与页面实现以及Web管理后台终端实现的核心逻辑；</span><span style="color: blue;">第5章进行测试环境与策略构建与核心业务功能测试；</span><span style="color: blue;">第6章总结全文工作并对未来研究方向进行展望。</span>
2系统分析
　　<span style="color: blue;">在明确了系统的业务目标和相关的开发技术之后，本章将从系统的可行性入手，深入剖析目标用户的核心痛点，并在此基础上详细阐述系统在交互功能及非功能性能维度的具体需求规格，为后续的系统架构与数据库设计奠定基础。</span>
2.1可行性分析
　　“小步（Small Steps）”系统的研发在工程实施、操作体验与理论指导三个方面均进行了严谨的考量，以确保项目的顺利落地与后续的稳定运营。
2.1.1技术可行性
　　<span style="color: blue;">后端采用成熟的Spring Boot系统基于标准的 B/S（Browser/Server）与 C/S（Client/Server 移动端）混合演进的前后端分离架构，通过 RESTful API 进行松耦合的数据通讯。</span>
　　<span style="color: blue;">后端支撑：采用成熟的 Spring Boot 3 框架搭配 MyBatis-Plus 数据持久层，二者在 Java 生态中已经过大规模工程验证，具备极高的稳定性和海量的社区支持。</span>
　　<span style="color: blue;">前端展现：UniApp 3.0 框架可一次编写实现多平台（Android、H5）的适配输出，Vue 3 生态的 Composition API 和 Pinia 状态管理工具链亦已趋于稳定，大大降低了跨端开发成本。</span>
　　<span style="color: blue;">数据保障：使用广泛采用的 PostgreSQL 关系型数据库存储核心业务数据，辅以 Redis 处理高频缓存与防并发机制，为高并发场景提供了可靠的技术基础。</span><span style="color: blue;"> 综合来看，系统选用的技术栈成熟度高，技术方案具备高度可行性。</span>
2.1.2操作可行性
<span style="color: blue;">系统面向的终端用户包括 ADHD 儿童（6-15岁）及其家长。</span>
　　<span style="color: blue;">儿童端：交互设计严格遵循“零认知负荷”原则，采用大字体、大按钮和单线程任务呈现的方式，摒弃复杂的导航层级。</span><span style="color: blue;">操作流程力求直觉化，符合儿童的使用直觉，不要求用户具备任何技术背景。</span>
<span style="color: blue;">家长端与管理后台：家长端的功能布局参照主流移动应用的常见范式，操作逻辑清晰；</span><span style="color: blue;">管理后台采用标准化的 Element Plus 组件库，面向具备基本计算机操作能力的运营人员，操作门槛可控，极易上手。</span>
2.1.3理论指导可行性
<span style="color: blue;">系统并非简单的软件堆砌，其核心交互逻辑深度融合了心理学与教育学理论：</span>
　　<span style="color: blue;">认知负荷理论 (CLT)：通过界面的“认知卸载”设计（单线程呈现、低饱和色彩），释放患儿有限的工作记忆空间。</span>
　　<span style="color: blue;">脚手架理论 (Scaffolding)：通过 AI 研判实现的渐进式辅助（Fading Strategy），帮助患儿实现从“他律”向“自律”的平稳过渡[9]。</span>
　　<span style="color: blue;">操作性条件反射与系统家庭动力学：以随机、即时的正向游戏化反馈建立稳固的多巴胺循环，同时通过系统作为“缓冲介质”，将家长的角色从“裁判”重塑为“队友”，从理论底层保证了干预方案在家庭环境中的可行性与长效性。</span>
2.2系统需求分析
　　需求分析是软件工程流程中的关键环节，它决定了系统建设的边界与最终交付的价值。本节针对“小步”系统的双端目标受众特征进行深度剖析，并推导出相应的功能与非功能需求。
2.2.1目标用户群体分析
　　本系统的核心服务对象是一个双核架构：即干预的接受者（ADHD 儿童）与干预的辅助实施者（家长或监护人）。这两个群体在生理基础、心理预期及对软件的直观诉求上存在巨大差异。
（1）ADHD儿童与青少年的认知与行为画像
　　<span style="color: blue;">根据对全国各地多家特教机构及儿科门诊的实地调研采样，年龄在 6-15 岁区间的 ADHD 学龄群体具有以下显著的通用画像：</span>
　　<span style="color: blue;">注意力短暂且极度受兴趣驱动：对于高多巴胺刺激（如竞技游戏、短视频）能保持极强的专注力（Hyperfocus），但对于日常重复性任务（如洗漱、整理书包、背诵课文）的注意力通常维持不到 5-10 分钟。</span>
　　<span style="color: blue;">计划与时间感知盲区：脑内仿佛缺少一个内置的时钟，患儿极度缺乏对“预计耗时”的评估能力，经常表现出“磨洋工”或是到了最后一刻极度慌乱。</span>
　　<span style="color: blue;">高频情绪波动与极低挫折抗性：相较于神经典型（Neurotypical）儿童，他们更容易因为一点小失败而情绪崩溃大哭，或者直接选择放弃并表现出攻击性抗拒。</span>
　　基于上述画像，儿童端应用的需求底线是：零学习成本、极高的容错率、即时且剧烈的视觉/听觉奖励。该端口绝不能像一个“复杂的效率工具”，而应该像一个“了解他们心智的通关游戏界”。
（2）监护人的管理诉求与痛点分析
与此同时，陪伴 ADHD 患儿成长的家长群体亦是本系统的关键用户。他们的典型痛点包括：
　　监督疲劳与精力透支：每天需重复数百次相同的指令（如“去刷牙！”、“坐直！”），导致情绪耗竭（Burnout），引发高频率的家庭冲突。
　　过程盲盒与“虚假完成”困境：很多家长在辅导时极容易被孩子敷衍了事的“做完了”所蒙蔽，缺乏对任务完成质量与投入时长的系统性量化把控手段。
渴望科学的指导而非冰冷的说教：家长迫切需要能够告诉他们“在孩子此刻情绪崩溃时，我该怎么接话”的实操型辅助建议。 因此，家长端系统的需求必须围绕数据可视化可视、任务高效下发、以及智能辅助话术为中心展开，充当家长的“外脑”和“情绪稳定器”。
2.2.2系统功能需求
　　依据多角色业务流向，系统在功能域上划分为三大相互耦合的模块：儿童移动端、家长移动端以及全局管理后台终端。
（1）核心业务模块划分
　　<span style="color: blue;">总体而言，系统的核心业务围绕任务生命周期展开。</span><span style="color: blue;">家长在移动端创建并配置任务，将其分配至指定儿童账户；</span><span style="color: blue;">儿童通过专注模式执行任务并完成打卡；</span><span style="color: blue;">系统对行为数据进行实时记录与统计，并同步至家长端数据看板；</span><span style="color: blue;">在周期性时间窗口内（如每日夜间），系统调用外部大语言模型（LLM）对行为数据进行分析，生成个性化反馈与干预建议，从而形成“数据驱动”的行为优化闭环。</span>
<span style="color: blue;">为直观展示系统参与者与功能边界之间的关系，构建系统全局用例关系图如下所示 图 2.1：</span>

图 2.1全局用例图
（2）核心业务流程分析
　　在明确功能划分的基础上，为进一步描述系统内部交互顺序与数据流转过程，构建系统核心业务时序图，如 图 2.2：

图 2.2系统核心业务时序图
　　由该时序图可知，系统形成了完整的闭环流程：任务由家长发起，经由儿童执行产生行为数据，随后由系统进行汇总并反馈至家长，同时借助大语言模型生成进一步的干预建议。
为了进一步从数据视角描述系统运行机制，构建顶层数据流图如下：

图 2.3数据流图
（3）儿童端功能需求描述 (专注模式、任务打卡)
<span style="color: blue;">儿童端作为数据产生的触发源头，核心功能极尽精简，主要围绕以下几点：</span>
　　<span style="color: blue;"> 任务卡片极简展示：系统需以大字体、高宽容度图片（Icon）的方式，依次单线程展示当下的待办任务，支持一键“开始进行”或“暂缓跳过”。</span><span style="color: blue;">避免列表式平铺带来的压迫感。</span>
　　<span style="color: blue;"> 沉浸式专注模式（动态番茄钟）：提供基于番茄工作法变体的正计时与倒计时工具。</span><span style="color: blue;">在计时期间，屏幕需屏蔽外界干扰，以可视化的流水、沙漏或呼吸灯环等微小动效具象化“时间的流逝”，减轻时间流失焦虑。</span>
　　<span style="color: blue;"> 随手正向打卡与代币系统[10]：任务完成后，系统需触发绚丽的全屏成功动画，并即时发放虚拟碎片/代币。</span><span style="color: blue;">代币需自动归入进度池，进度可视化（如“蓄水池”概念），兑换由家长设定的心愿礼物。</span>

图 2.4儿童端功能
（4）家长端功能需求描述 (任务分发、数据查看)
<span style="color: blue;">家长端旨在为家庭管理者提供“发号施令”与“观测结果”的控制台：</span>
　　<span style="color: blue;">结构化任务创建与智能模版：家长可以新建任务，设置周期（如每日/每周三）、奖励代币数额以及强制性的前置步骤打卡（支持图文附件）。</span><span style="color: blue;">系统应内置常见的“起床仪式”、“作业准备”等模版供一键引用。</span>
　　<span style="color: blue;">实时数据与多维度数据看板：需支持查看孩子每日的总体任务完成率、累计专注时长、各任务平均超时情况。</span><span style="color: blue;">数据需以柱状图、环形图等直观形式呈现。</span>
　　<span style="color: blue;">AI 智能生成反馈：接收由大语言模型（LLM）基于前日数据自动撰写的、旨在安抚儿童情绪与肯定微小进步的“每日寄语”，并支持一键下发给儿童端。</span>

图 2.5家长端功能
（5）管理后台功能需求描述 (用户管理、系统监控)
<span style="color: blue;">管理后台主要供平台运营人员与超级管理员使用，核心保障系统的良性运作：</span>
　　<span style="color: blue;">系统用户与组织机构管理：实现对海量家长注册账号、儿童子账号状态的冻结、解封操作。</span><span style="color: blue;">监控平台日活与异常登录行为。</span>
<span style="color: blue;">公共素材库与模版审核：管理和维护全局任务库与系统内置的奖励图标、表扬音效素材，方便端侧应用拉取。</span>
　　<span style="color: blue;">大模型配置与运营监控：配置对接外部 LLM 的 API 密钥（如 DeepSeek/智谱等底层模型），监控生成 Token 的消耗量，并配置应对模型降级的兜底话术库。</span>

图 2.6管理后台
2.2.3非功能性需求分析
（1）性能与响应时延要求
　　<span style="color: blue;">高频打卡接口响应：考虑到专注模式结束时的状态同步与代币结算涉及跨库事务处理，系统核心 API 接口的响应时间（Response Time）需控制在 150 毫秒以内（99th Percentile），确保动画衔接无卡顿。</span>
　　<span style="color: blue;">大模型异步处理：由于 AI 寄语生成通常伴随着极长的链路延迟（10s-30s），此类功能不可阻塞主线程，必须采用消息队列或定时任务异步处理，保证界面的立即反馈。</span>
　　<span style="color: blue;">并发承载：晚间 20:00 - 21:00 是全国中小学生写作业的高峰时段。</span><span style="color: blue;">系统需至少支持单节点 1000 QPS（Query Per Second）的并发请求压力，以免由于瞬时流量峰值导致系统雪崩并波及患儿情绪。</span>
（2）系统安全性与用户隐私保护要求
　　<span style="color: blue;">未成年人数据隔离：ADHD 是极其敏感的个人健康隐私。</span><span style="color: blue;">数据库设计需遵循极小化采集原则，任何包含患儿姓名、生理缺陷识别的信息在入库时必须进行哈希混淆（Hashing）或非对称加密存储。</span>
　　<span style="color: blue;">API 防重放与防篡改：前端（App）发往后端的每一个含写操作的请求，均需经过严密的时间戳校验与请求签名（Signature Validate）比对，杜绝黑客伪造“完成任务以无限刷古代币”的恶意请求。</span>
　　<span style="color: blue;">角色越权防护：严格利用 Sa-Token 基于 RBAC（Role-Based Access Control）模型验证。</span><span style="color: blue;">不仅是在路由层，更要在核心业务逻辑中验证（如强制验证：当前家长账号只能查询其名下绑定的儿童的日历数据），严防纵向或横向的越权攻击。</span>
（3）前后端的可用性与兼容性要求
　　跨终端的一致性表现：由 UniApp 构建的安装包，在主流 Android 混合厂商（华为等）设备下，排版（尤其是 TailwindCSS 原子类的异形圆角渲染）不能有可见撕裂，并自适应主流的沉浸式状态栏/刘海屏。
　　弱网抗性保障：即便在卧室等 Wi-Fi 信号微弱甚至断连的场景下，儿童端的核心“倒计时”本地模块绝不应失效。应用须将当前进度离线缓存，待网络恢复后在后台静默发起增量同步策略。
2.3本章小结
　　<span style="color: blue;">本章从系统可行性与需求分析两个维度对“小步”行为习惯辅助系统进行了全面论证。</span><span style="color: blue;">首先，在工程与操作层面论证了前后端分离架构与全平台适配的可行性，并深入探讨了认知负荷理论、脚手架理论及家庭动力学对系统交互设计的底层理论支撑。</span><span style="color: blue;">随后，通过对患儿与家长这一“双核”目标用户群体的痛点解构，推导出了儿童端的“极简执行与即时激励”和家长端的“任务分发与智能观测”核心功能流转闭环。</span><span style="color: blue;">最后，明确了系统在响应时延、大模型异步处理、多角色数据越权防护及弱网抗性方面的非功能性要求。</span><span style="color: blue;">本章的需求抽象与分析结果，为后续的系统总体架构搭建与核心数据库结构设计提供了直接且清晰的蓝图约束。</span>
3系统设计
　　系统架构设计是连接需求分析与编码实现的核心桥梁。在本章中，我们将从宏观的逻辑分层入手，制定出合理的前后端分离协同机制；进而在微观层面剥析认证鉴权、任务流转等核心业务模块的具体架构支撑方案；最后，将业务实体沉淀至数据层，提供标准化、高扩展性的 PostgreSQL 及 Redis 存储结构设计。系统架构设计是连接需求分析与编码实现的核心桥梁。在本章中，我们将从宏观的逻辑分层入手，制定出合理的前后端分离协同机制；进而在微观层面剥析认证鉴权、任务流转等核心业务模块的具体架构支撑方案；最后，将业务实体沉淀至数据层，提供标准化、高扩展性的 PostgreSQL 及 Redis 存储结构设计。
3.1总体架构设计

图 3.1 总体架构设计
3.1.1架构演进与逻辑分层设计
　　<span style="color: blue;">本系统（小步 Small Steps）秉承高内聚、低耦合的设计原则，采用经典的 N 层逻辑架构体系（N-Tier Architecture）。</span><span style="color: blue;">为保证代码的可维护性与模块的独立演进，系统将整体结构自上而下严格划分为表现层（Presentation Layer）、业务逻辑层（Business Logic Layer）、数据访问层（Data Access Layer）及底层抽象层（Infrastructure Layer）[11]。</span>
　　<span style="color: blue;">表现层（前端控制层）：涵盖了家长与儿童交互的移动端（App）以及运营人员使用的 Web 后台管理界面。</span><span style="color: blue;">该层通过 UniApp 与 Vue 3 技术栈实现了 UI 渲染逻辑，专门负责将用户的触控、点击行为转化为符合协议规范的 HTTP 异步请求，并响应后台处理结果更新组件视图。</span>
　　<span style="color: blue;">业务逻辑层（Service 层）：位于后端的中心脏地带，基于 Spring Boot 3 搭建。</span><span style="color: blue;">在此层封装了所有关于“任务如何流转”、“代币如何核算”及“家长如何绑定儿童逻辑”。</span><span style="color: blue;">通过提供标准化接口（Controller-Service-Manager结构），承载了系统最关键的计算推演逻辑，抵御外部无效请求，确保业务数据的合法性。</span>
　　<span style="color: blue;">数据访问层（DAO 层）：在业务逻辑层之下，借助 MyBatis-Plus ORM 框架，消解了直接操作底层数据引擎的硬编码耦合。</span><span style="color: blue;">负责对持久化关系型数据结构提供高度语义化的增删改查支持，向上为服务层提供 selectById、updateWrapper 等面向对象的实体查询方案。</span>
　　<span style="color: blue;">底层抽象层：囊括了如 PostgreSQL 关系型数据库、Redis 缓存引擎、分布式日志追踪系统等基础设施。</span>在这一层不仅持久化实体数据，也包括将对接外部大型语言模型（LLM）等第三方 API 供应商的网络代理与超时重试等基础设施代码内聚起来。
3.1.2前后端分离协同架构
　　<span style="color: blue;">“小步”系统在物理部署规划架构上，完全采用了前后端分离模型[12]。</span><span style="color: blue;"> 前端 App（基于移动客户端环境）和管理后台（基于 Web 浏览器）通过广域网，利用标准 HTTPS 协议的 RESTful API 技术格式，将前端所需的动态业务请求发送至云端的 Nginx API 网关。</span><span style="color: blue;"> API 网关作为唯一对外的暴露点，在进行负载均衡与跨域请求过滤后，再将流量转发给隐藏在内网中的 Spring Boot 业务集群。</span><span style="color: blue;">此外，前后端的数据报文交换统一约定为 application/json 格式，并通过公共的响应泛型模型（Result<T>）包装，以携带全局鉴权层错误码与统一的信息文本，这极大降低了前后端协同开发的调试成本。</span>
3.2核心业务模块设计
3.2.1用户认证与鉴权模块设计 (基于 Sa-Token)
　　本系统涉及“管理员、家长、儿童”三种差异巨大的角色身份。系统的访问安全防御依托 Sa-Token 框架全权构建[13]。
（1）集中登陆认证
　　前端经过账户密码（或短信验证码）换取认证凭据。后端验证通过后，在 Redis 中生成该用户的会话上下文（User Context），并发放对应的 JWT 或是随机散列 Token 返回给前端。
（2）双域隔离设计
　　<span style="color: blue;">为防止后台管理员 Token 在移动端 App 误用，系统采用 Sa-Token 的多账号体系（Multi-Account System）架构，将后台管理系统（Admin）的用户中心与移动终端（App）的用户中心在缓存路由中严格隔离。</span>
（3）细粒度权限管控
　　业务层接口执行前，会经过 Sa-Token 全局拦截器（Global Interceptor）。通过在业务特定的 Controller 方法上注入 @SaCheckRole("PARENT") 与 @SaCheckPermission("task:create") 等鉴权注解，保证例如儿童不可创建或随意删除高优任务，家长不能跨家庭体系查看其他儿童数据，实现角色与组织层的严格互斥。
3.2.2任务管理与流程设计
　　任务（Task）是横贯系统各功能线的最核心业务概念。由于 ADHD 患儿完成状态的不确定能力极强，系统在任务的生命周期状态机（State Machine）流转设计上采用了极高弹性的设计。
（1）核心状态枚举
　　配置为“未开始”、“执行中”（已在此任务内点击开启番茄钟）、“已完成”（打卡提交完毕）、或“已废弃”（当日最终未完成过期作废）。
（2）任务配置模型
　　在家长创建阶段，除了标准的标题与预期耗时配置以外，引入了核心属性如“执行周期类型（单次/每日循环/自定义频率）”与“获得奖励代币权值”。
（3）任务拆解特性
　　支持为复杂任务绑定“关联子步骤清单（Sub-Steps List）”，以应对 ADHD 儿童应对长期大体量任务极易产生的畏难情绪，由后端支撑实现化整为零的过程考核。
3.2.3专注模式与时间管理机制设计
　　<span style="color: blue;">专注模块服务于儿童进入指定任务后的时间管理沉浸感，其流转不涉及持久层事务写入，以保障实时流畅度为第一优先级：</span>
<span style="color: blue;">前端获取当前选定打卡的“待专注任务ID”配置参数。</span>
　　<span style="color: blue;">儿童确认开始后，前端 Pinia 状态树切入“专注模式锁定态”，倒计时引擎启动。</span><span style="color: blue;">在此状态下阻断 App 的全局路由返回与底部 TabBar 切换路由请求，实现全屏沉浸与免扰模式。</span>
　　<span style="color: blue;">若倒计时自然结束，产生一个完成记录包（包含持续秒数和设备信息类型）发送至后端 API，由后端开启全局事务确认任务结束并触发奖励核算业务；</span>
　　<span style="color: blue;">若儿童中途强制打断或放弃，前端依然将该次“有效积累时长”回传，后端将其归档但标记为“非完全态完成记录”，以便后续 AI 研判儿童耐受力的阈值并进行情绪记录跟踪。</span>
3.2.4智能辅助生成与数据反馈模型设计
　　为了解决家长撰写辅导话术的枯燥以及干预过程机械化的问题，设计了这一由后端触发驱动、连接三方 AI 接口的旁路反馈闭环[14]。 该模块不阻碍每日事务流，后端调度系统开启定时任务（Task Scheduler）：
　　每日特定时段将某一绑定对下（单个患儿+其监护人）的历史十天打卡记录（总数、成功度、超时行为特征、情绪打分）进行数据聚合。
形成一套严谨抽象的结构化 JSON “行为指征摘要”。
动态结合管理后台配置好的一组系统 Prompt（如：“请依据该 ADHD 患者近3天抗压能力的显著下降趋势，拟定一段家长用安抚话术，强调同理心”），向远程 LLM 引擎发起异步 API 请求。
　　将生成的话术脱敏落库，待家长次日早晨登录 App 时，首页通过专栏形式曝光这一经过 AI 解析重塑的“辅助指引卡片”，家长即可选择一键同步显示至儿童端的“时光机信箱”界面上。
3.3数据库设计
　　<span style="color: blue;">数据库是系统业务逻辑落地的核心载体，其设计直接决定系统的数据一致性、扩展性与运行性能。</span><span style="color: blue;">针对ADHD儿童行为干预场景的特殊性，本系统在数据库设计中不仅关注传统业务数据建模，同时引入游戏化激励、任务拆解以及情绪追踪等扩展维度，以支撑系统的长期行为引导能力。</span>
3.3.1设计原则与总体架构
　　<span style="color: blue;">通过从业务需求描述对象中剥离实体与映射关联，抽取出本系统的四类主要实体构建了 E-R（Entity-Relationship）在数据库设计过程中，系统遵循以下核心原则：</span>
　　<span style="color: blue;">高内聚与领域划分原则 围绕系统核心业务，将数据划分为“用户与档案”、“任务流转”、“激励体系”与“情绪与AI追踪”四大领域，保证各模块职责清晰、边界明确。</span>
　　<span style="color: blue;">读性能优先原则 针对儿童端与家长端的高频读取场景，通过适度去范式化设计与缓存机制，减少多表关联查询带来的性能开销。</span>
　　<span style="color: blue;">灵活扩展原则 对于任务子步骤、用户偏好等非结构化数据，采用 PostgreSQL 的 JSONB 类型存储，以适应未来业务变化。</span>
<span style="color: blue;">数据一致性保障原则 通过快照字段与流水表设计，确保积分、奖励等关键数据具备可追溯性与审计能力。</span>
<span style="color: blue;">系统整体采用“关系型数据库 + 缓存层”的双层架构，其结构如下：</span>

图 3.2双层架构
3.3.2概念模型设计 (E-R模型)
　　<span style="color: blue;">为了更直观地展现系统的底层架构，本节采用包含实体主要属性的 E-R 模型，将系统的核心库表划分为四大业务域进行展示。</span>
<span style="color: blue;">用户与档案域，如 图 3.3：负责维护系统鉴权基础以及儿童的独立档案和游戏化属性。</span>
<span style="color: blue;">任务流转域，如 图 3.4：为系统的业务中枢，实现了从家长任务下发到儿童实际打卡执行的全生命周期闭环。</span>
<span style="color: blue;">激励体系域，如 图 3.5：负责系统内虚拟资产（积分）的发放、核算以及与心愿奖品的最终兑换流转。</span>
<span style="color: blue;">情绪追踪域，如 图 3.6：专项支持 ADHD 治疗中所需的话术动态生成及情绪安抚应对机制。</span>
　　<span style="color: blue;">具体而言，用户档案域以 sys_user 表与 ss_child 表的一对多映射奠定权限隔离根基；</span><span style="color: blue;">任务流转域通过 ss_parent_task 主表关联 ss_task_log 实现细粒度执行追踪；</span><span style="color: blue;">激励体系域则围绕 ss_parent_reward_redemption 奖励兑换记录表确保有正反馈。</span><span style="color: blue;">四大域协同建模为后续高内聚微服务拆分提供了清晰的边界参照。</span>

图 3.3用户与档案

图 3.4任务流转

图 3.5激励体系

图 3.6情绪追踪
3.3.3关系型数据库结构详述
　　结合工程中的实际 JPA/MyBatis-Plus 实体映射，本系统在 PostgreSQL 中建立了一系列核心物理表，下面列出关键表的字段设计：
表 3.1系统用户表 (sys_user)
 字段名称 类型 长度 必填 说明 user_id int8 20 是 用户ID status char 1 否 帐号状态（0正常 1停用） dept_id int8 20 否 部门ID user_name varchar 30 是 用户账号 nick_name varchar 30 是 用户昵称 user_type varchar 10 否 用户类型（sys_user系统用户） email varchar 50 否 用户邮箱 phonenumber varchar 11 否 手机号码 sex char 1 否 用户性别（0男 1女 2未知） password varchar 100 否 密码 remark varchar 500 否 备注
表 3.2儿童档案表 (ss_child)
 字段名称 类型 长度 必填 说明 id int8 20 是 主键ID total_stars int4 11 否 累计星星 parent_id int8 20 是 绑定的家长ID nickname varchar 64 是 儿童昵称 challenges jsonb - 否 挑战进度记录 avatar_config jsonb - 否 虚拟形象配置 level int4 11 否 当前等级 daily_config jsonb - 否 个性化每日限制配置 gender char 1 否 性别 birthday timestamp 6 否 生日 star_balance int4 11 否 星星余额
表 3.3家长任务发布表 (ss_parent_task)
 字段名称 类型 长度 必填 说明 task_id int8 20 是 任务ID user_id int8 20 否 所属用户ID title varchar 100 否 任务标题 description varchar 500 否 任务描述 prompt_level int4 11 否 支架强度/辅助强度(1-5) difficulty int4 11 否 难度等级(1-5) reward_points int4 11 否 奖励积分 status char 1 否 状态(0进行中 1已完成 2已过期) cycle_type int4 11 否 循环类型(0单次 1每日 2每周) dept_id int8 20 否 家庭ID(部门ID) parent_id int8 20 否 父任务ID(用于任务拆解)
表 3.4任务执行记录表 (ss_task_log)
 字段名称 类型 长度 必填 说明 id int8 20 是 主键ID target_date date - 否 预定执行日期 task_id int8 20 是 关联的任务定义ID child_id int8 20 是 执行儿童ID finish_time timestamp 6 否 实际打卡完成时间 status char 1 否 状态(0:待办, 1:进行中, 2:已完成) proof varchar 500 否 任务证明图片/资料 reward_snap int4 11 否 实际奖励星星快照 title_snap varchar 128 否 任务标题快照 actual_duration int4 11 否 实际专注时长(秒) dept_id int8 20 否 家庭ID(部门ID)
表 3.5儿童积分余额表 (ss_child_score)
 字段名称 类型 长度 必填 说明 user_id int8 20 是 用户ID（儿童的对应系统登录ID） balance int4 11 否 当前余额 total_earned int4 11 否 累计获得 update_time timestamp 6 否 更新时间
表 3.6积分流水记录表 (ss_score_history)
 字段名称 类型 长度 必填 说明 id int8 20 是 主键ID id int8 20 是 流水ID user_id int8 20 是 关联儿童ID amount int4 11 是 变动数值 type char 1 否 类型(1:获取 2:消费) source_id int8 20 否 关联源记录ID（如任务ID） reason varchar 255 否 变动事由说明 create_time timestamp 6 否 流水产生时间
表 3.7家长奖励配置表 (ss_parent_reward)
 字段名称 类型 长度 必填 说明 reward_id int8 20 是 奖励ID user_id int8 20 否 所属家长用户ID name varchar 100 否 奖励名称 points_required int4 11 否 所需兑换积分 stock int4 11 否 库存(-1无限) icon varchar 100 否 奖励图标 status char 1 否 状态(0上架 1下架) create_by int8 20 否 创建者 create_time timestamp 6 否 创建时间 del_flag char 1 否 删除标志 create_dept int8 20 否 创建部门
表 3.8奖励兑换记录表 (ss_parent_reward_redemption)
 字段名称 类型 长度 必填 说明 redemption_id int8 20 是 兑换ID reward_id int8 20 是 奖励ID user_id int8 20 是 发起用户ID(儿童) points_cost int4 11 否 消耗积分 status char 1 否 状态(0:待审批 1:已批准 2:已拒绝) create_by int8 20 否 创建者 create_time timestamp 6 否 申请提交时间 update_by int8 20 否 更新/审批者 update_time timestamp 6 否 更新/审批时间 create_dept int8 20 否 创建部门
表 3.9情绪记录表 (ss_emotion_record)
 字段名称 类型 长度 必填 说明 id int8 20 是 主键ID tenant_id varchar 20 否 租户编号 child_id int8 20 是 关联儿童ID mood_level int4 11 否 情绪状态/能效评级 mood_type varchar 32 否 情绪大类(如开心、愤怒等) description varchar 500 否 具体表现文本描述 voice_url varchar 255 否 声音分析录音URL parent_feedback varchar 500 否 家长的应对方式反馈 is_read char 1 否 状态(是否已查阅) record_time timestamp 6 否 情绪记录时间 create_time timestamp 6 否 入库时间
3.3.4缓存策略与 Redis 结构设计
　　<span style="color: blue;">系统高频读写场景（如移动端每次路由跳转时的会话合法鉴权，以及首页小程序的排行榜积分查询）若直接落在 PostgreSQL 将轻易击穿性能指标。</span><span style="color: blue;">故以 Redis 构筑了全局分布式缓存池：</span>
　　<span style="color: blue;">认证缓存：配合 Sa-Token，按不同用户建立诸如 satoken:login:session:{userId} 的 Hash 对象，存储权限集合（Permission Sets）与失效时间，免去权限比对时的额外查库消耗。</span>
　　<span style="color: blue;">任务防重点赞/防连击键构建：利用 Redis 短期 Key 的自动失效机制（TTL）结合 SETNX（Set if Not eXists）分布式互斥原生指令，当儿童端快速双击“任务完成按钮”时，拦截第二发请求，保证在高并发情景下不会因为网络延迟发包造成重复结算下发代币奖励情况出现。</span>
　　<span style="color: blue;">重点设计并输出了 sys_user、ss_parent_task及任务执行记录表的相关 E-R 概念定义与详尽规范字段结构，结合高效的 Redis 缓存拓扑，搭建了完整并极具扩展特性的功能及数据实现框架。</span>
3.4本章小结
　　<span style="color: blue;">本章重点对系统的整体架构和核心模块进行了详细设计。</span><span style="color: blue;">首先，确立了基于 Spring Boot 与 Vue 3 的前后端分离 N 层架构体系。</span><span style="color: blue;">随后，针对鉴权、任务流转、专注沉浸模式及大模型智能反馈四大核心业务模块，给出了具体的实现机制设计。</span><span style="color: blue;">最后，结合业务需求设计了基于 PostgreSQL 和 Redis 的数据存储结构，通过合理的 E-R 模型抽象与物理表设计，为系统的稳定运行和后续编码实现夯实了底层数据基础。</span>
4系统实现
4.1系统登录
　　<span style="color: blue;">本章为论文的核心工程实践部分。</span><span style="color: blue;">在之前完成的需求规划与架构设计蓝图引导下，本章将深入 smallsteps-api（后端层）、smallsteps-app（移动端层）以及 smallsteps-ui（管理中台层）三大工程子库的代码腹地。</span><span style="color: blue;">我们将结合核心代码片段、关键组件配置及接口设计标准，详尽展示系统从抽象逻辑到具体二进制可执行程序的演化过程。</span>
4.2后端统筹与接口实现 (smallsteps-api)
　　<span style="color: blue;">后端工程基于 Spring Boot 3 标准的 Maven 多模块体系构建，分为 API 定义、Service 业务逻辑、以及统一的配置管理中心，承载了整个家庭智能干预系统的计算中枢任务。</span>
4.2.1安全认证与路由拦截的实现细节
　　<span style="color: blue;">在用户进行登录请求时，系统调用 SysUserServiceImpl 层的验证逻辑。</span><span style="color: blue;">相比于传统的 JWT 手动拼接，系统引入了 Sa-Token 处理登录态。</span><span style="color: blue;">当验证通过后，直接调用 StpUtil.</span><span style="color: blue;">login(user.</span><span style="color: blue;">getId())。</span><span style="color: blue;">这一简单接口的背后，框架自动向 Redis 缓存写入了当前用户的登录状态与过期时间戳，并在 HTTP Response Header 中自动下发以 satoken 为索引的凭据标识。</span><span style="color: blue;"> 为了保障核心业务接口不被未授权访问，后端实现了一个实现了 WebMvcConfigurer 接口的配置类。</span><span style="color: blue;">在此类中注册了 Sa-Token 的拦截器 SaInterceptor：</span>
　　@Configurationpublic class SaTokenConfigure implements WebMvcConfigurer {
@Override
　　public void addInterceptors(InterceptorRegistry registry) {
registry.addInterceptor(new SaInterceptor(handle -> StpUtil.checkLogin()))
.addPathPatterns("/ssapi/**")
.excludePathPatterns("/ssapi/public/login", "/ssapi/public/register");
}}
　　<span style="color: blue;">此机制保证了除公开登录注册接口外，所有带有 /ssapi/ 前缀的请求在触达 Controller 的业务逻辑前，都必须经过底层 Redis 中上下文 Token 的比对，有效实现了第一层鉴权。</span>
4.2.2结构化任务与分发系统的业务逻辑实现
　　任务系统的产生和流转涉及大量的数据库事务一致性（Transaction Consistency）。以“家长为儿童当天新建任务”这一核心业务表现为例： 在对应的 TaskController 中暴露 POST 请求接口。该请求包含被控端儿童 ID、任务元数据及预期所需时段。 在 TaskServiceImpl 逻辑中，由于此操作同时牵涉向任务模版表 task_info 插入源数据，以及在任务实体日志表 task_daily_log 预生成当日的待办占位记录，为了防止网络中断造成的数据不一致（如：主模版建立但今日待办未生成），整个 Service 方法使用了 Spring 框架提供的 @Transactional(rollbackFor = Exception.class) 接口注解包覆。 另外，为实现 MyBatis-Plus 赋能的高级表关联查询，系统针对家长端“查看孩子近一周所有已排期任务”需求，利用 MyBatis-Plus 的 QueryWrapper 构建了类型安全的条件筛选：
　　QueryWrapper<TaskDailyLog> wrapper = new QueryWrapper<>();
wrapper.eq("child_id", currentChildId)
.between("target_date", startDate, endDate)
.orderByDesc("target_date");return taskDailyLogMapper.selectList(wrapper);
此段代码有效地屏蔽了复杂的 SQL 拼接逻辑，并自然防御了潜在的 SQL 注入攻击。
4.2.3数据看板聚合与智能数据生成的后端处理
　　由于 ADHD 系统需要实时生成数据反馈图表，若每次都在数据库进行 GROUP BY 和多表连接求和运算，不仅慢且耗费资源。 因此，后端提供了数据聚合层 DashboardAggregatorService。该定时服务（Cron Job）会在每天凌晨 2:00 自动扫描前天的全部交易打卡日志 task_daily_log，计算“成功完成率”、“平均超时比例”，最终将其作为结构化摘要 JSON 存储于 Redis 或特定的月度统计表。 在人工智能（大语言模型）集成上，这一功能位于独立的 AiInferenceService 中。后端利用 Spring 的 WebClient 发起基于 HTTP 协议的外部请求。组装提示词（Prompt）的方式为： String prompt = "作为儿童心理学专家，针对以下数据：任务完成率 "+ rate +"%，情绪分低落。请生成一段不超过50字的家长安抚建议。"; 后端在拿到大模型 JSON 返回体后，将清洗出的文本字段落库至专门的表。因为外部调用极可能遭遇限流或超时，系统针对这一服务进行了熔断和降级（Fallback）配置，若连续 3 次调用 AI 接口失败，系统将从本地数据库中随机抓取一组预设的通用安抚文本返回给家长端，从而最大程度保证应用界面的完整展示。
4.3移动端应用框架与页面实现 (smallsteps-app)
　　移动端是 ADHD 患儿与家长直接互动的核心载体。该前端项目基于 UniApp 3.0 与 Vue 3 技术栈打造[15]。
4.3.1基础项目配置与 Vue 3 生态集成
　　在项目的 package.json 配置中，引入了适配 UniApp 的 vite 构建打包工具，保证了热重载的实时性和构建效率。利用 Vue 3 的 Composition API（<script setup>），将原本按功能强行切割的 Option API 生命周期内聚起来。 例如，在需要感知应用切回前台（OnShow）重新刷新数据的“首页”文件 Index.vue 中，仅需以声明式的 onShow(() => { fetchLatestTask() }) 即可优雅地触发网络请求。
4.3.2状态管理在双模式切换中的应用
　　双模式（家长模式/儿童模式）是应用核心特性之一。用户首次登入后，身份标志不会存在于各种层级极深的组件 Props 传递中，而是托管于全局唯一的 Store（仓库）里。 在项目 src/stores/auth.js 中，利用 Pinia 创建了用以长久维持的 Token 状态树。当后端验证成功后：
　　这种设计之下，底部的 TabBar 组件或者路由鉴权中间层，只需判断 authStore.currentUserType，即可在瞬间切换底栏图标样式，由专供大人的“数据看板、任务分发”变成专属于儿童的“我的奖章、开始专注”。

图 4.1 app登录
4.3.3TailwindCSS 支持下的响应式页面构建
　　基于 ADHD 界面应尽量减少文字而多使用包容性色彩块的需求，项目深度集成了 TailwindCSS 预设。 开发者不再需要在各个 .vue 中专门撰写冗长的 <style> 代码。以任务概览卡卡片为例，直接利用形如： <view class="flex items-center justify-between p-4 mb-3 bg-white rounded-2xl shadow-sm hover:shadow-md transition"> 的原子结构便可搭建出兼顾移动端尺寸适应和圆角阴影的舒适卡片组件，极大提高了 UI 产出和迭代的一致性效率。
4.3.4核心交互流程实现 (任务卡片、番茄钟交互)
　　专注模式（番茄钟页面 FocusMode.vue）是整个应用难度也是最重要的模块所在。 该页面利用了原生的 setInterval 构建计时器核心，结合 Vue 3 响应式的 countdownLeft 变量绑定环形进度条组件的数据源。 当用户点击“开始”按钮：系统将屏蔽顶部的原生导航栏，屏幕进入常亮保持（利用 uni.setKeepScreenOn），阻断屏幕熄灭。 专注过程中，应用监听原生安卓的物理返回按键/左滑返回事件：
onBackPress((options) => {
if (isFocusing.value) {
uni.showModal({ title: '确认放弃?', content: '现在退出专注将失去当前奖励碎片' });
return true; // 拦截返回操作
}});
　　此种防护型设计（Graceful Degrade）避免了由于 ADHD 儿童的误触导致任务直接强制终断的灾难性后果，为系统积累了极大的情感可用度。

图 4.2 任务

图 4.3洞察

图 4.4家长中心
4.4Web 管理后台终端实现 (smallsteps-ui)
　　作为整个干预生态链的数据大脑中枢，smallsteps-ui（管理后台）基于标准 Vue 3 + Element Plus 技术体系独立部署。
4.4.1管理员系统登录与权限控制
　　由于管理系统掌握极高权限体系（账号封禁、全系统日志获取），其不仅依靠后端的逻辑，更依托前端的动态路由特性（Dynamic Router）。在管理员登录之后，应用首先请求后台菜单树（Menu Tree），系统基于此配置，仅挂载该高管名下拥有的侧边栏路由。即使有普通家长端用户知晓了后台网址并强行进入前端路由 /#/admin/dashboard，也会被本端的白名单守卫（Router Guard）在渲染之前检测出无关联 Token 从而弹回至公共登录界面。

图 4.5管理后台登录
4.4.2后台数据图表与列表渲染实现
　　<span style="color: blue;">针对平台的海量活动分析（如每日使用该 App 的打卡总次数监控），使用流行的轻量前端库 ECharts 配合 Element Plus 的组件系统。</span><span style="color: blue;">开发者构建了一套涵盖最近30天的柱状、平滑折线统计图。</span><span style="color: blue;">每次数据更新时，组件内利用 Vue 3 的监听器（Watcher）捕捉 API 返回的新时序 JSON 数据集，并在 ECharts 图表对象内触发 setOption() 方法实现图表的丝滑重绘与渲染，辅助技术和研究人员高效掌握应用使用规律。</span>

图 4.6系统监控
4.5本章小结
　　<span style="color: blue;">本章由内至外深入演示了整个系统的重磅技术实践步骤。</span><span style="color: blue;">在后端，分析了 Spring Boot 结合 MyBatis-Plus 保证数据库的一致性并展示了 AI 聚合链路的具体写法及防降级策略。</span><span style="color: blue;">在最体现产品灵魂的移动前端方面，说明了选用 UniApp 与 Pinia 配合实现秒级角色切换与数据持久同步的方案，并阐述了利用原子类 CSS (TailwindCSS) 大幅提升组件适配率以及专注模式对意外中断的拦截处理机制。</span><span style="color: blue;">最后简述了用以承载管理员运维诉求的独立后端终端。</span><span style="color: blue;">经过本章开发逻辑与部分源码级讲解的沉淀，整个具备双端智能闭环控制的 ADHD 辅助治疗数字结构已经完全成文可见。</span>
5系统测试
　　<span style="color: blue;">任何软件工程项目在正式进入生产环境（Production Environment）并交付给终端用户之前，都必须经历详尽而严苛的测试。</span><span style="color: blue;">对于“小步”系统而言，由于其目标群体的特殊性（儿童）及数据的高隐私敏感度，系统的稳定性、安全性和交互防错能力显得尤为重要。</span><span style="color: blue;">本章将详细描述系统的测试环境搭建、从核心功能逻辑到性能抗压的多维度测试方案及其实际运行结果分析。</span>
5.1测试环境与策略构建
5.1.1测试环境说明
为保证测试结果的可靠性与拟真度，本次测试构建了独立的预发布回归环境：
　　后端服务端环境： 使用 Docker 容器化运行 Postgres 15 数据库与 Redis 7，保证了隔离性。
　　前端及终端环境：移动端打出了面向 Android 的 .apk 包和H5测试包，测试华为P40 pro 和mate 30 pro都可正常使用。管理后台终端通过最新版的 Google Chrome 浏览器访问。
5.1.2测试维度设计
测试规划依据以下三大核心维度展开：
　　功能逻辑验证（黑盒测试）：确认业务从“家长建任务 -> 儿童接收 -> 执行完成 -> AI 反馈生成”的完整闭环没有逻辑挂起断点。
UX 交互测试：模拟可能的操作流程，各方面的交互都正常。
5.2核心业务功能测试
5.2.1多角色权限与路由测试用例
<span style="color: blue;">测试目标：测试 Sa-Token 在处理同一家庭群组不同家庭成员身份时的横向及纵向越权问题。</span> 
<span style="color: blue;">测试执行：</span>
　　<span style="color: blue;">【场景 A】使用儿童端账号 Token 直接尝试发起 POST 请求访问 /ssapi/parent/task/create（家长建任务接口）。</span><span style="color: blue;">结果显示被响应体拦截，状态码 403 Forbidden，抛出异常提示“权限不足”，预期达成。</span>
<span style="color: blue;">【场景 B】使用家长甲的 Token 尝试获取家长乙名下儿童的数据。</span><span style="color: blue;">结果显示被底层 SQL 数据隔离拦截器阻断，返回空数组，说明租户防越权数据隔离设计有效，预期达成。</span>
5.2.2任务生命周期状态扭转测试
<span style="color: blue;">测试目标：覆盖任务单的各个关键链路流转。</span> 
<span style="color: blue;">测试执行：在移动端完整走通以下流转并查询后台数据库：</span>
<span style="color: blue;">建立一条“限时执行 5 分钟”的扫地任务。</span>
　　<span style="color: blue;">儿童端刷新即可看到对应卡片（状态：待办 status=0），进入并点击“开始专注”，倒计时正常流转（状态变更为 status=1），若此时切至后台应用挂起，再次唤醒后，时间依旧按自然时间差递减，未出现暂停错误。</span>
<span style="color: blue;">倒计时计满，播放成功音效，自动发起提交流水，数据库校验代币 coin_balance 更新正确。</span>
<span style="color: blue;">结论：任务全生命周期的推演完全符合产品需求定义文档，数据回溯表现完整。</span>
5.3本章小结
　　<span style="color: blue;">本章对“小步”系统进行了严密的回归测试验证。</span><span style="color: blue;">我们首先搭建了独立且数据隔离的预发布测试环境，并确立了功能、交互与兼容性三大测试维度。</span><span style="color: blue;">通过对最核心的“多角色防越权”、“任务全生命周期流转”以及“专注模式容错与防连击”等典型用例进行实机执行，系统均给出了符合预期的结果。</span><span style="color: blue;">测试数据表明，系统在 Sa-Token 保护下的权限隔离稳定可靠，Spring Boot 事务和 Redis 互斥锁也经受住了异常操作的考验。</span><span style="color: blue;">系统整体达到了设计初期的功能目标和稳定性要求，具备了实际落地的交付条件。</span>
6	总结与展望
　　当前社会的快节奏使得部分在认知执行神经系统上具有先天劣势的个体（诸如 ADHD 族群）面临严峻的生存挑战，尤其是在成长关键期的家庭教育中。为了缓解大量 ADHD 家庭深陷其中的监督耗竭陷阱，设计并开发了一套“小步”双端行为习惯辅助协同系统。<span style="color: blue;"> 在整个研究与开发流程中，完成了以下核心工作：</span>
　　<span style="color: blue;">主导了全局纯粹无压力的 UI 交互哲学。</span><span style="color: blue;">放弃了威慑感，改由通过游戏化代币的正向奖励与大模型的话术安抚来完成闭环干预的设计。</span>
　　<span style="color: blue;">现代化重构架构体系搭建：完全摒弃了传统的单体结构。</span><span style="color: blue;">后端利用 Spring Boot 3、MyBatis-Plus 的高效生态组建了业务枢纽，利用 Sa-Token 完成了灵活的权限防线；</span><span style="color: blue;">前端基于 UniApp 3.0 实现多端全覆盖布局，引入 Vue 3 的 Composition API 和 Pinia 实现极致渲染效能及跨栏状态管理。</span>
　　<span style="color: blue;">AI 赋能业务新范式：不仅完成基础的信息交互，更是尝试在后端逻辑定时接入并研判 LLM 智能接口，让原本机械死板的软件代码具备了类似“驻场儿童心理咨询师”般的同理心反馈视角，极大程度释放了家长的心智负担。</span>
6.1总结
　　在整个工程浩大的重构中也面临了不小的技术阻力：由于最初业务对状态同步的一致性要求极高，曾一度因为过多连表查询导致后端陷入速度瓶颈。后来在引入 Redis 承担大量会话认证校验及去重锁之后，系统的生命力才有了质的跃升（QPS 破千）。此外，前端为了达成让 ADHD 儿童“零跳转、所见即所得”的原子级状态表现，大量剥离了复杂路由，依靠 Pinia 和 TailwindCSS 的实时按需呈现来接管控制，虽然增加了前期系统设计的复杂度，但回馈了极低的用户操作延迟体验。
6.2系统存在的不足与未来研究展望
　　虽然“小步”系统在实验室层面通过了测试并在核心架构上奠定了长远发展的框架，但在迈向下一代商业化级产品的路上，依然具有部分可深挖的研究点：
　　更多维度数据的联动感知：目前数据获取仅限患儿的“主动点击打卡完成时间”。未来或可考虑加入物联网（IoT）可穿戴设备的蓝牙集成，通过实时获取血氧、心率以客观标定孩子的绝对心流/暴躁状态，形成多模态验证。
　　脱离云端的大模型本地化（Edge AI）：为了保护干预数据的绝对隐私，并在未来规避第三方 API Token 计费过高的问题，未来的“小步系统”拟在网关内网甚至边缘计算终端探索本地部署轻量化 LLM（如 Qwen-1.5B/7B 级别模型）的能力，实现完全切断外网情况下的智能解析。
　　总而言之，科学技术的前景不止是在解决效率，更应在那些不易被大众察觉的“角落”去建立平等的帮助系统。“小步”是拥抱神经多样性的一次技术宣告，我们期待它在未来真正走向百万普通家庭，让每一位“特别”的孩子都能在自己的时区与步伐下，踏出自信且专注的下一步。
致谢
　　时光荏苒，岁月如梭，转眼间本科阶段的学习与生活即将落下帷幕。本篇毕业论文的完成，既是对我所学知识的总结，也是我人生旅途中一段宝贵的经历。在此，我谨向所有在我的学业、生活以及论文写作过程中给予我无私帮助与支持的人，表达最诚挚的谢意。
　　在此，对在学术钻研路上给予我无私引领的指导老师，我要特别感谢我的指导老师薛庆水。从本课题的初步构思、系统架构的设计到最终论文的定稿，薛老师都倾注了大量心血。老师严谨的治学态度与渊博的专业知识，使我能够顺利克服难关，在工程实践上受益匪浅。
　　此外，感谢开源社区中无数默默奉献的极客同行。正是您们不断推陈出新，构建了繁荣的开源生态，使得本系统能够站在巨人的肩膀上快速落地。
　　最后，感谢母校上海应用技术大学提供的优良学习环境，感谢家人的包容与陪伴。未来，我将带着这份感恩，继续怀揣对技术的热爱不断探索，砥砺前行。
参考文献
[1] 郑毅, 刘靖. 中国注意缺陷多动障碍防治指南(第二版)[M]. 北京: 中华医学电子音像出版社, 2015.
[2] 袁秀洪, 罗学荣, 邓云龙, 刘祥彦. 儿童注意缺陷多动障碍流行病学调查回顾[J]. 国际精神病学杂志, 2007(2).
[3] 沈玲, 罗学荣, 龚靖波, 石利娟. 注意缺陷多动障碍儿童的神经软体征[J]. 中国儿童保健杂志, 2015(12).
[4] 孙焕良, 李海鹰, 张莉. 数字化干预在儿童注意缺陷多动障碍中的应用进展[J]. 中国儿童保健杂志, 2021, 29(12): 1319-1322.
[5] Sweller J. Cognitive load during problem solving: Effects on learning[J]. Cognitive Science, 1988, 12(2): 257-285.
[6] 鲍梦依, 赵家靖, 严晨毓, 冯尚, 潘纲, 李海峰, 王跃明, 姚林, 舒强. 儿童ADHD数字药物的神经机制、应用进展与临床挑战[J]. 中国现代应用药学, 2025, 42(22): 3945-3953.
[7] Kollins S H, DeLoss D J, Cañadas E, et al. A novel digital intervention for actively reducing severity of paediatric ADHD (STARS-ADHD): a randomised controlled trial[J]. The Lancet Digital Health, 2020, 2(4): e168-e178.
[8] Craig Walls. Spring Boot in Action[M]. Shelter Island: Manning Publications, 2016.
[9] Vygotsky L S. Mind in Society: The Development of Higher Psychological Processes[M]. Cambridge: Harvard University Press, 1978.
[10] Deterding S, Dixon D, Khaled R, et al. From game design elements to gamefulness: defining “gamification”[C]//Proceedings of the 15th International Academic MindTrek Conference. 2011: 9-15.
[11] 吴凡, 卞建玲, 宋振乾, 李庶衍, 焦文韬. 微服务软件架构设计模式及其应用[J]. 数字通信世界, 2024(1).
[12] 尤雨溪, 霍春阳. Vue.js 设计与实现[M]. 北京: 人民邮电出版社, 2022.
[13] 王勇, 吕明久, 陈莉, 程祺. 基于RBAC模型的权限管理系统的设计与实现[J]. 江苏工程职业技术学院学报, 2024(3).
[14] 罗亚威, 杨易. 大型语言模型和领域特定模型协作的智慧教育方法[J]. Frontiers of Information Technology & Electronic Engineering, 2024, 25(3): 333-341.
[15] 张玮, 廖若飞. 基于uni-App的小程序开发技术路线及系统研究[J]. 无线互联科技, 2024, 21(22): 41-44.
附  录
附录A：LLM任务分解Prompt模板
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
