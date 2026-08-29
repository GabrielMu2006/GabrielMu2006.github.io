---
title: "Palimpsest"
collection: Repositories
type: "World simulation sandbox"
permalink: /Repositories/palimpsest/
date: 2026-08-29
status: "Active"
link: "https://github.com/GabrielMu2006/Palimpsest"
---

Palimpsest 是一个“Agent-first”的世界 / 文明 / 个体历史模拟 Sandbox 的架构探索项目（临时工程代号）。它的核心构想是“创建一个世界，让世界真实、自主地生活，然后以观察者身份去研究、追踪和干预它的历史”，首发 macOS，目标玩家是喜欢深度模拟、愿意研究一个世界的观察者型用户。当前仓库完成的是 Phase 0 架构验证；完整游戏与 Phase 1 玩法仍按规划推进。

## 当前状态

- 使用 Rust + Godot 4；仓库以根目录 `MASTER_SPEC.md`（只读权威）为最高规格，GitHub 未检测到开源许可证声明，没有 README（以 `MASTER_SPEC.md` 与 `docs/` 为权威说明）。
- Phase 0（架构 Spike）已于 2026-08-29 完成并由产品负责人确认，产物为 `docs/reports/ARCHITECTURE_SPIKE_V1.md`；主体是权威的 Rust headless Simulation Core + Godot 4 macOS 客户端 + GDExtension bridge。
- 关键架构决策：稳定持久 `EntityId`（单调、不复用）；以秒为单位的 `SimInstant` 模拟时间 + 单调 `SimClock`；确定性 due-time 优先队列调度器；结构化事件 / 快照原型 + SQLite 事件存储；`bevy_ecs` 作为暂定 ECS 假设。
- Phase 1 规划、任务规范与 ADR 已获授权；Phase 1 实现仅限被明确批准的有界任务（World Grid、Terrain、Local Tile、Person Entity、Basic Movement、Time、Needs、Basic Utility AI 以及 100-NPC / 10 年验证），明确不做战争、政治、宗教、魔法、史官、NLG、LLM、规则编辑器或 Web 端。

## 设计原则（来自 MASTER_SPEC）

**Simulation First / LLM Optional.** LLM 只用于高价值认知增强与可选叙事润色，永远不是模拟真相的来源；关闭本地模型、网络与 API，整个世界仍必须正常运行。

**世界先存在，故事后产生。** 不能随机生成故事文本再假装发生过；必须遵循 Simulation State → Entity Actions → Events → Consequences → History → Narrative 的证据链。

**真实历史与认知分离。** 至少保留 Simulation Truth / Knowledge-Belief / Historiography 三层（真实事实 vs 角色认知 vs 官方史书），三者不得混淆。

**重要结果需要因果来源。** 例如人物参战由 Utility Score（保护家庭、忠诚、朋友参军等权重）计算，而不是 `random()`。

**个体深度优先于人口数字。** 智慧个体暂定 ≤ 10,000；不为“十万人世界”制造统计数字，并对模拟实施分级 LOD。

## Phase 0 基准

在 Apple M5 / 16GB 参考机上：10K dummy 实体约 241 字节/实体（RSS 增量 2.30 MiB）；约 1.270B 次组件更新/s；结构化事件生成 36.409M/s、JSON 序列化 6.239M/s；SQLite 批处理写入 835,593 events/s；快速快照 46,702 字节；Rust↔Godot 标量调用约 354.67 ns/次；128×128 瓦片渲染稳定 60 FPS；headless 比渲染态快约 2.09×。

**Insight.** 最值得注意的不是“要做一个多大的模拟世界”，而是把可观察历史的证据链当成一等公民：Simulation Truth、角色认知、史书三层分离，加上因果来源（Utility Score）与结构化事件 / SQLite，让事后能回答“这段历史到底依据哪些史料”。同时坚持 LLM 默认不参与真相，把生成式文本严格限制为润色，避免了模型污染模拟历史的常见陷阱。

**Repository.** [GabrielMu2006/Palimpsest](https://github.com/GabrielMu2006/Palimpsest)
