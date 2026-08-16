# Muzhi Li personal site

This repository is the source for [gabrielmu2006.cn](https://gabrielmu2006.cn), a Jekyll personal site hosted by GitHub Pages. It uses AcademicPages/Minimal Mistakes content conventions with a small local theme.

## Project map

| Path | Responsibility |
| --- | --- |
| `_config.yml` | Canonical URL, author profile, collections, integrations, build settings, and output exclusions |
| `_data/navigation.yml` | Primary navigation |
| `_pages/` | Homepage and public archive pages |
| `_Notes/`, `_Repositories/`, `_Blogs/`, `_Links/` | Published Markdown collection entries |
| `_layouts/`, `_includes/` | Page shells and reusable Liquid components |
| `_sass/`, `assets/` | Site styling, images, and browser behavior |
| `test/` | Structural regression tests |
| `docs/` | Historical implementation records; excluded from the generated site |
| `AGENTS.md` | Canonical bilingual maintenance and publishing guide |

The main public routes are `/`, `/Notes/`, `/Repositories/`, `/Blogs/`, `/Guestbook/`, and `/Links/`. Blog updates are also available as an Atom feed at `/feed.xml`.

## Local development

```bash
bundle install
bundle exec jekyll serve
```

Open `http://127.0.0.1:4000/`. Generated output and local dependency/cache directories are intentionally ignored by Git.

## Verification

Run the same checks required before publishing:

```bash
ruby test/site_structure_test.rb
bundle exec jekyll build
git diff --check
```

The structure suite validates the canonical domain, navigation, collection metadata, permalink conventions, Blog ordering, integration wiring, and build-output boundaries.

## Maintenance

Read [`AGENTS.md`](AGENTS.md) before changing the site. It is the single source of truth for content publishing, verification, Git behavior, external-service boundaries, and the approval workflow for visual changes.

Current implementation records are indexed in [`docs/README.md`](docs/README.md). They provide historical context only and do not override `AGENTS.md`.

## Deployment

- Repository: `GabrielMu2006/GabrielMu2006.github.io`
- Deployment branch: `main`
- Canonical URL: `https://gabrielmu2006.cn`
- Custom-domain declaration: `CNAME`
- Host: GitHub Pages

GitHub Pages publishes the generated site after changes reach `main`. DNS and Pages settings are external configuration and must not be changed as routine repository maintenance.
