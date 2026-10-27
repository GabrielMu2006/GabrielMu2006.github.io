---
title: "StreamSaver"
collection: Repositories
type: "macOS Safari extension"
permalink: /Repositories/streamsaver/
date: 2026-10-28
status: "Released"
link: "https://github.com/GabrielMu2006/StreamSaver"
---

StreamSaver 是一款 macOS Safari 视频下载工具：在 Safari 里播放网页视频后，点工具栏上的扩展图标就能识别视频资源（MP4 直链 / HLS / AES-128 加密 HLS），再调用本机 FFmpeg 无损下载、合并为本地 MP4 或 MKV。当前版本 `v1.0.0`，MIT。README 明确划了边界：只处理用户有合法访问权限的内容，不实现也不支持 DRM 破解或访问控制规避。

## 它能做什么

- **Safari 工具栏扩展（WebExtension MV3）**：一键扫描当前页面视频，列出类型 / 分辨率 / 时长，支持 iframe 内视频、多候选去重，也可以手动粘贴 M3U8 / MP4 直链。
- **多层检测**：`<video>` / `<source>` 元素 → 播放器 `data-*` 属性 → Performance Resource Timing（覆盖 HLS.js / DPlayer / Video.js 等动态加载的 m3u8 / mp4）→ Blob（MSE）视频提示。
- **下载引擎**：FFmpeg `-c copy` 无损转封装；HLS master 播放列表自动选最高清晰度；标准 AES-128 自动取密钥解密；完整保留 URL 查询参数（签名 token）。
- **真实进度与可靠性**：解析 FFmpeg `-progress` 输出显示百分比 / 速度 / 已下载 / 剩余时间；先写 `.part` 临时文件，ffprobe 校验完整性后才落地正式文件；403 / 404 / 网络中断 / 播放列表失效分类报错，MP4 容器不兼容时自动改用 MKV，失败可重试。
- **下载管理**：SwiftUI 主程序分「下载中 / 已完成 / 失败 / 历史 / 设置」，支持并发控制、完成通知、Finder 定位、同名自动重命名。
- **隐私**：视频地址与历史只存本机（`~/Library/Application Support/StreamSaver/`），不向第三方发送；日志不记录 Cookie 与密钥。

## 架构与关键决策

```text
Safari 扩展（popup / content script）
   → runtime.sendNativeMessage
   → SafariWebExtensionHandler（沙盒扩展进程）
   → POST http://127.0.0.1:47631/bridge（仅回环）
   → DownloadCoordinator → DownloadManager
   → FFmpeg / ffprobe（直接 exec，无 shell）
   → ~/Movies/StreamSaver/*.mp4
```

- **回环 HTTP 桥**：实测 macOS 26 的 Safari 不再为 `SafariWebExtensionHandler` 拉起 App（Handler 运行在沙盒化的扩展进程内），于是扩展与主 App 通过 `127.0.0.1:47631` 的本地 JSON 服务通信：主 App 用 `NWListener` 只绑定回环地址，沙盒扩展持 `network.client` 权限、ATS 放行回环，全程零 TCC 授权弹窗。README 还记录了两条被实测否决的替代方案——App Group 容器（对个人团队签名会触发 TCC 且授权不持久）与 `/tmp` 文件桥（沙盒扩展不可写）。
- **扩展必须沙盒**：pkd（PlugInKit 守护进程）会静默拒绝未沙盒的 Safari Web 扩展，没有任何日志；主 App 保持非沙盒，以便调用 Homebrew FFmpeg 并写入任意保存目录。
- **按需注入**：popup 打开时才注入检测脚本（`scripting.executeScript` + activeTab 授权），不申请 `<all_urls>` 全站权限。
- **Performance Resource Timing 是检测主力**：它跨内容脚本隔离世界共享页面资源时间线，动态 fetch 的 m3u8 全部可见，不必做侵入式的 fetch / XHR 钩子（Safari 隔离世界钩不到页面网络层）。

## 安装与测试

- 系统要求：macOS 13.0+、Safari 17+、FFmpeg（含 ffprobe）；构建需要 Xcode 15+ 与 xcodegen。
- 从 Releases 下载 `StreamSaver-1.0.0-macOS-arm64.zip`（仅 Apple Silicon，开发者签名但未公证，首次打开需右键「打开」）；安装 FFmpeg 后运行 `scripts/install.sh` 注册扩展，再到 Safari 设置里启用一次。
- 测试：`run_engine_tests.sh` 跑 8 个引擎端到端用例（自带本地 HLS 服务器，校验 Range / 206 与 token），`Tests/EngineRunner` 对 Swift 生产代码做 18 条断言并覆盖扩展桥接全链路，测试媒体由脚本本地生成。

## 已知限制

- 不转发浏览器 Cookie；不支持直播流与 DRM；Blob 视频依赖资源时间线匹配。
- 无开发者证书的 ad-hoc 构建，每次 Safari 重启后需要重新允许未签名扩展。
- 完整清单见仓库的 `docs/LIMITATIONS.md`，测试结果见 `docs/TEST_REPORT.md`。

## 设计见解

**Insight.** 这个仓库写得最有价值的不是功能列表，而是「为什么非这样不可」：README 把回环 HTTP 桥的由来、两条被实测否决的方案及否决原因都留在文档里，Safari 不再为 Handler 拉起 App、扩展必须沙盒这类平台细节也写成了可复现的结论。再加上不接受 DRM、不转发 Cookie 的明确边界，它更像一份 Safari 扩展的工程笔记，而不是一个下载器广告。

**Repository.** [GabrielMu2006/StreamSaver](https://github.com/GabrielMu2006/StreamSaver)
