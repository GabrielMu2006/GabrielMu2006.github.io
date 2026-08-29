---
title: "新增 Football Simulator UI v2 与 Palimpsest 项目介绍"
collection: Blogs
type: "Project sync"
permalink: /Blogs/project-sync-260829/
date: 2026-08-29
order: 6
status: "Published"
---

今天更新了网站的项目页，新增了两个条目：Football Simulator 和 Palimpsest。

## 这次更新了什么

**Football Simulator（UI v2）**

该仓库最近完成了一次大改版，从实验脚本变成了可打包的桌面应用（v0.2.0）。现在提供 macOS 的 DMG 和 zip 安装包，存档从旧的 state.json 迁移到了 SQLite，界面也重构成一个路由式的数据工作台：球员、球队、比赛、赛事互联互通，可以在主表中筛选、排序、推进赛季、查看战报。介绍页按最新 README 重写，核心是其定位为离线单机的足球联赛模拟器。

**Palimpsest**

该仓库建于 8 月 29 日，是一个 Agent-first 的世界 / 文明 / 历史模拟 Sandbox 的架构探索项目。目前完成的是 Phase 0 架构 Spike：Rust headless Simulation Core + Godot 4 macOS 客户端 + GDExtension bridge，已打通稳定 EntityId、模拟时间、调度器、结构化事件 / SQLite 快照等核心，并跑通了 10K 实体基准。介绍页基于 MASTER_SPEC 与文档编写，说明了其设计原则与 Phase 0 结果。

/Repositories/ 页面已更新，可查看这两个项目的介绍。
