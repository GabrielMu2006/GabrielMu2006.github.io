---
title: "Ox Alpha Evaluation"
collection: Repositories
type: "Evaluation framework"
permalink: /Repositories/oxalpha-evaluation/
date: 2026-08-22
status: "Active"
link: "https://github.com/GabrielMu2006/OxAlpha-Evaluation"
---

OxAlpha-Evaluation 是一套配置驱动的黑盒评测框架，分别评估 Ox Alpha 的原生 API 能力，以及 Ox Alpha 接入 OpenCode 之后的 Agent 能力，面向需要可复现、可追溯证据而不是单一排行榜分数的模型评测与选型场景。

## 当前状态

- Python 3.12 + uv 管理依赖，SQLite 与内容寻址产物保存原始证据；Docker 镜像以 registry digest 固定。仓库当前未标注开源许可证。
- 首个实测 Provider 是 OpenCode Go 的 OpenAI-compatible API，模型 ID 为 `ox-alpha-free`（Agent 侧为 `opencode-go/ox-alpha-free`）。Ox Alpha Free 是限时模型：每次实跑前必须请求 `/models` 确认目标模型存在，缺失时直接停止，绝不静默替换其他模型。
- 已完成 Phase 1 框架基础、有边界的 Phase 2 原生 API 核心，以及 Phase 3 OpenCode Agent 试点框架（3 个 Basic + 3 个 Engineering 任务，尚未达到完整基准的任务量）。
- Phase 4 离线 harness 就绪检查与 SWE-bench Lite Gold 准入门已跑通；后者只是基础设施兼容性验证，不做推理、不产生分数。模型实测 SWE-bench 仍被阻断，需等官方 Harness 容器禁用网络出口。
- 主要命令：`api-preflight` / `api-run`、`agent-preflight` / `agent-baseline` / `agent-run` / `agent-summary`、`phase4-harness-check` / `phase4-swebench-gold`，另有 `validate`、`dry-run` 与 `pytest` / `ruff` / `mypy` 质量检查。

## 实测结果（部分覆盖）

2026-08-22 的中文评测报告给出的是"部分覆盖"结果，不是完整能力分数：

- HumanEval Base 156/164 通过（Pass@1 95.12%），HumanEval+ 151/164 通过（Pass@1 92.07%）；每题单样本、不做多候选选优。
- OpenCode Agent Core 6 个任务、每题独立运行 3 次，共 18/18 次成功。
- 按 Native API 60% / OpenCode Agent 40% 加权得到的部分 Overall 为 98.68，但明确不覆盖多模态与模型实跑 SWE-bench；Agent 任务只有 6 个小型 Python 仓库，非编码任务为烟雾级，存在天花板效应，不用于与其他模型的公开榜单成绩比较。

## 设计原则

**原始数据优先。** 评分链固定为 Raw Metrics → Task Score → Category Score → Overall Score；最终总分不能替代原始实验数据，失败样本必须保留并单独报告，而不是被丢弃。

**可复现性优先。** 模型、Prompt、数据集、评分规则、运行时、Docker 与 OpenCode 版本全部版本化；原始响应、工具轨迹、补丁与测试输出内容寻址保存，无法完全确定性的部分必须在报告中披露。

**黑盒与公平。** 不依赖模型内部参数，不用参考答案修补模型输出，评分规则在正式实验前冻结并版本化；无效样本和基础设施错误不进入能力分数。

**隔离与自动化。** 任务配置化、模型调用走 Model Adapter；Agent 任务默认按完全自主设计，人工只处理 API 与环境故障。验收测试在 digest 固定、禁网、只读的 Docker 容器中运行，环境故障与模型失败分开归因。

**诚实计分。** 缺失能力记为 N/A 而不是零分；98.68 这类分数被明确标注为部分覆盖，README 与报告反复强调"不用于公开榜单比较"。

**Insight.** 框架最核心的设计是把"分数"当作可追溯链的终点而非产品本身：Raw Metrics First 保证任何总分都能回退到原始响应、日志与测试证据，而"部分覆盖"的自我标注则把结论诚实限制在已测边界内。配合"模型缺失即停止、绝不静默回退"的规则，它更像一个审计工具，而不是又一个刷榜脚本。

**Repository.** [GabrielMu2006/OxAlpha-Evaluation](https://github.com/GabrielMu2006/OxAlpha-Evaluation)
