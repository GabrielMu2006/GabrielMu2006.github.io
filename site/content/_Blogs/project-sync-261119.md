---
title: "Godot 游戏工作流技能发布，API Meter 1.6.3 补上组织资源包"
collection: Blogs
type: "Project sync"
permalink: /Blogs/project-sync-261119/
date: 2026-11-19
order: 10
status: "Published"
---

今天把两个仓库的近况写进网站：新增 Godot Game Workflow 的项目介绍，并按 1.6.3 的发布说明更新了 API Meter。

## Godot Game Workflow

Godot Game Workflow 是今天公开的 Agent Skill，面向 Godot 4.x 和 GDScript。它指导编码助手迭代已有游戏、搭出可玩的 2D 或 3D 场景、处理素材，并导出 macOS、Windows 和 Web 构建。入口是 `SKILL.md`，需要时再读 `references/` 和 `scripts/`。

安装可以用 git clone，也可以下 ZIP。README 的目录表写了 Codex、OpenCode、Cursor、DeepSeek Harness、ZCode Agent、Claude Code 和 VS Code Copilot 的技能目录和调用方式。装好之后，构建和运行游戏仍然要有匹配版本的 Godot 4 编辑器和导出模板；素材可以按需用 Aseprite、Tiled、Blender 或 FFmpeg。

无界面冒烟检查是 `scripts/godot-smoke.sh`：导入工程、启动主场景、默认跑 120 帧，发现引擎或脚本错误就失败。可以用 `GODOT_BIN` 指定本机的 Godot。仓库目前没有 release 或 tag。

介绍页：/Repositories/godot-game-workflow/

## API Meter 1.6.3

API Meter 发了 [1.6.3](https://github.com/GabrielMu2006/APIMeter/releases/tag/v1.6.3)，不是预发布，仍然要求 macOS 15 及以上。这一版修的是 Qoder 的组织资源包。

已分配共享资源包的团队，接口把额度写在 `cap` 而不是 `total`。解码器对不上字段，就把整个组织池丢掉了。个人积分用尽的团队，界面上只剩一个空池。1.6.3 把组织池按个人池同样映射：已用百分比、剩余积分和重置日期，菜单栏面板、仪表盘、桌面小组件和系统组件都会显示。

回归测试来自 2026-11-19 的一份真实团队响应，里面同时有用尽的个人池和正在使用的组织包。单元测试从 154 增到 155。

预构建包是 [API-Meter-1.6.3.dmg](https://github.com/GabrielMu2006/APIMeter/releases/download/v1.6.3/API-Meter-1.6.3.dmg)，面向 Apple Silicon。

介绍页：/Repositories/apimeter/

这两个仓库都没有单独的展示站，所以 /Links/ 没有新增条目。

**仓库。** [GabrielMu2006/godot-game-workflow](https://github.com/GabrielMu2006/godot-game-workflow) · [GabrielMu2006/APIMeter](https://github.com/GabrielMu2006/APIMeter)
