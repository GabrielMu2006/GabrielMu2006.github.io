# SpecForge

**把一句模糊的想法，逐步打磨成可以交给 Coding Agent 的 `SPEC.md`。**

[English](README.en.md) · [Skill 入口](skills/specforge/SKILL.md) · [完整示例](examples/timetable/SPEC.md) · [下载发布包](https://github.com/GabrielMu2006/SpecForge/releases/latest)

很多项目在开始编码时，还没有明确服务谁、第一版做到哪里、怎样才算完成。SpecForge 把这段讨论变成可复用的 Agent skill，帮助不懂开发的人和 AI 一起作出产品决策。

> 我想做一个朋友之间共享课表并找共同空闲时间的网站。

从这里开始，SpecForge 会分阶段澄清问题，建议取舍，标记假设，最终整理产品定位、用户、V1 / V2、页面或其他交互入口、流程、业务规则、功能边界、Roadmap 和可验收的 Task List。

## 它如何工作

```text
一句想法 / 已有 SPEC.md
        ↓
问题与用户 → 第一版范围 → 产品行为 → 开发交接
        ↓          每轮最多 3 个问题
SPEC.md：需求 + 规则 + 验收 + 任务 + 未决事项
```

- **像产品搭档一样讨论。** 指出冲突和范围膨胀，给出建议，由用户决定重要取舍。
- **让非技术用户能回答。** 用生活场景解释选择；代码架构留给 Coding Agent。
- **不知道也能继续。** 对可逆细节提出暂用方案；核心价值和 V1 范围仍需要明确决定，除非用户已明确委托。
- **事实按需查证。** 只调研影响方案的事实；没有联网能力时，将它保留为待验证项。
- **能继续修改。** 读入现有规格，检查新需求对流程、验收标准和任务的影响，保留稳定的需求与任务编号。
- **适配项目类型。** 网站、App、脚本、自动化、插件和 skill 使用不同的提问重点。脚本不必有页面。

默认产出一个 `SPEC.md`。内容过多时，可把任务拆到 `TASKS.md`，并保留一个清晰入口。达到可开工条件就交付；有阻塞项则交付标明原因的 Draft，不制造“全部想清楚了”的假象。

## 安装

运行 skill 不需要 Python、API Key、MCP 或特定模型。需要一个能够读取 skill 及其支持文件的 Agent；联网查证和写入文件取决于宿主能力。

下载 [最新发布包](https://github.com/GabrielMu2006/SpecForge/releases/latest)，解压得到 `specforge/`，把**整个文件夹**放到下列位置之一：

| 使用环境 | 个人安装目录 | 调用示例 |
| --- | --- | --- |
| Codex | `~/.agents/skills/specforge/` | `$specforge 我想做一个朋友共享课表的网站` |
| Claude Code | `~/.claude/skills/specforge/` | `/specforge 我想做一个朋友共享课表的网站` |
| 其他支持 Agent Skills 的工具 | 按宿主文档设置 skill 目录 | 请求使用 `specforge` |

也可以在项目内使用 `.agents/skills/specforge/`（Codex）或 `.claude/skills/specforge/`（Claude Code）。安装目录和调用方式依据 [Codex 官方说明](https://learn.chatgpt.com/docs/build-skills)与 [Claude Code 官方说明](https://code.claude.com/docs/en/skills)；核心格式遵循 [Agent Skills 规范](https://agentskills.io/specification)。这些是格式和文档层面的适配，尚未逐一完成不同宿主的真实多轮运行评测。

如果你偏好 Git，在一个用于存放工具的目录执行：

```sh
git clone https://github.com/GabrielMu2006/SpecForge.git
cd SpecForge
mkdir -p "$HOME/.agents/skills"
test ! -e "$HOME/.agents/skills/specforge" && cp -R skills/specforge "$HOME/.agents/skills/specforge"
```

Claude Code 用户将最后两行中的 `.agents` 换成 `.claude`。目标已存在时，命令不会覆盖它；更新前先保留自己的修改，再用新版本替换该文件夹。若新 skill 未显示，重新打开 Agent 会话。

没有原生 skill 功能的聊天工具也可以使用：提供 `SKILL.md` 和它引用的支持文件，并要求遵循其中流程。这种方式需要手动提供上下文；没有文件工具时，输出 Markdown 内容供你保存。

## 开始使用

在你准备创建产品的项目目录中，发送：

```text
使用 specforge。我想做一个朋友之间共享课表并找共同空闲时间的网站。
我不懂开发，请先帮我明确第一版应该做什么。
```

你不需要先写一份完整需求文档。回答每轮问题即可；也可以说“这部分你推荐”“先保存草稿”或“今天先到这里”。

修改已有规格：

```text
使用 specforge 读取当前 SPEC.md。
我想让第一版支持跨学校朋友，请检查需要调整哪些规则和任务。
```

开发交接时：

```text
读取 SPEC.md，核对它的状态与阻塞项。
如果已准备好，请基于现有代码库提出实现方案，再按任务依赖推进。
```

这条开发指令由用户另外发出；SpecForge 本身负责定义产品。

## 交付示例

- [共享课表网站](examples/timetable/SPEC.md)：带业务规则、异常情况、数据可见性、需求编号和任务依赖的完整示例。
- [文件整理脚本](examples/file-organizer/SPEC.md)：演示没有页面、登录和 V2 承诺的小工具规格。

示例是人工编写的教学材料，包含虚构的已选条件；它们不是用户访谈记录，也不是跨模型效果证明。

## 仓库结构

```text
skills/specforge/       可安装的 skill
  SKILL.md              入口、对话规则、就绪标准
  references/           提问、写作与修订指南
  assets/               可调整的 SPEC 模板
  agents/openai.yaml    Codex 展示信息
examples/               完整输出示例
evals/                  行为回归场景及评测方法
scripts/                维护者使用的检查与打包工具
```

## 开发与验证

维护工具需要 Python 3.9+，不属于 skill 的运行依赖。

```sh
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements-dev.txt
.venv/bin/python scripts/check.py
.venv/bin/python scripts/package.py
```

检查覆盖元数据、本地链接、必需资源和发布包内容。行为质量需要按 [回归场景](evals/README.md)进行真实对话评测；静态检查通过不代表访谈效果已被验证。贡献前请阅读 [贡献说明](CONTRIBUTING.md)。

## 边界

SpecForge 的目标是让关键决策足够清楚，并保留可见的不确定性。它不保证市场需求成立，不自动证明第三方集成可行，也不会通过生成任务清单宣称软件已经实现。V1 聚焦产品层的开发交接，不预先强制技术栈、数据库或接口设计。

采用 [MIT License](LICENSE)，可以复用、修改和分发。
