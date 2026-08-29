---
title: "Football Simulator"
collection: Repositories
type: "Simulation game"
permalink: /Repositories/football-simulator/
date: 2026-08-29
status: "Released"
link: "https://github.com/GabrielMu2006/Football-Simulator"
---

Football Simulator（UI v2）是一款本地运行的足球联赛模拟游戏：玩家创建存档、初始化球队与球员，按周推进赛季，在路由式数据工作台里查看联赛、杯赛、交易、选秀、荣誉和球员历史。它面向喜欢离线、数据驱动、自建模拟联赛的玩家。

## 当前版本

- 当前版本 `v0.2.0`（Football Simulator UI v2），已发布 macOS DMG 与便携 zip（另有 Windows 构建 v0.1.0-windows）；源码用 Python 编写，UI 为 PySide6/Qt，GitHub 未标注开源许可证。
- 40 支虚拟球队：每个新存档随机排序，前 20 支进入一级联赛、后 20 支进入次级联赛。
- 200 名真实球员池：每个新存档随机排序，前 50 名作为初始真实球员，其余依次进入后续选秀池。
- 每队基础阵容 1 门将 / 4 后卫 / 3 中场 / 3 前锋。
- 一级联赛完整比赛模拟，统计进球、助攻、创造机会、成功防守、扑救、零封、评分和身价；次级联赛采用独立简化模拟。
- 升降级、杯赛（优胜者杯 / 挑战杯 / 超级杯）、转会系统、选秀系统、历史与荣誉。
- 存档管理支持新建、选择、删除；存档为 SQLite 数据库（旧版 `state.json` 存档不兼容）。
- 路由式数据工作台：侧栏含首页 / 赛季 / 比赛 / 赛事 / 球队 / 球员 / 转会 / 选秀 / 历史 / 存档；顶部提供后退、前进、面包屑、全局搜索（Cmd/Ctrl+K）、存档选择、推进下一周、本周战报与刷新。球员、球队、比赛、赛事互联互通，列表页为全高主表，支持筛选与列排序。
- 附带应用图标（`assets/app.icns`，脚本生成）与按队名确定性生成的虚拟队徽，后续可通过 `set_custom_crest_provider()` 替换为自定义图片。

## 设计原则与洞察

**本地优先。** 存档保存在本机（源码运行在项目 `saves/`，打包应用在 `~/Library/Application Support/Football Simulator/saves`），单机离线即可游玩。

**逻辑与界面分层。** 游戏逻辑、SQLite 持久化、查询层与 UI 分离，`ui_v2_main.py` 是唯一入口，逻辑层可在无 UI 环境下运行。

**Insight.** v2 最大的变化不是加了更多玩法，而是把整个游戏重构成一个“可检索的数据工作台”：球员、球队、比赛、赛事全部互联，玩家主要在主表里筛选、排序、推进、读战报。配合从 `state.json` 迁移到 SQLite、加入确定性队徽与应用图标、以及 DMG/zip 打包，它已经从实验脚本变成了可分发、可维护的桌面应用。

**Repository.** [GabrielMu2006/Football-Simulator](https://github.com/GabrielMu2006/Football-Simulator)
