# Academic Dashboard

**English** | [简体中文](README.zh-CN.md)

Academic Dashboard is a desktop Obsidian plugin that turns an existing Vault
into a calm, widget-based workspace for study, research, daily planning, and
bounded Agent handoffs.

It is local-first and metadata-aware. The Dashboard reads the notes you already
have, adapts to your frontmatter conventions, and keeps optional integrations
optional. It does not scrape for papers, create a second Agent runtime, or
silently reorganize a Vault.

> Current source version: **0.3.0**<br>
> Minimum Obsidian version: **1.11.4**<br>
> Platform: **Obsidian Desktop**; macOS is the primary acceptance platform<br>
> Latest published release: **[0.3.0](https://github.com/GabrielMu2006/academic-dashboard/releases/tag/0.3.0)**

## What it provides

### Home

- Date and time, calendar, recent notes, and local daily quote.
- Native Markdown tasks grouped into overdue, today, and the next seven days,
  plus up to three user-selected Today Focus references.
- Recent papers and due-review summaries based on configurable metadata.
- Quick links, frequently used Obsidian commands, and an Agent entry point.
- Review-first creation of one Daily Note, course note, paper-reading note, or
  book-reading note.
- Exact Native Markdown task completion with current-session conditional Undo.
- Editable weekly review draft for the local Monday-to-Sunday window. It lists
  retained Dashboard write events, Agent handoffs, and notes whose file
  modification time falls in the week, then exclusively creates one note under
  `Weekly Reviews` after a second review.

### Study

- Course Overview grouped by exact course and term, with course notes, related
  resources, due tasks, and due reviews in one read-only detail view. Each
  result states whether it came from metadata or the configured course root.
- Automatic course-folder buttons generated from the configured course-note
  destination. Clicking reveals and expands that folder in the File explorer;
  buttons refresh when folders change.
- Native Markdown review queue with an optional Spaced Repetition read adapter.
- Bounded 10/20-item review sessions filtered by course and type, with explicit
  viewed, skipped, source-open, and safe Native next-date actions.
- Local Obsidian activity derived from Markdown modification dates.
- Optional GitHub contribution calendar with explicit refresh and stale states.
- Bounded review-date updates for one unambiguous Native Markdown marker, with
  confirmation and current-session conditional Undo.

### Research

- Unified paper/book reading queue with plugin-side status, manual ordering,
  next step, and page/chapter/stage position. Stable IDs and edition-aware
  signatures reconnect renamed notes without merging books by title alone.
- Search and filter existing paper notes by mapped title, author, venue, DOI,
  year, reading status, and tags. Save up to 12 reproducible pinned views and
  page through a clearly bounded visible result count.
- Explainable related-material links based only on the mapped explicit relation
  field or an exact shared tag.
- Optional Bases custom view where the supported public API is available.
- One-paper status and favorite controls with conflict detection and
  current-session conditional Undo.
- No external paper discovery, scraping, or implicit metadata migration.

### Agent

- Select Codex or OpenCode as the requested target.
- Choose one of eight bounded workflows: organize or summarize a note, repair
  Markdown, search the Vault, route today's Daily Note into existing academic
  notes, create a course note, create a paper-reading note, or create a
  book-reading note.
- Preview the workflow, requested target, related paths, resolved creation
  location, and bounded context size locally before opening Claudian. Editing
  the request invalidates the preview and requires a fresh review.
- Open and prefill the reviewed request in Claudian. Existing-note writes remain
  review-first; the three single-note creation workflows run after path checks
  without asking for a second confirmation.
- Review the five newest retained request records and prepare the same workflow
  and target again without restoring request text or sending automatically.
  Prefilled/waiting, opened-only, failed, and user-marked completion states stay
  distinct; current Claudian compatibility provides no verified execution result.
- Keep provider, model, authentication, permissions, sending, and execution in
  Claudian and the selected Agent rather than duplicating those controls.

## Requirements and optional integrations

| Component | Required | Purpose |
| --- | --- | --- |
| Obsidian Desktop 1.11.4+ | Yes | Plugin host and SecretStorage API |
| Claudian | Agent page only | Review and hand off Agent workflows |
| Codex or OpenCode | Agent execution only | Selected target behind Claudian |
| Tasks | No | Capability detection remains available; the grouped Home task window uses Native Markdown for exact source identity |
| Spaced Repetition | No | Optional review read adapter; Native Markdown remains available |
| Bases | No | Optional Academic Papers custom view |
| PaperPulse Academic | No | Optional visual integration through public theme variables |
| Node.js 22+ and npm | Source builds only | Development, tests, and production bundle |

The local Dashboard pages work in a plain Vault. A missing or incompatible
optional integration produces an explicit fallback or unavailable state rather
than preventing the plugin from loading.

## Installation

### From a GitHub release

Download these three files from the same published release:

```text
main.js
manifest.json
styles.css
```

Create the plugin folder and copy the files into it:

```text
<Vault>/.obsidian/plugins/academic-dashboard/
├── main.js
├── manifest.json
└── styles.css
```

In Obsidian Desktop, open **Settings → Community plugins**, enable
**Academic Dashboard**, then run **Academic Dashboard: Open dashboard** from the
command palette.

Release 0.3.0 was installed and exercised on Obsidian Desktop 1.13.7 on macOS,
including an in-place settings migration from schema 6 to schema 7 and a render
check of the Home, Study, Research, and Agent pages.

Do not download, publish, or copy a `data.json`. Obsidian creates that file for
each Vault to hold its own settings and layouts.

### Build from source

```sh
git clone https://github.com/GabrielMu2006/academic-dashboard.git
cd academic-dashboard/plugin
npm ci
npm run build
```

Copy only `plugin/main.js`, `plugin/manifest.json`, and `plugin/styles.css` into
the Vault plugin folder shown above. Building from source does not install or
enable the plugin automatically.

### Updating

Replace the installed three runtime files with files from one newer release and
reload Obsidian. Keep the existing installed `data.json`; it contains that
Vault's settings and layouts and is migrated conservatively by the plugin.

## First-time configuration

1. Open **Settings → Academic Dashboard** and choose the default page and
   visible Widgets.
2. Review **Academic metadata** mappings so course, paper, and book notes match your
   existing frontmatter rather than being migrated.
3. Optionally enter the exact **Current term** used in your course metadata so
   same-name courses from different terms remain separate in Course Overview.
4. Configure Daily Note destinations and course/paper/book templates if you want
   local review-first note creation. The default roots are `Course`, `Paper`,
   and `Reading`.
5. Optionally set a Vault-relative local quote file such as
   `每日引言.md` at the Vault root. Each non-empty, non-heading line is one quote, up to 366
   entries.
6. Optionally add up to three Today Focus note references, or pin tasks from Home.
7. Optionally configure GitHub contributions and Claudian as described below.

Changing a metadata mapping affects future reads and actions only. Academic
Dashboard does not rewrite a Vault to enforce its recommended schema.

## Recommended metadata

These defaults are examples; every important field is configurable.

```yaml
# course note
type: course-note
course: ""
term: ""
date: 2026-08-11
tags: []
```

```yaml
# paper note
type: paper
title: ""
authors: []
year: null
status: unread # unread | reading | reviewed
venue: ""
doi: ""
favorite: false
tags: []
```

```yaml
# book-reading note
type: book-note
title: ""
authors: []
status: reading
date: 2026-08-11
tags: []
```

Research actions support only simple, unambiguous top-level scalars. Duplicate,
malformed, nested, multiline, tagged, aliased, stale, or conflicting YAML is
left unchanged for manual review.

## GitHub contributions

The optional Study Widget makes requests only to
`https://api.github.com/graphql` for the authenticated viewer's contribution
calendar.

1. Create a GitHub personal access token for your own account.
2. In **Settings → Academic Dashboard → GitHub contributions**, paste it and
   choose **Save securely**.
3. Public contributions require no repository scope. Enable the anonymous
   private contribution total only if desired and grant `read:user`; never grant
   `repo` for Academic Dashboard.

The token value is stored only through Obsidian SecretStorage, not in plugin
`data.json`, logs, diagnostics, or the contribution cache. The plugin retains at
most 366 date/count pairs, treats data as stale after six hours, and shows
last-updated, stale, refresh, and bounded error states. It never requests
repository names or contents.

## Claudian and Agent handoff

Academic Dashboard uses one Agent path:

```text
Academic Dashboard → Claudian → Codex | OpenCode
```

Install and enable Claudian only if you want the Agent page. Configure the CLI
path, provider, model, authentication, and permissions in Claudian and the
selected Agent's trusted interface. Dashboard stores only the selected target
preference and prepares bounded workflow context.

With the verified Claudian 2.1.3 compatibility boundary, Dashboard can open and
prefill the composer but cannot reliably switch the target, press Send, or
observe completion. Verify the target, then send it yourself. For course,
paper, and book creation, Dashboard first resolves the destination through the
Obsidian Vault API; that send is the only confirmation, and Claudian creates the
one resolved note without another plan/diff approval or Shell-based scan.
`Ready for review` and `Ready to send` mean the request was prefilled; neither
claims that an Agent ran or changed a file.

## Write-safety model

Academic Dashboard permits only deliberately narrow local actions:

- toggle one verifiable Native Markdown task;
- update one supported Native Markdown review marker;
- change one mapped paper status or favorite scalar; or
- create one Daily, course, paper, or book note at a non-existing safe path.

Academic note creation searches the configured root recursively first. An exact
matching folder is reused; related files in one folder keep the new note beside
them; when nothing matches, Dashboard creates `<root>/<title>/<title>.md`.
Matches spanning multiple equally suitable folders fail closed, and existing
files are never moved or overwritten.

Edits re-read and compare the complete note immediately before writing. A later
user edit, moved note, changed field, ambiguous structure, or existing creation
destination makes the operation fail closed. Edit Undo exists only in memory
for the current plugin session and refuses to overwrite later changes.

The plugin has no delete, move, rename, bulk-edit, Git, subprocess, custom API
endpoint, or automatic Vault-restructuring capability. Dashboard-to-Claudian
handoffs are separate from local actions. Existing-note writes still require
review in Claudian; the three bounded new-note workflows are explicitly
authorized by Send and do not request a second approval.

## Privacy and data handling

| Data or capability | Behavior |
| --- | --- |
| Vault metadata | Read locally to build bounded note, paper, calendar, and activity summaries |
| Note content | Read only where required for Native task/review parsing and exact safe writes |
| Local writes | One user-triggered Markdown target at a time; no delete or bulk operation |
| Network | Optional fixed GitHub GraphQL contribution request only |
| GitHub PAT | Obsidian SecretStorage only; never plugin data or logs |
| Agent credentials | Managed by Codex/OpenCode and Claudian; never collected by Dashboard |
| Logs | Content-free operation metadata with configurable retention |
| Telemetry | None |

Community plugins inherit Obsidian Desktop's application privileges. Review the
source and the [privacy and security model](docs/privacy-security.md) before use
with a sensitive Vault. Never attach an unreviewed `data.json`, token, Agent
transcript, private note, or screenshot containing personal data to an issue.

## Layout, themes, and accessibility

Home, Study, Research, and Agent keep independent layouts. Choose **Edit
layout** to drag or resize Widgets between their supported `small`, `medium`,
and `large` sizes. Arrow keys move a focused Widget; Shift+Arrow resizes it;
Escape exits edit mode. Responsive one- and two-column layouts do not overwrite
the saved canonical desktop layout.

The visual system derives from Obsidian semantic variables and works without a
specific theme. Theme authors can use only the documented
`--academic-dashboard-*` variables on `.academic-dashboard-view`; component
selectors are not a public theme API. See the
[theme-author contract](docs/theme-author-contract.md).

The accepted UI includes English and Simplified Chinese resources, keyboard
operation, focus restoration, screen-reader labels and live regions, non-color
state cues, reduced motion, increased contrast, and forced-colors handling.

## Development

Use Node.js 22 or later:

```sh
cd plugin
npm ci
npm run typecheck
npm run lint
npm test
npm run build
```

The production build writes `plugin/main.js`. Nothing is copied into a Vault or
enabled automatically. Use fake ports and synthetic fixtures for tests; never
run automated writes against a personal Vault.

## Repository layout

```text
academic-dashboard/
├── README.md
├── README.zh-CN.md             # Simplified Chinese README
├── manifest.json               # public Obsidian manifest
├── versions.json               # version-to-minimum-Obsidian map
├── PROJECT.md                  # authoritative product boundaries
├── ROADMAP.md                  # implementation history and sequencing
├── CHANGELOG.md
├── CONTRIBUTING.md
├── SECURITY.md
├── THIRD_PARTY_NOTICES.md
├── docs/                       # setup, architecture, safety, QA, and plans
├── scripts/check-setup.mjs     # read-only environment diagnostic
├── scripts/check-release.mjs   # release metadata consistency check
└── plugin/
    ├── manifest.json
    ├── package.json
    ├── package-lock.json
    ├── src/
    ├── tests/
    ├── styles.css
    └── main.js                 # generated production bundle; not committed
```

The repository is independent from every user Vault. An installed plugin
`data.json`, private notes, local Agent configuration, and generated development
dependencies are never release assets.

## Release contents

Obsidian installs the individual `main.js`, `manifest.json`, and `styles.css`
attachments from a GitHub Release whose tag exactly matches the manifest
version. The project may additionally provide a ZIP and SHA-256 checksums for
manual installation, but those do not replace the three individual files.

See the [GitHub publication plan](docs/github-publication-plan.md) for the
required repository-root manifest, version map, release workflow correction,
history sanitization, and optional Community directory submission.

## Documentation and support

- [Setup and installation](docs/setup.md)
- [Architecture](docs/architecture.md)
- [Privacy and security](docs/privacy-security.md)
- [Claudian setup](docs/claudian-setup.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Demo and screenshot guide](docs/demo.md)
- [Contributing](CONTRIBUTING.md)
- [Security policy](SECURITY.md)
- [Changelog](CHANGELOG.md)

Report reproducible bugs with synthetic data and the Academic Dashboard,
Obsidian, operating-system, and relevant optional-plugin versions. Use the
private security-reporting process for vulnerabilities.

## License

Academic Dashboard is released under the [MIT License](LICENSE). GridStack is
bundled under its own MIT terms; see
[Third-party notices](THIRD_PARTY_NOTICES.md).
