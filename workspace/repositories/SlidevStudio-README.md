# Slidev Studio — Plugin / 插件

[中文](#中文) · [English](#english) · [Agent 安装执行指南 / Installation playbook](INSTALL.md) · [Releases](https://github.com/GabrielMu2006/slidev-studio/releases/latest)

## 中文

**Slidev Studio 的分发单位是插件（plugin），其中包含两项 skill、本地工具和八套风格预设。** `slidev` 负责 Slidev 创作、模板选择、交互与导出；`slidev-template-import` 负责从 PPT 提炼完整布局模板、验证、入库和复用。仓库不存在名为 `slidev-studio` 的单项 skill。

原生插件安装会在宿主的插件管理器中登记 `slidev-studio`，由宿主管理启停与更新，再加载两项 skill。把两个文件夹复制到 skills 目录属于 **skills 兼容安装**，其内容可以使用，但没有完成原生插件注册。插件自带的 skill 仍然会出现在技能列表中；是否装成插件，应同时检查插件管理器中的记录和来源。

### 给安装 agent 的执行指令

收到本仓库 URL 并被要求安装时，按以下流程执行。详细命令与验证见 [INSTALL.md](INSTALL.md)。

1. **识别当前宿主。** 依据当前会话、宿主工具与设置判断；机器上存在 `codex` / `claude` / `dsh` 命令，不代表当前 agent 就属于它。不要给另一个宿主安装后声称当前宿主可用。
2. **选择专用路线。** Claude Code、ZCode、DeepSeek Harness、Codex 优先原生插件路线。用户要求插件时，不要默默降级为 skills 兼容安装。其他 agent 先查其实际插件格式；仅支持 skills 时说明差异，并按用户已有授权选择兼容方式。
3. **执行安装或更新。** 使用宿主实际提供的插件工具、CLI 或界面。只有界面入口而无界面操作能力时，给出准确的待操作步骤并标记未完成；不要编造命令、手改未公开的注册数据库或用复制 skills 冒充成功。
4. **分别验证三层结果。** A：宿主中插件已注册、启用且版本正确；B：两项 skill 可发现/加载；C：已安装副本中的工具可运行且返回八套预设。`verify_install.py` 只证明文件与工具，不能单独证明 A。
5. **报告安装形态。** 报告当前宿主、`native-plugin` / `skills-compatibility` / `pending`、版本、位置、A/B/C 证据以及是否需要刷新会话。保留既有项目和用户配置。

| 当前宿主 | 专用路线 | 成功依据 |
| --- | --- | --- |
| Claude Code | [Claude 原生插件](INSTALL.md#claude) | Claude 插件列表已登记并启用，两项 skill 属于该插件 |
| ZCode | [ZCode 原生插件](INSTALL.md#zcode) | 设置 → 插件中显示已安装并启用；技能来源为 Plugin 技能 |
| DeepSeek Harness / DSH | [DSH 原生 bundle](INSTALL.md#dsh) | 当前实际 profile 中 bundle 已启用，provider 激活并注册两项 skill |
| Codex | [Codex 原生插件](INSTALL.md#codex) | 插件列表已登记并启用，技能来源为 slidev-studio@slidev-local |
| 其他 agent | [其他宿主判断路线](INSTALL.md#other) | 根据宿主能力报告原生插件或明确的 skills 兼容安装 |

**ZCode 快速入口：** 打开一个工作区 → 设置 → 插件 → 创建 → 添加插件市场 → 输入 `https://github.com/GabrielMu2006/slidev-studio` → 在市场 `slidev-local` 中安装并启用 `slidev-studio`。不要从“技能 → 导入”代替该操作。看到两项技能位于“Plugin 技能”分组是正常现象。依据：[ZCode 官方插件说明](https://zcode.z.ai/cn/docs/plugin)。

可直接发送给安装 agent：

> 请读取 https://github.com/GabrielMu2006/slidev-studio 的 README.md 和 INSTALL.md，识别当前宿主，执行其原生插件安装路线；分别验证插件注册、两项 skill 和八套预设。不要把 skills 兼容安装当成原生插件成功；无法操作宿主安装界面时，请报告具体待完成步骤。

### 已保留的八套风格预设

八套全部保留，第 1 套固定命名“青蓝课堂”。它们是可视化选择器中的风格预设；从 PPT 提炼的完整布局模板包使用独立模板库，数量不限。

![八套预设实际封面](docs/images/templates.png)

| 编号 | 名称 | 标识 | 风格与场景 |
| --- | --- | --- | --- |
| 1 | 青蓝课堂 / Cyan Classroom | `cyan-classroom` | 深色封面、白底内容、青蓝渐变标题。适合中文课程与教学。 |
| 2 | 清简 / Minimal Light | `minimal-light` | 暖白底、墨绿强调、清晰的叙事层级。适合分享与产品讲解。 |
| 3 | 纸上学术 / Academic Paper | `academic-paper` | 纸色背景、深红标题、衬线风格。适合组会、论文与学术报告。 |
| 4 | 夜间技术 / Terminal Dark | `terminal-dark` | 深色画布、浅色代码、青绿强调。适合技术会议与代码演示。 |
| 5 | 咨询蓝 / Consulting Blue | `consulting-blue` | 白底深蓝、左对齐封面、标题分隔线。适合业务汇报与决策建议。 |
| 6 | 琥珀叙事 / Editorial Amber | `editorial-amber` | 奶油纸色、琥珀强调、衬线标题与编辑式留白。适合人文与案例叙事。 |
| 7 | 蓝图实验 / Blueprint Lab | `blueprint-lab` | 海军蓝网格、青色标注、等宽标题。适合架构、工程和实验过程。 |
| 8 | 玫瑰演讲 / Keynote Rose | `keynote-rose` | 浅玫瑰底、莓红大标题、舞台式留白。适合观点演讲与产品发布。 |

[逐套封面与内容页](docs/TEMPLATES.md)。安装并刷新后，可直接要求 agent：“用青蓝课堂创建一份 Slidev 演示”，或“从这份 PPT 提炼完整模板，检查效果后加入模板库”。

工具使用 Python 3.9+；创建演示需要符合 Slidev CLI 要求的 Node（验证基线 Slidev 53.0.0 / Node >=22.12.0）。DSH 原生适配器由 DSH 的 Node 运行时加载。源 PPT 渲染可用 LibreOffice + Poppler 或宿主工具；CLI 导出需要 Chromium。仅提取 XML 的模板保持草稿状态，真实构建和视觉检查后才能标记为已验证。

插件、宿主清单、DSH bundle、两项 skill 共用 VERSION；用户模板库在插件缓存之外。更新见 [UPDATING.md](docs/UPDATING.md)，已测试范围见 [COMPATIBILITY.md](docs/COMPATIBILITY.md)。

## English

**Slidev Studio is distributed as a plugin package containing two skills, local tools and eight presets.** `slidev` covers authoring, preset selection, interactions and exports; `slidev-template-import` distills full PPT-derived layout templates, verifies them and manages reusable bundles. There is no single skill named `slidev-studio`.

A native install registers `slidev-studio` with the host's plugin manager, which controls activation and updates and loads both skills. Copying the two skill directories is a **skills compatibility installation**; it does not register a native plugin. Plugin-provided skills normally appear in a skills list too, so inspect plugin registration and skill origin together.

### Agent installation procedure

Read [INSTALL.md](INSTALL.md), then execute the route for the **active host**, inferred from the current session and host capabilities. A `codex`, `claude` or `dsh` binary on disk is not evidence that this is the active host.

Prefer the dedicated native routes for [Claude Code](INSTALL.md#claude), [ZCode](INSTALL.md#zcode), [DeepSeek Harness](INSTALL.md#dsh) and [Codex](INSTALL.md#codex). For [other agents](INSTALL.md#other), establish the actual plugin format first. When a user requests a plugin, do not silently substitute skills compatibility mode. Use the user's existing authorization when deciding whether that alternative is acceptable.

Use the host's real CLI, tools or GUI. If installation is GUI-only and the agent lacks GUI control, report the exact pending user action. Do not invent commands, edit undocumented registration databases or claim success from copied skills.

Verify independently: **A** native registration, activation and version; **B** discovery/loading of both skills with plugin origin; **C** installed helper execution and the eight-preset catalog. `verify_install.py` proves package content and helper execution, not A. Report host, mode (`native-plugin`, `skills-compatibility` or `pending`), version, location, A/B/C evidence and remaining session refresh. Preserve user projects and configuration.

**ZCode quick path:** open a workspace → Settings → Plugins → Create → Add marketplace → enter `https://github.com/GabrielMu2006/slidev-studio` → install and enable `slidev-studio` from `slidev-local`. The Skills import page is a different workflow. Both skills appearing in the Plugin skills group is expected. [Official ZCode documentation](https://zcode.z.ai/en/docs/plugin).

Copyable request:

> Read README.md and INSTALL.md at https://github.com/GabrielMu2006/slidev-studio, identify your active host and execute its native plugin installation route. Verify native registration, both skills and the eight presets separately. Do not present a skills compatibility install as a native plugin install; report any GUI action you cannot perform.

### Eight retained presets

All eight are retained; preset 1 is Cyan Classroom / 青蓝课堂. Full PPT-derived layout bundles use a separate, unlimited library. [Inspect actual covers and content pages](docs/TEMPLATES.md).

| # | Name | ID | Style and use |
| --- | --- | --- | --- |
| 1 | Cyan Classroom | `cyan-classroom` | Dark illustrated cover, white content, cyan headings for teaching. |
| 2 | Minimal Light | `minimal-light` | Warm white, green accents and restrained sans-serif type for general talks. |
| 3 | Academic Paper | `academic-paper` | Paper, deep red and serif type for research presentations. |
| 4 | Terminal Dark | `terminal-dark` | Dark canvas, mint accents and light code for technical demonstrations. |
| 5 | Consulting Blue | `consulting-blue` | White and navy, left-aligned covers and ruled headings for business decisions. |
| 6 | Editorial Amber | `editorial-amber` | Cream paper, amber accents and editorial serif hierarchy for stories and case studies. |
| 7 | Blueprint Lab | `blueprint-lab` | Navy grids, cyan annotations and monospaced headings for architecture and engineering. |
| 8 | Keynote Rose | `keynote-rose` | Pale rose, large berry headings and open poster composition for keynotes and launches. |

Tools require Python 3.9+. Decks need Node satisfying the installed CLI (tested baseline: Slidev 53.0.0 / Node >=22.12.0); the DSH adapter uses the host Node runtime. Reference rendering uses optional LibreOffice/Poppler or a host renderer; CLI exports need Chromium. XML-only template extraction remains a draft until build and visual inspection pass. Static exports differ from live interactions; verify editable-export support against the installed CLI and actual output.

One VERSION controls native manifests, the DSH bundle and both skills. User templates stay outside plugin caches. See [updates](docs/UPDATING.md) and [validated scope](docs/COMPATIBILITY.md).

### Development / 开发

```bash
python3 scripts/release.py sync 0.4.0
python3 -m unittest discover -s plugins/slidev-studio/tests -v
python3 -m unittest discover -s tests -v
node --test tests/dsh-provider.test.mjs
python3 scripts/release.py build
```

MIT; [LICENSE](plugins/slidev-studio/LICENSE) and [NOTICE](plugins/slidev-studio/NOTICE.md). Independent project, not an official plugin of any supported host. Skills remain in the canonical `plugins/slidev-studio/skills/` tree.
