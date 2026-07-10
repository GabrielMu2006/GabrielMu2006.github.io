# Content Publishing Workflow

This is the canonical maintenance guide for publishing Notes, Blogs, and Repository entries on this site. It is written for both the site owner and a fresh Codex chat with no prior conversation context.

## 1. Start Every Content Task Here

Before editing anything:

1. Work from `/Users/gabrielmu/Documents/个人网页`.
2. Read `AGENTS.md` and this file completely.
3. Run `git status --short` and preserve any existing user changes.
4. Identify the content type: Note, Blog, or Repository.
5. Inspect at least one existing entry in the matching collection before creating a new file.

Never publish passwords, API keys, access tokens, cookies, private URLs, unpublished private-repository content, or personal information that the owner did not explicitly provide for publication.

## 2. Shared Publishing Rules

All content entries are Markdown files with YAML front matter.

- Use an ASCII, lowercase, hyphen-separated filename, such as `transformer-lecture-2.md`.
- Keep the filename slug and the final segment of `permalink` identical.
- Use a unique permalink under the matching collection path.
- Use the actual publication date in `YYYY-MM-DD` format, based on the Asia/Shanghai date unless the owner specifies another date.
- Keep visible content in the language supplied by the owner. Chinese and English are both supported.
- Use `status: "Published"` only when the entry is ready to appear. The current archive pages do not hide entries merely because their status says `Draft`, so unfinished content should stay outside the collection until it is ready.
- Do not edit navigation for individual entries. The collection archive and homepage read collection files automatically.

The shared front matter fields are:

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

The `collection`, `type`, and `permalink` values must be adjusted for the content type as described below.

## 3. Publish a Note

Notes live in `_Notes/*.md` and appear at `/Notes/`.

### Inputs to collect

- The source Markdown file or the note text.
- A readable title and, when relevant, the course or topic name.
- A short explanation of what the note covers.
- The intended publication date.

When the owner provides a local file path, read that source directly and preserve its meaning. Do not modify the original source file outside this repository. Create the website copy in `_Notes/`.

### Front matter

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

### Body preparation

1. Add a short introduction immediately after the front matter. Explain the source, scope, and how the note can be used.
2. Add a brief reading map when the note is long enough to benefit from one.
3. Preserve the author's technical content and voice. Correct formatting problems and obvious typos without silently changing claims.
4. Preserve headings, lists, tables, links, code blocks, formulas, and Obsidian callouts.
5. Check every list transition, formula block, table, and callout against the detailed rules below.

### Obsidian callouts

Keep standard callouts as blockquotes:

```markdown
> [!note] Optional title
> Callout content.
```

Keep foldable callouts in Obsidian syntax. A minus sign means collapsed by default; a plus sign means expanded by default:

```markdown
> [!example]- Collapsed by default
> Callout content.

> [!example]+ Expanded by default
> Callout content.
```

Inside a callout, quote every line and insert a blank quoted line between paragraphs, lists, tables, formulas, and other sections:

```markdown
> Introductory sentence.
>
> $$
> E = mc^2
> $$
>
> Closing sentence.
```

### Formulas, code, lists, and tables

- Use multiline display math fences. Never write display math as one-line `$$...$$`.
- Put a blank line before the opening `$$` and after the closing `$$`.
- Inside a callout, prefix the opening fence, every equation line, and the closing fence with `>`.
- Never place Markdown code fences inside `$$` blocks. Use a normal fenced code block for code and `aligned` or another LaTeX structure for multiline equations.
- Prefer `\lvert V\rvert` over `|V|` in inline math so kramdown does not interpret the bars as table syntax.
- Insert a blank line between the end of a list and the next paragraph or label.
- Insert blank lines before and after Markdown tables, including tables inside callouts.
- Indent a URL when it belongs to the preceding list item.

The site's callout upgrader is in `assets/js/main.js`, callout styles are in `_sass/academic.scss`, MathJax is configured in `_includes/head.html`, and Obsidian-style hard line breaks are enabled in `_config.yml`.

### Note-specific verification

After the general build succeeds, inspect the generated page in `_site/Notes/<slug>/index.html` or in the local browser. Confirm that:

- the note appears on `/Notes/` and its detail page opens;
- callouts have the expected title and style;
- foldable callouts open and close;
- display equations render and no raw `$$` remains visible;
- code is outside math containers;
- labels and paragraphs after lists are not swallowed into the previous list item.

## 4. Publish a Blog Post

Blog posts live in `_Blogs/*.md` and appear at `/Blogs/`.

### Inputs to collect

- The complete draft or a clear outline.
- The desired title, topic, and publication date.
- Any links that should be included.

### Front matter

```yaml
---
title: "Blog post title"
collection: Blogs
type: "Site update"
permalink: /Blogs/blog-post-slug/
date: YYYY-MM-DD
status: "Published"
---
```

Choose a concise `type` that describes the post, such as `Site update`, `Personal essay`, `Project log`, or `Study reflection`.

### Body preparation

1. Preserve the owner's language, tone, humor, and point of view.
2. Lightly fix punctuation, spacing, paragraph boundaries, and obvious ambiguity.
3. Do not turn an informal personal post into formal promotional copy unless explicitly requested.
4. Use headings only when they genuinely improve a longer post. A short post can remain as a sequence of paragraphs.
5. Verify every external link and use descriptive Markdown link text.

After publishing, confirm that the post appears in the homepage writing area, appears on `/Blogs/`, and opens at its permalink.

## 5. Publish a Repository Entry

Repository entries live in `_Repositories/*.md` and appear at `/Repositories/`. These are website descriptions that link to GitHub; they do not copy or host the repository itself.

### Inputs to collect

- The full GitHub repository URL.
- Confirmation that the repository is public, or explicit permission and access to read it.
- The current README and repository description.
- The project's status, purpose, and intended audience.

If a repository was recently changed from private to public, fetch its README again before writing. Do not rely on a description captured while access was unavailable.

### Front matter

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

Use a truthful project status such as `Active`, `In progress`, `Maintained`, or `Archived`. The `link` field is required for Repository entries.

### Research and body preparation

1. Open the public GitHub page and read the latest README.
2. Check repository metadata that materially affects the description, such as its stated platform, language, installation method, and development status.
3. Write a short opening paragraph explaining what the project is, who it helps, and what workflow it supports.
4. Add an `**Insight.**` paragraph that identifies the most meaningful design idea or lesson supported by the README. Clearly phrase interpretation as an insight rather than a repository claim.
5. Add an `**Highlights.**` list containing only features or plans supported by the public repository.
6. End with a direct repository link:

```markdown
**Repository.** [OWNER/REPOSITORY](https://github.com/OWNER/REPOSITORY)
```

Do not invent completion status, usage numbers, supported platforms, features, or implementation details. If the README describes plans rather than finished code, say so explicitly.

After publishing, confirm that the entry appears on the homepage project area, appears on `/Repositories/`, opens at its permalink, and links to the correct GitHub repository without a 404.

## 6. Validate and Publish Changes

Run the repository checks from the project root:

```bash
ruby test/site_structure_test.rb
bundle exec jekyll build
```

Both commands must succeed before claiming the upload is complete. For rendering-sensitive Notes, also inspect the generated HTML and the local browser page.

Review the change set:

```bash
git status --short
git diff --check
git diff
```

Stage only the files related to the current upload, then commit with a concise site-related message and push:

```bash
git add <changed-files>
git commit -m "Add <content title>"
git push origin main
```

The owner has already approved normal site-maintenance commits and `git push origin main` in `AGENTS.md`. The runtime permission system remains authoritative; use its approval UI if it still requires confirmation.

After pushing, allow GitHub Pages time to rebuild, then check the live archive page and detail permalink. A successful local build does not by itself prove that GitHub Pages has deployed the new commit.

## 7. Prompts for a New Codex Chat

Use one of these prompts in a separate chat. Attach the source file or include the URL/text after the prompt.

### Note

```text
Read AGENTS.md and CONTENT_WORKFLOW.md first. Publish the attached note to the Notes collection. Preserve my content, add a short introduction, process Obsidian callouts and formulas according to the documented rules, run all required tests and the Jekyll build, then commit and push the completed site update.
```

### Blog

```text
Read AGENTS.md and CONTENT_WORKFLOW.md first. Publish the following draft as a Blog post. Preserve my voice and language, make only light readability edits, use the documented front matter and permalink rules, run all required tests and the Jekyll build, then commit and push the completed site update.
```

### Repository

```text
Read AGENTS.md and CONTENT_WORKFLOW.md first. Add this public GitHub repository to the Repositories section. Read its latest README, write an accurate overview with an Insight and Highlights, avoid unsupported claims, verify the repository link, run all required tests and the Jekyll build, then commit and push the completed site update.
```

When starting a new chat, always provide the source note, blog draft, or GitHub URL together with the relevant prompt.
