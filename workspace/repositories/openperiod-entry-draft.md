# 待发布草稿：OpenPeriod 的 Repositories 条目

状态：**未发布**。仓库 `GabrielMu2006/openperiod` 目前仍是 private（匿名访问 <https://github.com/GabrielMu2006/openperiod> 返回 404），按 AGENTS.md 第 7 节需等仓库公开后再发布含仓库链接的条目。

用户已确认：介绍以**产品功能**为主，不写服务器拓扑、环境变量名、数据库迁移号等运维细节。

发布时把下面内容写入 `site/content/_Repositories/openperiod.md`，并在 `site/content/_Links/openperiod.md` 建对应站点条目，然后运行测试、构建、推送并核对线上页面。

---

```markdown
---
title: "OpenPeriod（课隙）"
collection: Repositories
type: "Web application"
permalink: /Repositories/openperiod/
date: 2026-09-21
status: "Released"
link: "https://github.com/GabrielMu2006/openperiod"
---

OpenPeriod（课隙）是一个响应式多人课表工具：每个人维护自己的课程与私人忙碌，加入群组后按各自学校、开学日和作息换算，算出真实钟点上的共同空闲。正式入口是 <https://openperiod.gabrielmu2006.cn>，当前版本 `0.3.0`。

## 核心能力

- 邮箱加密码登录；注册、老账号首次设置密码和找回密码时才发送邮箱验证码。
- 32 套学校 / 校区 / 季节作息预设，也支持每位用户自定义作息。
- 课表导入支持 Excel 行式与网格式解析（`.xlsx` / `.xls`），带导入预览与人工修正；导入按目标学校与学期隔离，确认时事务替换目标学期，并保留一份 7 天恢复点。
- 可选的智谱 AI 截图 / 文字识别，识别结果必须进入同一个预览页确认后才写入课表。
- 课程与上课时段管理、单周或批量标注「不去」、一次性或周期性的私人忙碌，以及「本学期无课」确认。
- 跨校共同空闲：按成员各自学校的开学日、教学周和作息换算到统一真实钟点轴；没有课表的成员不会被当成全天空闲。
- 三级隐私投影：仅忙闲 / 课程名称 / 完整课程；私人忙碌的标题只对本人可见。
- 群组支持创建、邀请码、退出、改名、移出成员、群主转让，以及可恢复的软归档。

## 技术栈

Next.js 16 App Router、React 19、TypeScript、PostgreSQL 17 与 Drizzle ORM；测试使用 Vitest、PGlite、Testing Library 与 jsdom；课表解析用 SheetJS 与 read-excel-file；密码用 Argon2id 哈希。

## 设计原则

**先确认再写入。** 无论 Excel 导入还是 AI 识别，结果都必须经过预览确认才落库；导入以事务替换目标学期，并保留 7 天恢复点。

**未知不等于空闲。** 共同空闲按真实钟点轴换算，没有课表的人不会被当作全天有空，避免把「不知道」算成「可以约」。

**隐私分级而不是全有全无。** 三级投影让使用者自己决定分享到哪一层，私人忙碌的标题始终只有本人可见。

**Insight.** 这个工具解决的不是「课表怎么排」，而是「不同学校、不同开学日、不同作息的人怎么找到共同的空档」——难点在于把各自的相对周次还原到同一条真实时间轴上。它对「未知课表」和「隐私投影」的处理比功能数量更能说明设计取向：宁可显示不确定，也不假装知道。

## 当前限制

- 学年与学期名称仍由代码中的单一默认学期定义，维护脚本只能更新该学期各学校的开学日、周数和时区。
- 学校预设解决的是作息换算，不代表能直接解析任意一所学校教务系统的导出格式。
- AI 识别会把截图或文字发送给第三方服务做解析；原图不落库，但供应商侧的数据处理受其服务条款约束。
- 群组没有永久删除入口，归档是可恢复状态；生产数据清理需要另行审阅和授权。
- 尚未接入 PKU IAAA，也不会收集学校门户密码。

**Repository.** [GabrielMu2006/openperiod](https://github.com/GabrielMu2006/openperiod)
```

对应的 Links 条目草稿（`site/content/_Links/openperiod.md`）：

```markdown
---
title: "课隙 · OpenPeriod"
collection: Links
type: "Web app"
permalink: /Links/openperiod/
date: 2026-09-21
status: "Active"
link: "https://openperiod.gabrielmu2006.cn/"
---

多人课表工具「课隙」的正式入口：维护自己的课程与私人忙碌，加入群组后按各自学校的开学日与作息换算，找出真实钟点上的共同空闲；支持 Excel 课表导入、可选 AI 识别、三级隐私投影与可恢复的群组归档。HTTP 访问会跳转到 HTTPS，源码见 [GabrielMu2006/openperiod](https://github.com/GabrielMu2006/openperiod)。
```
