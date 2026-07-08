---
permalink: /
title: "Home"
excerpt: "About Gabriel Mu"
author_profile: true
hide_title: true
---

<section class="home-hero">
  <p class="home-hero__eyebrow">Welcome</p>
  <h1>Hi, I'm Gabriel Mu.</h1>
  <p class="home-hero__summary">I am building a small home for notes, projects, reading, and the things I am learning in public.</p>
  <div class="home-hero__actions" aria-label="Primary links">
    <a href="{{ '/Notes/' | relative_url }}">Read notes</a>
    <a href="{{ '/Repositories/' | relative_url }}">View projects</a>
    <a href="https://github.com/GabrielMu2006">GitHub</a>
  </div>
</section>

<section class="home-panel home-panel--intro">
  <h2>About this site</h2>
  <p>Inspired by Lynn's personal blog style, this homepage keeps the warmth of a personal site while preserving an academic-friendly structure for notes, repositories, blogs, and links.</p>
</section>

<section class="home-section">
  <div class="home-section__header">
    <h2>Recently updated notes</h2>
    <a href="{{ '/Notes/' | relative_url }}">More notes</a>
  </div>
  <div class="home-card-list">
    {% assign recent_notes = site.Notes | sort: "date" | reverse %}
    {% for item in recent_notes limit:3 %}
      <article class="home-card">
        <a class="home-card__title" href="{{ item.url | relative_url }}">{{ item.title }}</a>
        <p class="home-card__meta">{% if item.date %}{{ item.date | date: "%Y-%m-%d" }}{% endif %}{% if item.type %} · {{ item.type }}{% endif %}</p>
        <p>{{ item.excerpt | strip_html | normalize_whitespace | truncate: 120 }}</p>
      </article>
    {% endfor %}
  </div>
</section>

<section class="home-section">
  <div class="home-section__header">
    <h2>Selected repositories</h2>
    <a href="{{ '/Repositories/' | relative_url }}">All projects</a>
  </div>
  <div class="home-card-list">
    {% assign recent_projects = site.Repositories | sort: "date" | reverse %}
    {% for item in recent_projects limit:3 %}
      <article class="home-card">
        <a class="home-card__title" href="{{ item.url | relative_url }}">{{ item.title }}</a>
        <p class="home-card__meta">{% if item.status %}{{ item.status }}{% endif %}{% if item.link %} · <a href="{{ item.link }}">Project link</a>{% endif %}</p>
        <p>{{ item.excerpt | strip_html | normalize_whitespace | truncate: 120 }}</p>
      </article>
    {% endfor %}
  </div>
</section>

<section class="home-section">
  <div class="home-section__header">
    <h2>Latest writing</h2>
    <a href="{{ '/Blogs/' | relative_url }}">All blogs</a>
  </div>
  <div class="home-card-list">
    {% assign recent_blogs = site.Blogs | sort: "date" | reverse %}
    {% for item in recent_blogs limit:3 %}
      <article class="home-card">
        <a class="home-card__title" href="{{ item.url | relative_url }}">{{ item.title }}</a>
        <p class="home-card__meta">{% if item.date %}{{ item.date | date: "%Y-%m-%d" }}{% endif %}{% if item.type %} · {{ item.type }}{% endif %}</p>
        <p>{{ item.excerpt | strip_html | normalize_whitespace | truncate: 120 }}</p>
      </article>
    {% endfor %}
  </div>
</section>

<section class="home-link-grid" aria-label="Site sections">
  <a href="{{ '/Notes/' | relative_url }}">
    <span>Notes</span>
    <small>Course notes, reading notes, and research notes.</small>
  </a>
  <a href="{{ '/Repositories/' | relative_url }}">
    <span>Repositories</span>
    <small>Projects, source code, and build logs.</small>
  </a>
  <a href="{{ '/Blogs/' | relative_url }}">
    <span>Blogs</span>
    <small>Long-form writing and occasional updates.</small>
  </a>
  <a href="{{ '/Links/' | relative_url }}">
    <span>Links</span>
    <small>Useful sites, friends, and references.</small>
  </a>
</section>

<section class="home-panel">
  <h2>Pageviews</h2>
  <p>Analytics are not enabled by default. Add your visitor map or tracking snippet here after you choose a provider.</p>
</section>

<section class="home-panel">
  <h2>Contact</h2>
  <p>GitHub: <a href="https://github.com/GabrielMu2006">GabrielMu2006</a>. Add an email address in <code>_config.yml</code> when you are ready to make it public.</p>
</section>
