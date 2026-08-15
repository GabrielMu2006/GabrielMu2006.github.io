# Muzhi Li personal site

This repository contains a lightweight Jekyll personal homepage. The information architecture keeps the AcademicPages-style sections, while the visual direction is closer to Lynn's dark, card-based personal blog.

## Structure

- `_config.yml`: site metadata, author profile, collections, GitHub Pages URL, and GitHub repository metadata.
- `_data/navigation.yml`: top navigation links.
- `_pages/about.md`: public homepage at `/`.
- `_pages/Notes.md`, `_pages/Repositories.md`, `_pages/Blogs.md`, `_pages/Links.md`: collection archive pages.
- `_pages/Guestbook.md`: public guestbook page at `/Guestbook/`.
- `_Notes`, `_Repositories`, `_Blogs`, `_Links`: Markdown entries managed with front matter.
- `_layouts`, `_includes`, `_sass`, `assets`: local theme structure.
- `AGENTS.md`: bilingual site-management guide for agents, including publishing, maintenance, styling, verification, and Git rules.

## Local development

```bash
bundle install
bundle exec jekyll serve
```

Then open `http://127.0.0.1:4000`.

## Update personal information

Update `_config.yml` first:

- `title`
- `name`
- `description`
- `author.name`
- `author.avatar`
- `author.bio`
- `author.email`
- `author.github`

Then add your own Markdown entries to each collection.

## Publish site content

See [`AGENTS.md`](AGENTS.md) for the complete bilingual workflow for importing Notes, publishing Blogs, connecting GitHub repositories, maintaining the site, changing its visual style, verifying builds, and publishing through Git.

## Guestbook setup

The `/Guestbook/` page is wired for [Giscus](https://giscus.app/), a comments system powered by [GitHub Discussions](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/enabling-or-disabling-github-discussions-for-a-repository). Until the repository and category IDs are configured, the page shows a setup notice instead of a broken comment box.

The homepage writer and `/Guestbook/` share one fixed Giscus thread through `guestbook.mapping: specific` and `guestbook.term: Guestbook`, so messages written on the homepage are visible in the guestbook.

To enable public messages:

1. Make sure `GabrielMu2006/GabrielMu2006.github.io` is public.
2. Enable GitHub Discussions in the repository settings.
3. Install or configure the Giscus GitHub app for this repository.
4. Create or choose a discussion category named `Guestbook`.
5. Use [Giscus](https://giscus.app/) to generate the repository ID and category ID.
6. Fill `guestbook.repo_id` and `guestbook.category_id` in `_config.yml`.

## Pageviews

The author sidebar shows a single site pageview number below the author links. It is powered by Busuanzi and configured in `_config.yml` under `pageviews`. Set `pageviews.enabled: false` to hide it.

## GitHub Pages connection

The site remains hosted by the standard user Pages repository and uses a custom domain:

- GitHub user: `GabrielMu2006`
- Repository: `GabrielMu2006/GabrielMu2006.github.io`
- Public site URL: `https://gabrielmu2006.cn`
- Default Pages URL: `https://gabrielmu2006.github.io` (redirects to the custom domain)
- Custom domain declaration: root-level `CNAME`

The Alibaba Cloud DNS zone for `gabrielmu2006.cn` should contain four `A` records at `@`, pointing to `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, and `185.199.111.153`. It should also contain a `CNAME` record at `www` pointing directly to `GabrielMu2006.github.io`.

GitHub Pages remains the host. The apex domain is canonical, while the `www` variant redirects to it. Enable **Enforce HTTPS** in the repository Pages settings after GitHub finishes issuing the certificate.
