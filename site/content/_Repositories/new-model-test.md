---
title: "New Model Test"
collection: Repositories
type: "Model evaluation archive"
permalink: /Repositories/new-model-test/
date: 2026-09-10
status: "Active"
link: "https://github.com/GabrielMu2006/New_Model_Test"
---

New Model Test 是一个公开记录新模型评测过程的档案仓库：每个阶段保存原始 prompt、模型交付物、运行与测试方法、视觉证据和复盘报告，并把它们整理成 VibeTest 展示站 [vibetest.gabrielmu2006.cn](https://vibetest.gabrielmu2006.cn/)。目前档案里有三个模型在同一套 Phase 1 的 15 道题上的成果，以及 Phase 2 已测部分的运行。

## 公开展示站 VibeTest

- 规模：3 个模型 / 2 个阶段 / 20 个已归档任务（计划 45）/ 55 条运行 / 100 条评价 / 3 份阶段评估，共 174 个静态页面与 55 项成果预览，累计运行时长 7 小时 51 分。
- 界面按 Digital Museum / 编辑出版物风格重建：暖色纸质底、衬线标题、1px 分隔线，作品优先、不做排行榜；精选作品使用同样的宽度与预览比例，不标注「最佳模型」。
- 交互：`⌘K` 或 `/` 唤出命令面板全站搜索，任务类型 / 模型 / 阶段 Chip 筛选，同题运行并排对比（选择写入 URL，可分享与刷新恢复），成果 iframe 预览与深链；缺失值一律显示「未记录」，不推断、不补零。
- 模型页按「艺术家档案」组织，阶段页按「展览季」组织，页脚固定写明「忠实引用归档来源，不生成综合排名」。

## 第一阶段（15 题 × 3 模型）

- **DeepSeek-V4.1-Flash（0910 实验版，DSH harness）**：15/15，`93.6/100` 引自历史 AI 报告；task-11 的 21 项几何测试与 52 项浏览器检查、task-12 的 198 项引擎检查与 69 项浏览器检查、task-13 的 112 项逻辑断言、task-14 的 49 项金融断言与 73 项交互断言及 9 页审计、task-15 的 3,861 项引擎断言与 244 项浏览器检查均通过。
- **Muse Spark 1.3（opencode 1.18.29）**：15/15 交付，`84.9/100` 来自维护 agent 的非盲评 v1（每题 73–92 分）；task-12 与 task-15 的「未通过」经复核属于交付方式问题——交付物用 ES module，`file://` 打开被浏览器按 CORS 拦截，经 HTTP 服务后功能正常。
- **GPT-5.6 Sol（Codex CLI 0.147.0）**：15/15 交付，`82.9/100` 来自维护 agent 的非盲评 v3；独立评价尚未产出。
- 三份评分来自不同评委与不同口径，**不可直接比较**；Harness、预算与隔离等级也不同。

## 第二阶段（Task 16–45，已测 16–20）

- **DeepSeek-V4.1-Flash**：Task 16–20 共 5/30，`91.0/100` 来自 Muse Spark 1.3 的 AI 评价。
- **Muse Spark 1.3（xhigh，opencode 1.18.30）**：同题 5/30，`88.2/100` 来自维护 agent 的非盲评 v2，并附可复现取证脚本与截图。
- 其余 25 题尚未测试；本阶段每题目前只挂 1 份 AI 评价，人工评价待产出。

## 工程与验证

- 成果按 `Test_Results/<模型>/phase-NN/` 归档，题目在 `PROMPT/`，展示站在 `website/`（Astro + TypeScript），维护、测试与发布规范在 `docs/`、`AGENTS.md` 与 `test-workspace/`。
- 生产索引由导入器从归档来源确定性生成到 `website/data/catalog.json`，实体为 Phase / Task / Model / Run / Artifact / Review；未知值记为 `null`，不用 0 补齐，批次费用不拆成单题费用。
- 模型身份按组织者决定处理：0910 实验版与随后发布的正式版 `DeepSeek-V4.1-Flash` 视为同一模型、成绩同表，但每条运行单独标注 harness 报告的 model id 快照，跨快照比较必须标明差异。
- 发布前为上一可用版本打不可变回退标签（`website-rollback-<日期>-<短SHA>`），站点经 GitHub Actions 部署 `website/dist`。
- 已知限制：第一阶段 DeepSeek 归档未记录 model id，页面显示「未记录」；Muse Spark 的逐字 `prompt.txt` 为事后补录；隔离等级为 `workspace-only`，污染状态 `clean` 是组织者判定且原始日志未封存，不能读作「无污染」。

## 设计原则

**来源优先。** 每条运行指标、Prompt 和评价都保留文件与行定位，并绑定各自的归档提交。

**评价分离。** 人工评价、各版 AI 评价与展示站自身的验证分别记录、并列展示，不静默合并；同一运行可以挂多份不同评委的评价。

**缺失即缺失。** 未知配置显示「未记录」，不推断单题费用或模型能力。

**同题才比较。** 只有同一任务版本的运行才能进入对比，跨模型比较必须注明 harness、预算与隔离差异；展示站不生成综合排名。

**Insight.** 这次重建最有意思的取舍是「用美术馆的方式做评测」：三个模型的作品用同样的尺寸并排陈列，不标记最佳，分数只作为带出处和评委信息的引用出现，进度条上还写着 20/45 和分母来源。把评测做成档案展而不是排行榜，等于承认排名本身是一种口径选择——这种克制比多一列总分更难得。

**Showcase.** [vibetest.gabrielmu2006.cn](https://vibetest.gabrielmu2006.cn/)

**Repository.** [GabrielMu2006/New_Model_Test](https://github.com/GabrielMu2006/New_Model_Test)
