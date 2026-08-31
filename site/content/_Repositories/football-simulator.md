---
title: "Football Simulator"
collection: Repositories
type: "Simulation game"
permalink: /Repositories/football-simulator/
date: 2026-08-31
status: "Released"
link: "https://github.com/GabrielMu2006/Football-Simulator"
---

Football Simulator（UI v2）是一款本地单机的足球联赛模拟游戏：创建存档、初始化球队与球员，按周推进赛季，在路由式数据工作台中查看联赛、杯赛、转会、选秀、荣誉和球员历史。当前版本 `v1.0.0`（首个正式版），面向喜欢离线、数据驱动、自建模拟联赛的玩家。

## 当前版本

- 当前版本 `v1.0.0`（首个正式版），已发布 macOS DMG 与 Windows 便携 zip（大型二进制通过 GitHub Releases 提供，不进入 git）；Python 编写，UI 为 PySide6/Qt；GitHub 未标注开源许可证。
- 40 支虚拟球队：每个新存档随机排序，前 20 支进入一级联赛、后 20 支进入次级联赛；40 支球队使用 `team_badges_40_v2/PNG` 队徽（V2：无外框、核心图案更大）。
- 250 名真实球员池（200 基础 + 50 新增高声誉球员，见 `real_player_additions_50.md`）：每个新存档随机排序，前 50 名为初始真实球员，其余依次进入后续选秀池。
- 每队基础阵容 1 门将 + 4 后卫 + 3 中场 + 3 前锋。
- 一级联赛完整比赛模拟（进球 / 助攻 / 创造机会 / 成功防守 / 扑救 / 零封 / 评分 / 身价）；次级联赛完整模拟但权重低于一级。
- 升降级、三杯赛（优胜者杯 / 挑战杯 / 超级杯）、转会（球员换球员）、选秀、赛季荣誉与历史归档。
- 存档管理：新建 / 选择 / 删除（回收站）/ 备份 / 导出 / 导入；存档为 SQLite 数据库。
- 首次启动自动弹出游戏教程，之后可从顶栏「教程」按钮随时打开。
- 路由式数据工作台：侧栏为首页 / 赛季 / 比赛 / 赛事 / 球队 / 球员 / 转会 / 选秀 / 历史 / 存档（大图标 + 大文字）；顶栏为实心后退 / 前进箭头、面包屑、全局搜索、存档切换、赛季与周次、处理待办、模拟下一周 / 推进（到下一待办 / 到赛季末）、本周战报、刷新、教程。球员 / 球队 / 比赛 / 赛事全站互联，列表页为全高主表，支持筛选与列排序。
- 快捷键：Cmd/Ctrl+K 全局搜索；Cmd/Ctrl+Enter 模拟下一周；Cmd/Ctrl+Shift+Enter 模拟到下一待办；Cmd/Ctrl+Alt+Enter 模拟到赛季末；Cmd/Ctrl+Shift+W 本周战报；Cmd/Ctrl+R 刷新。

## 平台与存档

- macOS：DMG 上手即用；Windows：便携 zip 解压运行，但需在 Windows 本机构建（PyInstaller 不支持跨平台交叉编译）。
- 源码运行存档在项目 `saves/`；macOS 打包应用在 `~/Library/Application Support/Football Simulator/saves`；Windows 打包应用在 `%APPDATA%\Football Simulator\saves`。旧版 `state.json` 存档不兼容。

## 设计原则与洞察

**本地优先。** 单机离线运行，存档全程在本机（支持备份 / 导出 / 导入），数据由自己掌控。

**逻辑与界面分层。** 游戏逻辑、SQLite 持久化、查询层与 UI 分离，`ui_v2_main.py` 是唯一入口，逻辑层可在无 UI 环境下运行；三赛季基线指纹用于约束玩法变化。

**Insight.** v1.0.0 标志着它从“能玩的模拟器”走向“能分发的正式版”：新增 Windows 便携版与 macOS DMG、把真实球员池从 200 扩到 250、加入首次启动教程与顶栏「教程」入口、用 V2 队徽与更大的实心导航箭头统一视觉，并把存档升级为支持回收站、备份、导出、导入的完整管理。它已经是一个带教程、跨平台、可长期离线使用的完整桌面足球经理。

**Repository.** [GabrielMu2006/Football-Simulator](https://github.com/GabrielMu2006/Football-Simulator)
