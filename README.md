# Muzhi Li personal site

This repository contains a lightweight Jekyll personal homepage. The information architecture keeps the AcademicPages-style sections, while the visual direction is closer to Lynn's dark, card-based personal blog.

## Structure

- `_config.yml`: site metadata, author profile, collections, GitHub Pages URL, and GitHub repository metadata.
- `_data/navigation.yml`: top navigation links.
- `_pages/about.md`: public homepage at `/`.
- `_pages/Notes.md`, `_pages/Repositories.md`, `_pages/Blogs.md`, `_pages/Links.md`: collection archive pages.
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

## GitHub Pages connection

The site is configured for the standard user Pages repository:

- GitHub user: `GabrielMu2006`
- Expected repository: `GabrielMu2006/GabrielMu2006.github.io`
- Expected site URL: `https://gabrielmu2006.github.io`

If the repository does not exist yet, create a public repository named `GabrielMu2006.github.io` on GitHub. Then push this local repository to `origin` and enable Pages from the repository settings if GitHub does not enable it automatically.

Add a `CNAME` file later if you connect a custom domain.
