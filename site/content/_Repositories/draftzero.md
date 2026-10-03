---
title: "DraftZero（无限草稿室）"
collection: Repositories
type: "Desktop application"
permalink: /Repositories/draftzero/
date: 2026-10-03
status: "Pre-release"
link: "https://github.com/GabrielMu2006/DraftZero"
---

DraftZero（无限草稿室）是面向独立创作者的桌面应用（macOS + Windows）：把散落在各处的未完成草稿、网页与 GitHub 链接收进一个完全本机的工作区，再用离线语义模型提示「这些想法可能属于同一个项目」，每条建议都附原文证据，接受与否由本人决定。无账号、无云端、无遥测；工作区可经 `.dzarchive` 档案在 Mac 与 Windows 之间双向迁移。当前版本 `v0.2.0`，Releases 提供 macOS 与 Windows 安装包，均为未签名的预览版。

## 核心能力

- **收纳**：拖入 TXT / Markdown / PDF，或粘贴网页与 GitHub 链接；导入逐项报告，重复有提示，原文件永不改动。PDF 支持应用内翻页预览，扫描版会标注「无可用于关联的文字」。
- **本机归类建议**：离线 multilingual-e5-small 语义向量加字面线索，产出「同一项目线索」与「可能重复」两个待审队列，每条附能定位到原文的证据；接受 / 拒绝 / 暂缓由使用者决定，拒绝后不再重复打扰。
- **项目整理**：一稿可属多个项目；待整理 / TODO / 进行中 / 基本完成 / 暂时封存；标签筛选与全文搜索。
- **版本与恢复**：编辑自动留版本（静默 60 秒结算），可对比、可恢复；拆分与合并保留双向来路。
- **双向迁移**：`.dzarchive` 档案含草稿正文、版本、项目、PDF 与裁决，在 Mac ↔ Windows 之间互相导入导出；仅向空工作区导入，先整体校验再原子写入。
- **桌面组件（仅 macOS）**：TODO 与最近项目常驻桌面，点项目行直达应用。

## 数据与隐私

- 全部数据在本机（macOS 在 `~/Library/Application Support/DraftZero/`，Windows 在 `%LocalAppData%\DraftZero\`），无账号、无云端。
- 完整备份的做法是退出应用后整体拷贝该目录；跨平台迁移必须用 `.dzarchive`，不能直接拷 SQLite 文件，因为两端库文件不通用。
- 可选 DeepSeek 分析默认关闭，API Key 只存本机受保护存储（macOS 钥匙串 / Windows DPAPI）；`draftzero://` 深链的写入型操作必须经应用内确认弹窗，拒绝即零写入。

## 工程与验证

- macOS 侧要求 Xcode 27（Swift 6.4），113 MB 模型权重走 Git LFS；Windows 侧使用仓库内便携 .NET SDK 与锁定还原。
- 质量口径写在 README 里并标注了边界：30 份生成集离线复测中，Mac recall@5 = 21/21、prec@3 = 47/63，Windows recall@5 = 21/21、prec@3 = 46/63，两端都达到既定门槛（≥80% / ≥70%）；但这是生成集结果，独立真实素材的正式验收尚未进行，因此版本保持 Pre-release。
- 实现一致性：两端分词与 Python 参考逐条一致；Windows fp32 推理与 Python 参考逐位吻合；Mac 使用 int8 CoreML 并记录了量化噪声。
- 复核状态：Windows 实机安装 / 迁移 / 升级 / 卸载已于 2026-10 由产品所有者复核通过；Narrator 朗读、DeepSeek 付费路径与 Mac VoiceOver 仍未真人复核。
- 仓库保留了发布收口证据（`release-closure/`，含 v0.1.0 与 v0.2.0 证据、Windows 复核卡）、验收记录（`ACCEPTANCE.md`、`UI-ACCEPTANCE.md`）以及第三方许可（`docs/licenses/`）。

## 设计见解

**Insight.** 这个项目最有意思的取舍是把「自动整理」降级成「带证据的建议」：归类完全离线，每条建议都能定位回原文，接受与否由使用者决定，拒绝后不再打扰。它同时把诚实写进了发布流程——生成集指标明确标注不代表真实素材、未签名的预览版要求手动确认而不是让人关掉系统保护、尚未真人复核的项目逐条列出。对一个承诺无账号、无云端、无遥测的工具来说，把不确定性摆在明面上，本身就是隐私承诺的一部分。

## 许可

项目代码**暂未选择开源许可证**（README 说明由产品所有者另行决定），未经授权请勿二次分发；随包第三方组件按其原始许可分发，见 `THIRD-PARTY-NOTICES.md`。

**Repository.** [GabrielMu2006/DraftZero](https://github.com/GabrielMu2006/DraftZero)
