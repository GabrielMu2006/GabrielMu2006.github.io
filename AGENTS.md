# Personal Website Management Guide / 个人网页管理说明

本文件是本仓库唯一且完整的 Agent 管理说明。任何 Agent 开始工作前都必须完整阅读本文件。中文与英文部分内容一致，英文部分仅为中文部分的翻译；修改规则时必须同时更新两种语言。

This file is the single, complete agent management guide for this repository. Every agent must read it in full before starting work. The Chinese and English sections contain the same rules, and the English section is only a translation of the Chinese section. Any rule change must update both languages together.

---

# 中文

## 1. 网站概况

这是 Muzhi Li 的 Jekyll 个人网站，采用 AcademicPages/Minimal Mistakes 的内容结构和定制深色样式。

- 本地仓库：`/Users/gabrielmu/Documents/个人网页`
- GitHub 仓库：`GabrielMu2006/GabrielMu2006.github.io`
- 部署分支：`main`
- 正式域名：`https://gabrielmu2006.cn`
- GitHub Pages 地址：`https://gabrielmu2006.github.io`，会跳转到正式域名
- 托管服务：GitHub Pages
- 自定义域名声明：`site/CNAME`；GitHub Pages 设置中的自定义域名为实际生效配置

主要公开页面：

- `/`：主页，由 `site/_pages/about.md` 提供
- `/Notes/`：课程和学习笔记
- `/Repositories/`：GitHub 项目介绍
- `/Blogs/`：博客
- `/Links/`：链接
- `/Guestbook/`：留言板

主要文件：

- `site/_config.yml`：站点、作者、collections、Guestbook、访问量和域名配置
- `site/_data/navigation.yml`：顶部导航
- `site/_pages/`：主页和各列表页
- `site/content/_Notes/`、`site/content/_Repositories/`、`site/content/_Blogs/`、`site/content/_Links/`：已发布 Markdown 内容
- `site/_layouts/`、`site/_includes/`：页面结构和复用组件
- `site/_sass/academic.scss`：主要定制样式
- `site/assets/js/main.js`：交互、Obsidian callout 等前端行为
- `site/_includes/head.html`：MathJax 和访问量脚本
- `workspace/`：草稿、原始资料和发布前记录，不参与网站构建
- `project/docs/`、`project/test/`：内部文档和站点结构测试
- `.github/workflows/pages.yml`：从 `site/` 构建并部署 GitHub Pages

## 2. 开始任何任务前

1. 在 `/Users/gabrielmu/Documents/个人网页` 工作。
2. 完整阅读本文件。
3. 运行 `git status --short`。
4. 保留所有已有修改；不得撤销并非当前 Agent 创建的改动。
5. 判断任务属于 Note、Blog、Repository、普通维护还是视觉样式修改。
6. 创建内容前至少查看同一 collection 中一个现有条目。
7. 优先沿用仓库现有的 Jekyll、AcademicPages 和 Minimal Mistakes 模式。
8. 搜索优先使用 `rg` / `rg --files`，手工修改优先使用 `apply_patch`。

不得发布密码、API Key、访问令牌、Cookie、私有链接、未经授权的私有仓库内容，或用户没有明确要求公开的个人信息。

## 3. 权限与提交规则

普通网站维护包括：

- 新增或更新 Note、Blog、Repository、Links
- 修改用户明确提供的个人信息和联系方式
- 修复文字、日期、排序、链接、front matter 和简单渲染问题
- Guestbook、访问量和已有配置的小范围维护

完成普通维护后，Agent 应运行要求的检查，自动提交并执行 `git push origin main`，不需要再次向用户确认。用户已授权普通网站维护使用：

```text
git add <本次相关文件>
git commit -m "<简洁的网站维护说明>"
git push origin main
```

只暂存当前任务相关文件。运行时权限系统仍然有效；如果工具界面要求授权，应通过工具权限界面申请，但不要在对话中重复询问已经记录的普通维护权限。

以下操作必须先询问用户：

- 任何视觉样式修改的提交或推送
- 删除内容或文件
- 修改 DNS、GitHub Pages、仓库可见性或 GitHub 仓库设置
- 引入新的第三方统计、评论或跟踪服务
- 破坏性 Git 操作或可能覆盖用户数据的操作

绝不主动运行 `rm`、`git reset --hard`、`git checkout --` 等破坏性命令。只有用户明确要求该具体操作时才可以执行。

## 4. 内容通用规则

Note、Blog 和 Repository 都使用带 YAML front matter 的 Markdown 文件。

- 文件名使用 ASCII 小写字母和连字符，例如 `transformer-lecture-2.md`。
- 文件名 slug 必须与 `permalink` 最后一段一致。
- permalink 必须唯一，并位于正确的 collection 路径下。
- 日期使用 `YYYY-MM-DD`；除非用户指定其他日期，否则采用 Asia/Shanghai 的实际发布日期。
- 保留用户提供的语言、语气和观点。中文和英文均可发布。
- 只有准备公开的内容才放入 collection 并使用 `status: "Published"`。当前列表页不会因为 `Draft` 自动隐藏文件。
- 单篇内容不需要手工加入导航；列表页和主页会自动读取 collection。
- 不得编造功能、状态、发布日期、平台、使用量或来源。

通用 front matter 字段包括：

```yaml
---
title: "Readable title"
collection: Notes
type: "Course note"
permalink: /Notes/readable-slug/
date: YYYY-MM-DD
status: "Published"
---
```

## 5. 发布 Note

Note 位于 `site/content/_Notes/*.md`，显示在 `/Notes/`。

需要确认或从用户材料中获得：源 Markdown 或正文、标题、课程/主题、简介和发布日期。用户提供本地文件时，只读取源文件，在 `site/content/_Notes/` 创建网站副本，不修改仓库外的原文件。尚未准备发布的本地材料可以放在 `workspace/notes/`，但不得把私密内容提交到仓库。

front matter 示例：

```yaml
---
title: "Course or topic - Lecture N"
collection: Notes
type: "Course note"
permalink: /Notes/course-topic-lecture-n/
date: YYYY-MM-DD
status: "Published"
---
```

正文处理：

1. front matter 后添加简短的中文或英文介绍，说明来源、范围和用途。
2. 长笔记可以添加简短阅读导引。
3. 保留作者的技术内容和表达，只修复格式问题及明显错别字，不静默改变观点。
4. 保留标题、列表、表格、链接、代码、公式和 Obsidian callout。

Obsidian callout 保持 blockquote 形式：

```markdown
> [!note] Optional title
> Content
```

折叠 callout 语法：

```markdown
> [!example]- Collapsed by default
> Content

> [!example]+ Expanded by default
> Content
```

callout 内的段落、列表、表格和公式之间使用带 `>` 的空行：

```markdown
> Intro text.
>
> $$
> E = mc^2
> $$
>
> More text.
```

公式和 Markdown 规则：

- 展示公式必须使用多行 `$$`，不要写成单行 `$$...$$`。
- `$$` 前后留空行；callout 内公式的每一行都要以 `>` 开头。
- 不要把 Markdown 代码围栏放入 `$$`；代码使用普通 fenced code block，多行公式使用 `aligned` 等 LaTeX 结构。
- 使用 `\lvert V\rvert`，避免 `$|V|$` 被 kramdown 误识别为表格。
- 列表结束后与下一段文字或标签之间留空行。
- Markdown 表格前后留空行，callout 内也一样。
- 属于某个列表项的 URL 应缩进到该列表项下。
- `site/_config.yml` 中的 `kramdown.hard_wrap: true` 用于保留 Obsidian 单换行。
- callout 转换逻辑位于 `site/assets/js/main.js`，不得把内容粗暴转换为纯文本，必须保留 kramdown 生成的 `<br>`。
- callout 样式位于 `site/_sass/academic.scss`，MathJax 位于 `site/_includes/head.html`。

Note 发布后必须确认：

- `/Notes/` 中出现该笔记，详情 permalink 能打开。
- callout 标题和样式正确，折叠 callout 可以展开和收起。
- 公式完成渲染，没有可见的原始 `$$`。
- 代码没有进入数学容器。
- 列表后的标签和段落没有被吞入上一个 `<li>`。

## 6. 发布 Blog

Blog 位于 `site/content/_Blogs/*.md`，显示在 `/Blogs/` 和主页的 writing 区域。发布前草稿可以放在 `workspace/blogs/`。

front matter 示例：

```yaml
---
title: "Blog post title"
collection: Blogs
type: "Site update"
permalink: /Blogs/blog-post-slug/
date: YYYY-MM-DD
order: 1
status: "Published"
---
```

发布规则：

1. 保留用户的语言、语气、幽默和观点，只轻微修正标点、空格、分段和明显歧义。
2. 不把轻松的个人文字改成正式宣传稿，除非用户明确要求。
3. 短文不必强行增加标题层级；长文只有在有助阅读时才增加小标题。
4. 外部链接使用明确的 Markdown 链接文字，并确认地址正确。
5. 每篇 Blog 必须有唯一 `order`。新文章读取全部现有 Blog 的 `order`，使用当前最大值加一。
6. `site/_pages/about.md` 和 `site/_pages/Blogs.md` 必须按 `order` 从大到小排列，因此最新文章显示在最前面。
7. 日期仍应真实准确；`order` 只负责明确展示顺序，不能用来伪造发布日期。

发布后确认文章出现在主页和 `/Blogs/`，每篇文章链接到自己的唯一 permalink。

## 7. 发布 Repository

Repository 条目位于 `site/content/_Repositories/*.md`，显示在 `/Repositories/`。这些页面是项目介绍并链接 GitHub，不会复制或托管项目仓库本身。发布前的 README 快照和调研记录可以放在 `workspace/repositories/`。

输入应包括公开 GitHub URL、最新 README、项目状态、用途和目标用户。若仓库刚从 private 改为 public，必须重新读取 README，不得依赖此前无法访问时的内容。

front matter 示例：

```yaml
---
title: "Repository name"
collection: Repositories
type: "Project type"
permalink: /Repositories/repository-slug/
date: YYYY-MM-DD
status: "Active"
link: "https://github.com/OWNER/REPOSITORY"
---
```

发布步骤：

1. 打开公开 GitHub 页面并读取最新 README。
2. 核对平台、语言、安装方式、版本和开发状态等会影响介绍的重要信息。
3. 开头简要说明项目是什么、服务谁、支持什么工作流。
4. 根据 README 编写有依据的简介、设计见解和重点功能；解释性判断要明确表述为见解。
5. README 中描述的是计划而不是已实现功能时，必须明确说明。
6. 结尾提供直接仓库链接：

```markdown
**Repository.** [OWNER/REPOSITORY](https://github.com/OWNER/REPOSITORY)
```

发布后确认主页项目区域和 `/Repositories/` 中出现该条目，详情页和 GitHub 链接均可打开且不返回 404。

## 8. 简单维护

个人资料优先修改 `site/_config.yml` 中的：

- `title`、`name`、`description`
- `author.name`、`author.avatar`、`author.bio`
- `author.email`、`author.github` 和其他作者链接

导航修改 `site/_data/navigation.yml`。主页内容修改 `site/_pages/about.md`。修改链接、permalink 或 collection 时，应同时搜索所有引用，并检查是否产生重复 permalink。

Guestbook 使用 Giscus 和 GitHub Discussions：

- 配置位于 `site/_config.yml` 的 `guestbook`。
- 嵌入组件位于 `site/_includes/guestbook-giscus.html`。
- 主页和 `/Guestbook/` 使用同一条 discussion thread。
- 修改 Giscus repo/category ID、GitHub App 或 Discussions 设置属于外部配置变更，必须先询问用户。

访问量使用 Busuanzi：

- 配置位于 `site/_config.yml` 的 `pageviews`。
- 数字显示在作者侧栏链接下方。
- `pageviews.enabled: false` 可关闭显示。
- 更换统计服务或增加跟踪脚本必须先询问用户。

域名和部署：

- GitHub Pages 是服务器/托管服务，阿里云只提供 DNS。
- `site/CNAME` 应保持为 `gabrielmu2006.cn`，同时不得擅自改变 GitHub Pages 设置中实际生效的自定义域名。
- `site/_config.yml` 的 `url` 应保持为 `https://gabrielmu2006.cn`，`baseurl` 为空。
- 网站通过 `.github/workflows/pages.yml` 从 `site/` 构建；Pages 发布源应设置为 GitHub Actions。
- DNS 或 Pages 设置不得在普通维护中擅自修改。

## 9. 视觉样式修改与恢复机制

视觉样式修改包括颜色、字体、间距、主页布局、卡片、导航栏、头像区域、响应式/移动端样式、深色主题以及明显改变页面外观的模板或 JavaScript 修改。

视觉修改不得直接在 `main` 上提交。必须按以下流程执行：

1. 运行 `git status --short`，确认并保留已有改动。
2. 记录修改前的 commit：`git rev-parse HEAD`。
3. 从当前 `main` 创建独立分支，分支名使用 `codex/` 前缀，例如 `codex/update-homepage-style`。
4. 在该分支修改并运行测试和 Jekyll 构建。
5. 本地浏览器预览不是每次都强制；用户要求、复杂响应式调整或仅靠源码无法确认效果时，应运行 `bundle exec jekyll serve --source site --config site/_config.yml --destination _site` 并检查相关页面。若未预览，必须明确告诉用户。
6. 在任何 commit 和 push 之前，向用户说明改动、验证结果、分支名和修改前 commit；有预览时提供截图或清晰结果。等待用户确认。
7. 用户确认后才能提交。随后将已确认的修改合入 `main` 并推送，或按用户指定方式发布。
8. 保留修改前 commit 和样式分支信息，不主动删除分支。需要恢复时优先使用可审计的 `git revert <style-commit>`；不得未经确认使用 reset 或 checkout 覆盖内容。

如果用户不同意样式方案，不得提交或推送，也不得擅自删除未提交修改；询问用户是保留分支供后续调整，还是明确放弃。

## 10. 验证与发布

所有内容发布和维护至少运行：

```bash
ruby project/test/site_structure_test.rb
bundle exec jekyll build --source site --config site/_config.yml --destination _site
git diff --check
```

然后检查：

```bash
git status --short
git diff
```

对渲染敏感的 Note 或视觉修改，还应检查 `_site` 生成结果；必要时运行：

```bash
bundle exec jekyll serve --source site --config site/_config.yml --destination _site
```

并访问 `http://127.0.0.1:4000/`。本地服务完成任务前应妥善停止，不要留下无用的后台进程。

普通维护检查通过后，只暂存相关文件，自动提交并推送 `main`。推送后等待 `.github/workflows/pages.yml` 的 GitHub Pages 工作流完成，并尽可能检查正式列表页和详情 permalink。仅本地构建成功不能证明线上部署已经完成。

## 11. 新 Agent 可复用请求

Note：

```text
请先完整阅读 AGENTS.md，然后把附带的笔记发布到 Notes。保留原文内容，增加简短简介，按文档规则处理 Obsidian callout 和公式，运行测试与 Jekyll 构建，并自动提交和推送网站更新。
```

Blog：

```text
请先完整阅读 AGENTS.md，然后把以下草稿发布为 Blog。保留我的语气和语言，只做轻微可读性修改，使用正确且唯一的 front matter、order 和 permalink，运行测试与 Jekyll 构建，并自动提交和推送网站更新。
```

Repository：

```text
请先完整阅读 AGENTS.md，然后把这个公开 GitHub 仓库加入 Repositories。读取最新 README，写准确的项目介绍，不添加无依据的信息，验证仓库链接，运行测试与 Jekyll 构建，并自动提交和推送网站更新。
```

视觉样式：

```text
请先完整阅读 AGENTS.md，然后在独立 codex/ 分支进行以下网站样式修改。完成测试和必要的预览后，先向我展示结果并说明恢复点；未经我确认不要提交或推送。
```

---

# English

## 1. Site Overview

This is Muzhi Li's Jekyll personal website. It uses the AcademicPages/Minimal Mistakes content structure with a customized dark visual style.

- Local repository: `/Users/gabrielmu/Documents/个人网页`
- GitHub repository: `GabrielMu2006/GabrielMu2006.github.io`
- Deployment branch: `main`
- Canonical domain: `https://gabrielmu2006.cn`
- GitHub Pages URL: `https://gabrielmu2006.github.io`, which redirects to the canonical domain
- Hosting service: GitHub Pages
- Custom domain declaration: `site/CNAME`; the custom domain in GitHub Pages settings is authoritative

Main public pages:

- `/`: homepage provided by `site/_pages/about.md`
- `/Notes/`: course and study notes
- `/Repositories/`: GitHub project descriptions
- `/Blogs/`: blog posts
- `/Links/`: links
- `/Guestbook/`: guestbook

Main files:

- `site/_config.yml`: site, author, collections, Guestbook, pageview, and domain configuration
- `site/_data/navigation.yml`: top navigation
- `site/_pages/`: homepage and archive pages
- `site/content/_Notes/`, `site/content/_Repositories/`, `site/content/_Blogs/`, `site/content/_Links/`: published Markdown content
- `site/_layouts/`, `site/_includes/`: page structure and reusable components
- `site/_sass/academic.scss`: main custom styles
- `site/assets/js/main.js`: interactions, Obsidian callouts, and other frontend behavior
- `site/_includes/head.html`: MathJax and pageview scripts
- `workspace/`: drafts, source material, and pre-publication records; never part of the website build
- `project/docs/`, `project/test/`: internal documentation and site structure tests
- `.github/workflows/pages.yml`: builds and deploys GitHub Pages from `site/`

## 2. Before Starting Any Task

1. Work from `/Users/gabrielmu/Documents/个人网页`.
2. Read this file completely.
3. Run `git status --short`.
4. Preserve all existing changes. Never revert changes that were not created by the current agent.
5. Classify the task as Note, Blog, Repository, routine maintenance, or visual styling.
6. Before creating content, inspect at least one existing entry in the same collection.
7. Prefer the Jekyll, AcademicPages, and Minimal Mistakes patterns already used in the repository.
8. Prefer `rg` / `rg --files` for searches and `apply_patch` for manual edits.

Never publish passwords, API keys, access tokens, cookies, private links, unauthorized private-repository content, or personal information that the user did not explicitly ask to make public.

## 3. Permissions and Commit Rules

Routine site maintenance includes:

- Adding or updating Notes, Blogs, Repositories, and Links
- Updating personal information and contact details explicitly provided by the user
- Fixing text, dates, ordering, links, front matter, and simple rendering issues
- Small maintenance changes to the existing Guestbook, pageviews, and configuration

After completing routine maintenance, the agent must run the required checks, commit automatically, and execute `git push origin main` without asking the user again. The user has authorized the following normal site-maintenance actions:

```text
git add <files related to the current task>
git commit -m "<concise site-maintenance message>"
git push origin main
```

Stage only files related to the current task. The runtime permission system remains authoritative. If the tool UI requires approval, request it through that UI, but do not ask again in conversation for already documented routine-maintenance permission.

The following actions require user approval first:

- Committing or pushing any visual style change
- Deleting content or files
- Changing DNS, GitHub Pages, repository visibility, or GitHub repository settings
- Adding a new third-party analytics, comments, or tracking service
- Destructive Git operations or actions that may overwrite user data

Never proactively run destructive commands such as `rm`, `git reset --hard`, or `git checkout --`. They may be used only when the user explicitly requests that exact operation.

## 4. Shared Content Rules

Notes, Blogs, and Repositories use Markdown files with YAML front matter.

- Use ASCII lowercase, hyphen-separated filenames such as `transformer-lecture-2.md`.
- Keep the filename slug identical to the final segment of `permalink`.
- Every permalink must be unique and under the correct collection path.
- Use `YYYY-MM-DD` dates. Unless the user specifies another date, use the actual publication date in Asia/Shanghai.
- Preserve the language, voice, and viewpoint supplied by the user. Both Chinese and English content are supported.
- Place only publication-ready content in a collection and use `status: "Published"`. Current archive pages do not automatically hide files marked `Draft`.
- Do not edit navigation for individual entries. Archive pages and the homepage read collections automatically.
- Never invent features, status, release dates, platforms, usage numbers, or sources.

Shared front matter fields include:

```yaml
---
title: "Readable title"
collection: Notes
type: "Course note"
permalink: /Notes/readable-slug/
date: YYYY-MM-DD
status: "Published"
---
```

## 5. Publishing a Note

Notes live in `site/content/_Notes/*.md` and appear at `/Notes/`.

Obtain from the user or source material: the source Markdown or body, title, course/topic, introduction, and publication date. When the user provides a local file, read it and create the website copy in `site/content/_Notes/`; do not modify the original file outside the repository. Unpublished local material may live in `workspace/notes/`, but private material must never be committed.

Example front matter:

```yaml
---
title: "Course or topic - Lecture N"
collection: Notes
type: "Course note"
permalink: /Notes/course-topic-lecture-n/
date: YYYY-MM-DD
status: "Published"
---
```

Body preparation:

1. Add a short Chinese or English introduction after front matter, explaining the source, scope, and intended use.
2. Add a short reading map when a long note benefits from one.
3. Preserve the author's technical content and expression. Fix formatting problems and obvious typos without silently changing claims.
4. Preserve headings, lists, tables, links, code, equations, and Obsidian callouts.

Keep Obsidian callouts as blockquotes:

```markdown
> [!note] Optional title
> Content
```

Foldable callout syntax:

```markdown
> [!example]- Collapsed by default
> Content

> [!example]+ Expanded by default
> Content
```

Use a blank quoted line between paragraphs, lists, tables, and equations inside callouts:

```markdown
> Intro text.
>
> $$
> E = mc^2
> $$
>
> More text.
```

Equation and Markdown rules:

- Display equations must use multiline `$$` fences, never one-line `$$...$$`.
- Leave blank lines before and after `$$`. Inside callouts, prefix every equation line with `>`.
- Never put Markdown code fences inside `$$`. Use a normal fenced code block for code and LaTeX structures such as `aligned` for multiline equations.
- Use `\lvert V\rvert` instead of `$|V|$` to prevent kramdown from interpreting bars as table syntax.
- Insert a blank line between the end of a list and the following paragraph or label.
- Insert blank lines before and after Markdown tables, including inside callouts.
- Indent a URL beneath the list item it belongs to.
- `site/_config.yml` uses `kramdown.hard_wrap: true` to preserve Obsidian-style single line breaks.
- The callout upgrader lives in `site/assets/js/main.js`. It must not flatten content into plain text and must preserve kramdown-generated `<br>` elements.
- Callout styles live in `site/_sass/academic.scss`, and MathJax is configured in `site/_includes/head.html`.

After publishing a Note, confirm that:

- The note appears on `/Notes/`, and its detail permalink opens.
- Callout titles and styles are correct, and foldable callouts open and close.
- Equations render and no raw `$$` remains visible.
- Code does not appear inside math containers.
- Labels and paragraphs following lists are not swallowed into the preceding `<li>`.

## 6. Publishing a Blog Post

Blog posts live in `site/content/_Blogs/*.md` and appear on `/Blogs/` and in the homepage writing area. Pre-publication drafts may live in `workspace/blogs/`.

Example front matter:

```yaml
---
title: "Blog post title"
collection: Blogs
type: "Site update"
permalink: /Blogs/blog-post-slug/
date: YYYY-MM-DD
order: 1
status: "Published"
---
```

Publishing rules:

1. Preserve the user's language, voice, humor, and viewpoint. Make only light corrections to punctuation, spacing, paragraph breaks, and obvious ambiguity.
2. Do not turn casual personal writing into formal promotional copy unless explicitly requested.
3. Do not force headings into a short post. Add headings to a longer post only when they improve readability.
4. Use descriptive Markdown link text for external links and verify the URL.
5. Every Blog must have a unique `order`. Read all existing Blog order values and assign the current maximum plus one to a new post.
6. `site/_pages/about.md` and `site/_pages/Blogs.md` must sort by `order` in descending order so the newest post appears first.
7. Dates must remain truthful. `order` exists only to make display order explicit and must not be used to falsify publication dates.

After publishing, confirm that the post appears on the homepage and `/Blogs/`, and that each post links to its own unique permalink.

## 7. Publishing a Repository Entry

Repository entries live in `site/content/_Repositories/*.md` and appear at `/Repositories/`. These pages describe and link to GitHub projects; they do not copy or host the repositories themselves. Pre-publication README snapshots and research notes may live in `workspace/repositories/`.

Inputs should include a public GitHub URL, the latest README, project status, purpose, and intended audience. If a repository was recently changed from private to public, read the README again rather than relying on information captured while access was unavailable.

Example front matter:

```yaml
---
title: "Repository name"
collection: Repositories
type: "Project type"
permalink: /Repositories/repository-slug/
date: YYYY-MM-DD
status: "Active"
link: "https://github.com/OWNER/REPOSITORY"
---
```

Publishing steps:

1. Open the public GitHub page and read the latest README.
2. Check important information that affects the description, including platform, language, installation method, version, and development status.
3. Open with a short explanation of what the project is, who it serves, and what workflow it supports.
4. Write an evidence-based overview, design insight, and feature highlights based on the README. Clearly label interpretive judgments as insights.
5. If the README describes plans rather than implemented functionality, say so explicitly.
6. End with a direct repository link:

```markdown
**Repository.** [OWNER/REPOSITORY](https://github.com/OWNER/REPOSITORY)
```

After publishing, confirm that the entry appears in the homepage project area and on `/Repositories/`, and that both the detail page and GitHub link open without a 404.

## 8. Routine Maintenance

For personal information, update these `site/_config.yml` fields first:

- `title`, `name`, and `description`
- `author.name`, `author.avatar`, and `author.bio`
- `author.email`, `author.github`, and other author links

Edit navigation in `site/_data/navigation.yml` and homepage content in `site/_pages/about.md`. When changing links, permalinks, or collections, search all references and check for duplicate permalinks.

The Guestbook uses Giscus and GitHub Discussions:

- Configuration lives under `guestbook` in `site/_config.yml`.
- The embed component is `site/_includes/guestbook-giscus.html`.
- The homepage and `/Guestbook/` share one discussion thread.
- Changing Giscus repository/category IDs, GitHub App access, or Discussions settings is an external configuration change and requires user approval first.

Pageviews use Busuanzi:

- Configuration lives under `pageviews` in `site/_config.yml`.
- The number appears below the links in the author sidebar.
- Set `pageviews.enabled: false` to hide it.
- Replacing the analytics provider or adding tracking scripts requires user approval first.

Domain and deployment:

- GitHub Pages is the server/hosting service; Alibaba Cloud provides DNS only.
- `site/CNAME` must remain `gabrielmu2006.cn`; do not change the authoritative custom domain in GitHub Pages settings without approval.
- `site/_config.yml` must keep `url: https://gabrielmu2006.cn` and an empty `baseurl`.
- The site is built from `site/` by `.github/workflows/pages.yml`; the Pages publishing source must be GitHub Actions.
- Do not change DNS or Pages settings as part of routine maintenance.

## 9. Visual Style Changes and Recovery

Visual style changes include colors, typography, spacing, homepage layout, cards, navigation, avatar area, responsive/mobile styling, dark theme, and template or JavaScript changes that materially alter the site's appearance.

Never commit visual changes directly on `main`. Follow this workflow:

1. Run `git status --short` and preserve all existing changes.
2. Record the pre-change commit with `git rev-parse HEAD`.
3. Create a separate branch from the current `main` using the `codex/` prefix, for example `codex/update-homepage-style`.
4. Make changes on that branch and run the tests and Jekyll build.
5. A local browser preview is not mandatory every time. Run `bundle exec jekyll serve --source site --config site/_config.yml --destination _site` and inspect the relevant pages when the user requests it, the change is responsively complex, or source inspection alone cannot verify the result. If preview is skipped, explicitly tell the user.
6. Before any commit or push, explain the changes, verification results, branch name, and pre-change commit to the user. Provide screenshots or a clear preview result when a preview was performed. Wait for user approval.
7. Commit only after the user approves. Then merge the approved change into `main` and push it, or publish it using the method specified by the user.
8. Preserve the pre-change commit and style branch information. Do not proactively delete the branch. To restore a published style change, prefer the auditable `git revert <style-commit>` workflow. Never use reset or checkout to overwrite content without explicit approval.

If the user rejects a style proposal, do not commit, push, or silently discard the uncommitted changes. Ask whether to keep the branch for revision or explicitly abandon it.

## 10. Verification and Publishing

Run at least the following for every content publication and maintenance task:

```bash
ruby project/test/site_structure_test.rb
bundle exec jekyll build --source site --config site/_config.yml --destination _site
git diff --check
```

Then review:

```bash
git status --short
git diff
```

For rendering-sensitive Notes or visual changes, also inspect the generated `_site` output. When needed, run:

```bash
bundle exec jekyll serve --source site --config site/_config.yml --destination _site
```

and visit `http://127.0.0.1:4000/`. Stop the local service cleanly before finishing the task; do not leave unnecessary background processes running.

After routine maintenance passes verification, stage only the related files, commit automatically, and push `main`. After pushing, wait for the GitHub Pages workflow in `.github/workflows/pages.yml` and check the live archive and detail permalink whenever possible. A successful local build alone does not prove that GitHub Pages deployed the new commit.

## 11. Reusable Requests for a New Agent

Note:

```text
Read AGENTS.md completely, then publish the attached note to Notes. Preserve the source content, add a short introduction, process Obsidian callouts and equations according to the documented rules, run the tests and Jekyll build, and automatically commit and push the site update.
```

Blog:

```text
Read AGENTS.md completely, then publish the following draft as a Blog post. Preserve my voice and language, make only light readability edits, use correct and unique front matter, order, and permalink values, run the tests and Jekyll build, and automatically commit and push the site update.
```

Repository:

```text
Read AGENTS.md completely, then add this public GitHub repository to Repositories. Read the latest README, write an accurate project description without unsupported claims, verify the repository link, run the tests and Jekyll build, and automatically commit and push the site update.
```

Visual style:

```text
Read AGENTS.md completely, then make the following website style changes on a separate codex/ branch. After testing and any necessary preview, show me the result and identify the recovery point. Do not commit or push without my approval.
```
