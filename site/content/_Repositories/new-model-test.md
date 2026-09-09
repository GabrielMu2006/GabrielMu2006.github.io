---
title: "New Model Test"
collection: Repositories
type: "Model evaluation archive"
permalink: /Repositories/new-model-test/
date: 2026-09-09
status: "Active"
link: "https://github.com/GabrielMu2006/New_Model_Test"
---

New Model Test 是一个公开记录新模型评测过程的档案仓库：每个阶段保存原始 prompt、模型交付物、运行与测试方法、视觉证据和复盘报告。仓库内还包含一个 Astro 展示站，把这些归档整理成可浏览的公开站点 [vibetest.gabrielmu2006.cn](https://vibetest.gabrielmu2006.cn/)。当前为 Phase 1，用 15 个任务评估 `DeepSeek-V4.1-Flash-Exp-0910`。

## 公开展示站

- 地址 <https://vibetest.gabrielmu2006.cn/>，中文 / 英文双语，共 78 个静态页面与 17 个 HTML 成果入口。
- 分区为概览、阶段、模型、任务、对比、方法；任务页可按标题或原始 Prompt 搜索，并按类别（网站 / SVG 插画 / SVG 时钟 / 游戏 / 创作工具 / 效率工具 / 实用工具 / 数据仪表盘）筛选。
- 任务详情展示真实成果预览（iframe 懒加载）、原始 Prompt、运行指标和彼此独立的评价来源；对比页把同一任务版本的两条运行并排展示，选择状态写入 URL，可分享与刷新恢复。
- iframe 只授予 `allow-scripts allow-downloads allow-forms`，刻意不开放 `allow-same-origin`、弹窗和顶层导航；嵌入受限时页面提供独立打开入口。
- 根路径跳转中文首页，语言切换保留当前实体与查询参数；无效实体显示归档内 404 状态，未知物理路径使用静态 404 页面。

## 阶段与结果

- Phase 1 已完成：15 个任务均满足原始 prompt 的核心要求；`93.6/100` 与 `15/15` 是引用历史 AI 报告的结论，不是展示站重新计算或独立证明的数字。
- task-11：21 项几何测试与 52 项浏览器检查通过；task-12：198 项引擎检查与 69 项浏览器检查通过。
- task-13：112 项逻辑断言通过，应用通过 4 个视口 × 2 个主题的渲染检查，但统一验证命令仍有服务编排问题。
- task-14：49 项金融断言、73 项交互断言，以及全部 9 个页面的桌面 / 移动审计通过。
- task-15：3,861 项引擎断言与 244 项浏览器检查通过。
- 批次口径指标：12 个会话、8,282 秒、693 次 API 调用、735 次工具调用、42 次失败或重试；输入 334,670 tokens、输出 1,072,534 tokens、缓存读取 63,042,176 tokens，批次费用 ¥9.30。

## 工程与验证

- `website/` 是 Astro 静态展示站，`docs/` 保存数据模型、验证记录、部署、来源审计与新增结果说明，`website-check.yml` 只跑数据校验、类型检查、逻辑测试和静态构建（不运行归档模型产物中的脚本），`website-deploy.yml` 在 `main` 相关路径变化或手动触发时部署 `website/dist`。
- 生产索引由 `website/scripts/import-data.mjs` 从归档来源确定性生成到 `website/data/catalog.json`，稳定实体为 Phase / Task / Model / Run / Artifact / Review；Artifact 使用显式文件清单、入口和预览权限，构建不会递归发布整个任务目录。
- 2026-09-09 的验证记录（Node 24.19.0、Astro 7.3.2、Playwright 1.63.0）全部通过：`validate:data`（15 tasks、15 runs、30 reviews）、`check`（0 errors）、`test`、`build`（78 页 / 17 个成果）、`test:e2e`（Chromium / Firefox / WebKit：搜索、英文详情直达、对比深链恢复、懒加载预览、390 / 768 / 1440 横向溢出、15/15 成果入口加载）以及成果专项交互检查；198 个实施前文件的 SHA-256 逐一核对，内容未变。
- 展示站经 Actions 部署到独立子域名 `vibetest.gabrielmu2006.cn`（CNAME 指向 `gabrielmu2006.github.io`，证书 approved 并强制 HTTPS），旧项目路径 `gabrielmu2006.cn/New_Model_Test/` 301 跳转到新域名。
- 已知限制：task-13 的部分浏览器验证脚本仍包含原评测机器上的 Playwright 缓存路径；天气成果依赖 Open-Meteo，网络不可用时使用其自身缓存 / 离线模型；对比页目前每个任务只有一条真实运行记录，尚无第二条可比较。

## 设计原则

**来源优先。** 每条运行指标、Prompt 和评价都保留文件与行定位，源码链接固定到归档提交，不声称所有文件等同于生成瞬间的版本。

**评价分离。** 人工评价、历史 AI 报告与展示站自身的验证分别记录、并列展示，不静默合并；task-06 与 task-07 的人工观感与 AI 评分差异被原样保留。

**缺失即缺失。** 未知值记为 `null` 并显示"未记录"，不用 0 代替；token 输入、输出、缓存读取分列，¥9.30 只保留批次口径，不拆分为单题费用。

**同题才比较。** 只有同一任务版本的运行才能进入对比，且仅在口径一致时显示差值；展示站不生成综合排名。

**Insight.** 这次更新把仓库从"归档目录"变成了"可审计的公开证据站"：展示站不重新计算分数，而是把 93.6/100、15/15 明确标注为引用历史报告的结论，同时把人工与 AI 的分歧、缺失值和批次与单题的口径差别一起摆出来。对一个模型评测项目来说，这种把"不可知"和"有分歧"也一并公开的做法，比多一个漂亮的展示页更能建立可信度。

**Showcase.** [vibetest.gabrielmu2006.cn](https://vibetest.gabrielmu2006.cn/)

**Repository.** [GabrielMu2006/New_Model_Test](https://github.com/GabrielMu2006/New_Model_Test)
