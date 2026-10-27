---
title: "API Meter"
collection: Repositories
type: "macOS app"
permalink: /Repositories/apimeter/
date: 2026-10-28
status: "Released"
link: "https://github.com/GabrielMu2006/APIMeter"
---

API Meter 是一款本地优先的 macOS 菜单栏应用，把 DeepSeek 官方数据（余额 API + 用量导出）和几个编码套餐的额度窗口，变成常驻桌面的用量仪表盘，服务需要随时掌握余额、花费与套餐余量的开发者。

## 当前版本

- 当前版本 `1.5.1`，要求 macOS 15 及以上，Swift 6 编写，MIT 协议；预构建 DMG 面向 Apple Silicon（ad-hoc 签名，首次打开需右键「打开」），Intel 机型需自行从源码构建（构建需要 Xcode 26+）。
- 菜单栏快捷面板：DeepSeek 余额与今日花费一行展示，ZCode / Kimi / Qoder 的套餐环带重置时间，点击进入完整仪表盘。
- 浮动仪表盘：DeepSeek / ZCode / Kimi / Qoder 四等分，筛选器旁显示时段统计，柱状图按天按 Key 悬停查看明细，支持每日历史、日详情与多选 Key 过滤。
- 编码套餐额度：ZCode（GLM Coding Plan）取 5 小时与每周窗口，复用官方 `glm-plan-usage` 插件同一个额度端点，刷新节流到每 5 分钟一次；Kimi 从 `~/.kimi-code` 凭据自动发现并自动续期（轮换后的 token 写回并校验血缘）；Qoder 从桌面端加密授权文件只读解析，含月度积分池与团队资源包。
- Codex（ChatGPT 套餐）额度：从 `~/.codex/auth.json` 自动发现 5 小时与每周限额窗口，token 自动续期；默认关闭的可选代理，用于 chatgpt.com 不可达的网络，探测失败时回退到 CLI 写进会话日志的限流值。
- 原生系统组件（WidgetKit）：可在桌面或通知中心添加 Coding Plan 环（中）与 DeepSeek 余额（小），数据跟随应用刷新周期；另有桌面级组件行，拖动可移动、点击打开仪表盘、右键操作（Option+W 切换）。
- 数字口径分层：已完成日期以官方导出为准（按天、模型、Key 使用替换语义，重复导入不会翻倍），「今日花费」由余额快照差值估算并识别充值；按 Key 的成本拆分来自导出的 `price x amount` 行并与账单总额交叉核对。
- 可选 DeepSeekSync：每天 00:30 自动下载并导入官方用量导出，错过时在启动或唤醒后补跑，也可以在应用内一键完成安装与登录。

## 设计原则

**本地优先。** 所有数据留在本机，不抓包、不读浏览器 Cookie、不做 HTTPS MITM；密钥只存 macOS Keychain（不同服务各自独立条目），数据库只存 SHA256 指纹，日志脱敏。

**数字要诚实。** 已完成日期的成本以官方导出为准；「今日花费」明确标注为余额差值估算，README 甚至记录了它何时会低估（充值发生在使用期间时会被余额跳变吸收）。

**Insight.** 最强的设计思路仍然是把「估算」与「权威数据」分层：实时信号永远只是带标签的估计，官方导出才是最终账本，两种口径的偏差写在文档里而不是藏起来。`1.4` 到 `1.5.1` 把这条原则扩展到了外部服务——每个套餐额度都注明来源（官方插件同款端点、本机凭据自动发现、或 CLI 会话日志回退），并在拿不到时明确降级而不是编一个数字。

**Repository.** [GabrielMu2006/APIMeter](https://github.com/GabrielMu2006/APIMeter)
