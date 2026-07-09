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

## GitHub Pages connection

The site is configured for the standard user Pages repository:

- GitHub user: `GabrielMu2006`
- Expected repository: `GabrielMu2006/GabrielMu2006.github.io`
- Expected site URL: `https://gabrielmu2006.github.io`

If the repository does not exist yet, create a public repository named `GabrielMu2006.github.io` on GitHub. Then push this local repository to `origin` and enable Pages from the repository settings if GitHub does not enable it automatically.

Add a `CNAME` file later if you connect a custom domain.
