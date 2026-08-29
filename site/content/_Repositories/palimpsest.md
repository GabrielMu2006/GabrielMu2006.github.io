---
title: "Palimpsest"
collection: Repositories
type: "World simulation sandbox"
permalink: /Repositories/palimpsest/
date: 2026-08-29
status: "Active"
link: "https://github.com/GabrielMu2006/Palimpsest"
---

Palimpsest 是一个“Agent-first”的世界 / 文明 / 个体历史模拟 Sandbox 项目（临时工程代号），核心构想来自仓库里只读权威的 `MASTER_SPEC.md`。它的玩法定义不是“基地建设”或“直接控制角色”，而是一种更底层的体验：

> 创建一个世界，让这个世界真实、自主地生活，然后以观察者的身份去观察、研究、追踪和干预它的历史。

没有胜利条件、失败条件或主线任务，乐趣来自 **创造 → 观察 → 发现 → 追踪 → 理解 → 干预 → 继续观察** 的循环。首发 macOS，MVP 语言为中文。目前仓库完成的是 Phase 0 架构验证，完整游戏与 Phase 1 玩法仍按规划推进。

## 产品构想

玩家要面对的是一个会自己运转的世界：从创世时代开始演化，可任意控制时间速度，看文明、聚落、生物自主活动；既能看世界级重大事件，也能追踪一个普通角色的一生——家庭、记忆、信仰、关系、知识、经历；还能切入角色的“认知视角”，读史官、书信、法令等世界内部文献，研究一段历史到底依据哪些史料；也可以回到过去查看历史世界状态，或通过“上帝事件”影响世界。后续甚至可以用自然语言修改世界规则。

最终世界愿景覆盖世界地理、生态、天气、资源、人口、家庭、遗传与种族适应、身体与疾病、技能与职业、经济、生产链、建筑、聚落、组织、政治、战争、犯罪、司法、科技、文化、语言谱系、宗教、魔法规律、知识传播、记忆、史学、文献、历史考据与世界规则。

## 它想证明什么

MVP 的唯一核心问题不是“我们能实现多少功能”，而是：**一个足够小的世界，在无人控制的情况下运行 200 年以后，会不会形成值得玩家主动研究的历史。** MVP 基准为智慧人口 100～200、聚落 2～5、智慧种族 2～3、Local Map 128×128、生态物种约 5～15、历史长度 ≥200 年，首发中文、macOS。

## 设计原则

MASTER_SPEC 列出的六条“不可破坏”的产品原则：

- **Simulation First / LLM Optional**：LLM 只用于高价值认知增强与可选叙事润色，永远不是模拟真相的来源；关闭本地模型、网络与 API，整个世界仍须正常运行。
- **世界先存在，故事后产生**：不能随机生成故事文本再假装发生过，必须走 Simulation State → Entity Actions → Events → Consequences → History → Narrative 的证据链。
- **真实历史与认知分离**：至少保留 Simulation Truth / Knowledge-Belief / Historiography 三层（真实事实 vs 角色认知 vs 官方史书），三者不得混淆。
- **重要结果需要因果来源**：人物参战由 Utility Score 决定，而不是 `random()`。
- **个体深度优先于人口数字**：智慧个体暂定 ≤ 10,000，不为“十万人世界”制造统计数字。
- **模拟深度依赖 LOD**：不允许 1 万 NPC 全部每帧执行完整 AI。

**Insight.** 最打动人的不是“要做一个多大的模拟世界”，而是把可观察历史的证据链当成一等公民：真实历史、角色认知、官方史书三层分离，加上因果来源，事后能回答“这段历史到底依据哪些史料”。同时坚持 LLM 默认不参与真相，只做润色——这是把模拟世界的真实性放在叙事之上的关键设计。

## 工程与现状

目前仓库完成的是 **Phase 0 架构 Spike**（2026-08-29 完成并由产品负责人确认）：Rust 权威的 headless Simulation Core + Godot 4 macOS 客户端 + GDExtension bridge。核心决策包括稳定持久 `EntityId`、以秒为单位的模拟时间与单调时钟、确定性调度器、结构化事件 / 快照 + SQLite 原型，以及把 `bevy_ecs` 作为暂定 ECS 假设。仓库以 `MASTER_SPEC.md` 为最高规格（无可读 README 与许可证声明），Phase 1 规划与 ADR 已获授权，实现仅限被明确批准的有界任务。

在 Apple M5 / 16GB 参考机上，Phase 0 跑通了 10K dummy 实体基准、结构化事件与 SQLite 写入、快速快照、Rust↔Godot 调用与 128×128 瓦片渲染（稳定 60 FPS，headless 比渲染态快约 2.09×）。

**Repository.** [GabrielMu2006/Palimpsest](https://github.com/GabrielMu2006/Palimpsest)
