# New Model Test · 新模型测试

> A growing, evidence-oriented benchmark archive for evaluating new AI models through visual generation, interactive applications, implementation quality, and reproducible testing.  
> 一个持续扩展、重视证据的模型评测档案，通过视觉生成、交互应用、工程实现与可复现测试来观察新模型的能力。

[中文](#中文说明) · [English](#english)

**公开展示站 / Public showcase:** https://vibetest.gabrielmu2006.cn/

浏览双语任务、真实成果预览、运行指标、独立评价来源与同题对比。Browse bilingual tasks, live artifacts, run metrics, independent reviews, and same-task comparisons.

## 中文说明

### 项目简介

本仓库用于公开记录和展示新模型测试。每个阶段保存当期使用的原始 prompt、模型交付物、运行或测试方法、视觉证据以及复盘报告。目标不是只展示“最好看的结果”，而是尽量保留从任务输入到成果、验证和问题分析的完整链路。

当前内容包括 **第一阶段（Phase 1）**：两个模型在 15 个任务上的成果、运行证据与独立评价——`DeepSeek-V4.1-Flash`（0910 实验版，DSH harness）与 `Muse Spark 1.3`（opencode harness）；**GPT-5.6 Sol**（Codex CLI 0.147.0）在同样 15 题上的成果与独立评价；以及 **第二阶段（Phase 2）的部分运行**：`DeepSeek-V4.1-Flash` 与 `Muse Spark 1.3` 各自的 Task 16–20（第二阶段共 30 题，其余 25 题尚未测试）。评估的能力包括：

- SVG 视觉生成与精确约束遵循；
- 单文件网页、游戏和创作工具；
- 复杂交互式 Web 应用；
- 几何、计算、数据状态与错误处理；
- 响应式设计、可访问性、视觉完成度和自动化测试。

公开展示站 [vibetest.gabrielmu2006.cn](https://vibetest.gabrielmu2006.cn/) 目前收录 3 个模型 / 2 个阶段 / 20 个任务 / 55 条运行 / 100 条评价（第一阶段三模型：Human + 各 AI 评委；第二阶段每题已各挂 1 份 AI 评价）/ 3 份阶段评估，共 174 个静态页面与 55 项成果预览。界面按 [Digital Museum / 编辑出版物风格](website/VibeTest%20Digital%20Museum%20UI%20Design%20Specification.md) 设计（暖色纸质底、衬线标题、1px 分隔线，作品优先、不做排行榜），支持中英文切换、命令面板全站搜索（`⌘K` 或 `/`）、任务类型/模型/阶段 Chip 筛选、同题运行对比（选择写入 URL）、成果预览与深链；缺失值一律显示「未记录」，不推断、不补零。

仓库将保留后续阶段扩展能力。未来可在 Test_Results/ 下增加模型文件夹，并在模型目录中增加阶段文件夹，并继续沿用“任务 → 原始 prompt → 成果 → 测试 → 评估”的归档方式。

### 当前阶段

| 阶段 | 被测模型 | Harness | 任务数 | 核心完成率 | 内部综合评估 | 状态 |
| --- | --- | --- | ---: | ---: | ---: | --- |
| Phase 1 | DeepSeek-V4.1-Flash（0910 实验版） | DSH | 15 | 15/15 | 93.6/100（历史 AI 报告引用） | 已完成 |
| Phase 1 | Muse Spark 1.3 | opencode 1.18.29 | 15 | 15/15 交付（2 题交付方式待改） | 84.9/100（维护 agent 非盲评 v1） | 已完成 |
| Phase 1 | GPT-5.6 Sol | Codex CLI 0.147.0 | 15 | 15/15 交付 | 82.9/100（维护 agent 非盲评 v3） | 已完成 |
| Phase 2 | Muse Spark 1.3（xhigh） | opencode 1.18.30 | 5 / 30（部分） | 5/5 交付 | 88.2/100（维护 agent v2 非盲评 AI 评价） | 部分完成（Task 16–20） |
| Phase 2 | DeepSeek-V4.1-Flash（0910 实验版） | DSH | 5 / 30（部分） | 5/5 交付 | 91.0/100（Muse Spark 1.3 AI 评价） | 部分完成（Task 16–20） |

> 两行的评分来自不同评委与不同口径，**不可直接比较**；Harness、预算与隔离等级也不同。

> 综合分数来自仓库内的阶段性人工与自动化评估，用于总结本次测试，不应被视为跨模型通用排行榜分数。

> **模型身份与快照**（2026-09-10 组织者决定）：0910 实验版与随后发布的正式版 `DeepSeek-V4.1-Flash` 视为**同一个模型**，成绩同表记录。展示站为每个运行单独标注 harness 报告的 model id（即快照）：已归档的 20 条 DeepSeek 运行全部跑在 `deepseek-v4.1-flash-expires-on-0910` 快照上（第一阶段 归档未记录 model id，页面显示「未记录」）；正式版的快照 id 待第一次运行后回填，不据品牌名推断。模型实体 id 与全部既有 URL 保持不变，正式版运行将使用 `run-deepseek-v4-1-flash-task-NN-r1` 形式的 runId；**跨快照比较必须标明差异**。

### 第一阶段任务

| # | 任务 | 类型 | 主要交付物 |
| ---: | --- | --- | --- |
| 01 | Aevum 奢侈腕表落地页 | 单文件网页 | `index.html` |
| 02 | 骑自行车的鹈鹕 | SVG 视觉生成 | `pelican-on-bicycle.svg` |
| 03 | 模拟时钟 6:25 | SVG 精确约束 | `clock-625.svg` |
| 04 | 模拟时钟 11:52:30 | SVG 精确约束 | `clock-11-52-30.svg` |
| 05 | 侧面骑自行车的人 | SVG 姿态约束 | `bicycle_rider.svg` |
| 06 | 手持剪刀剪纸 | SVG 动作表达 | `scissors_cutting_paper.svg` |
| 07 | 推独轮车的人 | SVG 方向与动作约束 | `pushing_wheelbarrow.svg` |
| 08 | 霓虹打砖块 | 单文件游戏 | `index.html` |
| 09 | 山谷农场 | 单文件游戏 | `index.html` |
| 10 | 像素画编辑器 | 单文件创作工具 | `index.html` |
| 11 | 2D 户型图编辑器 | 交互式 Web 应用 | 编辑器、几何引擎与测试 |
| 12 | 计算器 | 交互式 Web 应用 | 计算引擎、UI 与测试 |
| 13 | Skylight 天气仪表盘 | 数据型 Web 应用 | 仪表盘、离线模型与审计工具 |
| 14 | Meridian Bank 银行网站 | 多页网站 | 9 个页面、计算器与审计工具 |
| 15 | Shelf 读书追踪 | 数据型 Web 应用 | 领域引擎、UI 与测试 |

### 后续阶段（Phase 2）

Phase 2 的 30 条高级纯创造题（Task 16–45）已写入 [`PROMPT/PHASE2_30_ADVANCED_CREATION_PROMPTS_BILINGUAL.md`](PROMPT/PHASE2_30_ADVANCED_CREATION_PROMPTS_BILINGUAL.md)，强调从空目录起步的复杂系统创作。**Task 16–20（5 题）已由两个模型完成并接入展示站**：`DeepSeek-V4.1-Flash` 的 0910 实验版（DSH）与 **Muse Spark 1.3 xhigh（opencode 1.18.30）**。Muse 的 5 题产出 1 份/题的 **AI 评价**（维护 agent v2，非盲评，平均 **88.2/100**）；DeepSeek 的 5 题**尚无独立评价**，站点显示「本运行暂无独立评价」；两批**都没有人工评价**，跨模型比较须注明 harness、预算与隔离差异（归档见 [phase-02 运行清单](Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-02/README.md)）；Task 21–45 尚未测试。第二阶段目前**没有人工或 AI 评价**，因此上表只列交付情况、不给分数。

Phase 2 的隔离等级为 `workspace-only`（`AGENTS.md` 两条绝对规则 + 收尾日志审查）：这是**策略级约束**，不是强制隔离，也不表示「无污染」。Task 16–45 的题目已在公开仓库发布（提交 `0540edf`，见 [已知问题](docs/known-issues.md)），成绩须同时标注该暴露。越界判定只影响标注、不影响成绩录入（2026-09-10 组织者决定）：`task-17`、`task-20` 记录了「越界尝试，未取得内容」，**只留在审计档案里**（运行页不作外显标注），不作排除。测试流程与接入步骤见[测试隔离与防答案污染](docs/testing-protocol.md)与[接入操作步骤](docs/adding-results.md)。

### 仓库结构

```text
New_Model_Test/
├── README.md
├── AGENTS.md
├── PROMPT/
│   ├── README.md
│   ├── Phase1_TEST_PROMPTS_BILINGUAL.md
│   └── PHASE2_30_ADVANCED_CREATION_PROMPTS_BILINGUAL.md   # Phase 2 题目（Task 16–45）
├── Test_Results/
│   ├── README.md
│   ├── DeepSeek-V4.1-Flash-Exp-0910_DSH/
│   │   ├── phase-01/
│   │   │   ├── README.md
│   │   │   ├── Reviews/
│   │   │   └── task-01-.../ ... task-15-.../
│   │   └── phase-02/                  # Task 16–20（部分：共 30 题）
│   │       ├── README.md
│   │       ├── Reviews/               # 评价待产出
│   │       └── task-16-.../ ... task-20-.../
│   └── Muse-Spark-1.3_Opencode/
│       ├── phase-01/
│       │   ├── README.md
│       │   ├── Reviews/
│       │   ├── evidence/
│       │   └── task-01-.../ ... task-15-.../
│       └── phase-02/                  # 同题 Task 16–20（部分）
│           ├── README.md
│           ├── Reviews/ai/maintenance-agent-v2/
│           └── task-16-.../ ... task-20-.../
├── test-workspace/            # 后续阶段测试脚手架（隔离规则、启动方案、模板）
├── website/                   # Astro 展示站、导入器与自动化测试
├── docs/                      # 数据模型、测试流程、部署与验证记录
└── .github/workflows/
```

后续结果按 Test_Results/模型/阶段/ 加入；根 README 维护索引。接入步骤见 docs/adding-results.md。

### 关键文档

- [Agent 协作规范](AGENTS.md)
- [结果交接接口](docs/result-interface.md)与[接入操作步骤](docs/adding-results.md)
- [测试隔离与防答案污染](docs/testing-protocol.md)
- [测试工作区启动方案](test-workspace/README.md)：按阶段建任务目录、逐题隔离测试、汇总归档。
- [网站维护、发布及回退](docs/deployment.md)
- [展示站 UI 设计规范（Digital Museum / 编辑出版物）](website/VibeTest%20Digital%20Museum%20UI%20Design%20Specification.md)

- [15 条原始 Prompt、双语理论成果与验收内容](PROMPT/Phase1_TEST_PROMPTS_BILINGUAL.md)
- [30 条 Phase 2 高级创造题（Task 16–45）](PROMPT/PHASE2_30_ADVANCED_CREATION_PROMPTS_BILINGUAL.md)
- [Phase 2 归档与运行清单（已测 Task 16–20）](Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-02/README.md)
- [GPT-5.6 Sol 第一阶段索引](Test_Results/GPT-5.6-Sol_Codex/phase-01/README.md)
- [成果归档索引](Test_Results/README.md)
- [第一阶段项目索引与运行说明](Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/README.md)
- [Muse Spark 1.3 第一阶段索引](Test_Results/Muse-Spark-1.3_Opencode/phase-01/README.md)
- [15 项任务完成质量评估](Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/Reviews/15-任务完成质量评估.md)
- [任务执行统计与评测复盘](Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/Reviews/DeepSeek-V4.1-Flash-Exp-0910-任务评测复盘.md)
- [人工评价汇总](Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/Reviews/Personal_Review.md)

### 查看与运行

任务 01–10 的主要成果可以直接打开，无需安装依赖：

```bash
open Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/task-01-aevum-luxury-watch-landing-page/index.html
open Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/task-03-analog-clock-6-25/clock-625.svg
open Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/task-08-breakout-game/index.html
```

任务 11–15 带有项目内测试。多数项目无需 `npm install`，Node.js 主要用于执行测试：

```bash
cd Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/task-12-calculator
npm test

cd ../task-15-book-tracker
npm test
```

完整命令和已知限制请阅读各任务的 `README.md`。特别说明：task-13 的部分浏览器验证脚本仍包含原评测机器上的 Playwright 缓存路径；其逻辑单元测试可直接运行，但跨机器执行浏览器审计前需要调整 Playwright 路径或通过 `PW` 环境变量提供模块位置。

### 第一阶段结果摘要

**DeepSeek-V4.1-Flash（0910 实验版，DSH harness）**

- 15 个任务均满足原始 prompt 的核心要求；
- task-11：21 项几何测试与 52 项浏览器检查通过；
- task-12：198 项引擎检查与 69 项浏览器检查通过；
- task-13：112 项逻辑断言通过；应用通过 4 个视口 × 2 个主题的渲染检查，但统一验证命令仍有服务编排问题；
- task-14：49 项金融断言、73 项交互断言，以及 9 页桌面/移动审计通过；
- task-15：3,861 项引擎断言与 244 项浏览器检查通过。

更完整的扣分理由、风险和改进优先级见[质量评估报告](Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/Reviews/15-任务完成质量评估.md)。

**Muse Spark 1.3（opencode 1.18.29 harness）**

- 15 个任务全部交付；task-12（计算器）与 task-15（读书追踪）的“未通过”经复核属于**交付方式问题**——交付物使用 ES module，`file://` 直接打开时被浏览器按 CORS 拦截，经 HTTP 提供服务后功能正常，不是功能逻辑缺陷。
- 评分口径为维护 agent 的**非盲评 v1**（2026-09-09）：每题 73–92 分、平均 84.9/100，与 DeepSeek 的 93.6/100 评委与口径均不同，**不可直接比较**；独立盲评仍待补。
- 累计用时 25 分 45 秒；178 次工具调用 / 8 次失败；token 过路量 3,669,385（输入 384,338 + 输出 154,563 + 缓存读 3,130,484）；费用 ¥0（contributor-free 档）。
- 隔离等级为 `workspace-only`（配置 + 提示词约束），污染状态记为 `clean（组织者判定）`，范围仅限已声明的控制措施；判定依据的原始日志未随档案封存，因此不能解释为“训练数据无污染”。
- 15 个 `prompt.txt` 为按题目文档**事后补录**并逐字比对，不是当时封存的输入副本。
- 阶段索引、逐题明细与已知限制见 [Muse-Spark-1.3 / Phase 1](Test_Results/Muse-Spark-1.3_Opencode/phase-01/README.md)。

### 后续阶段约定

新增阶段时建议：

1. 创建新的阶段或模型目录，不覆盖已有结果；
2. 保存原始 prompt，并记录任何补充轮次；
3. 每个任务使用独立目录，包含成果和任务 README；
4. 将可复现测试保存在仓库内，不只引用临时脚本；
5. 同时记录通过项、失败项、重试、已知限制和人工观察；
6. 在根 README 的阶段表中追加结果，以便长期比较。

### 说明

本仓库中的品牌、银行、账户、利率、人物和产品均为测试或演示内容。Meridian Bank 是虚构机构，不提供真实金融服务；请勿向任何演示表单输入真实个人或财务信息。测试结果仅描述当前归档中的模型、任务、环境和评估方法。

---

## English

### About

This repository publicly documents and showcases new-model evaluations. Each phase preserves the original prompts, model-produced artifacts, run or test instructions, visual evidence, and retrospective reports. The goal is not to present only the most attractive outputs, but to keep a traceable path from task input to result, verification, and issue analysis.

The archive covers **Phase 1**: three models — `DeepSeek-V4.1-Flash` (0910 preview, DSH harness), `Muse Spark 1.3` (opencode harness) and `GPT-5.6 Sol` (Codex CLI 0.147.0) — on the same 15 tasks, with run evidence and independent reviews; plus a **partial Phase 2**: Tasks 16–20 completed and archived by `DeepSeek-V4.1-Flash` (0910 preview; 5 of 30 tasks; the remaining 25 have not been run and this part has no independent review yet). The suite examines:

- SVG generation and compliance with exact visual constraints;
- self-contained web pages, games, and creative tools;
- complex interactive web applications;
- geometry, arithmetic, data state, and error handling;
- responsive design, accessibility, visual finish, and automated testing.

The public showcase [vibetest.gabrielmu2006.cn](https://vibetest.gabrielmu2006.cn/) currently covers 3 models / 2 phases / 20 tasks / 55 runs / 100 reviews (Phase 1: three models with a human review plus one or more AI reviews each; Phase 2: one AI review per run) across 174 static pages and 55 artifact previews. It uses a [Digital Museum / editorial archive interface](website/VibeTest%20Digital%20Museum%20UI%20Design%20Specification.md) (warm paper, serif display type, 1px dividers, works first, no leaderboard) with bilingual pages, a `⌘K` command palette, type/model/phase chip filters, same-task run comparison (selection kept in the URL), artifact previews and deep links; unknown values always read "Not recorded" instead of being inferred or zero-filled.

The repository is designed to grow. Future results can be added under Test_Results/<model-folder>/phase-NN/ while retaining the same “task → original prompt → artifact → test → evaluation” archive pattern.

### Current phase

| Phase | Model under test | Harness | Tasks | Core completion | Internal evaluation | Status |
| --- | --- | --- | ---: | ---: | ---: | --- |
| Phase 1 | DeepSeek-V4.1-Flash (0910 preview) | DSH | 15 | 15/15 | 93.6/100 (quoted historical AI report) | Complete |
| Phase 1 | Muse Spark 1.3 | opencode 1.18.29 | 15 | 15/15 delivered (2 flagged as delivery-method issues) | 84.9/100 (maintenance-agent non-blind v1) | Complete |
| Phase 1 | GPT-5.6 Sol | Codex CLI 0.147.0 | 15 | 15/15 delivered | 82.9/100 (maintenance-agent non-blind v3) | Complete |
| Phase 2 | Muse Spark 1.3 (xhigh) | opencode 1.18.30 | 5 / 30 (partial) | 5/5 delivered | 88.2/100 (maintenance-agent v2, non-blind AI review) | Partial (Tasks 16–20) |
| Phase 2 | DeepSeek-V4.1-Flash (0910 preview) | DSH | 5 / 30 (partial) | 5/5 delivered | 91.0/100 (Muse Spark 1.3 AI review) | Partial (Tasks 16–20) |

> The two rows come from different reviewers and rubrics and must not be compared directly; harness, budget and isolation level also differ.

> The aggregate score comes from the human and automated evaluation stored in this repository. It summarizes this phase and is not intended as a universal cross-model leaderboard score.

> **Model identity and snapshots** (organizer decision, 2026-09-10): the 0910 experimental preview and the subsequent GA release of `DeepSeek-V4.1-Flash` are treated as **one model**, reported in the same table. The showcase records the harness-reported model id (the snapshot) on every run: all 20 archived DeepSeek runs used the `deepseek-v4.1-flash-expires-on-0910` snapshot (the Phase 1 archive logged no model id, shown as “Not recorded”); the GA snapshot id will be filled in after its first run and is not inferred from the brand name. The entity id and all existing URLs stay unchanged, and GA runs will use runIds of the form `run-deepseek-v4-1-flash-task-NN-r1`; **cross-snapshot comparisons must be labelled**.

### Phase 1 tasks

| # | Task | Category | Primary artifact |
| ---: | --- | --- | --- |
| 01 | Aevum luxury-watch landing page | Single-file website | `index.html` |
| 02 | Pelican riding a bicycle | SVG generation | `pelican-on-bicycle.svg` |
| 03 | Analog clock at 6:25 | Exact SVG constraint | `clock-625.svg` |
| 04 | Analog clock at 11:52:30 | Exact SVG constraint | `clock-11-52-30.svg` |
| 05 | Side-view bicycle rider | SVG pose constraint | `bicycle_rider.svg` |
| 06 | Hand cutting paper with scissors | SVG action depiction | `scissors_cutting_paper.svg` |
| 07 | Person pushing a wheelbarrow | SVG direction/action constraint | `pushing_wheelbarrow.svg` |
| 08 | Neon Breakout | Single-file game | `index.html` |
| 09 | Harvest Hollow | Single-file game | `index.html` |
| 10 | Pixel-art editor | Single-file creative tool | `index.html` |
| 11 | 2D floor-plan editor | Interactive web app | Editor, geometry engine, and tests |
| 12 | Calculator | Interactive web app | Arithmetic engine, UI, and tests |
| 13 | Skylight weather dashboard | Data-driven web app | Dashboard, offline model, and audit tools |
| 14 | Meridian Bank website | Multi-page website | 9 pages, calculators, and audit tools |
| 15 | Shelf book tracker | Data-driven web app | Domain engine, UI, and tests |

### Later phase (Phase 2)

Phase 2 adds 30 advanced creation prompts (Task 16–45) in [`PROMPT/PHASE2_30_ADVANCED_CREATION_PROMPTS_BILINGUAL.md`](PROMPT/PHASE2_30_ADVANCED_CREATION_PROMPTS_BILINGUAL.md), focused on complex systems built from an empty directory. **Tasks 16–20 were completed and published by both models**: the 0910 preview snapshot of `DeepSeek-V4.1-Flash` (DSH) and **Muse Spark 1.3 xhigh (opencode 1.18.30)**. The five Muse runs carry one **AI review** each (maintenance-agent v2, non-blind, average **88.2/100**); the five DeepSeek runs have **no independent review yet**, shown on the site as “No independent review has been produced for this run yet”; neither batch has a human review, and cross-model comparison must note harness, budget and isolation differences (see the [phase-02 run index](Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-02/README.md)); Tasks 21–45 have not been run. This phase has **no human or AI review yet**, so the table above records delivery only, with no score.

Phase 2 isolation is `workspace-only` (two absolute `AGENTS.md` rules plus a post-hoc log audit): a **policy-level constraint**, not enforced isolation, and not a claim of “no contamination”. The Task 16–45 prompts are also published in this public repository (commit `0540edf`, see [known issues](docs/known-issues.md)), which the scores must be labelled with. A boundary finding affects annotation only, never score entry (organizer decision, 2026-09-10): `task-17` and `task-20` record “boundary attempt, no external content obtained”, kept in the audit archive only (never annotated on the run page), with no exclusion. See the [test isolation and anti-contamination protocol](docs/testing-protocol.md) and the [integration workflow](docs/adding-results.md).

### Repository layout

```text
New_Model_Test/
├── README.md
├── AGENTS.md
├── PROMPT/
│   ├── README.md
│   ├── Phase1_TEST_PROMPTS_BILINGUAL.md
│   └── PHASE2_30_ADVANCED_CREATION_PROMPTS_BILINGUAL.md   # Phase 2 prompts (Tasks 16-45)
├── Test_Results/
│   ├── README.md
│   ├── DeepSeek-V4.1-Flash-Exp-0910_DSH/
│   │   ├── phase-01/
│   │   │   ├── README.md
│   │   │   ├── Reviews/
│   │   │   └── task-01-.../ ... task-15-.../
│   │   └── phase-02/                  # Tasks 16-20 (partial: 5 of 30)
│   │       ├── README.md
│   │       ├── Reviews/               # reviews pending
│   │       └── task-16-.../ ... task-20-.../
│   └── Muse-Spark-1.3_Opencode/
│       ├── phase-01/
│       │   ├── README.md
│       │   ├── Reviews/
│       │   ├── evidence/
│       │   └── task-01-.../ ... task-15-.../
│       └── phase-02/                  # same Tasks 16-20 (partial)
│           ├── README.md
│           ├── Reviews/ai/maintenance-agent-v2/
│           └── task-16-.../ ... task-20-.../
├── test-workspace/            # Test scaffolding for later phases (isolation rules, runbook, templates)
├── website/                   # Astro showcase site, importer and automated tests
├── docs/                      # Data model, test protocol, deployment and verification records
└── .github/workflows/
```

Future phases live inside each model folder under Test_Results/. The root README maintains the index; see docs/adding-results.md for integration requirements.

### Key documents

- [Agent instructions](AGENTS.md)
- [Result interface](docs/result-interface.md) and [integration workflow](docs/adding-results.md)
- [Test isolation and anti-contamination protocol](docs/testing-protocol.md)
- [Test workspace runbook](test-workspace/README.md): phase scaffolding, per-task isolation, summary and archiving.
- [Deployment and rollback](docs/deployment.md)
- [Website UI design specification (Digital Museum / editorial archive)](website/VibeTest%20Digital%20Museum%20UI%20Design%20Specification.md)

- [15 original prompts with bilingual expected outcomes and acceptance checks](PROMPT/Phase1_TEST_PROMPTS_BILINGUAL.md)
- [30 Phase 2 advanced creation prompts (Task 16–45)](PROMPT/PHASE2_30_ADVANCED_CREATION_PROMPTS_BILINGUAL.md)
- [Phase 2 archive and run index (Tasks 16–20 archived)](Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-02/README.md)
- [GPT-5.6 Sol phase 1 index](Test_Results/GPT-5.6-Sol_Codex/phase-01/README.md)
- [Result archive index](Test_Results/README.md)
- [Phase 1 index and run instructions](Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/README.md)
- [Muse Spark 1.3 Phase 1 index](Test_Results/Muse-Spark-1.3_Opencode/phase-01/README.md)
- [Quality evaluation of all 15 completed tasks](Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/Reviews/15-任务完成质量评估.md)
- [Execution metrics and evaluation retrospective](Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/Reviews/DeepSeek-V4.1-Flash-Exp-0910-任务评测复盘.md)
- [Human-review summary](Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/Reviews/Personal_Review.md)

### View and run

The primary artifacts for tasks 01–10 open directly without installing dependencies:

```bash
open Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/task-01-aevum-luxury-watch-landing-page/index.html
open Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/task-03-analog-clock-6-25/clock-625.svg
open Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/task-08-breakout-game/index.html
```

Tasks 11–15 include in-project tests. Most do not require `npm install`; Node.js is primarily used as the test runner:

```bash
cd Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/task-12-calculator
npm test

cd ../task-15-book-tracker
npm test
```

See each task's `README.md` for full commands and known limitations. In particular, some task-13 browser tools still contain the original evaluation machine's Playwright cache path. Its logic tests run directly, but browser audits on another machine require adjusting that path or providing the Playwright module through the `PW` environment variable.

### Phase 1 result summary

**DeepSeek-V4.1-Flash (0910 preview, DSH harness)**

- All 15 tasks satisfy the core requirements of their original prompts.
- Task 11: 21 geometry tests and 52 browser checks passed.
- Task 12: 198 engine checks and 69 browser checks passed.
- Task 13: 112 logic assertions passed; the app passed 4 viewports × 2 themes in the render audit, although the aggregate verification command still has a server-orchestration issue.
- Task 14: 49 finance assertions, 73 interaction assertions, and desktop/mobile audits across all 9 pages passed.
- Task 15: 3,861 engine assertions and 244 browser checks passed.

See the [quality evaluation report](Test_Results/DeepSeek-V4.1-Flash-Exp-0910_DSH/phase-01/Reviews/15-任务完成质量评估.md) for detailed deductions, risks, and prioritized improvements.

**Muse Spark 1.3 (opencode 1.18.29 harness)**

- All 15 tasks were delivered; the "failed" verdicts for task-12 (calculator) and task-15 (book tracker) were re-checked as **delivery-method issues** — the artifacts use ES modules, which browsers block under `file://` for CORS reasons, and they work once served over HTTP. They are not functional defects.
- Scores come from the maintenance agent's **non-blind v1 review** (2026-09-09): 73–92 per task, 84.9/100 average. The reviewer and rubric differ from the DeepSeek 93.6/100, so the two **must not be compared directly**; an independent blind review is still pending.
- 25 min 45 s total; 178 tool calls / 8 failures; 3,669,385 tokens passed through (384,338 input + 154,563 output + 3,130,484 cache reads); cost ¥0 (contributor-free tier).
- Isolation level `workspace-only` (configuration plus prompt constraints) with contamination status `clean (organizer verdict)`, limited to the declared controls. The evidence behind that verdict was not archived, so it cannot be read as "no training-data contamination".
- The 15 `prompt.txt` files are **post-hoc transcriptions** checked word by word against the task document, not input copies sealed at run time.
- See the [Muse-Spark-1.3 / Phase 1 index](Test_Results/Muse-Spark-1.3_Opencode/phase-01/README.md) for per-task detail and known limitations.

### Convention for future phases

When adding another phase:

1. Create a new phase or model directory; do not overwrite previous results.
2. Preserve original prompts and record any follow-up turns.
3. Keep every task in its own directory with its artifact and task README.
4. Store reproducible tests in the repository instead of referring only to temporary scripts.
5. Record passes, failures, retries, known limitations, and human observations.
6. Append the result to the phase table in this root README for longitudinal comparison.

### Disclaimer

Brands, banks, accounts, rates, people, and products in this repository are test or demonstration content. Meridian Bank is fictional and provides no financial services; never enter real personal or financial information into any demo form. Results describe only the archived model, task set, environment, and evaluation method.
