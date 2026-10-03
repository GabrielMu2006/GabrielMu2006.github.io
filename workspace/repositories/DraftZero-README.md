# Draft Zero —— 无限草稿室

**面向独立创作者的桌面应用（macOS + Windows）：收纳未完成的想法，把它们归类成可继续推进的项目。**

把散落在各处的草稿、网页、GitHub 文件收进一个完全本机的工作区；离线语义模型自动找出"这些想法可能属于同一个项目"，每条建议都附原文证据，接受与否由你决定。无账号、无云端、无遥测。工作区可经 `.dzarchive` 档案在 Mac 与 Windows 之间双向迁移。

![线索台两栏](ui-acceptance/07-线索台-两栏.png)

## 功能

- **收纳**：拖入 TXT / Markdown / PDF，或粘贴网页与 GitHub 链接；导入逐项报告，重复有提示，原文件永不改动。PDF 支持应用内翻页预览（扫描版会标注「无可用于关联的文字」）。
- **本机归类建议**：离线 multilingual-e5-small 语义向量 + 字面线索 → 「同一项目线索」与「可能重复」两个待审队列，每条附能定位到原文的证据；接受 / 拒绝 / 暂缓由你决定，拒绝后不再重复打扰。
- **项目整理**：一稿多项目、待整理 / TODO / 进行中 / 基本完成 / 暂时封存、标签筛选、全文搜索。
- **版本与恢复**：编辑自动留版本（静默 60 秒结算），可对比、可恢复；拆分 / 合并保留双向来路。
- **双向迁移**：`.dzarchive` 档案（含草稿正文、版本、项目、PDF、你的裁决）在 Mac ↔ Windows 之间互相导入导出；仅向空工作区导入，先整体校验再原子写入。
- **桌面组件（仅 macOS）**：TODO 与最近项目常驻桌面，点项目行直达应用。

![加入项目弹层](ui-acceptance/09-线索台-加入项目弹层.png)

## 系统要求与安装

两个平台都在 [Releases](https://github.com/GabrielMu2006/DraftZero/releases) 下载，**均为未签名的预览版（Pre-release）**，首次运行需一步手动确认；请不要为此全局关闭系统保护。

**macOS**（Apple Silicon，macOS 26+，`DraftZero-v0.2.0-arm64.zip`）：

1. 解压，把 `DraftZero.app` 拖入「应用程序」；
2. 首次打开若被拦：右键点应用 →「打开」；仍被拦则到 **系统设置 → 隐私与安全性** 点「仍要打开」。

**Windows**（Windows 11 24H2+ x64，`DraftZero-Setup-v0.2.0-win-x64.exe`）：

1. 双击安装，SmartScreen 提示时点「更多信息 → 仍要运行」；每用户安装，无需管理员；
2. 全组件随包分发（自带 .NET runtime 与离线模型，约 274 MB），建立开始菜单与卸载入口，注册 `draftzero://` 协议；卸载保留 `%LocalAppData%\DraftZero\` 数据。

无自动更新；后续版本请回到 Releases 页手动下载，同版本升级会保留数据。建议下载后核对 `SHA256SUMS` 中的 SHA-256。

## 数据与备份

全部数据在本机，无账号无云：

```
macOS:    ~/Library/Application Support/DraftZero/   # SQLite 库（含 WAL）+ PDF 快照
Windows:  %LocalAppData%\DraftZero\                  # 同上
```

**完整备份 = 完全退出应用后整体拷贝该目录**；不要只拷单个 `.sqlite` 文件。恢复时原样拷回。

- **跨平台迁移用 `.dzarchive` 档案，不要直接拷贝 SQLite 文件**（两端库文件不通用）：设置页 → 导出当前工作区 / 导入工作区。
- 深链 `draftzero://` 的写入型操作必须经应用内确认弹窗，拒绝即零写入。
- 可选 DeepSeek 分析默认关闭；API Key 只存本机受保护存储（macOS 钥匙串 / Windows DPAPI）。

## 隐私

核心归类完全离线；可选的 DeepSeek 分析默认关闭，启用前界面会说明发送范围。详见 [PRIVACY.md](PRIVACY.md)。第三方组件与模型许可见 [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md)。

## 预览版质量口径（如实说明）

- 30 份**生成集**离线复测：Mac recall@5 = 21/21、prec@3 = 47/63；Windows recall@5 = 21/21、prec@3 = 46/63；两端同时达到既定门槛（≥80% / ≥70%）。**这是生成集结果，不代表真实资料保证**，独立真实素材的正式验收尚未进行，因此本版保持 Pre-release。
- **实现一致性**：两端分词与 Python 参考逐条一致；Windows fp32 推理与 Python 参考逐位吻合；Mac 为 int8 CoreML（量化噪声已记录，见发布说明）。
- Windows 实机安装 / 迁移 / 升级 / 卸载已于 2026-10 由产品所有者复核通过；**Narrator 朗读、DeepSeek 付费路径、Mac VoiceOver 仍未真人复核**（完整清单见发布说明）。

完整说明与已知限制见 [RELEASE-NOTES-v0.2.0.md](RELEASE-NOTES-v0.2.0.md)。

## 开发

```bash
# macOS（XcodeGen 便携版；Git LFS 需自装，113MB 模型权重走 LFS）
tools/xcodegen/bin/xcodegen generate
cd Core && swift test          # 核心测试
tools/release/build-release.sh # 发布构建（双构建对照 + 校验 + ZIP + SHA256）

# Windows（在 Windows 机上；仓库内便携 .NET SDK，锁定还原）
dotnet test Windows/tests/DraftZero.Core.Tests
# 发布安装器：tools/windows/freeze-transfer.sh <commit> 冻结传输 →
# 远程 tools/windows/build-windows.ps1（边界内构建 + ISCC 打包）
```

macOS 要求 Xcode 27（Swift 6.4）；Windows 构建链见 [V0.2.0-WINDOWS-PLAN.md](V0.2.0-WINDOWS-PLAN.md) 与 [release-closure/V0.2.0-WINDOWS-EVIDENCE.md](release-closure/V0.2.0-WINDOWS-EVIDENCE.md)。依赖以各工程锁文件为准；不要把本机构建缓存当作依赖来源（2026-09-29 曾发现 SwiftPM 缓存被伪造快照污染并已清除，见 `Core/Package.swift` 注释）。

产品与验收规格见 [SPEC.md](SPEC.md)；实施与验证记录见 [IMPLEMENTATION.md](IMPLEMENTATION.md) 与 [ACCEPTANCE.md](ACCEPTANCE.md)；UI 设计出处见 [design-concepts/](design-concepts/)。

## 许可与反馈

- 项目代码**暂未选择开源许可证**（由产品所有者另行决定），未经授权请勿二次分发；随包第三方组件按其原始许可分发（见上文声明）。
- 安装失败、启动崩溃、数据问题请开 [Issue](https://github.com/GabrielMu2006/DraftZero/issues)，附系统版本与复现步骤；数据丢失或误写类问题按最高优先级处理，修复以补丁版本发布，不暗换已发布资产。
