---
title: "PaperPulse"
collection: Repositories
type: "Apple app"
permalink: /Repositories/paperpulse/
date: 2026-07-12
status: "Released"
link: "https://github.com/GabrielMu2006/PaperPulse"
---

PaperPulse 是一款面向科研工作流的 Apple 平台论文发现、阅读与管理工具。它从“订阅一条研究方向”开始，将学术检索、权威性筛选、开放获取 PDF、本地资料库与 AI 解读连接成一条可控、可追溯的阅读流程。

它希望解决的不是“如何更快生成一段摘要”，而是科研阅读中更基础的问题：如何稳定发现值得读的论文，明确来源与筛选依据，并把真正需要留下的内容沉淀为可长期使用的本地资料库。

## 当前版本

macOS `V0.1.0` 已发布，支持 Apple silicon Mac，最低系统版本为 macOS 14。

- 为每个研究方向创建独立订阅，配置 arXiv 分类、关键词、排除词与学术来源。
- 手动触发单个订阅的论文推送，避免无感打扰与不可控的自动抓取。
- 聚合 arXiv、OpenAlex、Crossref 等学术来源，并按规则进行权威性筛选。
- 仅下载可公开访问的 PDF，不绕过登录、订阅或付费墙。
- 以 DOI、arXiv ID 与标题等信息去重；同一论文可归入多个订阅，但本地论文数据与 PDF 只保存一份。
- 提供按订阅分组的本地资料库、搜索、收藏与未归类论文清理。
- 支持论文短简介，以及基于 PDF 的异步完整解读。
- 在桌面端以 PDF 与完整解读并排阅读，并记住用户调整后的阅读比例。
- 支持中文、英文界面切换；界面语言与论文简介语言可独立设置。
- 支持 OpenAI-compatible、Anthropic、Gemini 与自定义模型服务配置；API Key 保存在系统 Keychain，本地资料库、PDF 与解读文件保存在设备本机。

## 设计原则

**先可靠，再智能。** PaperPulse 优先使用可验证的学术数据源与确定性规则完成检索、合并、去重、筛选和开放获取判断；LLM 用于帮助理解论文，而不是替代来源判断。

**本地优先。** 论文库、PDF、收藏、解读与模型配置均由用户设备掌控。macOS 与 iOS 分别维护独立的本地数据和 Keychain 配置，当前不进行隐式同步。

**尊重访问边界。** PaperPulse 只处理能够公开访问的论文与 PDF，不试图绕过付费墙、机构订阅或登录限制。

**用户自带模型。** 应用不绑定单一模型服务。用户可以选择自己的模型提供商、Base URL、模型名称与能力设置，并由自己管理相关 API 凭据。

## 后续规划

- 完善 iOS 端的独立阅读与资料库体验，并保持与 macOS 相同的核心检索与阅读原则。
- 扩展更多学术来源与开放获取验证能力，例如 Semantic Scholar、Unpaywall 等。
- 提升多来源结果合并、作者、机构、期刊会议筛选与排序的可解释性。
- 持续优化长论文 PDF 解析、完整解读质量、页码锚点与阅读交互。
- 为需要定期更新的用户探索更可靠的后台刷新与可选调度方案，同时保持用户对触发频率和数据流的控制。
- 完善 macOS 分发签名、公证与跨设备使用体验。

**Repository.** [GabrielMu2006/PaperPulse](https://github.com/GabrielMu2006/PaperPulse)
