---
title: "API Meter"
collection: Repositories
type: "macOS app"
permalink: /Repositories/apimeter/
date: 2026-08-17
status: "Released"
link: "https://github.com/GabrielMu2006/APIMeter"
---

API Meter 是一款本地优先的 macOS 菜单栏应用，把 DeepSeek 官方数据（余额 API + 用量导出）变成常驻桌面的用量仪表盘，服务需要实时掌握 API 余额与花费的开发者。

## 当前版本

- 当前版本 `1.0.0`，要求 macOS 15 及以上，预构建 DMG 面向 Apple Silicon，Swift 编写，MIT 协议。
- 菜单栏快捷面板：余额、今日花费、7 天迷你趋势、用量最高的 API Key，一键打开完整仪表盘。
- 浮动仪表盘：余额/今日/周期花费/请求数/Token 数指标卡，7 天 / 30 天 / 本月 / 自定义区间，柱状图支持按天按 Key 悬停查看明细。
- 按 Key 的成本拆分来自官方导出的 `price x amount` 行，并与账单总额交叉核对；导入采用替换语义，重复导入不会翻倍计数。
- 今日花费由余额快照差值估算（昨日基线减今日余额，充值被识别并忽略），官方导出对已完结日期保持权威。
- 可选 DeepSeekSync 模块：每天 00:30 自动下载官方用量导出并导入，错过时在下次启动/唤醒补跑。
- 附加功能：余额告警（防骚扰）、登录自启、Dock 图标开关、全局快捷键（默认 Option+Space）、迷你模式、深浅色、macOS 26 Liquid Glass 按钮。

## 设计原则

**本地优先。** 所有数据留在本机，不抓包、不读浏览器 Cookie、不做 HTTPS MITM；API Key 只存 macOS Keychain，数据库仅存 SHA256 指纹，日志脱敏（`sk-***`）。

**数字要诚实。** 已完成日期的成本以官方导出为准；"今日花费"明确标注为余额差值估算，README 甚至记录了它何时会低估（充值发生在使用期间时会被余额跳变吸收）。

**Insight.** 最强的设计思路是把"估算"与"权威数据"分层：实时信号永远只是带标签的估计，官方导出才是最终账本，并且两种口径的偏差被明确写进文档而不是藏起来。

**Repository.** [GabrielMu2006/APIMeter](https://github.com/GabrielMu2006/APIMeter)
