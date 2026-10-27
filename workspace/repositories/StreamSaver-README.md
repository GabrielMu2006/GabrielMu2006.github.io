# StreamSaver

一款 macOS Safari 视频下载工具：在 Safari 中播放网页视频后，点击工具栏扩展图标即可识别视频资源（MP4 直链 / HLS / AES-128 加密 HLS），并调用本机 FFmpeg 无损下载合并为本地 MP4/MKV 文件。

> 仅用于处理用户有合法访问权限的内容。本项目不实现、也不支持 DRM 破解或访问控制规避。

## 下载安装（推荐）

从 [Releases](https://github.com/GabrielMu2006/StreamSaver/releases) 下载 `StreamSaver-x.x.x-macOS-arm64.zip`：

1. 解压并将 `StreamSaver.app` 拖入「应用程序」
2. 安装 FFmpeg：`brew install ffmpeg`
3. 运行 `scripts/install.sh`（或手动：右键 App → 打开 → 运行后按 [docs/INSTALL.md](docs/INSTALL.md) 注册扩展）
4. 在 Safari 设置 → 扩展中启用「StreamSaver Extension」

> Release 包为开发者签名（未公证）：首次打开需右键 →「打开」，或在
> 系统设置 → 隐私与安全性 中点「仍要打开」。仅支持 Apple Silicon（arm64）。

## 从源码构建

```bash
brew install xcodegen ffmpeg
./scripts/build.sh      # 生成 build/StreamSaver.app（Release）
./scripts/install.sh    # 安装到 /Applications 并注册扩展
```

> `project.yml` 中的 `DEVELOPMENT_TEAM` 需替换为你自己的 Team ID
> （Xcode 登录 Apple ID 后可见）。若无开发者证书，可改为 ad-hoc 签名
> （`CODE_SIGN_IDENTITY: "-"` + 移除 DEVELOPMENT_TEAM），但需在 Safari
> 「开发者」设置中每次手动允许未签名扩展，见 docs/INSTALL.md。

## 功能特性

- **Safari 工具栏扩展**（WebExtension MV3）：一键扫描当前页面视频，列出类型 / 分辨率 / 时长，支持 iframe 内视频、多候选去重、手动粘贴 URL 下载
- **多层视频检测**：`<video>/<source>` 元素 → 播放器 data-* 属性 → Performance Resource Timing（覆盖 HLS.js / DPlayer / Video.js 等动态加载的 m3u8/mp4）→ Blob（MSE）视频提示
- **下载引擎**：FFmpeg `-c copy` 无损转封装；HLS master 播放列表自动选最高清晰度；标准 AES-128 自动取密钥解密；完整保留 URL 查询参数（签名 token）
- **真实进度**：解析 FFmpeg `-progress` 输出，显示百分比 / 速度 / 已下载 / 剩余时间（无任何模拟进度）
- **可靠性**：.part 临时文件 + ffprobe 完整性校验后才落地正式文件；403/404/网络中断/播放列表失效分类报错；MP4 容器不兼容自动改用 MKV；失败可重试
- **下载管理**：SwiftUI 主程序（下载中 / 已完成 / 失败 / 历史 / 设置）、并发控制、完成通知、Finder 定位、同名自动重命名、历史清除
- **隐私**：视频地址与历史仅存本机（`~/Library/Application Support/StreamSaver/`），不向第三方发送数据；日志不记录 Cookie / 密钥

## 系统要求

| 组件 | 要求 |
|---|---|
| macOS | 13.0+（开发验证环境：macOS 26.6.2, Apple Silicon） |
| Safari | 17+（验证环境：Safari 26.6.2） |
| FFmpeg | 任意近期版本，含 ffprobe（验证环境：FFmpeg 9.0.2） |
| 构建 | Xcode 15+、[xcodegen](https://github.com/yonaskolb/XcodeGen) |

## 快速开始

```bash
# 1. 安装 FFmpeg（已安装可跳过）
brew install ffmpeg

# 2. 构建
brew install xcodegen        # 首次需要
./scripts/build.sh           # 产物: build/StreamSaver.app

# 3. 安装并注册扩展
./scripts/install.sh         # 复制到 /Applications 并注册到 Safari
```

然后在 Safari 中启用扩展（**仅需一次**，详细图文见 [docs/INSTALL.md](docs/INSTALL.md)）：

1. 重启 Safari
2. Safari 设置（⌘,）→「扩展」→ 勾选启用 **StreamSaver Extension**
3. 打开视频页播放几秒 → 点击工具栏 StreamSaver 图标 → 选择视频 → 「下载」

> 构建需要 Xcode 登录过 Apple ID（免费账号即可，用于 Apple Development 证书签名，
> Team ID 在 `project.yml` 的 `DEVELOPMENT_TEAM` 配置）。无证书的 ad-hoc 构建也可运行，
> 但需要在 Safari「开发者」设置中每次手动允许未签名扩展，见 docs/INSTALL.md。

## 使用方式

- **扩展 Popup**：显示当前页面标题、检测到的视频列表（类型徽章 / 分辨率 / 时长 / 来源），点击「下载」即交给本机 App；右上角 ⟳ 重新扫描；下方手动粘贴 M3U8/MP4 直链
- **主程序**：菜单栏 ⬇︎ 图标或 Dock 打开；左侧分栏「下载中 / 已完成 / 失败 / 历史 / 设置」
- **设置**：下载目录（默认 `~/Movies/StreamSaver/`）、输出格式（MP4/MKV）、并发数（1-5）、完成通知、FFmpeg 路径、Referer 开关

## 架构

```
Safari (JS: popup/content script)
   │  browser.runtime.sendNativeMessage("com.streamsaver.StreamSaver")
   ▼
SafariWebExtensionHandler（运行在沙盒化的扩展进程内，macOS 26 实测）
   │  POST http://127.0.0.1:47631/bridge（JSON 进 / JSON 出，Shared/Bridge.swift）
   ▼
LoopbackServer（主 App：NWListener 仅绑定回环地址）
   ▼
DownloadCoordinator → DownloadManager（任务队列/状态机/历史）
   │  Process(直接 exec，无 shell，无注入风险)
   ▼
FFmpeg / ffprobe（-c copy、AES-128 解密、进度解析、完整性校验）
   │
   ▼ ~/Movies/StreamSaver/*.mp4
```

关键设计决策（为什么这样做）：

- **回环 HTTP 桥**：实测发现 macOS 26 的 Safari 不再把包含 App 拉起执行
  `SafariWebExtensionHandler`（Handler 运行在沙盒化扩展进程内）。扩展与主 App
  之间经 `127.0.0.1:47631` 的本地 JSON 服务通信：主 App 用 NWListener 仅绑定
  回环地址；沙盒扩展持 network.client 权限、ATS 放行回环，全程零 TCC 授权弹窗。
  （曾先后试验 App Group 容器与 /tmp 文件桥：前者在 macOS 26 对个人团队签名
  触发 TCC 且授权不持久；后者对沙盒扩展不可写，均被实测否决。）
- **扩展必须沙盒**：实测发现 macOS 的 pkd（PlugInKit 守护进程）会**静默拒绝未沙盒的
  Safari Web 扩展**（无任何日志）。扩展目标带 `com.apple.security.app-sandbox`；
  主 App 保持非沙盒以自由调用 Homebrew FFmpeg 与写任意保存目录。
- **常驻方式**：安装脚本注册 LaunchAgent 登录自启；主 App 常驻时下载随时可用，
  手动退出后下次登录自动恢复。
- **扩展必须沙盒**：实测发现 macOS 的 pkd（PlugInKit 守护进程）会**静默拒绝未沙盒的 Safari Web 扩展**（无任何日志）。本项目扩展目标带 `com.apple.security.app-sandbox` entitlement；主 App 保持非沙盒以自由调用 Homebrew FFmpeg 与写任意保存目录。
- **on-demand 注入**：popup 打开时才注入检测脚本（`scripting.executeScript` + activeTab 授权），无需申请 `<all_urls>` 全站权限，权限最小化。
- **Performance Resource Timing 是检测主力**：它跨内容脚本隔离世界共享页面资源时间线，HLS.js/DPlayer 动态 fetch 的 m3u8 全部可见，无需侵入式 fetch/XLR 钩子（Safari 隔离世界钩不到页面网络层）。

## 目录结构

```
StreamSaver/
├── project.yml                    # xcodegen 工程定义
├── StreamSaver.xcodeproj          # 生成的 Xcode 工程（可提交、可直接打开）
├── StreamSaver/                   # 主 App（Swift/SwiftUI）
│   ├── App/AppDelegate.swift      # 菜单栏 + 窗口生命周期
│   ├── Views/                     # RootView / TaskViews / SettingsView
│   ├── Models/DownloadTask.swift
│   ├── Services/                  # 设置 / 历史 / 通知 / 文件名清洗
│   └── DownloadManager/           # 协调器 / 管理器 / FFmpegService
├── StreamSaver Extension/         # Safari Web Extension
│   ├── SafariWebExtensionHandler.swift
│   └── Resources/                 # manifest.json / popup / content / background / 图标
├── Shared/MessageProtocol.swift   # 扩展 ↔ 原生消息协议（两端共用）
├── Tests/
│   ├── run_engine_tests.sh        # FFmpeg 引擎端到端测试（8 用例）
│   ├── EngineRunner/main.swift    # Swift 生产代码集成测试（18 断言）
│   ├── hls_server.py              # 本地 HLS 测试服务器（Range/206、token 校验）
│   └── fixtures/                  # 本地生成的测试媒体（脚本生成）
├── scripts/                       # build.sh / install.sh / make_fixtures.sh
└── docs/                          # 安装 / 测试报告 / 限制清单
```

## 开发与测试

```bash
./scripts/make_fixtures.sh         # 生成本地 HLS/AES-128 测试媒体
./Tests/run_engine_tests.sh        # 引擎端到端测试（自动起本地服务器）
swiftc -o /tmp/ss_engine_test \
  Shared/MessageProtocol.swift \
  StreamSaver/Models/DownloadTask.swift \
  StreamSaver/Services/*.swift \
  StreamSaver/DownloadManager/*.swift \
  "StreamSaver Extension/SafariWebExtensionHandler.swift" \
  Tests/EngineRunner/main.swift
/tmp/ss_engine_test                # Swift 生产代码集成测试（含扩展桥接全链路）
```

测试内容与结果详见 [docs/TEST_REPORT.md](docs/TEST_REPORT.md)。

## 已知限制

见 [docs/LIMITATIONS.md](docs/LIMITATIONS.md)。要点：不转发浏览器 Cookie；不支持直播流与 DRM；Blob 视频依赖资源时间线匹配；「允许未签名的扩展」在 Safari 重启后需重新勾选（无开发者证书环境固有限制）。

## License

[MIT](LICENSE)
