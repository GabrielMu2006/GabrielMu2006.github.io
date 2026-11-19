---
title: "API Meter"
collection: Repositories
type: "macOS app"
permalink: /Repositories/apimeter/
date: 2026-10-28
status: "Released"
link: "https://github.com/GabrielMu2006/APIMeter"
---

API Meter 是一款本地优先的 macOS 菜单栏应用，把 DeepSeek 官方数据（余额 API + 用量导出）和几家编码套餐的额度，放进常驻桌面的用量仪表盘。套餐目前包括 ZCode、Kimi、Qoder、Codex 和 Cursor，服务需要随时掌握余额、花费与套餐余量的开发者。

## 当前版本

- 当前版本 `1.6.3`，要求 macOS 15 及以上，Swift 6 编写，MIT 协议；预构建 DMG 面向 Apple Silicon（ad-hoc 签名，首次打开需右键「打开」），Intel 机型需自行从源码构建（构建需要 Xcode 26+）。发布页：[API Meter 1.6.3](https://github.com/GabrielMu2006/APIMeter/releases/tag/v1.6.3)，安装包：[API-Meter-1.6.3.dmg](https://github.com/GabrielMu2006/APIMeter/releases/download/v1.6.3/API-Meter-1.6.3.dmg)。
- 菜单栏快捷面板：DeepSeek 余额与今日花费一行展示，各套餐窗口带重置时间，点击进入完整仪表盘。Cursor 显示的是账期已用百分比和重置日期；刷新失败时菜单栏会标出错误，悬停可以看到原因，而不是停在一个旧数字上。
- 浮动仪表盘：DeepSeek 用量和各套餐额度放在同一张面板里。1.6.0 把最小宽度放到 1080，以放下 DeepSeek、ZCode、Kimi、Qoder、Codex、Cursor 六列。筛选器旁显示时段统计，柱状图按天按 Key 悬停查看明细，支持每日历史、日详情与多选 Key 过滤。
- 编码套餐额度：ZCode（GLM Coding Plan）取 5 小时与每周窗口，复用官方 `glm-plan-usage` 插件同一个额度端点，刷新节流到每 5 分钟一次；Kimi 从 `~/.kimi-code` 凭据自动发现并自动续期（轮换后的 token 写回并校验血缘）；Qoder 从桌面端加密授权文件只读解析，个人月度积分池与团队组织资源包分开映射。
- Qoder 组织资源包（1.6.3）：已分配共享资源包的团队，接口把额度放在 `cap` 而不是 `total`。1.6.3 之前解码器会整段丢掉这个池，个人积分用尽时界面上只剩一个空池。这一版把组织池按个人池同样映射：已用百分比、剩余积分和重置日期，出现在菜单栏面板、仪表盘、桌面小组件和系统组件里。回归测试用的是 2026-11-19 的一份真实团队响应（个人池已用尽，组织包正在使用）。发布说明记了 155 个单元测试（此前 154）。
- Codex（ChatGPT 套餐）额度：从 `~/.codex/auth.json` 自动发现 5 小时与每周限额窗口，token 自动续期；默认关闭的可选代理，用于 chatgpt.com 不可达的网络，探测失败时回退到 CLI 写进会话日志的限流值。
- Cursor 额度：账期已用百分比和重置日期，从 Cursor 桌面端的本地状态数据库只读读出（`~/Library/Application Support/Cursor/User/globalStorage/state.vscdb`）。用量端点是 api2.cursor.sh 上仪表盘自己的 RPC，不是官方文档里的 API。token 大约两个月，每次打开 Cursor 会自己轮换。Cursor 3.30 起用 Chromium SafeStorage 加密这份 token；1.6.2 按 Qoder 同一套方式解开信封，每次启动最多提示一次钥匙串，选「始终允许」即可。
- 原生系统组件（WidgetKit）：可在桌面或通知中心添加 Coding Plan 环与 DeepSeek 余额（小）。1.6.1 起中号组件不再写死 2×2，按行排布，五个编码套餐（含 Cursor）都会出现。另有桌面级组件行，拖动可移动、点击打开仪表盘、右键操作（Option+W 切换）。Cursor 的账期用量同时出现在这两种组件和设置里。
- 重复构建时可以用 `scripts/sign-local.sh` 给 `API Meter.app` 签上本机的 Apple Development 证书。ad-hoc 签名每次构建身份都会变，钥匙串里「始终允许」的授权会失效；机器上没有这张证书时，脚本不做任何事，包保持 ad-hoc 签名。
- 数字口径分层：已完成日期以官方导出为准（按天、模型、Key 使用替换语义，重复导入不会翻倍），「今日花费」由余额快照差值估算并识别充值；按 Key 的成本拆分来自导出的 `price x amount` 行并与账单总额交叉核对。
- 可选 DeepSeekSync：每天 00:30 自动下载并导入官方用量导出，错过时在启动或唤醒后补跑，也可以在应用内一键完成安装与登录。

## 设计原则

**本地优先。** 所有数据留在本机，不抓包、不读浏览器 Cookie、不做 HTTPS MITM；密钥只存 macOS Keychain（不同服务各自独立条目），数据库只存 SHA256 指纹，日志脱敏。

**数字要诚实。** 已完成日期的成本以官方导出为准；「今日花费」明确标注为余额差值估算，README 甚至记录了它何时会低估（充值发生在使用期间时会被余额跳变吸收）。

**Insight.** 最强的设计思路仍然是把「估算」与「权威数据」分层：实时信号永远只是带标签的估计，官方导出才是最终账本，两种口径的偏差写在文档里而不是藏起来。后来的版本把这条原则扩展到了外部服务——每个套餐额度都注明来源（官方插件同款端点、本机凭据自动发现、或 CLI 会话日志回退），并在拿不到时明确降级而不是编一个数字。Cursor 也沿用只读本机状态：1.6.2 在 Cursor 3.30 改用 SafeStorage 之后补上解密，刷新失败会标出来，而不是让百分比停在上次的值上。Qoder 组织资源包同样不编一个空池：1.6.3 承认接口用 `cap` 而不是 `total` 表示额度，把组织池映射出来。

**Repository.** [GabrielMu2006/APIMeter](https://github.com/GabrielMu2006/APIMeter)
