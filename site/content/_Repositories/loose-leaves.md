---
title: "Loose Leaves"
collection: Repositories
type: "macOS app"
permalink: /Repositories/loose-leaves/
date: 2026-11-14
status: "Released"
link: "https://github.com/GabrielMu2006/loose-leaves"
---

Loose Leaves 是一款记下和回看 vibe coding 点子与作品的 macOS 应用。菜单栏浮窗、管理窗口和本机命令 `looseleaves` 读同一份资料，内容只留在这台 Mac 上。当前版本 `1.1.0`，面向 Apple 芯片、macOS 14 及以上。

## 界面

![菜单栏浮窗：点子按时间排列，右侧是星级或「未评分」](/assets/images/repositories/loose-leaves/menu-bar-ideas.png)

![作品详情：链接是可选中文字，「打开链接」是单独按钮，截图留在本机](/assets/images/repositories/loose-leaves/menu-bar-work.png)

上面两张图来自仓库 `docs/evidence/`，是应用把 SwiftUI 视图画进离屏窗口后导出的，不是桌面录屏，画面里的条目是样例资料。样例列表里有一条提到桌面小组件；那是 1.0.0 的文案，1.1.0 已经拿掉小组件。

- 菜单栏浮窗宽 360、高 540。可以在「点子 / 作品」和「时间 / 星级」之间切换。列表只排标题和星级，未评分写「未评分」。
- 管理窗口默认 980×680，侧栏是「概览」「待做点子」「作品」「已完成」。概览按纸本、墨夜、叶序三种外观计数；点子和作品页是列表加详情。
- 点进详情不会打开浏览器。地址是可选中文字，「打开链接」是单独的按钮。浮窗里的截图要到管理窗口更换。

## 点子、作品和命令

- 点子要有标题和正文，星级可选，范围 1–5。作品要有标题，以及 `http://` 或 `https://` 链接，本机地址也可以。
- 每个点子最多关联一件作品，一件作品可以对应多个点子。关联成功后，点子变成已完成，离开菜单栏的「点子」列表，仍可在管理窗口的「已完成」里回看。
- 删除作品会解除所有指向它的关联，那些点子恢复未完成。删除点子会保留作品。命令删除必须带 `--yes`。
- 截图支持 PNG、JPEG、GIF、TIFF、HEIC、WebP，最大 40MB。命令把图片复制进资料库，之后可以删掉原始文件。
- 命令在应用包里：`"/Applications/Loose Leaves.app/Contents/MacOS/looseleaves" help`。也可以链到 `~/.local/bin/looseleaves`。查找、添加、修改、截图、关联和删除的例子写在 `docs/AGENT.md`。

## 资料与安装

```text
~/Library/Application Support/Loose Leaves/
```

`library.json` 是点子和作品，`browse.json` 是菜单栏的类别与排序，`Attachments` 是已经复制进来的截图。不要手改 `library.json`。`looseleaves path` 会打印实际目录。如果以前的资料还在 App Group 目录里，第一次启动会把它复制过来。

下载 [Loose Leaves 1.1.0](https://github.com/GabrielMu2006/loose-leaves/releases/tag/v1.1.0)，解压 `LooseLeaves-1.1.0-macOS-arm64.zip`，把 `Loose Leaves.app` 放进「应用程序」。从源码构建需要 Xcode 15 或更新版本，以及 XcodeGen，然后运行 `./scripts/build.sh`。克隆后如果签名失败，要在 Xcode 里改成自己的开发团队。

## 版本与签名

v1.0.0 是同一天的首个公开包，当时还带中号和大号桌面小组件。v1.1.0 拿掉了小组件，因此不再嵌入大约 7 天就会过期的描述文件，本机不用每周重新构建。

当前签名是个人开发团队的 Apple Development 证书，不是 Developer ID，也没有公证。本机第一次打开时，按住 Control 再选择「打开」。另一台 Mac 仍可能因为没有公证而拦截一次。

## 设计见解

**Insight.** 视觉方向是「书桌散页」：纸色底、衬线标题、墨色选中、琥珀星级。列表只留标题和星级，正文、备注、链接和截图都放在详情里，所以菜单栏可以扫一眼，而不会把一条点子摊成一张卡片。另一个收束是 1.1.0 拿掉桌面小组件：少一个 7 天描述文件，换来一份不必每周重建的本机资料。

**Repository.** [GabrielMu2006/loose-leaves](https://github.com/GabrielMu2006/loose-leaves)
