---
title: "WindowGarden（窗口花园）"
collection: Repositories
type: "macOS desktop widget"
permalink: /Repositories/windowgarden/
date: 2026-10-03
status: "Active"
link: "https://github.com/GabrielMu2006/WindowGarden"
---

WindowGarden（窗口花园）是一个 macOS 桌面陪伴应用：一个真正的 WidgetKit 系统小组件，在桌面上种一座随使用状态慢慢生长的手绘小花园。产品规格见 `SPEC.md`，插画生成记录与换装指南见 `ART_PROMPTS.md`，MIT 协议。

## 架构

- **菜单栏引擎**（`WindowGarden.app`，无 Dock 图标）：常驻后台，测量活跃时长、推进植物生长、记录离开与回归，并把变化推送给组件；它是花园唯一的计时器。
- **桌面组件**（`WindowGardenWidget`，WidgetKit 扩展）：在系统组件库里叫「窗口花园」，有小、中两个尺寸；住在桌面层，永远在所有窗口之下，不遮挡任何应用。它按系统调度的快照刷新（相位边界与生长 / 离开事件），没有逐帧动画，也没有常驻渲染。

## 使用与生长规则

- **生长**：持续使用电脑时植物缓慢生长——每累计约 8 活跃小时推进最幼的一株一个阶段，共 4 阶段，植物永不枯萎；引擎退出时花园静止，不倒退。
- **昼夜**：跟随本地时间（清晨 05:30 / 白天 08:00 / 黄昏 17:30 / 夜晚 19:30），夜晚有星星、萤火虫与会发光的月见草。
- **访客**：离开约 5 分钟后，组件里会出现小动物，回来后它们散去。
- 小尺寸自动展示最成熟的 3 株，中尺寸展示全部 6 株；菜单栏提供刷新组件、打开插画文件夹、开机自动启动等入口。

## 插画即接口

- 花园的所有图样都是普通 PNG 文件，**替换即生效**——这是产品的正式接口，无需改代码、无需重新构建：菜单栏打开插画文件夹（`~/Library/Application Support/WindowGarden/art/`），用同名 PNG 覆盖，等几秒自动生效，急的话点「刷新组件」。
- 命名与规格有明确约定：植物 `plant_<物种>_<1..4>.png`（6 物种 × 4 阶段，透明底、根部贴齐底边、竖构图），访客 `animal_<cat|bird|hedgehog>.png`（面朝左，程序按行走方向自动翻转），环境元素 `ambient_*.png` 共 7 个，另有可选的地面土带与菜单栏图标。
- 应用内置的同名插画只是首次启动的默认素材，复制到本地目录后不会再覆盖自定义文件；重置可删除 `state.json` 或整个目录；`swift scripts/check_art.swift` 能批量检查透明底、贴底对齐与白底残留；想用 AI 生成整套素材，`ART_PROMPTS.md` 内含全部提示词。

## 工程要点

- **构建安装**：`./scripts/make_app.sh --install` 构建、安装到 `/Applications` 并注册进系统组件库；要求 macOS 14+。组件库只收录标准位置的应用，放在项目 `build/` 目录里会搜索不到。
- README 记录了几条实测结论（macOS 26）：全局空闲查询（`CGEventSource.secondsSinceLastEventType`）不需要任何系统权限；组件扩展**必须沙盒化**才会被系统组件门禁收录，未沙盒的扩展被静默忽略；**SwiftPM 直接产出的组件扩展会被系统静默拒绝**，必须经 Xcode / xcodebuild 构建——仓库因此采用 `.xcodeproj` 加本地 SwiftPM 包的混合结构。
- 调试入口：`swift run GardenPreview` 离屏渲染各尺寸 × 各时段的预览图；`--growth-x` 可加速生长、`--debug` 输出心跳日志、`WG_STATE_DIR` 可隔离状态目录。

## 设计见解

**Insight.** 这个应用把「陪伴」做成了一件不需要盯着看的事：花园只在后台按活跃时长缓慢生长，永不枯萎，也没有逐帧动画和常驻渲染——它跟着系统调度的快照刷新，天然省电，也避开了「养成类应用反过来占用你时间」的常见陷阱。另一个好判断是把插画目录当成正式接口：换一套 PNG 就换了一整座花园，不用改代码也不用等新版本，自定义因此变成了产品能力，而不是一条待办需求。

## 现状与限制

- 仓库目前**没有发布安装包**，需要本地构建（`./scripts/make_app.sh --install`）；引擎需要保持运行花园才会生长。
- 应用内置插画由 GPT 生成，与代码同按 MIT 分发；许可见 `LICENSE`。

**Repository.** [GabrielMu2006/WindowGarden](https://github.com/GabrielMu2006/WindowGarden)
