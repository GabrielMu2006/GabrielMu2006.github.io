---
title: "PaperPulse Academic"
collection: Repositories
type: "Obsidian theme"
permalink: /Repositories/paperpulse-academic-theme/
date: 2026-08-16
status: "Released"
link: "https://github.com/GabrielMu2006/paperpulse-academic-theme"
---

PaperPulse Academic 是一个完整的 Obsidian 主题，把 PaperPulse macOS 端的视觉语言带入学术笔记场景，服务需要长时间专注阅读、科研与写作的用户。

## 当前版本

- 当前版本 `1.0.0`，要求 Obsidian 1.13.6 及以上，macOS 桌面端为主要验证环境，纯 CSS 实现，MIT 协议。
- 深色模式：近黑的科研外壳搭配海军蓝与茄紫层次，饱和脉冲色只用于身份、选择、焦点与进度，不压在长文背景上。
- 浅色模式：暖白与羊皮纸色表面配酒红/梅紫文字，独立设计而非深色模式反色生成。
- 覆盖侧栏、标签页、ribbon、菜单、命令面板、弹窗、通知、设置、表单、Properties、Bases、Canvas 与 Graph。
- 支持用户 Accent Color、可选 Style Settings 控制（玻璃强度、纸张温度、强调强度、圆角、阴影、界面密度），但 Style Settings 不是依赖。
- 纯 CSS：无 JavaScript、无网络请求、无远程字体/图片、无遥测，不读取或修改笔记。

## 设计原则

**为长文阅读设计。** 低饱和度的编辑与阅读平面以持续工作为目标；明暗两套色彩层次分别调校，浅色模式按纸张阅读体验独立设计。

**可访问性优先。** 交互状态不单靠颜色区分，提供 reduced-motion、reduced-transparency、increased-contrast、forced-colors 与打印回退。

**与 Academic Dashboard 的契约。** 通过公开的 `--academic-dashboard-*` 自定义属性为独立插件提供皮肤，集成只作用于 `.academic-dashboard-view`，不依赖插件的组件类名或 DOM 结构；插件缺席时主题功能不受影响。

**Insight.** 把"主题"当作公共视觉契约而不是一次性皮肤：主题作者与插件作者通过文档化的 CSS 变量协作，双方各自独立演化，这比深层耦合的配套主题更可持续。

**Repository.** [GabrielMu2006/paperpulse-academic-theme](https://github.com/GabrielMu2006/paperpulse-academic-theme)
