---
title: "Academic Dashboard"
collection: Repositories
type: "Obsidian plugin"
permalink: /Repositories/academic-dashboard/
date: 2026-08-16
status: "Released"
link: "https://github.com/GabrielMu2006/academic-dashboard"
---

Academic Dashboard 是一款桌面端 Obsidian 插件，把现有 Vault 变成以小组件为主的学术工作台，覆盖学习、科研、日常规划与有边界的 Agent 交接，主要面向用 Obsidian 管理课程、论文和阅读的学生与研究者。

## 当前版本

- macOS 为主要验证平台，当前版本 `0.2.0`，要求 Obsidian Desktop 1.11.4 及以上，TypeScript 编写，MIT 协议。
- Home 页提供日期时间、日历、最近笔记、每日引言、今日任务与论文/复习摘要；支持创建每日、课程、论文、书籍四种笔记。
- Study 页提供原生 Markdown 复习队列、本地学习活动统计与可选的 GitHub 贡献日历。
- Research 页按标题、作者、venue、DOI、年份和阅读状态检索现有论文笔记，不提供外部论文抓取或自动元数据迁移。
- Agent 页可在 Codex 与 OpenCode 之间选择目标，提供八种有边界的流程（整理、摘要、修复 Markdown、检索 Vault、路由日记、创建课程/论文/书籍笔记），打开 Claudian 并预填请求；对已有笔记的写入保持 review-first。
- 可选集成全部非必需：Tasks、Spaced Repetition、Bases、PaperPulse Academic 主题；缺省时显示明确回退状态而不影响插件加载。

## 设计原则

**本地优先。** 插件读取现有笔记与 frontmatter，适配用户已有的字段映射，不做全库重写或静默整理。

**写入最小化。** 只允许勾选任务、更新复习标记、修改论文状态/收藏、在安全路径创建单个笔记这四类操作；无删除、移动、重命名、批量编辑或 Git 能力。

**尊重 Agent 边界。** 提供者、模型、认证与执行权限都保留在 Claudian 和所选 Agent 中，Dashboard 只准备有边界的工作流上下文。

**隐私克制。** 除可选的 GitHub GraphQL 贡献日历外无网络请求；Token 只存入 Obsidian SecretStorage，不进插件数据或日志；无遥测。

**Insight.** README 中最强的设计意图不是"把 Agent 装进 Obsidian"，而是把人与 Agent 的协作切成两类动作：本地动作必须窄而可撤销，交接给 Agent 的动作必须经过评审再执行。这个 write-safety 模型是插件区别于一般 dashboard 的核心。

**Repository.** [GabrielMu2006/academic-dashboard](https://github.com/GabrielMu2006/academic-dashboard)
