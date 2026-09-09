---
title: "New Model Test"
collection: Repositories
type: "Model evaluation archive"
permalink: /Repositories/new-model-test/
date: 2026-09-09
status: "Active"
link: "https://github.com/GabrielMu2006/New_Model_Test"
---

New Model Test 是一个公开记录新模型评测过程的档案仓库：每个阶段保存原始 prompt、模型交付物、运行与测试方法、视觉证据和复盘报告，并把它们整理成可浏览的公开站点 [vibetest.gabrielmu2006.cn](https://vibetest.gabrielmu2006.cn/)。第一阶段（Phase 1）是同一套 15 道题上的两个模型——`DeepSeek-V4.1-Flash-Exp-0910`（DSH harness）与 `Muse Spark 1.3`（opencode 1.18.29 harness）。

## 公开展示站

- 目前收录 2 个模型 / 1 个阶段 / 15 个任务 / 30 条运行 / 60 条评价，共 110 个静态页面与 30 项成果预览，中英文双语。
- 支持按标题或原始 Prompt 搜索、按类别筛选、同题运行并排对比（选择写入 URL，可分享与刷新恢复）、成果 iframe 懒加载预览与深链。
- 方法页写明四条边界：来源优先、评价分离、缺失即缺失、同题才比较；跨模型比较必须注明 harness、预算与隔离差异。
- iframe 只授予 `allow-scripts allow-downloads allow-forms`，刻意不开放 `allow-same-origin`、弹窗和顶层导航；嵌入受限时页面提供独立打开入口。

## 第一阶段结果

- **DeepSeek-V4.1-Flash-Exp-0910（DSH harness）**：15 个任务满足原始 prompt 的核心要求，`93.6/100` 与 `15/15` 引自历史 AI 报告。task-11 的 21 项几何测试与 52 项浏览器检查、task-12 的 198 项引擎检查与 69 项浏览器检查、task-13 的 112 项逻辑断言、task-14 的 49 项金融断言与 73 项交互断言及 9 页审计、task-15 的 3,861 项引擎断言与 244 项浏览器检查均通过。
- **Muse Spark 1.3（opencode 1.18.29 harness）**：15 个任务全部交付，评分来自维护 agent 的非盲评 v1（每题 73–92 分、平均 `84.9/100`）。该口径与 DeepSeek 的 93.6/100 评委与口径都不同，**不可直接比较**，独立盲评仍待补。
- task-12 与 task-15 的“未通过”经复核属于交付方式问题：交付物使用 ES module，`file://` 打开时被浏览器按 CORS 拦截，经 HTTP 提供服务后功能正常，不是功能逻辑缺陷。
- Muse Spark 批次累计 25 分 45 秒、178 次工具调用 / 8 次失败、3,669,385 token 过路量、费用 ¥0；隔离等级 `workspace-only`，污染状态记为 `clean（组织者判定）`，但判定依据的原始日志未随档案封存，因此不能读作“无污染”。

## 工程与验证

- 成果按 `Test_Results/<模型>/phase-NN/` 归档，题目在 `PROMPT/`，展示站在 `website/`（Astro），维护与测试规范在 `docs/` 与 `test-workspace/`。
- 生产索引由导入器从归档来源确定性生成到 `website/data/catalog.json`，实体为 Phase / Task / Model / Run / Artifact / Review；未知值记为 `null`，不用 0 补齐。
- 发布前会为上一可用版本打不可变回退标签（`website-rollback-<日期>-<短SHA>`），站点经 GitHub Actions 部署 `website/dist`。
- 已知限制：Muse Spark 的逐字 `prompt.txt` 为事后补录；task-13 的部分浏览器脚本仍包含原评测机器的 Playwright 缓存路径；对比页目前每个任务只有两条运行（两个模型各一条）。

## 后续阶段

Phase 2 的 30 条高级纯创造题（Task 16–45）已起草，强调从空目录起步的复杂系统创作。目前尚未执行任何模型运行，因此不计入阶段表，也不进入展示站的生产索引。

## 设计原则

**来源优先。** 每条运行指标、Prompt 和评价都保留文件与行定位，并绑定各自的归档提交。

**评价分离。** 人工评价、各版 AI 评价与展示站自身的验证分别记录、并列展示，不静默合并；task-06 与 task-07 的人工观感与 AI 评分差异被原样保留。

**缺失即缺失。** 未知配置显示“未记录”，不推断单题费用或模型能力；批次费用只保留批次口径。

**同题才比较。** 只有同一任务版本的运行才能进入对比，跨模型比较必须注明 harness、预算与隔离差异；展示站不生成综合排名。

**Insight.** 这个仓库的价值不在“15 道题都跑完了”，而在把评测做成了可审计的档案：两个模型、同一套题，各自的运行证据与独立评价并列摆开，同时把口径差异、缺失值、事后补录的 prompt 和未封存的隔离证据一并写明。当一个评测项目愿意公开自己的不确定性和分歧时，那些通过的分数才真正有分量。

**Showcase.** [vibetest.gabrielmu2006.cn](https://vibetest.gabrielmu2006.cn/)

**Repository.** [GabrielMu2006/New_Model_Test](https://github.com/GabrielMu2006/New_Model_Test)
