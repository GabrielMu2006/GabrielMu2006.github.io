---
title: "Football Simulator"
collection: Repositories
type: "Simulation game"
permalink: /Repositories/football-simulator/
date: 2026-10-28
status: "Released"
link: "https://github.com/GabrielMu2006/Football-Simulator"
---

Football Simulator 是一款本地运行的足球联赛观察模拟器：推进一个 52 周赛季，追踪 40 支球队、两级联赛、六项杯赛、球员数据与赛季故事。`V0.2.0` 起加入了由 DeepSeek API 生成的报刊中心，把赛季里发生的事写成完整报道。当前发布仅覆盖 macOS Apple Silicon。

## 版本线

- `V0.1.0`（2026-10-23）：绿金足球图标，重构后的联赛观察版，从 V0.1.0 重新编号；仓库里更早的 `v1.0.x` 属于此前的发布序列。
- `V0.2.0`（2026-10-26）：蓝鲸足球图标，新增报刊中心与长文阅读页。
- 两个版本使用不同的名称、图标与应用标识，数据目录分开（`~/Library/Application Support/Football Simulator/` 与 `…/Football Simulator V0.2.0/`）；新版本不会自动改写旧存档，需要继续旧进度时先导出 `.fsarchive` 再导入副本。旧版裸 SQLite / JSON 存档不迁移。
- 应用为本机临时签名，尚未做 Apple Developer ID 公证；Windows 移植与实测继续延期。

## 报刊中心（V0.2.0）

- **周报**手动选择已完成周次生成；**阶段报**在两级联赛半程、Reign Cup 小组赛、Apex Cup 瑞士轮、Ascendance Cup 组外循环与突围赛结束后自动生成。
- **赛事总报、转会窗报、选秀报、Top20 专题**在相应结算或决定完成后进入后台队列，不阻塞推进；赛事、转会、选秀与年度 Top20 页面都提供对应报道入口，筛选、返回与 F5 保留上下文。
- 每个存档单独启用，**不补过去的报道**；此前历史事实仍可作为新文章的背景。
- 成功文章只生成一次，阅读、刷新、重开都不会再次调用 API；正常关闭会保存当前请求并暂停，重开后复用已完成部分。失败时允许手动重试缺失部分，未知请求结果不会自动重新付费。Top20 按概览与 20 位球员点评分段生成后本地合成。
- 报道基于游戏冻结的事实撰写，媒体评论由模型生成；比分、榜单与正式荣誉仍以游戏记录为准。
- API 密钥用使用者自己的 DeepSeek 密钥，可选仅本次使用或存入 macOS 钥匙串；费用由密钥所属账户承担，本项目不是 DeepSeek 官方应用。源码、Release 与安装包不含任何密钥、存档或个人配置。

## 游戏内容

- 40 支球队、两级联赛各 20 队、38 轮主客场循环。
- 六项杯赛：Reign Cup、Destiny Cup、Apex Cup、Resurgence Cup、Ascendance Cup、Aeon Cup，含分组、瑞士轮、双败、突围与两回合淘汰；S1 无杯，S2 开放五杯，S3 起六杯全开，所有冠军都在冬窗后产生。
- 八座赛事奖杯、40 队队徽与双语球场；中立比赛不获得主场加成。
- 真实球员目录、历届冠军、历史数据、跨赛季荣誉分总榜、奖杯数与年度 Top20。
- 不同位置、每方最多三人的球员交换，总身价差上限 20，交换后位置人数不超限，同一球员同窗仅转会一次。
- 自动处理、关键事项暂停、全部手动三种观察模式；另有转会审核、选秀、升降级与升级附加赛。

## 工程与验证

- 唯一现行入口是 `ui_v2_main.py`，窗口为 `football_simulator.ui.main_window.MainWindow`；旧 `football_simulator/ui_v2/` 已退役归档。源码运行用 venv，并以 `FS_DATA_ROOT` 指定独立数据目录。
- 测试通过 Docker 跑 core 与 ui 两套；容器只挂载白名单源码快照，不挂载用户存档、正式应用、主目录或 Docker socket。Linux 离屏 Qt 测试不作为 macOS Cocoa 验收。
- 构建输出使用独立临时目录，验证候选后才晋升正式包；源码与发布清单需经过密钥检查，应用 ZIP 通过 GitHub Release 分发，不提交到 Git。

## 设计原则与洞察

**本地优先。** 单机离线运行，存档全程在本机（支持备份 / 导出 / 导入），数据由自己掌控。

**事实冻结，评论交给模型。** 报刊中心只让模型写评论，比分、榜单和荣誉仍以游戏记录为准；已成功生成的文章不会重复付费，未知结果也不自动重试。

**Insight.** 这次重构最值得看的是「把版本线重开」而不是硬改旧版：观察模拟版从 V0.1.0 重新编号，新旧两个应用用不同身份并存，靠 `.fsarchive` 显式迁移而不是自动改写用户存档。再加上报刊中心对成本与事实的双重约束——成功只生成一次、失败手动重试、评论可生成但结论以游戏为准——它更像一个被认真维护的长期项目，而不是一次功能堆叠。

**Repository.** [GabrielMu2006/Football-Simulator](https://github.com/GabrielMu2006/Football-Simulator)
