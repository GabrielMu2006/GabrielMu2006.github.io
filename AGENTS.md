# Codex Working Notes

Before starting future work in this repository, read this file first.

## General Rules

- Work from `/Users/gabrielmu/Documents/个人网页`.
- Check `git status --short` before editing.
- Do not revert user changes unless the user explicitly asks for that exact operation.
- Prefer existing Jekyll, AcademicPages, and Minimal Mistakes patterns already used in this repository.
- Use `rg` / `rg --files` for searching.
- Use `apply_patch` for manual edits.
- For website rendering fixes, verify with both source-level checks and the generated `_site` output.

## Notes Workflow

Notes live in `_Notes/*.md` and are rendered by the `Notes` collection.

Use this front matter shape:

```yaml
---
title: "Readable note title"
collection: Notes
type: "Course note"
permalink: /Notes/readable-note-slug/
date: YYYY-MM-DD
status: "Published"
---
```

After front matter, add a short English or Chinese introduction before the imported note body. The introduction should tell readers what the note covers and how it can be used.

### Obsidian Import Rules

- Keep Obsidian callouts as blockquotes:

```markdown
> [!note] Optional title
> Content
```

- Foldable Obsidian callouts are supported:

```markdown
> [!example]- Collapsed by default
> Content

> [!example]+ Expanded by default
> Content
```

- Use a blank quoted line between paragraphs, tables, formulas, and sections inside callouts:

```markdown
> Intro text.
>
> $$
> E = mc^2
> $$
>
> More text.
```

- Do not rewrite callout content as plain text in JavaScript. The callout upgrader must preserve kramdown-generated `<br>` nodes so Obsidian-style line breaks stay visible.
- The callout behavior is implemented in `assets/js/main.js`; styles live in `_sass/academic.scss`.

### Math Rules

- Use multiline display math fences, never one-line `$$...$$`:

```markdown
$$
P(S)=\prod_i P(t_i \mid t_{<i})
$$
```

- Inside callouts, quote every line:

```markdown
> $$
> P(S)=\prod_i P(t_i \mid t_{<i})
> $$
```

- Put a blank line before opening `$$` and after closing `$$`.
- Do not put Markdown code fences inside `$$` math blocks.
- If the content is code or literal syntax, use a normal fenced code block outside math.
- If the content is a multi-line equation, use LaTeX structures such as `aligned` inside display math.
- Avoid `$|V|$`; use `$\lvert V\rvert$` so kramdown does not parse `|` as table syntax.
- MathJax is configured in `_includes/head.html`.

### Lists, Tables, and Line Breaks

- `_config.yml` sets `kramdown.hard_wrap: true` so Obsidian-style single line breaks are preserved.
- Add a blank line between a list and following normal text:

```markdown
- First item
- Second item

Following paragraph.
```

- Add a blank line before labels such as `评价方式：`, `缺点：`, `代表性方法：`, or `简单理解：` when they follow a list.
- Add blank lines before and after Markdown tables, especially inside callouts.
- For URL lines that belong to a list item, indent them under the list item.

### Note Verification

After editing notes or callout/math rendering, run:

```bash
ruby test/site_structure_test.rb
bundle exec jekyll build
```

For visual/rendering changes, also check the generated page in the browser:

- Confirm callouts are upgraded.
- Confirm foldable callouts open and close.
- Confirm MathJax renders display equations.
- Confirm no raw `$$` remains visible.
- Confirm key labels are not swallowed into previous `<li>` elements.

## Approved Permission Notes

The runtime approval system is still authoritative. If a command exactly matches a persisted approved prefix, do not ask the user separately in chat. If the sandbox still requires approval, use the tool's `require_escalated` flow with a concise justification.

Currently visible approved command prefixes:

```text
["curl"]
["git", "add"]
["git", "remote"]
["qlmanage", "-t"]
["bundle", "install"]
[".venv/bin/pip", "install"]
["git", "add", ".gitignore"]
["osascript", "-e", "using terms from application \"Mail\"", "-e", "tell application \"Mail\"", "-e", "activate", "-e", "end tell", "-e", "end using terms from"]
["python3", "-m", "fnlp_lab4.cli", "run", "--mode", "baseline", "--enable-thinking", "--full-required", "--workers", "4", "--output", "outputs/thinking_direct_full_submission.csv", "--trace", "outputs/traces/thinking_direct_full.jsonl"]
["python3", "-m", "fnlp_lab4.cli", "run", "--mode", "rag_verified", "--enable-thinking", "--full-required", "--workers", "2", "--expand-query", "--llm-verify", "--top-k", "10", "--candidates", "4", "--output", "outputs/thinking_rag_verified_full_submission.csv", "--trace", "outputs/traces/thinking_rag_verified_full.jsonl"]
```

Project actions the user has approved during this site setup:

```text
git commit -m "<site-related message>"
git push origin main
```

For the same site-maintenance flow, do not ask an extra conversational confirmation before committing or pushing. If the sandbox asks for approval, request it through the tool approval UI.

Never run destructive commands such as `rm`, `git reset --hard`, or `git checkout --` unless the user explicitly asks for that exact destructive action.
