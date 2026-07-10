# Content Publishing Workflow Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a durable, cross-chat guide for publishing notes, blog posts, and GitHub repository entries to this Jekyll site.

**Architecture:** Keep human-facing publishing instructions in one root-level `CONTENT_WORKFLOW.md`. Make `AGENTS.md` point future Codex sessions to that guide before content work, and protect the handoff contract with a small structure test.

**Tech Stack:** Markdown, Jekyll collections, YAML front matter, Ruby Minitest, GitHub Pages.

## Global Constraints

- Preserve the existing `_Notes`, `_Blogs`, and `_Repositories` collection conventions.
- Preserve all Obsidian, callout, math, line-break, and verification rules already documented in `AGENTS.md`.
- Do not include credentials, tokens, cookies, or private repository content in published Markdown.
- Use `ruby test/site_structure_test.rb` and `bundle exec jekyll build` for verification.

---

### Task 1: Protect the documentation contract

**Files:**
- Modify: `test/site_structure_test.rb`

**Interfaces:**
- Consumes: repository files read through the existing `read` helper.
- Produces: a test requiring `CONTENT_WORKFLOW.md` and the `AGENTS.md` handoff reference.

- [x] **Step 1: Add a failing structure test**

Add assertions for the guide, all three collection paths, their required front matter fields, verification commands, and the `AGENTS.md` reference.

- [x] **Step 2: Verify that the test fails**

Run: `ruby test/site_structure_test.rb`

Expected: FAIL because `CONTENT_WORKFLOW.md` does not exist yet.

### Task 2: Write the reusable publishing guide

**Files:**
- Create: `CONTENT_WORKFLOW.md`
- Modify: `AGENTS.md`
- Modify: `README.md`

**Interfaces:**
- Consumes: current front matter and content patterns in `_Notes`, `_Blogs`, and `_Repositories`.
- Produces: one canonical maintenance guide discoverable by people and future Codex sessions.

- [x] **Step 1: Create the guide**

Document preparation, exact front matter templates, collection-specific writing rules, filename and permalink rules, local verification, commit/push flow, and reusable prompts for a fresh Codex chat.

- [x] **Step 2: Add discovery links**

Require future sessions to read the guide in `AGENTS.md`, and link it from `README.md`.

- [x] **Step 3: Run verification**

Run: `ruby test/site_structure_test.rb`

Expected: all tests pass.

Run: `bundle exec jekyll build`

Expected: build completes without Liquid or front matter errors.

### Task 3: Review the final documentation

**Files:**
- Review: `CONTENT_WORKFLOW.md`
- Review: `AGENTS.md`
- Review: `README.md`

**Interfaces:**
- Consumes: the completed guide and generated `_site` output.
- Produces: a clean handoff suitable for a separate Codex chat.

- [x] **Step 1: Scan for incomplete instructions**

Run: `rg -n "TBD|TODO|fill in|example\.com" CONTENT_WORKFLOW.md AGENTS.md README.md`

Expected: no matches.

- [x] **Step 2: Inspect the diff**

Run: `git diff --check`

Expected: no whitespace errors.

Run: `git diff -- CONTENT_WORKFLOW.md AGENTS.md README.md test/site_structure_test.rb`

Expected: only the documentation workflow and its guard test are changed.
