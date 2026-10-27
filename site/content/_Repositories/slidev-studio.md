---
title: "Slidev Studio"
collection: Repositories
type: "Agent plugin"
permalink: /Repositories/slidev-studio/
date: 2026-10-28
status: "Released"
link: "https://github.com/GabrielMu2006/slidev-studio"
---

Slidev Studio 是给 Coding Agent 用的 Slidev 创作插件：分发单位是一个插件，里面包含两项 skill、本地工具和八套风格预设。`slidev` 负责 Slidev 创作、模板选择、交互与导出；`slidev-template-import` 负责从 PPT 提炼完整布局模板、验证、入库与复用。仓库里不存在名为 `slidev-studio` 的单项 skill。当前版本 `v0.4.0`。

## 八套预设

![八套风格预设的实际封面](/assets/images/repositories/slidev-studio/preset-covers.png)

| 预设 | 标识 | 适合的场景 |
| --- | --- | --- |
| 青蓝课堂 | `cyan-classroom` | 深色封面、白底内容、青蓝渐变标题，中文课程与教学 |
| 清简 | `minimal-light` | 暖白底、墨绿强调、叙事层级清晰，分享与产品讲解 |
| 纸上学术 | `academic-paper` | 纸色背景、深红标题、衬线风格，组会与论文报告 |
| 夜间技术 | `terminal-dark` | 深色画布、浅色代码、青绿强调，技术会议与代码演示 |
| 咨询蓝 | `consulting-blue` | 白底深蓝、左对齐封面、标题分隔线，业务汇报与决策建议 |
| 琥珀叙事 | `editorial-amber` | 奶油纸色、琥珀强调、编辑式留白，人文与案例叙事 |
| 蓝图实验 | `blueprint-lab` | 海军蓝网格、青色标注、等宽标题，架构与工程实验 |
| 玫瑰演讲 | `keynote-rose` | 浅玫瑰底、莓红大标题、舞台式留白，观点演讲与产品发布 |

从 PPT 提炼的完整布局模板包走独立模板库，数量不限，与这八套风格预设分开管理。

## 安装形态与验收

- **原生插件安装**会在宿主的插件管理器中登记 `slidev-studio`，由宿主管理启停与更新，再加载两项 skill；把两个文件夹复制到 skills 目录属于 **skills 兼容安装**，内容可用但没有完成原生插件注册。
- README 给出各宿主的专用路线：Claude Code、ZCode、DeepSeek Harness、Codex 优先原生插件；其他 agent 要先确认其实际插件格式，用户要求插件时不默默降级为兼容安装。
- **验证分三层**：A 插件已注册、启用且版本正确；B 两项 skill 可发现且来源为该插件；C 已安装副本的工具可运行并返回八套预设。仓库自带的 `verify_install.py` 只能证明文件与工具，不能单独证明 A。

## 环境与版本

- 工具需要 Python 3.9+；创建演示需要符合 Slidev CLI 要求的 Node（验证基线 Slidev 53.0.0 / Node ≥ 22.12.0）；DSH 原生适配器由宿主的 Node 运行时加载。
- 源 PPT 渲染可用 LibreOffice + Poppler 或宿主工具，CLI 导出需要 Chromium；仅提取 XML 的模板保持草稿状态，真实构建与视觉检查通过后才能标记为已验证。
- 插件、宿主清单、DSH bundle 与两项 skill 共用同一个 `VERSION`；用户模板库放在插件缓存之外，更新时不会被覆盖。

## 设计见解

**Insight.** 这个仓库最值得借鉴的是把「装好了没有」当成一个需要举证的说法：它区分原生插件注册与 skills 兼容安装，明确反对用「把 skill 复制过去」冒充插件安装成功，还把验收拆成 A/B/C 三层，并主动指出自带的 `verify_install.py` 只能证明第三层。对要分发给多种宿主的 agent 工具来说，这种把安装状态写成可核查断言的做法，比多写几行功能说明更有价值。

## 许可

MIT（`plugins/slidev-studio/LICENSE` 与 `NOTICE.md`）。README 声明它是独立项目，不是任何受支持宿主的官方插件。

**Repository.** [GabrielMu2006/slidev-studio](https://github.com/GabrielMu2006/slidev-studio)
