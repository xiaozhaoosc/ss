上海应用技术大学
SHANGHAI INSTITUTE OF TECHNOLOGY

高等学历继续教育
本科毕业设计（论文）

课题名称：  ADHD中小学生（儿童）行为习惯辅助系
统设计与实现
专    业：    计算机科学与技术
班    级：    2410420
学生学号：    241042025
学生姓名：    赵轩
指导教师：    薛庆水


2026年4月8日

ADHD中小学生（儿童）行为习惯辅助系统设计与实现

摘要：	注意缺陷多动障碍（Attention Deficit Hyperactivity Disorder, ADHD）是学龄期儿童中较为普遍的一类神经发育性障碍，其核心临床表现涵盖注意力维持困难、活动过度以及行为冲动三个维度。受上述症状影响，患儿在学业成绩、同伴社交以及日常行为规范的习得方面往往承受较大压力。现阶段，针对该障碍的主流干预路径仍以药物调控与线下行为矫正为主，但此类方法在药物副作用风险、专业康复师资稀缺以及家庭干预执行一致性等层面存在较为突出的不足。伴随移动互联网基础设施与人工智能算法的持续演进，借助数字化手段对ADHD实施辅助干预已逐步成为该领域的前沿研究方向之一。然而，就已有的软件产品而言，多数停留在日程提醒层面，在认知减负定制化设计、亲子协同交互以及动态激励反馈等关键环节仍存在明显短板。
针对上述不足，本课题设计并实现了一套面向ADHD中小学生的行为习惯养成综合辅助系统——"小步（Small Steps）"。该系统依据前后端分离的架构思路进行整体规划，通过儿童移动端、家长移动端和管理后台三个终端的协同运作，构建了涵盖渐进式任务拆解、多模态激励、情绪追踪与家庭系统协同的数字化干预闭环。
在技术实现层面，后端服务基于Spring Boot 3.5.9框架搭建，借助MyBatis-Plus完成数据持久化与业务查询的高效封装。权限管控方面，选用轻量级安全框架Sa-Token构建"儿童-家长-管理员"三重角色鉴权机制。数据存储采用Postgres 15承担关系型数据管理职责，同时引入Redis提供缓存加速与基于Token的会话管理支撑。移动端采用跨平台框架UniApp 3.0配合Vue 3的Composition API与Pinia状态管理实现儿童和家长双模式的动态切换，通过TailwindCSS进行响应式界面渲染。管理后台基于Vue 3与Element Plus搭建，提供数据看板、用户运营及策略配置的图形化操作界面。
系统的核心创新在于将生成式大语言模型（LLM）能力以智能辅助模块的形式集成至后端，该模块通过解析儿童的任务完成轨迹与专注时长分布，动态输出个性化的每日寄语与奖励策略建议，旨在缓解重复打卡所带来的执行疲劳。同时，系统借助多维度数据可视化与家庭成员间的互动机制，谋求将家长的角色从传统的"检查者"引导至"陪伴者"方向。
经过多轮功能测试与交互验证，系统各模块运行稳定，数据交互流畅，基本达到了预期的功能指标与业务目标。本课题不仅为ADHD儿童的日常辅助干预提供了一种可落地的数字化工具方案，也为基于现代前端框架与智能后端架构的数字疗法类产品积累了一定的工程实践经验。
关键词：注意力缺陷多动障碍；行为干预；Spring Boot 3；UniApp；Vue 3；前后端分离


Design and Implementation of ADHD Behavior Support System for Children

Abstract: 	Attention Deficit Hyperactivity Disorder (ADHD) is one of the most common neurodevelopmental disorders in school-aged children, characterized by core symptoms of inattention, hyperactivity, and impulsivity. These symptoms lead to significant challenges in academic performance, social interaction, and daily behavioral norms. Traditional intervention methods mainly rely on medication and manual behavioral therapy, which suffer from distinct limitations such as side effects, scarcity of professional rehabilitation resources, and poor sustainability of family-level interventions. With the continuous advancement of mobile internet and artificial intelligence technologies, digitally assisted interventions have gradually become a crucial research direction in the field of ADHD rehabilitation. However, most existing assistance systems focus on simple scheduling lacking customized designs tailored to the cognitive patterns of children with ADHD, and perform inadequately in parent-child collaboration, dynamic motivation, and data feedback.
To address the aforementioned problems, this project designs and implements a comprehensive assistance system focusing on cultivating the behavioral habits of primary and middle school students with ADHD. Adopting a microservice-oriented architecture with separated front-end and back-end, the system builds a digital closed-loop supporting progressive task decomposition, multi-modal incentives, emotional state tracking, and family system collaboration through multi-terminal synergy (children's mobile app, parents' mobile app, and management backend).
In terms of technical architecture, the core backend services are built upon the latest Spring Boot 3.5.9 framework, utilizing MyBatis-Plus to achieve efficient data persistence and encapsulation of complex business query layers. To ensure system-level security and fine-grained permission isolation, the lightweight security framework Sa-Token is introduced to construct a comprehensive multi-role (child, parent, administrator) authentication system. The data layer employs Postgres 15 for relational data governance and introduces Redis to provide high-performance caching and Token-based session management support, ensuring the system's response speed and stability under high-concurrency requests.
At the front-end implementation level, the system covers user-oriented mobile applications (App) and an administrator-oriented Web interface. The mobile application adopts the cross-platform framework UniApp 3.0, combining Vue 3's Composition API and the Pinia state management mechanism to achieve seamless and smooth switching between child and parent modes as well as global state sharing. Responsive and highly customized UI rendering is realized through TailwindCSS. The child interface emphasizes gamified feedback and cognitive load reduction, offering core functions like Pomodoro focus and fragmented task guidance; the parent interface focuses on task publication, data visualization, and emotional accompaniment management. The management backend is developed based on Vue 3 and Element Plus, providing a graphical management interface for comprehensive data dashboards, user management, and assistance strategy configuration.
The core innovation of the system lies in internally integrating advanced generative Large Language Model (LLM) capabilities into the system backend as an intelligent assistance module to deeply empower basic business processes. By analyzing the daily task completion status, focus duration distribution, and expressed emotions of children, this module dynamically generates personalized daily messages and reward suggestions, effectively alleviating the execution fatigue brought by monotonous check-ins. Furthermore, through multi-dimensional data visualization and interactive mechanisms between family members, the structural tension in ADHD families is reshaped, transforming the parents' role from "inspectors" to "companions."
Through multiple rounds of system testing and usability evaluations, all functional modules of this system operate stably, front-end and back-end data interactions are efficient, and page rendering is smooth, meeting the performance indicators and business requirement criteria set out at the initial stage of design. The research and development of this project not only provide a lightweight and digital effective tool for the daily intervention of ADHD children but also offer a referential engineering implementation paradigm for digital therapeutic products based on modern front-end frameworks and intelligent back-end architectures.
Keywords:（ADHD; Behavioral Intervention; Spring Boot 3; UniApp; Vue 3; Front-end and Back-end Separation）

目  录
1 绪论	1
1.1 研究背景	1
1.2 数字化行为辅助工具的应用价值	1
1.3 面向ADHD的技术干预需求与缺口	2
1.4 国内外研究现状与发展趋势	3
1.4.1 传统行为干预与认知疗法的局限	3
1.4.2 数字疗法与应用程序在ADHD干预中的发展	3
1.4.3 现状总结与本系统的突破方向	3
1.5 主要研究内容与论文组织结构	4
2 系统分析	5
2.1 可行性分析	5
2.1.1 技术可行性	5
2.1.2 操作可行性	6
2.1.3 经济可行性	6
2.2 关键技术概述	6
2.2.1 后端技术栈（Spring Boot 3与MyBatis-Plus）	6
2.2.2 CSS框架技术（TailwindCSS）	7
2.2.3 权限管理技术（Sa-Token）	7
2.2.4 相关理论基础	8
2.3 系统需求分析	9
2.3.1 目标用户群体分析	9
2.3.2 系统功能需求	10
2.3.3 非功能性需求分析	11
3 系统设计	13
3.1 总体架构设计	13
3.1.1 架构演进与逻辑分层	13
3.1.2 前后端分离协同机制	14
3.2 核心业务模块设计	14
3.2.1 用户认证与鉴权模块设计	14
3.2.2 任务管理与流程设计	15
3.2.3 专注模式与时间管理机制设计	15
3.2.4 智能辅助生成与数据反馈模型设计	16
3.3 数据库设计	16
3.3.1 概念模型与E-R图设计	17
3.3.2 关键数据表结构设计	18
3.3.3 缓存策略与Redis结构设计	22
4 系统实现	24
4.1 后端核心功能实现（smallsteps-api）	24
4.1.1 安全认证与路由拦截实现	24
4.1.2 任务管理的业务逻辑实现	25
4.1.3 数据看板聚合与智能生成的后端处理	25
4.2 移动端应用实现（smallsteps-app）	25
4.2.1 项目工程配置与Vue 3生态集成	26
4.2.2 Pinia状态管理在双模式切换中的应用	26
4.2.3 基于TailwindCSS的响应式页面构建	28
4.2.4 核心交互流程实现	28
4.3 管理后台实现（smallsteps-ui）	32
4.3.1 管理员登录与前端路由权限控制	32
4.3.2 数据图表与列表渲染实现	32
5 系统测试与结果分析	34
5.1 测试环境与策略	34
5.1.1 测试环境说明	34
5.1.2 测试维度设计	34
5.2 核心业务功能测试	34
5.2.1 多角色权限与越权防护测试	34
5.2.2 任务生命周期状态流转测试	35
5.2.3 兼容性与弱网场景测试	36
5.3 测试结果综合分析	36
6 总结与展望	37
6.1 研究成果总结	37
6.2 研究的意义与贡献	37
6.3 存在的不足	38
6.4 未来研究展望	38
致谢	39
参考文献	40
附  录	41
附录A：LLM任务分解Prompt模板	41

1 绪论

在全球范围内，注意力缺陷多动障碍（Attention Deficit Hyperactivity Disorder, ADHD）已成为学龄期儿童中发生率较高的一类神经发育性问题。该障碍的核心临床表现集中在注意力维持困难、活动过度和行为冲动等方面。对于正处于中小学阶段的患儿而言，上述症状对其学习效率、日常自理能力以及家庭内部关系均产生了不容忽视的影响。在传统干预方式——主要包括药物调控与线下行为矫正——面临副作用隐忧、费用门槛偏高以及康复资源地域失衡等制约的背景下，数字疗法（Digital Therapeutics, DTx）正逐步成为ADHD干预领域中备受关注的新兴思路[1]。然而，目前市面上的辅助软件大多局限于单一的定时提醒或基础的番茄钟功能，难以深入回应ADHD患儿"执行功能障碍（Executive Dysfunction）"这一核心痛点，且往往缺少家庭协同层面的交互支撑，导致用户的持续使用意愿不高，长期行为习惯的养成效果有限。

1.1 研究背景
注意缺陷多动障碍（简称ADHD），通常被称为多动症，是儿童及青少年阶段最为常见的一种慢性神经发育性障碍。从全球流行病学数据来看，学龄儿童群体中ADHD的患病率大致处于5%至7%的区间，部分地区甚至更高[2]。该障碍的核心症状主要表现为与年龄及发育水平不相称的注意力涣散、活动量过大以及行为控制力不足。值得关注的是，ADHD本身并不直接损害患儿的智力水平，但其对执行功能（Executive Function）——包括工作记忆、情绪调节、内在驱动力和计划组织能力——的削弱效应却十分显著[3]。
在家庭生活与学校教育两大日常情境中，ADHD儿童需要应对多方面的适应困难。学习层面，他们往往难以在课堂上维持专注姿态，课后作业环节拖延现象普遍，任务规划能力明显不足；社交层面，由于冲动控制薄弱，不当插话或肢体摩擦时有发生，容易在同伴关系中遭遇疏离。若长期处于反复受挫的状态中，患儿衍生出低自尊、焦虑等继发性心理问题的风险也随之上升[4]。因此，如何在日常环境中为ADHD儿童提供有效的行为引导，帮助其逐步建立规律的生活与学习节奏，兼具现实紧迫性与学术研究价值。

1.2 数字化行为辅助工具的应用价值
在现行的干预体系中，ADHD治疗主要沿着药物治疗与行为干预两条路径展开。药物方案（如盐酸哌甲酯等中枢兴奋剂）虽然在短期内可一定程度改善核心症状，但其在儿童群体中的长期使用始终伴有对食欲抑制、睡眠质量下降及发育影响等方面的担忧[2]。行为干预方案（如家长管理训练PMT等）虽被认为在长期效果上更具优势，但其实施高度依赖于专业人员的介入指导，对家长在日常执行中的一致性和持续性也提出了极高要求。然而在实际生活中，许多家庭面临着工作负荷与照护压力的双重挤压，部分家长在缺乏系统化工具支持的情况下，容易在反复的"督促—抗拒"拉锯中出现情绪失调，进而加剧家庭关系的紧张态势[5]。
在此背景下，数字化行为辅助工具展现出独特的应用潜力。基于智能移动终端的应用程序具有全天候可用、响应客观一致、行为数据精确可追溯等特性。将此类工具引入ADHD家庭干预框架，可以使其扮演一种"第三方介质"的调节角色：一方面，借助游戏化的任务呈现与即时反馈机制，为多巴胺分泌调节功能偏弱的ADHD儿童提供高频的正向激励，使枯燥的日常例行任务转化为具有参与感的趣味体验；另一方面，工具在一定程度上分担了原本由家长承担的监督职能，有助于减少亲子间因直接言语催促而产生的摩擦，使家长能够将更多精力投入到情感支持与陪伴中，进而为家庭动力结构（Family Dynamics）的改善创造条件。

1.3 面向ADHD的技术干预需求与缺口
尽管当前应用市场中已涌现出大量宣称具备"日程管理"、"时间追踪"以及"番茄工作法"等功能的效率类应用程序，但这些通用工具在面对具有特定脑神经基础的ADHD患儿时，暴露出若干适配性不足的问题，主要体现在以下几个方面：
（1）界面信息密度偏大，认知负荷超标。通用型效率工具的界面往往因功能堆砌而呈现较高的视觉复杂度，层级繁多的菜单结构和密集的图文排布，对于执行功能受限的ADHD儿童而言构成了额外的认知噪音源。
（2）缺少任务的细粒度前置拆解引导。ADHD儿童难以启动任务的根本原因之一，在于他们面对的往往是一个笼统而模糊的整体目标（例如"做作业"），而非一组可立即执行的具体步骤。目前多数工具并未提供这种强制性的、由粗到细的任务预拆解功能。
（3）反馈机制偏向负面结果导向。大多工具采用的是以数据总结为核心的冷性反馈方式（如"你今天有2个任务未完成"），这类信息传达容易触发ADHD患儿的挫败感。相比之下，他们更需要的是能够包容偶尔失败、对每一个微小进步给予肯定的即时温暖回应。
（4）缺乏家庭系统层面的协同设计。市面工具的关注焦点几乎全部集中于执行端（儿童），缺少对监护人端心理状态的引导机制，未能在家庭系统层面形成有效的联动干预。
综合以上分析，当前领域中亟需一款真正基于ADHD儿童认知特征进行交互设计、强调情感支持陪伴、以降低认知门槛为核心理念的双端协同辅助系统。这也是本课题立项与系统设计的出发点。

1.4 国内外研究现状与发展趋势
1.4.1 传统行为干预与认知疗法的局限
自二十世纪以来，认知行为疗法（CBT）及各类家长教育培训被陆续证实对ADHD症状的改善具有积极作用[7][8]。在临床实践中，治疗师通过角色模拟、代币经济系统（Token Economy）等手段，帮助患儿及其家庭在微观行为层面进行模式重建。然而，受时空条件制约，一旦患者回到自然家庭环境中，治疗效果的泛化（Generalization）与维持往往面临较大衰减。家长作为非专业的"执行者"，在缺乏持续监督与系统化工具辅助的前提下，其干预手段容易因主观情绪波动而产生实施变形，奖惩标准的一致性也难以保证。这一局限提示了引入标准化、可持续运行的技术辅助手段的必要性。

1.4.2 数字疗法与应用程序在ADHD干预中的发展
近年来，国际医疗研究机构与技术公司开始在神经精神类疾病领域积极探索数字疗法的应用可能。2020年，美国食品和药物管理局（FDA）批准了首款面向ADHD的处方级视频游戏产品EndeavorRx[6]，此举标志着游戏化数字干预在医疗认可层面实现了重要突破。在应用软件领域，欧美多国的研发团队已推出若干旨在增强时间感知能力、辅助日程规划的工具系统。
在国内，ADHD数字辅助软件的发展尚处于快速探索阶段。目前市面上的辅助产品形态以线上量表评估、知识付费课程和基础打卡工具为主。虽有部分开发者尝试引入积分奖励体系，但在交互细节打磨和面向神经多样性群体（Neurodiversity）的定制化研究方面，仍有较大的提升空间。

1.4.3 现状总结与本系统的突破方向
综合国内外的研究进展与产品实践可以看出，利用移动互联网平台提供行为干预辅助已逐渐成为领域共识。但就国内ADHD中小学群体而言，依然缺乏一套深度契合患者认知特征的家庭化综合解决方案。
本论文提出的"小步（Small Steps）"系统正是在这一研究缺口下被设计的。与同类现有产品相比，本系统在以下三个方面做出了差异化尝试：
（1）以"尊严优先"为核心的交互理念：摒弃居高临下的监督视角，所有交互环节均围绕"平辈陪伴者"的定位进行设计，刻意弱化任务失败的惩罚暴露。
（2）引入LLM驱动的渐进式辅助策略：不仅提供日常提醒，更通过大语言模型对任务完成的关键卡点进行分析，输出逐步退出辅助（Fading）的动态建议，以"从他律到自律"为根本目标方向。
（3）采用前瞻性技术架构进行全栈工程化开发：基于Vue 3.0与Spring Boot 3的现代微服务体系完成前后端全栈建设，借助UniApp解决跨终端兼容问题，并通过全链路数据追踪将行为数据以可视化方式呈现，打破传统人工干预的信息黑盒。

1.5 主要研究内容与论文组织结构
本论文围绕ADHD中小学生在日常生活与学习中面临的实际困难，针对当前辅助工具存在的不足，运用现代软件工程技术与方法，设计并实现了一套涵盖移动端（儿童+家长）与管理后台的多角色协同辅助系统。研究工作聚焦于以下几个核心方向：
（1）将心理学中"认知负荷削减"、"代币奖励"、"即时正向反馈"等抽象研究成果，通过UniApp前端框架转化为可交互的UI组件与操作流程（如番茄钟界面、微小动效反馈、色彩引导语言等）。
（2）在前后端分离的架构体系下，利用Spring Boot 3与Sa-Token技术实现细粒度的角色权限控制，并借助Redis保障多端会话同步与高频接口的缓存支撑。
（3）在后端集成大语言模型（LLM）服务接口，基于儿童长周期的历史行为数据与多维打卡状态进行分析，自动生成个性化的日常寄语与针对性辅助建议。
（4）完整展示从需求调研、数据库设计、接口定义到前后端集成部署的软件工程全流程。
本文后续内容组织如下：第2章从可行性分析、关键技术选型与需求分析三个角度奠定系统建设基础；第3章阐述系统总体架构设计、业务模块设计与数据库结构设计；第4章详述后端服务、移动端应用以及管理后台的核心实现逻辑；第5章进行系统测试与结果分析；第6章总结全文工作并对未来研究方向进行展望。


2 系统分析

系统分析是进入设计阶段前的关键准备环节。本章首先从技术、操作和经济三个角度对项目进行可行性论证，随后对系统涉及的核心技术栈与理论基础进行概要说明，最后基于对目标用户群体的深度调研，推导出系统在功能维度与非功能性能维度的具体需求规格。

2.1 可行性分析
2.1.1 技术可行性
"小步"系统的研发选用了当前行业中成熟度较高且发展前景良好的技术组件。后端采用Spring Boot 3框架搭配MyBatis-Plus数据持久层，二者在Java生态中已经过大规模工程验证，具备完善的社区支持与文档体系。前端选型方面，UniApp 3.0框架可一次编写实现多平台（Android、H5）的适配输出，Vue 3生态的Composition API和Pinia状态管理工具链亦已趋于稳定。数据层面，Postgres 15和Redis 7均为开源且广泛采用的数据库产品。上述技术组件的成熟度和可获取性，为系统的工程化落地提供了可靠的技术基础。

2.1.2 操作可行性
系统面向的终端用户包括ADHD儿童（6-15岁）及其家长。儿童端的交互设计遵循"极简认知"原则，采用大字体、大按钮和单线程任务呈现的方式，操作流程力求直觉化，不要求用户具备技术背景。家长端的功能布局参照主流移动应用的常见范式，学习成本较低。管理后台面向具备基本计算机操作能力的运营人员，操作门槛可控。

2.1.3 经济可行性
系统开发全程采用开源技术栈，不涉及商业授权费用。服务器部署可基于Docker容器化方案灵活调配计算资源，在项目初期以较低的基础设施投入即可支撑验证性运行。大语言模型（LLM）的接入采用按量计费的第三方API服务，初期用量可控，经济负担在可接受范围内。

2.2 关键技术概述
2.2.1 后端技术栈（Spring Boot 3与MyBatis-Plus）
系统核心后端服务选用了Spring Boot 3.5.9框架。作为Java生态中应用最为广泛的微服务构建基础之一，Spring Boot在依赖管理、自动配置与内置服务器方面提供了高效的开发支撑[10]。选择3.x版本系列主要考量其对JDK 17的原生适配以及对Spring Framework 6的平滑集成，这也为后续引入AOT编译优化预留了升级空间。在本系统中，Spring Boot主要承担全局异常处理、跨域资源共享（CORS）配置以及统一响应结构封装等基础性职责。
在数据持久化层面，系统集成了MyBatis-Plus增强型ORM框架。之所以做出这一选择，是基于对项目中存在的大量"任务流转统计"与"用户状态聚合"类复杂查询需求的考量。传统MyBatis在应对此类场景时需要编写较多的样板代码，而全自动的JPA在复杂多表联查时的SQL定制灵活性又显不足。MyBatis-Plus在二者之间取得了较好的平衡——其内置的通用Mapper和条件构造器（Wrapper）大幅精简了基础单表CRUD的XML编写工作量，同时通过代码生成器引擎在数据库表到实体类的映射效率上也有明显提升，有助于保障项目快速迭代过程中数据层的代码质量。

2.2.2 CSS框架技术（TailwindCSS）
系统UI渲染层引入了TailwindCSS原子化CSS框架。在传统开发模式下，开发者需要为各类界面元素编写独立的CSS类名，这种方式容易引发样式冲突与命名管理负担。TailwindCSS采用"效用优先（Utility-First）"理念[11]，将flex、pt-4、text-center、rounded-lg等原子级样式类直接嵌入Vue模板中使用。
在面向ADHD儿童的界面设计场景中，对色彩对比度和微过渡动画有着较为严格的要求。TailwindCSS使开发者能够直接在模板层面快速搭建并微调视觉呈现，有效避免了"修改局部CSS引发全局布局异常"的样式污染问题。同时，其构建工具在生产环境中仅打包实际使用的类名，对移动端安装包体积的控制也产生了积极影响。

2.2.3 权限管理技术（Sa-Token）
在安全防护与权限隔离层面，本系统需同时服务"管理员、家庭主账号（家长）和附属子账号（儿童）"三类具有不同权限边界的角色。经评估，Spring Security虽功能全面但配置繁琐度偏高，学习曲线较为陡峭，与本项目的开发节奏不完全匹配。最终系统选用了国内开源的轻量级权限认证框架Sa-Token[14]。
Sa-Token的核心优势在于其API调用方式与人类直觉高度贴合——仅需StpUtil.login(id)一行代码即可完成会话登录操作。在此基础上，系统利用其内置拦截器引擎，结合自定义注解（如@RequiresRoles("PARENT")），实现了接口方法级别的细粒度鉴权。配合Redis，Sa-Token还承担了Token的无状态分布式校验、同端多账号互斥踢出以及敏感操作的二次认证等安全控制职能。

2.2.4 相关理论基础
技术手段的价值最终需要回归到对人的服务效能上。ADHD行为干预属于典型的技术与人文交叉领域课题，本系统的UI设计方向、交互逻辑定义及后端业务判断，均以如下心理学与教育学理论作为参照依据。
（1）认知负荷理论（Cognitive Load Theory, CLT）
认知负荷理论指出人类工作记忆的容量存在明确上限[7]。对于ADHD患儿而言，其前额叶皮层的发育特征使其在信息过滤和任务切换方面的能力低于同龄人平均水平。如果软件界面堆叠了过量的按钮、文字与色彩块，将引发"外在认知负荷"超载，导致患儿产生厌烦和拒绝使用的倾向。
在"小步"系统的前端设计中，这一理论被转化为"认知卸载"这一具体实践原则。例如，儿童端待办列表页面在同一屏幕内仅展示一项核心任务，背景色采用低饱和度的柔和色调；在任务表述上，系统鼓励使用图形化Icon搭配极简文案的形式。这种"单线程呈现"的界面策略，旨在最大限度地释放ADHD患儿有限的工作记忆空间，使其将主要精力集中于任务本身。
（2）渐进式辅助与正反馈循环模型
渐进式辅助源自维果茨基提出的"最近发展区"概念中的"脚手架理论（Scaffolding）"——它主张外部辅助力量在个体学习初期应提供较强支持，然后随着能力提升而逐步撤除（Fading），最终达成自主[8]。
在本系统的逻辑设计中，当一项新的长期习惯任务被创建时，系统初期会提供较高频率的多模态提醒并给予较高权重的代币奖励。当检测到该任务连续多日被按时完成后，系统将通过AI研判模块触发辅助降级策略——逐步减少前置提醒频次，引导外在强制力向内在习惯节奏过渡。这一"从他律到自律"的动态设计，旨在防止儿童对电子辅助工具形成过度依赖。
同时，本系统借鉴了操作性条件反射的相关研究[9]，采用微小、频繁且具有一定随机性的即时奖励（如专注结束后的星星掉落动画、碎片收集等），替代传统的远期结果期待型奖励，以此构建可持续的正向反馈循环。
（3）家庭动力学视角与角色重塑
传统干预存在的一种结构性偏差是将焦点过度集中于"矫正"儿童个体，而忽视了家庭作为整体微生态系统所发挥的影响力。在典型的ADHD家庭中，家长若长期充当"高压监督者"角色，不仅自身面临情绪耗竭风险，也容易与步入青春期的患儿发生正面对抗，使得任何干预行为均带上被动抗拒的底色[5]。
本系统尝试在这一家庭动力结构中引入调节机制。通过让系统作为"缓冲介质"介入，将原本依靠家长完成的记录、催促等易引发负面情绪的硬性行为，以游戏化形式由App客观完成。家长端则转变为数据观测视角——家长透过系统反馈看到的是类似"今日专注时长较前日下降20%，可能与睡眠时间不足有关"这样的客观提示。在这一框架下，家长的角色有条件向更具包容性的"观察者"方向迁移，而非继续停留在传统的"裁判者"位置。

2.3 系统需求分析
在完成技术选型与理论基础梳理之后，进入系统的需求规格制定阶段。需求分析是软件工程流程中决定系统建设边界与最终交付价值的关键环节。本节针对"小步"系统的目标群体特征进行深度剖析，在此基础上推导出功能维度与非功能维度的具体需求指标。

2.3.1 目标用户群体分析
本系统的核心受众呈现"双核"结构：即干预的直接接收者（ADHD儿童）与干预的辅助实施者（家长或监护人）。这两类群体在认知基础、心理预期以及对软件的使用诉求上存在显著差异。
（1）ADHD儿童与青少年的认知与行为特征
综合相关文献资料与调研信息，6至15岁学龄段的ADHD群体普遍呈现以下特征画像：注意力短暂且高度受兴趣驱动——对高刺激活动（如竞技游戏）可维持较高专注，但对日常重复性任务（如洗漱、整理物品）的注意力通常难以超过5至10分钟；时间感知能力偏弱——缺乏对"任务预计耗时"的准确评估，经常出现磨蹭或临近截止时慌乱的情况；情绪波动频率较高且挫折抗性偏低——面对小幅失败更容易产生剧烈情绪反应或直接选择放弃。
基于上述特征，儿童端应用的设计底线应当是：尽可能低的学习门槛、较高的误触容错率、以及即时且明显的视觉或听觉正向反馈。
（2）监护人群体的管理诉求与核心痛点
陪伴ADHD患儿成长的家长群体同样是本系统需要重点服务的用户。他们面临的典型困境包括：监督疲劳与精力透支——每天需重复发出大量相同的行为指令，长期消耗导致情绪耗竭，也间接提升了家庭冲突的频率；过程不可见与"虚假完成"困境——缺少对任务执行质量和实际投入时长的量化判断手段；对实操型科学指导的需求——家长希望获得的不是泛泛而谈的育儿理论，而是能够直接应用于"孩子此刻情绪崩溃时该如何回应"这类具体场景的策略建议。
因此，家长端的需求中心应围绕数据可视化呈现、任务高效下发以及智能辅助建议展开，承担家长在家庭干预中的"外脑"与情绪调节辅助角色。

2.3.2 系统功能需求
依据多角色业务流向，系统在功能域上划分为三大相互关联的模块：儿童移动端、家长移动端以及全局管理后台。
（1）核心业务流程概述
系统的整体业务流程围绕"任务"这一核心实体展开。在典型的一天周期中，家长在管理端创建任务并分配至指定日期的儿童账户；儿童端接收任务指令后，通过专注模式执行并在完成后触发奖励结算；任务数据随即回流至服务端并同步更新至家长端看板；夜间时段，系统内置的AI模块会扫描全天数据，生成分析总结与介入建议，供次日使用。
（2）儿童端功能需求
儿童端定位为数据产生的触发源头，核心功能应尽可能精简，主要包含：任务卡片的极简展示——以大字体、高辨识度图标的方式按序呈现当下待办任务，支持一键操作，避免列表式平铺带来的视觉压迫；沉浸式专注模式——提供基于番茄工作法变体的计时工具，计时期间屏蔽外界干扰，以可视化的动效具象化时间流逝；即时正向反馈与代币系统——任务完成后触发视觉奖励动画并立即发放虚拟代币，代币进度以可视化方式呈现，可兑换由家长预设的心愿奖品。
（3）家长端功能需求
家长端旨在为家庭管理者提供任务配置与数据观测的操控界面，核心功能包括：结构化任务创建与模版引用——支持设置执行周期、代币奖励数额及前置步骤等参数，并内置常见场景模版供一键调用；多维度数据看板——支持查看儿童每日任务完成率、累计专注时长及各任务耗时分布等指标，数据以图表形式直观呈现；AI反馈接收——展示由大语言模型基于前日数据自动生成的每日寄语与辅助建议，并支持同步推送至儿童端。
（4）管理后台功能需求
管理后台面向平台运营人员与超级管理员，核心保障系统的正常运转，主要功能包括：用户与组织管理——实现对家长账号和儿童子账号的状态管理，监控平台活跃度与异常登录行为；公共素材库维护——管理全局的任务模版库以及系统内置的奖励图标与表扬音效素材；AI服务配置——设置对外部LLM的API密钥与Token消耗监控，并配置模型降级时的兜底文案库。

2.3.3 非功能性需求分析
（1）性能指标
高频操作接口（如专注模式结束时的状态同步与代币结算）的响应时间需控制在150毫秒以内，以确保前端动画衔接流畅。AI寄语生成由于涉及较长的外部调用链路（10-30秒级别），必须采用异步处理方式，不得阻塞用户界面的主交互线程。系统需具备应对晚间高峰时段（约20:00-21:00）的并发承载能力。
（2）安全性与隐私保护
ADHD属于敏感个人健康信息范畴。数据库设计需遵循最小化采集原则，含患儿个人标识信息的字段在入库时应进行加密或脱敏处理。前端向后端发送的写操作请求需经过时间戳校验与签名比对，防范重放攻击。利用Sa-Token基于RBAC模型在路由层和核心业务逻辑中实施严格的角色权限验证，防止纵向或横向越权访问。
（3）可用性与兼容性
移动端安装包需在主流Android设备（含华为等国产厂商机型）上保持一致的排版与交互表现，并正确适配沉浸式状态栏与异形屏。儿童端的核心计时功能需具备离线可用性——在Wi-Fi信号弱化或临时断连的场景下，本地倒计时模块应正常运行，待网络恢复后在后台进行数据同步。

3 系统设计

系统设计是连接需求分析与编码实现的关键桥梁。本章将从宏观的逻辑分层入手，制定前后端分离的协同运作机制；进而在微观层面剖析认证鉴权、任务流转等核心业务模块的设计方案；最后，将业务实体沉淀至数据层，提供标准化、可扩展的数据存储结构设计。

3.1 总体架构设计

图 3.1 总体架构设计

3.1.1 架构演进与逻辑分层
本系统秉承高内聚、低耦合的设计方针，采用经典的N层逻辑架构体系。为保证代码的可维护性与模块的独立演进能力，系统将整体结构自上而下划分为表现层、业务逻辑层、数据访问层及基础设施层。
表现层（前端控制层）：涵盖家长和儿童使用的移动端App以及运营人员使用的Web管理后台。该层通过UniApp与Vue 3技术栈完成UI渲染，负责将用户的触控操作转化为标准HTTP请求，并根据后端处理结果更新视图状态。
业务逻辑层（Service层）：基于Spring Boot 3搭建，封装了任务流转规则、代币核算逻辑以及家长-儿童绑定等核心业务处理。通过Controller-Service-Manager的三层结构，承载系统最关键的计算推演逻辑，同时负责输入校验与非法请求拦截。
数据访问层（DAO层）：借助MyBatis-Plus ORM框架，对底层数据引擎的操作进行语义化封装。向上为业务层提供面向对象的实体查询方案，向下消解了直接编写SQL带来的硬编码耦合。
基础设施层：包含Postgres关系型数据库、Redis缓存引擎以及对接外部大语言模型的API代理等基础组件。该层不仅负责数据持久化，也内聚了超时重试、网络异常处理等基础设施逻辑。

3.1.2 前后端分离协同机制
在部署规划上，系统完全采用前后端分离模型。前端App（运行于移动客户端环境）和管理后台（运行于Web浏览器）通过HTTPS协议以RESTful API格式向云端的Nginx网关发送业务请求。网关作为唯一的对外暴露节点，在完成负载均衡与跨域过滤后，将流量转发至内网中的Spring Boot业务集群。前后端的数据报文统一约定为application/json格式，并通过公共响应泛型模型（Result<T>）进行包装，以携带全局错误码与标准化的信息文本，这一约定在降低前后端联调成本方面发挥了实际作用。

3.2 核心业务模块设计
3.2.1 用户认证与鉴权模块设计
本系统涉及管理员、家长和儿童三种权限差异显著的角色身份，访问安全防御依托Sa-Token框架构建。整体鉴权流程设计如下：
（1）集中登录认证：用户通过账号密码提交认证请求，后端验证通过后在Redis中生成会话上下文并将Token凭据返回给前端。
（2）双域隔离：管理后台与移动端App分别采用独立的Sa-Token账号体系，在缓存路由层实现严格隔离，防止不同终端间的Token误用。
（3）细粒度权限管控：业务接口执行前需经过全局拦截器检验。通过在Controller方法上注入@SaCheckRole和@SaCheckPermission等注解，确保例如儿童不可创建高优任务、家长不能跨家庭查看其他儿童数据等权限边界约束。

3.2.2 任务管理与流程设计
任务（Task）是贯穿系统各功能线的核心业务实体。考虑到ADHD患儿完成状态的高度不确定性，在任务生命周期的状态机设计上采取了弹性策略：
（1）核心状态枚举：设计为"未开始"、"执行中"、"已完成"和"已废弃"四种状态，覆盖从创建到结束的完整流转。
（2）任务配置模型：在家长创建阶段，除基本的标题与预期耗时外，引入了"执行周期类型"和"奖励代币权值"等核心属性，支持单次、每日循环及自定义频率的配置。
（3）任务拆解特性：支持为复杂任务绑定"关联子步骤清单"，通过将大任务化整为零的方式缓解ADHD儿童面对长期任务时的畏难心理，相应的过程考核由后端逻辑支撑实现。

3.2.3 专注模式与时间管理机制设计
专注模块服务于儿童进入特定任务后的沉浸式时间管理，其运行流程以保障实时流畅为第一优先级：
（1）进入阶段：前端获取当前待专注任务的配置参数。儿童确认开始后，Pinia状态树切入"专注锁定态"，倒计时引擎启动。在此状态下，App全局路由返回与底部导航切换请求被阻断，实现全屏沉浸效果。
（2）正常完成：若倒计时自然结束，前端生成一条包含持续时长和设备信息的完成记录包并发送至后端API，后端开启事务确认任务完成并触发奖励核算。
（3）中途退出：若儿童中途打断，前端仍将已积累的有效时长回传，后端将其归档但标记为"非完全完成"，以便后续AI模块分析儿童注意力持续性的阈值特征。

3.2.4 智能辅助生成与数据反馈模型设计
为应对家庭干预过程中辅导话术枯竭和干预行为机械化的问题，系统设计了一条由后端定时触发、对接第三方AI接口的旁路反馈链路。该模块独立于每日事务主流程运行，具体工作步骤如下：
（1）每日特定时段，后端调度系统对指定绑定对（单个患儿+监护人）的近十天打卡记录进行数据聚合，提取任务总数、完成率、超时行为特征及情绪打分等维度的指标。
（2）将聚合数据整理为结构化的JSON格式"行为指征摘要"。
（3）结合管理后台预配置的系统Prompt模板，向远程LLM引擎发起异步API请求。
（4）将生成的文本内容经脱敏处理后落库保存。待家长次日登录App时，首页以专栏卡片形式呈现这条经AI解析生成的辅助指引，家长可选择将其同步推送至儿童端的"时光机信箱"界面。

3.3 数据库设计
数据库是系统业务逻辑落地的持久化基础。本节梳理支撑以上业务模块运转所需的核心库表结构设计。

图 3.2 核心库表设计结构

3.3.1 概念模型与E-R图设计
通过从业务需求中提取实体与关联关系，本系统的概念模型主要包含以下四类核心实体：
（1）用户实体（User）：指代自然人用户，与"角色"之间存在多对多映射关系。家长与儿童同属用户表，依靠专门的映射表建立监护绑定关系。
（2）任务配置实体（Task Template）：与创建者（用户）之间构成一对多关系，记录任务的抽象配置规则。
（3）执行日志实体（Task Log）：记录儿童每次实际执行的具体结果数据，与儿童账户属于一对多关系，与特定日期对应的具体任务之间属于一对一关系。
（4）代币流水实体（Reward Log）：记录资产变更的明细历史，与用户资产池属性形成闭环校验关系。

3.3.2 关键数据表结构设计
基于上述E-R模型并结合查询优化考量，系统在Postgres 15上设计了以下核心物理表（此处列出关键字段与约束说明）：

表 3.3.2.1 系统用户表 (sys_user)
字段名称	类型	长度	必填	说明
user_id	BIGINT	20	是	主键 (雪花算法)
dept_id	BIGINT	20	否	所属家庭/机构 ID
user_name	VARCHAR	64	是	登录账号/用户名
password	VARCHAR	128	是	Bcrypt 加密 Hash
user_type	TINYINT	4	是	1:管理员, 2:家长, 3:儿童
nickname	VARCHAR	64	否	显示简称或儿童名
coin_balance	INT	11	是	账户代币余额 (默认 0)
status	TINYINT	4	是	0:正常, 1:停用

表 3.3.2.2 家庭/部门表 (sys_dept)
字段名称	类型	说明
dept_id	BIGINT	部门 ID
parent_id	BIGINT	父部门 ID
dept_name	VARCHAR	家庭名称 (如: "Leo的家")
leader	VARCHAR	家庭管理员 (家长)


表 3.3.2.3 父母绑定关系表 (ss_parent_child)
字段名称	类型	说明
id	BIGINT	主键
parent_id	BIGINT	家长用户 ID (FK)
child_id	BIGINT	儿童用户 ID (FK)
bind_time	DATETIME	绑定时间



表 3.3.2.4 任务定义表 (ss_task)
字段名称	类型	必填	说明	业务逻辑
task_id	BIGINT	是	主键	-
parent_id	BIGINT	否	父任务 ID	用于无限级任务拆解 (Task Crusher)
creator_id	BIGINT	是	创建者 ID	指向 sys_user (家长/系统)
title	VARCHAR	是	任务名称	如 "睡前阅读"
content	TEXT	否	任务指导语	具体的动作拆解文本
prompt_level	INT	是	辅助强度	1:全视频/图文, 5:自主完成
reward_amount	INT	是	激励金币值	完成任务可得数额
cycle_type	TINYINT	是	循环类型	0:单次, 1:每日, 2:每周
status	CHAR	是	状态	0:草稿, 1:启用, 2:废弃



表 3.3.2.5 任务执行日志 (ss_task_log)
字段名称	类型	说明
log_id	BIGINT	主键
task_id	BIGINT	关联任务定义
child_id	BIGINT	执行儿童 ID
target_date	DATE	预定执行日期
actual_duration	INT	实际专注时长 (秒)
status	TINYINT	0:待办, 1:进行中, 2:已完成, 3:放弃
end_time	DATETIME	提交打卡的时间

表 3.3.2.6 情绪分析表 (ss_emotion_log)
字段名称	类型	说明
log_id	BIGINT	主键
task_id	BIGINT	关联任务定义
child_id	BIGINT	执行儿童 ID
target_date	DATE	预定执行日期
actual_duration	INT	实际专注时长 (秒)
status	TINYINT	0:待办, 1:进行中, 2:已完成, 3:放弃
end_time	DATETIME	提交打卡的时间

3.3.3 缓存策略与Redis结构设计
系统中的高频读写场景（如每次路由跳转时的会话合法性校验、首页排行榜积分查询等）若直接落在关系型数据库上，容易引发性能瓶颈。为此，系统以Redis构建了全局缓存层，核心策略包括：
（1）认证缓存：配合Sa-Token，为每个登录用户建立satoken:login:session:{userId}格式的Hash对象，存储权限集合与失效时间戳，消除权限比对过程的数据库查询开销。
（2）任务操作防重机制：利用Redis的短期Key自动过期机制（TTL）结合SETNX分布式互斥指令，当儿童端快速双击"任务完成"按钮时，拦截重复提交请求，防止网络延迟导致的代币重复结算问题。

本章分别输出了系统用户表、任务定义表及各类流水记录表的E-R概念定义和字段结构规范，并配合Redis缓存拓扑设计，搭建了完整的数据存储框架。

4 系统实现

本章为论文的工程实践核心部分。在前述需求规划与架构设计的引导下，本章分别进入smallsteps-api（后端服务）、smallsteps-app（移动端应用）以及smallsteps-ui（管理后台）三个工程子库，结合关键代码片段与组件配置，展示系统从设计方案到可运行程序的转化过程。

4.1 后端核心功能实现（smallsteps-api）
后端工程基于Spring Boot 3标准的Maven多模块体系构建，按职能划分为API定义、Service业务逻辑以及配置管理中心三大部分，承担系统的核心计算与数据处理职责。

4.1.1 安全认证与路由拦截实现
在用户提交登录请求时，系统调用SysUserServiceImpl中的验证方法。验证通过后，通过调用Sa-Token的StpUtil.login(user.getId())接口完成会话建立。该接口调用后，框架自动将当前用户的登录状态和过期时间写入Redis缓存，同时在HTTP响应头中以satoken为索引下发凭据标识。
为保障核心业务接口不受未授权访问，后端实现了一个WebMvcConfigurer配置类，在其中注册了Sa-Token的全局拦截器。其核心实现逻辑如下：

@Configuration
public class SaTokenConfigure implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new SaInterceptor(handle -> StpUtil.checkLogin()))
            .addPathPatterns("/ssapi/**")
            .excludePathPatterns("/ssapi/public/login", "/ssapi/public/register");
    }
}

上述配置的作用在于：除公开的登录和注册接口外，所有以/ssapi/为前缀的请求在进入Controller的业务方法之前，都必须通过与Redis中存储的会话Token的比对校验，从而实现接入层的统一身份认证。

4.1.2 任务管理的业务逻辑实现
任务系统的创建与流转涉及多表写入的事务一致性保障。以"家长为儿童创建当天任务"这一典型场景为例：前端向TaskController发起POST请求，携带目标儿童ID、任务元数据及预期时段等参数。在TaskServiceImpl的处理逻辑中，由于该操作同时涉及向任务模版表插入源记录和在执行日志表预生成当日待办占位记录两步写入操作，为防止网络异常导致数据不一致（如模版已入库但日志未生成），整个Service方法使用Spring框架提供的@Transactional(rollbackFor = Exception.class)注解进行事务包覆。
此外，在家长端"查看孩子近一周排期任务"的查询场景中，系统利用MyBatis-Plus的QueryWrapper构建了类型安全的条件筛选逻辑：

QueryWrapper<TaskDailyLog> wrapper = new QueryWrapper<>();
wrapper.eq("child_id", currentChildId)
       .between("target_date", startDate, endDate)
       .orderByDesc("target_date");
return taskDailyLogMapper.selectList(wrapper);

这种编程式查询构建方式不仅避免了手动SQL拼接的繁琐，也天然防御了SQL注入风险。

4.1.3 数据看板聚合与智能生成的后端处理
由于系统需要向家长端提供实时的数据反馈图表，若每次请求都在数据库中执行聚合运算，将面临较大的性能压力。为此，后端设计了DashboardAggregatorService作为数据聚合层。该定时服务在每天凌晨自动扫描前一天的全部打卡日志，计算任务完成率和平均超时比例等指标，将结果以结构化摘要的形式缓存于Redis中。
在大语言模型集成方面，相关功能封装于独立的AiInferenceService中。后端利用Spring的WebClient向外部LLM服务发起HTTP请求，Prompt组装的基本方式是将儿童的行为数据指标嵌入预设模板中生成完整的请求文本。考虑到外部调用可能遭遇限流或超时，系统对该服务配置了降级策略——若连续3次调用AI接口失败，将从本地数据库的预设文本库中随机选取一条通用安抚文案返回给家长端，保证前端界面始终能正常展示内容。

4.2 移动端应用实现（smallsteps-app）
移动端是ADHD患儿与家长直接交互的核心载体，该前端工程基于UniApp 3.0与Vue 3技术栈构建。

4.2.1 项目工程配置与Vue 3生态集成
在项目的构建配置中，引入了适配UniApp的Vite构建工具链，为开发过程提供热重载的实时反馈。代码层面采用Vue 3的Composition API（<script setup>语法），将原本按生命周期切割的逻辑内聚为更清晰的函数式组织结构。例如在首页Index.vue中，当需要在用户切回应用前台时重新拉取数据，仅需以声明式的onShow(() => { fetchLatestTask() })即可完成绑定。

4.2.2 Pinia状态管理在双模式切换中的应用
双模式（家长模式/儿童模式）是应用的核心特性之一。用户登录后的身份标识不通过多层组件Props逐级传递，而是托管于全局唯一的Pinia Store中。在项目的src/stores/auth.js文件里，创建了用于长期维持登录状态和角色信息的状态树。当后端验证完成并返回Token后，该Store即完成初始化。
这一设计使得底部TabBar组件或路由鉴权中间件只需读取authStore.currentUserType属性，即可在极短时间内完成界面模式切换——将面向家长的"数据看板、任务分发"入口替换为面向儿童的"我的奖章、开始专注"界面。

图 4.1 app登录

4.2.3 基于TailwindCSS的响应式页面构建
基于ADHD界面应尽量减少文字、多使用包容性色彩块的设计原则，项目深度集成了TailwindCSS预设工具链。开发者无需在各个.vue组件中编写冗长的<style>代码块。以任务概览卡片为例，直接在模板中使用如下原子类组合：

<view class="flex items-center justify-between p-4 mb-3 bg-white rounded-2xl shadow-sm hover:shadow-md transition">

即可构建出兼顾移动端尺寸适配与圆角阴影效果的界面卡片组件。这种方式在提升UI产出效率的同时，也保证了组件间视觉风格的一致性。

4.2.4 核心交互流程实现
专注模式页面（FocusMode.vue）是整个移动端应用中交互复杂度最高也最为重要的模块。该页面利用原生的setInterval构建计时器核心逻辑，结合Vue 3响应式变量countdownLeft驱动环形进度条组件的渲染更新。
当用户点击"开始"按钮后，系统执行以下操作：隐藏顶部原生导航栏，调用uni.setKeepScreenOn保持屏幕常亮，阻断屏幕熄灭。在专注过程中，应用对物理返回按键和滑动返回手势进行了拦截处理：

onBackPress((options) => {
    if (isFocusing.value) {
        uni.showModal({ title: '确认放弃?', content: '现在退出专注将失去当前奖励碎片' });
        return true; // 拦截返回操作
    }
});

这种防护型设计的意义在于：考虑到ADHD儿童误触频率较高的使用特征，在专注进行中加入退出二次确认可以有效避免因意外操作导致任务中断所带来的挫败感，从而为系统积累了宝贵的情感可用性。

图 4.2.4.1 任务


图 4.2.4.2 洞察


图 4.2.4.3 家长中心


4.3 管理后台实现（smallsteps-ui）
管理后台作为整个干预生态的数据中枢，基于Vue 3与Element Plus技术体系独立构建与部署。

4.3.1 管理员登录与前端路由权限控制
管理后台由于掌握较高的系统操作权限（如账号封禁、全局日志查阅），除后端鉴权外，还在前端层面实施了动态路由控制。管理员登录成功后，应用首先向后端请求其有权访问的菜单树配置（Menu Tree），然后基于该配置动态注册对应的路由条目。即使外部用户获知后台URL并尝试直接访问某个管理页面路由，前端的路由守卫（Router Guard）也会在页面渲染前检测到缺少有效Token或权限标记，并将请求重定向至公共登录界面。

图 4.3.1.1 管理后台登录

4.3.2 数据图表与列表渲染实现
针对平台级的数据分析需求（如每日打卡总次数监控、活跃度趋势等），管理后台使用ECharts图表库搭配Element Plus组件系统进行实现。开发者构建了涵盖近30天的柱状图和折线图组件用于数据可视化展示。在数据更新机制上，组件内通过Vue 3的Watcher监听API返回的新数据集，当检测到数据变化时立即调用ECharts实例的setOption()方法触发图表重绘，从而保证展示数据与后端状态的实时同步。


图 4.3.2.1 系统监控

本章围绕三个工程子库，分别展示了后端服务如何通过Spring Boot与MyBatis-Plus保障数据一致性、AI链路如何实现调用与降级；移动端如何借助UniApp和Pinia实现双模式无缝切换、利用TailwindCSS提升界面适配效率以及专注模式如何处理意外中断；管理后台如何通过动态路由和ECharts满足运营管理需求。整个系统的代码实现至此已基本呈现完整。下一章将对已落地的系统进行功能与稳定性方面的测试验证。

5 系统测试与结果分析

软件工程要求系统在正式交付用户使用之前经过充分的测试验证。对于"小步"系统而言，鉴于其目标群体的特殊性（儿童）以及所处理数据的高隐私敏感度，系统在稳定性、安全性和交互防错能力方面需要达到较高标准。本章从测试环境搭建、核心功能逻辑验证和结果综合分析三个层面展开描述。

5.1 测试环境与策略
5.1.1 测试环境说明
为保证测试结果的可靠性与对生产环境的拟真度，本次测试构建了独立的预发布回归环境：
后端服务端：使用Docker容器化部署Postgres 15数据库与Redis 7实例，确保测试数据与开发环境的隔离性。
前端终端：移动端分别输出Android平台的.apk安装包和H5测试包，在华为P40 Pro和Mate 30 Pro两款机型上完成了实机验证。管理后台终端通过最新版Google Chrome浏览器访问。

5.1.2 测试维度设计
测试规划围绕以下三个维度展开：
功能逻辑验证（黑盒测试）：确认从"家长建任务→儿童接收→执行完成→AI反馈生成"的完整业务闭环不存在逻辑断点。
交互可用性测试：模拟用户可能的操作路径，验证各界面元素的响应行为与反馈是否符合预期。
兼容性与弱网测试：验证移动端在不同设备和网络条件下的运行表现。

5.2 核心业务功能测试
5.2.1 多角色权限与越权防护测试
测试目标：验证Sa-Token在多角色场景下对横向越权和纵向越权的防护有效性。
测试执行与结果：
场景A——使用儿童端账号的Token直接发起POST请求访问/ssapi/parent/task/create（家长建任务接口）。服务端返回403 Forbidden状态码并抛出"权限不足"异常提示，符合预期。
场景B——使用家长甲的Token尝试获取家长乙名下儿童的数据。底层SQL数据隔离拦截器阻断了该请求，返回空数组。结果表明跨家庭的数据隔离机制有效运行，符合预期。
结论：基于Sa-Token的多角色权限管控与租户级数据隔离设计均通过了验证。

5.2.2 任务生命周期状态流转测试
测试目标：覆盖任务从创建到完成或废弃的全生命周期关键流转节点。
测试执行与结果：
（1）在家长端创建一条"限时5分钟"的扫地任务。儿童端刷新后即可看到对应的待办卡片（数据库状态status=0）。
（2）儿童端点击"开始专注"，倒计时正常启动（状态变更为status=1）。在计时过程中将应用切至后台挂起，再次唤醒后，计时器依据自然时间差正确递减，未出现暂停或时间错乱。
（3）倒计时计满后，成功音效正常播放，系统自动提交完成记录。数据库中的coin_balance字段确认代币余额更新正确（状态变更为status=2）。
结论：任务全生命周期的状态推演与预期一致，数据回溯完整。

5.2.3 兼容性与弱网场景测试
兼容性方面，移动端安装包分别在华为P40 Pro（搭载HarmonyOS内核）和Mate 30 Pro上进行了主要页面的排版检查和交互测试，TailwindCSS原子类生成的圆角、阴影等视觉效果渲染正常，沉浸式状态栏适配无异常。
弱网测试方面，在手动将设备网络切换为弱Wi-Fi条件后，儿童端的本地倒计时模块持续正常运行未受影响。在网络恢复后，客户端在后台自动向服务端发起了数据同步请求，补传了断网期间的打卡数据，验证了离线缓存与增量同步机制的基本可用性。

5.3 测试结果综合分析
经过上述多维度测试，"小步"系统的主要功能模块运行稳定，三类角色的权限隔离与业务流转逻辑均符合需求定义。任务生命周期管理在含App切后台等干扰场景下仍保持了正确性。兼容性与弱网场景的测试结果表明系统在面向实际使用环境时具备了基本的鲁棒性。总体而言，系统达到了设计初期所设定的功能与稳定性目标。

6 总结与展望

6.1 研究成果总结
本论文围绕ADHD中小学生在日常生活和学习中面临的行为习惯养成困难，设计并实现了一套名为"小步（Small Steps）"的多端协同行为辅助系统。在整个研究与开发过程中，主要取得了以下成果：
（1）完成了理论到工程实践的转化。通过将认知负荷削弱理论和渐进式脚手架理论融入界面交互设计，系统在儿童端实现了"单屏单任务"的极简呈现策略，并以游戏化代币的正向奖励搭配AI生成的话术反馈构成了完整的干预闭环。
（2）搭建了基于现代技术栈的前后端分离架构。后端利用Spring Boot 3和MyBatis-Plus组建业务枢纽，Sa-Token构建权限防线；前端基于UniApp 3.0实现多端覆盖，结合Vue 3 Composition API和Pinia实现状态管理与角色动态切换。
（3）完成了AI赋能的智能反馈模块。在后端定时任务中集成了大语言模型接口，使系统具备了根据儿童历史行为数据自动生成个性化辅助建议的能力，为家庭干预场景提供了一种不同于传统手动编写的反馈生成方式。

6.2 研究的意义与贡献
在实践层面，本系统为ADHD家庭提供了一种可落地的数字化辅助工具方案。通过让技术系统承担日常记录与提醒的职能，在一定程度上减轻了家长在监督环节的精力消耗，为亲子关系的改善创造了结构性条件。儿童端的游戏化设计和即时反馈机制有助于提升患儿对日常任务的参与度。
在工程层面，本课题完整演示了从需求调研、架构设计、数据库建模、接口开发到多端集成的软件工程全流程，为同类数字疗法产品的开发提供了一套可参照的技术路径与工程组织方式。

6.3 存在的不足
当前系统仍存在以下有待改进之处：
（1）数据采集维度相对单一。目前系统对儿童行为状态的判断主要依赖"主动点击打卡"这一操作动作，缺乏生理指标（如心率、血氧等）的客观辅助验证，可能导致部分数据的准确性不足。
（2）LLM生成内容的质量稳定性有待提升。由于依赖第三方API服务，生成结果在不同模型版本和请求时段之间可能存在波动，且当前的降级兜底策略仅提供了有限的预设文案储备。
（3）用户测试的覆盖范围有限。受条件制约，系统尚未在真实的ADHD家庭群体中开展大规模的可用性评估与长期跟踪验证。

6.4 未来研究展望
针对上述不足，后续研究可在以下方向进行拓展：
（1）探索多模态数据感知的集成方案。考虑引入可穿戴设备的蓝牙数据通道，通过实时获取心率、活动量等生理指标，与打卡行为数据进行交叉验证，形成多模态的行为状态评估。
（2）推进大模型能力的本地化部署。为保护儿童数据的绝对隐私并降低对第三方API的依赖，未来可探索在网关内网或边缘计算节点部署轻量化LLM（如Qwen-1.5B/7B级别模型）的可行性。
（3）开展面向真实用户群体的效果验证研究。在伦理审批框架下，邀请ADHD家庭参与系统的试用与反馈，收集长期使用数据以评估系统对行为习惯养成的实际促进效果。

致谢

在此，对在学术研究过程中给予悉心指导的老师、在系统开发阶段提供使用反馈的试用家庭，以及为开源技术生态持续贡献力量的开发者社区，表达最诚挚的谢意。

参考文献


[1] 郑毅, 刘靖. 中国注意缺陷多动障碍防治指南(第二版)[M]. 北京: 中华医学电子音像出版社, 2015. 
[2] 罗学荣. 儿童注意缺陷多动障碍[M]. 北京: 人民卫生出版社, 2011. 
[3] 王玉凤. 注意缺陷多动障碍[M]. 北京: 北京大学医学出版社, 2007. 
[4] 孙焕良, 李海鹰, 张莉. 数字化干预在儿童注意缺陷多动障碍中的应用进展[J]. 中国儿童保健杂志, 2021, 29(12): 1319-1322. 
[5] 王梦鸽, 谢新水. 智能技术赋能注意缺陷多动障碍(ADHD)干预:现状、挑战与展望[J]. 中国特殊教育, 2022(5): 55-62. 
[6] Kollins S H, DeLoss D J, Cañadas E, et al. A novel digital intervention for actively reducing severity of paediatric ADHD (STARS-ADHD): a randomised controlled trial[J]. The Lancet Digital Health, 2020, 2(4): e168-e178. 
[7] Sweller J. Cognitive load during problem solving: Effects on learning[J]. Cognitive Science, 1988, 12(2): 257-285. 
[8] Vygotsky L S. Mind in Society: The Development of Higher Psychological Processes[M]. Cambridge: Harvard University Press, 1978. 
[9] Deterding S, Dixon D, Khaled R, et al. From game design elements to gamefulness: defining "gamification"[C]//Proceedings of the 15th International Academic MindTrek Conference. 2011: 9-15. 
[10] Craig Walls. Spring Boot in Action[M]. Shelter Island: Manning Publications, 2016. 
[11] 尤雨溪, 霍春阳. Vue.js 设计与实现[M]. 北京: 人民邮电出版社, 2022. 
[12] 李响, 刘明. 基于微服务架构的系统设计及其在企业平台中的应用[J]. 计算机工程与应用, 2019, 55(11): 91-96. 
[13] DCloud官方团队. Uni-App前端跨平台开发核心技术与综合案例[M]. 北京: 清华大学出版社, 2021.
[14] 赵赫, 刘建徽. 基于RBAC模型的系统权限管理设计与实现[J]. 计算机工程与设计, 2010, 31(18): 3986-3989. 
[15] 赵春露, 章宗长. 基于大语言模型的智能教育助手设计与应用[J]. 现代教育技术, 2023, 33(10): 25-33.

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
