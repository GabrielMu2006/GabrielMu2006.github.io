---
title: "Loose Leaves 首发，API Meter 与 SpecForge 同日更新"
collection: Blogs
type: "Project sync"
permalink: /Blogs/project-sync-261114/
date: 2026-11-14
order: 9
status: "Published"
---

今天把三个仓库的近况写进网站：新增 Loose Leaves 的项目介绍，并按最新 README 和发布说明更新了 API Meter 与 SpecForge。

## Loose Leaves 1.1.0

Loose Leaves 是今天新建的 macOS 应用，用来记下和回看 vibe coding 的点子与作品。菜单栏浮窗、管理窗口和本机命令 `looseleaves` 读同一份资料，内容只留在这台 Mac 上。

同一天发了两个版本。v1.0.0 是首个公开包，面向 Apple 芯片、macOS 14 及以上，带菜单栏浮窗、管理窗口和本机命令，以及一个桌面小组件。v1.1.0 拿掉了桌面小组件，因此不再嵌入大约 7 天就会过期的描述文件。资料改到 `~/Library/Application Support/Loose Leaves/`；如果旧资料还在 App Group 目录里，第一次打开会复制过去。

安装包没有公证，签名是个人开发证书。本机第一次打开时，按住 Control 再选择「打开」。另一台 Mac 仍可能因为没有公证而拦截一次。

介绍页：/Repositories/loose-leaves/

## API Meter 1.6.2

API Meter 现在跟踪的不只是 DeepSeek。菜单栏、仪表盘和组件里还有 ZCode、Kimi、Qoder、Codex，以及这次加上的 Cursor。

- v1.6.0：Cursor Pro 账期里的已用百分比和重置日期。它从 Cursor 桌面端的本地状态只读读出，出现在菜单栏、仪表盘、两种组件和设置里。
- v1.6.1：中号系统组件不再写死 2×2。行数按套餐数量排布，五个编码套餐都会出现。需要 macOS 15 及以上。
- v1.6.2：Cursor 3.30 用 SafeStorage 加密了本地 token 之后，额度刷新会静默停住。这一版按 Qoder 同一套方式解开信封。更新后第一次刷新可能会要一次钥匙串权限，选「始终允许」。菜单栏会标出刷新失败，而不是停在一个旧数字上。

仓库里还加了 `scripts/sign-local.sh`。它用本机的 Apple Development 证书签名，免得每次重新构建都丢掉钥匙串里已经允许的授权。没有这张证书时，脚本保持原来的 ad-hoc 签名。

介绍页：/Repositories/apimeter/

## SpecForge 0.2.1

SpecForge 仍是把一句模糊想法整理成 `SPEC.md` 的 Agent skill。这一版处理「同一条请求里既要规格、又要实现」：先交出规格，再做用户明确要求、且没有未解决阻塞的实现。如果 V1 还有阻塞，规格可以是标明原因的 Draft，没有被挡住的工作可以继续。

维护者的结构检查接受需求上的显式退役标记。Codex 元数据打开了自动发现，发布校验会看这项设置。

介绍页：/Repositories/specforge/

这三个仓库都没有单独的展示站，所以 /Links/ 没有新增条目。

**仓库。** [GabrielMu2006/loose-leaves](https://github.com/GabrielMu2006/loose-leaves) · [GabrielMu2006/APIMeter](https://github.com/GabrielMu2006/APIMeter) · [GabrielMu2006/SpecForge](https://github.com/GabrielMu2006/SpecForge)
