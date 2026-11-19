---
title: "Godot Game Workflow"
collection: Repositories
type: "Agent skill"
permalink: /Repositories/godot-game-workflow/
date: 2026-11-19
status: "Active"
link: "https://github.com/GabrielMu2006/godot-game-workflow"
---

Godot Game Workflow 是面向 Godot 4.x 和 GDScript 的 [Agent Skill](https://agentskills.io/specification)。它指导编码助手迭代已有游戏、搭出可玩的 2D 或 3D 场景、处理素材，并导出 macOS、Windows 和 Web 构建。入口是 `SKILL.md`，按任务再读 `references/` 和 `scripts/`。仓库目前没有 release 或 tag。

## 它做什么

- 从概念起步时，先写清玩家输入、目标、反馈，以及完成、失败或重开的路径。用一个能完整玩通的代表性场景验证核心玩法，再扩展内容。只有影响交付或难以返工的选择需要向用户确认。
- 改已有工程时，先找到 `project.godot`，查看仓库约定、Git 工作区、Godot 版本、主场景、Input Map、Autoload、资源布局、测试命令和导出预设，并沿用适用的场景结构、渲染器、命名和导入规则。
- 玩家可控动作放进 Input Map，物理运动放在 `_physics_process()`。资源要进最终场景验证；导出文件名、节点路径和资源引用区分大小写。已有项目的约定优先于 skill 里的示例。
- 需要快速检查导入和主场景启动时，运行 `scripts/godot-smoke.sh`。它会导入工程、无界面启动主场景并跑指定帧数（默认 120），发现引擎或脚本错误就返回失败，同时刷新该工程的导入缓存。工程目录需要有 `project.godot`。可以用 `GODOT_BIN` 指定 Godot 可执行文件；省略时脚本先在 `PATH` 里找 `godot` 或 `godot4`，再试用户的 Applications 目录。单独检查一段 GDScript 时，`SKILL.md` 写了 Godot 的 `--headless --check-only`。项目自己要求的 `gdlint`、`gdparse` 和 `gdformat --check` 是补充检查，脚本、场景和导入兼容性仍由项目版本的 Godot 验证。

## 随附参考

- `references/2d.md`：场景、精灵动画、图块和地图。
- `references/3d.md`：白盒场景、碰撞、相机，以及 Blender 到 Godot 的模型导入。
- `references/assets.md`：PNG、音频和源文件管理。
- `references/local-macos.md`：一套 Apple Silicon 本机工具和路径，供核对自己的机器。
- `references/exports.md`：macOS、Windows 和 Web 的导出及目标端检查。

技能目录里可以放一份个人 `local.md`，记下本机 Godot 路径或 Windows 测试根目录。Git 会忽略这个文件，相关任务里会读取它。当前任务里用户指定的路径优先。

## 安装

安装本身只需要能下载文件。构建或启动游戏仍要准备与项目版本匹配的 Godot 4 编辑器；导出还要安装同一版本的导出模板，并使用项目里的导出预设。做素材时按需使用 Aseprite、Tiled、Blender 或 FFmpeg。

README 让用户把仓库地址发给能联网、能写文件系统并运行命令的编码 Agent，由它按当前客户端和操作系统选择技能目录，下载完整仓库，保留 `SKILL.md`、`references/` 和 `scripts/`，并回报安装路径和调用方式。目录表覆盖这些客户端：

| 客户端 | 用户级技能根目录 | 项目级 | 调用 |
| --- | --- | --- | --- |
| Codex | `~/.agents/skills` | `.agents/skills` | `$godot-game-workflow`，或直接描述 Godot 任务 |
| OpenCode | `~/.agents/skills` | `.agents/skills` 或 `.opencode/skills` | `@godot-game-workflow` |
| Cursor | `~/.agents/skills` 或 `~/.cursor/skills` | `.agents/skills` 或 `.cursor/skills` | Agent 的 `/` 菜单 |
| DeepSeek Harness | `~/.agents/skills` | `.agents/skills` 或 `.dsh/skills` | 在启用了文件系统技能 provider 的会话里加载该 skill |
| ZCode Agent | `~/.zcode/skills` | 使用用户级目录 | 设置里刷新后，在聊天的 `/` 面板选择 |
| Claude Code | `~/.claude/skills` | `.claude/skills` | `/godot-game-workflow` |
| VS Code Copilot | `~/.copilot/skills` | `.github/skills` | `/godot-game-workflow` |

可以用 `git clone`，也可以下载 [仓库 ZIP](https://github.com/GabrielMu2006/godot-game-workflow/archive/refs/heads/main.zip)，把解压目录改名为 `godot-game-workflow` 放进技能根目录。装好后应能看到 `SKILL.md`、`README.md`、`references/` 和 `scripts/godot-smoke.sh`。已有同名技能时，先看来源和本地修改：来自本仓库且工作树干净的 Git 安装可以 `git pull --ff-only`；有手工改动、来源不同或属于手工安装时，保留现有文件并说明情况。ZIP 安装更新时保留自己的 `local.md`。

手动冒烟检查的例子（两个路径按本机填写）：

```sh
GODOT_BIN="/absolute/path/to/Godot" \
  bash "$HOME/.agents/skills/godot-game-workflow/scripts/godot-smoke.sh" \
  "/absolute/path/to/game" 120
```

Windows 上 README 说明可以用能访问 Godot 和项目路径的 Git Bash；如果 Git Bash 用的是 MSYS 路径，传给 Godot 的项目路径仍要能被 Windows 引擎识别。

## 设计见解

**Insight.** 这个 skill 把「能玩通的一小段」放在扩内容之前：先定输入、目标和重开路径，再用一个代表性场景验收，而不是先铺一整张地图。验收也拆开了——无界面冒烟只证明导入和主场景能跑过指定帧数；外观、输入、音频和性能仍要在正常窗口或目标浏览器里亲自走一遍，并记下实际跑过的命令、场景和还缺的环境。

**Repository.** [GabrielMu2006/godot-game-workflow](https://github.com/GabrielMu2006/godot-game-workflow)
