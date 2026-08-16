# Muzhi Li personal site

This repository contains the source and maintenance workspace for [gabrielmu2006.cn](https://gabrielmu2006.cn), a Jekyll personal site hosted by GitHub Pages.

## Project map

| Path | Responsibility |
| --- | --- |
| `site/` | Complete deployable Jekyll source |
| `site/content/` | Published Blogs, Notes, Repository entries, and Links |
| `site/_pages/` | Homepage and public archive pages |
| `site/_layouts/`, `site/_includes/` | Page shells and reusable Liquid components |
| `site/_sass/`, `site/assets/` | Styling, images, and browser behavior |
| `workspace/` | Drafts, source material, and other pre-publication records; never deployed |
| `project/docs/` | Historical implementation and design records |
| `project/test/` | Structural regression tests |
| `.github/workflows/` | GitHub Pages build and deployment workflow |
| `AGENTS.md` | Canonical bilingual maintenance and publishing guide |

The main public routes are `/`, `/Notes/`, `/Repositories/`, `/Blogs/`, `/Guestbook/`, and `/Links/`. Blog updates are also available as an Atom feed at `/feed.xml`.

## Local development

```bash
bundle install
bundle exec jekyll serve --source site --config site/_config.yml --destination _site
```

Open `http://127.0.0.1:4000/`. Generated output and local dependency/cache directories are intentionally ignored by Git.

## Verification

```bash
ruby project/test/site_structure_test.rb
bundle exec jekyll build --source site --config site/_config.yml --destination _site
git diff --check
```

The structure suite validates the canonical domain, organized source layout, navigation, collection metadata, permalink conventions, Blog ordering, integration wiring, and deployment workflow.

## Content flow

Use `workspace/` for material that is not ready to publish. Once an entry is public-ready, create or update its website copy under the matching collection in `site/content/`. The website build never reads directly from `workspace/`.

Read [`AGENTS.md`](AGENTS.md) before changing the site. Current implementation records are indexed in [`project/docs/README.md`](project/docs/README.md); they provide historical context only.

## Deployment

- Repository: `GabrielMu2006/GabrielMu2006.github.io`
- Deployment branch: `main`
- Canonical URL: `https://gabrielmu2006.cn`
- Jekyll source: `site/`
- Host: GitHub Pages through the workflow in `.github/workflows/pages.yml`

The Pages repository setting must use **GitHub Actions** as its publishing source. DNS, custom-domain, and Pages settings remain external configuration and require explicit approval before changes.
