---
title: "Academic Dashboard"
collection: Repositories
type: "Obsidian plugin"
permalink: /Repositories/academic-dashboard/
date: 2026-10-28
status: "Released"
link: "https://github.com/GabrielMu2006/academic-dashboard"
---

Academic Dashboard 是一款桌面端 Obsidian 插件，把现有 Vault 变成以小组件为主的学术工作台，覆盖学习、科研、日常规划与有边界的 Agent 交接，主要面向用 Obsidian 管理课程、论文和阅读的学生与研究者。

## 当前版本

- macOS 为主要验证平台，当前版本 `0.3.0`，要求 Obsidian Desktop 1.11.4 及以上，TypeScript 编写，MIT 协议。
- Home 页提供日期时间、日历、最近笔记、每日引言，以及分组的逾期 / 今天 / 未来七天原生 Markdown 任务，最多三个 Today Focus 引用；支持精确完成任务并带会话内条件撤销，还能编辑一份周一至周日的周报草稿，二次确认后在 `Weekly Reviews` 创建唯一一篇笔记。
- Study 页提供按课程与学期聚合的 Course Overview 详情视图（明确标注结果来自元数据还是配置的课程根目录）、由课程笔记目录自动生成的文件夹按钮、有界的 10 / 20 项复习会话（可标记已看、跳过、打开来源与安全的下次复习日期），以及单条明确复习标记的日期更新。
- Research 页提供统一的论文 / 书阅读队列：插件侧状态、手动排序、下一步与页 / 章 / 阶段位置，配合稳定 ID 与版次签名，笔记改名后仍能重新连上而不会按标题误合并；可按映射字段检索并保存最多 12 个固定视图，相关材料链接只依据映射的关系字段或完全相同的标签，不提供外部论文抓取。
- Agent 页在 Codex 与 OpenCode 之间选择目标，提供八种有边界的流程；`0.3.0` 起交接前有两步本地预览、目标路径与上下文大小检查，只保留最小请求历史，并区分等待、已打开、失败与用户标记几种状态。
- 可选集成全部非必需：Tasks、Spaced Repetition、Bases、PaperPulse Academic 主题；缺省时显示明确回退状态而不影响插件加载。

## 升级与兼容

- 设置 schema 从 6 原地迁移到 7，既有设置与保留的请求历史都会保留，新字段取安全默认值。
- `0.3.0` 在 Obsidian Desktop 1.13.7（macOS）上实测安装，覆盖迁移与 Home / Study / Research / Agent 四个页面的渲染检查。
- 升级时保留每个 Vault 的 `data.json`，只替换 `main.js`、`manifest.json`、`styles.css`，或改用打包好的 ZIP；发布附 `SHA256SUMS`。

## 设计原则

**本地优先。** 插件读取现有笔记与 frontmatter，适配用户已有的字段映射，不做全库重写或静默整理。

**写入最小化且可撤销。** 只允许勾选任务、更新复习标记、修改论文状态 / 收藏、在安全路径创建单个笔记这几类写入；`0.3.0` 的所有新写入同样带二次确认与会话内条件撤销，仍无删除、移动、重命名、批量编辑或 Git 能力。

**尊重 Agent 边界。** 提供者、模型、认证与执行权限都保留在 Claudian 和所选 Agent 中，Dashboard 只准备有边界的工作流上下文。

**隐私克制。** 除可选的 GitHub GraphQL 贡献日历外无网络请求；Token 只存入 Obsidian SecretStorage，不进插件数据或日志；无遥测。

**Insight.** README 与发布说明里最强的设计意图不是「把 Agent 装进 Obsidian」，而是把人与 Agent 的协作切成两类动作：本地动作必须窄而可撤销，交接给 Agent 的动作必须经过评审再执行。`0.3.0` 把这条原则扩展到了新的写入面——周报、复习日期、任务完成都带二次确认和条件撤销，还加入了来源指纹与 compare-and-swap，防止覆盖更新版本插件写下的设置。这种「先扩大能力、再同步加固写入边界」的节奏，比单纯堆功能更能说明维护者对数据安全的优先级。

**Repository.** [GabrielMu2006/academic-dashboard](https://github.com/GabrielMu2006/academic-dashboard)
