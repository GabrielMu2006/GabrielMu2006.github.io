---
title: "Palimpsest"
collection: Repositories
type: "World simulation sandbox"
permalink: /Repositories/palimpsest/
date: 2026-08-29
status: "Active"
link: "https://github.com/GabrielMu2006/Palimpsest"
---

**Palimpsest** 是一款以自主世界演化、个体生命与历史书写为核心的沙盒模拟游戏。

在这里，你不是统治一切的国王，而是一个世界的观察者。文明会自行诞生、扩张、分裂与衰亡；普通人会出生、成长、工作、相爱、争吵、迁徙、参战、衰老与死亡。饥荒可能引发迁徙，迁徙可能制造边境冲突，一次看似微不足道的个人经历，也可能在几十年后成为改变王朝命运的原因。

你可以让时间缓慢流动，观察一个村庄的一天；也可以让数百年飞逝，再从世界档案中追踪一场战争、一座废墟，或一个普通人的完整一生。

但 Palimpsest 模拟的不只是“发生了什么”。

人会遗忘、误解和撒谎；国家会宣传；史官会带着自己的立场写作；书信可能失传，档案可能被焚毁。真实发生过的历史，与人们记住的历史、后世最终相信的历史，可能完全不同。

你可以阅读世界中的史书、书信、法令与残卷，追查一句记载究竟来自目击证言、政治宣传，还是一个被反复转述的传闻。你也可以干预世界——制造旱灾、暴雨、疾病或异象——但你只能改变原因，之后的选择与后果仍由生活在其中的人自己决定。

> **Palimpsest — A world remembers imperfectly.**
> **一个会经历、记住、遗忘，并不断重写自身历史的世界。**

## 设计理念

- **Simulation First / LLM Optional**：LLM 只用于高价值认知增强与可选叙事润色，永远不是模拟真相的来源；关闭本地模型、网络与 API，整个世界仍须正常运行。
- **真实历史与认知分离**：至少保留 Simulation Truth / Knowledge-Belief / Historiography 三层（真实事实 vs 角色认知 vs 官方史书），三者不得混淆。
- **重要结果需要因果来源**：例如人物参战由 Utility Score（保护家庭、忠诚、朋友参军等权重）计算，而不是 `random()`。
- **个体深度优先于人口数字**：智慧个体暂定 ≤ 10,000，不为“十万人世界”制造统计数字，并实施分级模拟（LOD）。
- **世界先存在，故事后产生**：从 Simulation State → Entity Actions → Events → Consequences → History → Narrative，不能随机抽剧情再假装发生过。

**Insight.** 最打动人的不是“要做一个多大的模拟世界”，而是把可观察历史的证据链当成一等公民：真实历史、角色认知、官方史书三层分离，加上因果来源，事后能回答“这段历史到底依据哪些史料”。同时坚持 LLM 默认不参与真相，只做润色——这是把模拟世界的真实性放在叙事之上的关键设计。

## 它想证明什么

MVP 的唯一核心问题不是“我们能实现多少功能”，而是：**一个足够小的世界，在无人控制的情况下运行 200 年以后，会不会形成值得玩家主动研究的历史。** MVP 基准为智慧人口 100～200、聚落 2～5、智慧种族 2～3、Local Map 128×128、生态物种约 5～15、历史长度 ≥200 年，首发中文、macOS。

## 工程与现状

目前仓库完成的是 **Phase 0 架构 Spike**（2026-08-29 完成并由产品负责人确认）：Rust 权威的 headless Simulation Core + Godot 4 macOS 客户端 + GDExtension bridge。核心决策包括稳定持久 `EntityId`、以秒为单位的模拟时间与单调时钟、确定性调度器、结构化事件 / 快照 + SQLite 原型，以及把 `bevy_ecs` 作为暂定 ECS 假设。仓库以 `MASTER_SPEC.md` 为最高规格（无可读 README 与许可证声明），Phase 1 规划与 ADR 已获授权，实现仅限被明确批准的有界任务。

在 Apple M5 / 16GB 参考机上，Phase 0 跑通了 10K dummy 实体基准、结构化事件与 SQLite 写入、快速快照、Rust↔Godot 调用与 128×128 瓦片渲染（稳定 60 FPS，headless 比渲染态快约 2.09×）。

**Repository.** [GabrielMu2006/Palimpsest](https://github.com/GabrielMu2006/Palimpsest)
