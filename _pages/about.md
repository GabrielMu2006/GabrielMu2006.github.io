---
permalink: /
title: "Home"
excerpt: "About Muzhi Li"
author_profile: true
hide_title: true
---

<section class="home-hero">
  <p class="home-hero__eyebrow">SESS x EECS · Peking University</p>
  <h1>Muzhi Li</h1>
  <p class="home-hero__summary">I am learning across earth science, computation, and large-model systems. This site keeps the notes, code, and references I want to return to.</p>
  <div class="home-hero__actions" aria-label="Primary links">
    <a href="{{ '/Notes/' | relative_url }}">Read notes</a>
    <a href="{{ '/Repositories/' | relative_url }}">View projects</a>
    <a href="https://github.com/GabrielMu2006">GitHub</a>
  </div>
</section>

<section class="home-section">
  <div class="home-section__header">
    <h2>Recently updated notes</h2>
    <a href="{{ '/Notes/' | relative_url }}">More notes</a>
  </div>
  <div class="home-card-list">
    {% assign recent_notes = site.Notes | sort: "date" | reverse %}
    {% if recent_notes.size > 0 %}
      {% for item in recent_notes limit:3 %}
        <article class="home-card">
          <a class="home-card__title" href="{{ item.url | relative_url }}">{{ item.title }}</a>
          <p class="home-card__meta">{% if item.date %}{{ item.date | date: "%Y-%m-%d" }}{% endif %}{% if item.type %} · {{ item.type }}{% endif %}</p>
          <p>{{ item.excerpt | strip_html | normalize_whitespace | truncate: 120 }}</p>
        </article>
      {% endfor %}
    {% else %}
      <article class="home-card">
        <p class="home-card__title">No public notes on the shelf yet.</p>
        <p>Course notes, reading notes, and research fragments will appear here once they are worth keeping in public.</p>
      </article>
    {% endif %}
  </div>
</section>

<section class="home-section">
  <div class="home-section__header">
    <h2>Selected repositories</h2>
    <a href="{{ '/Repositories/' | relative_url }}">All projects</a>
  </div>
  <div class="home-card-list">
    {% assign recent_projects = site.Repositories | sort: "date" | reverse %}
    {% if recent_projects.size > 0 %}
      {% for item in recent_projects limit:3 %}
        <article class="home-card">
          <a class="home-card__title" href="{{ item.url | relative_url }}">{{ item.title }}</a>
          <p class="home-card__meta">{% if item.status %}{{ item.status }}{% endif %}{% if item.link %} · <a href="{{ item.link }}">Project link</a>{% endif %}</p>
          <p>{{ item.excerpt | strip_html | normalize_whitespace | truncate: 120 }}</p>
        </article>
      {% endfor %}
    {% else %}
      <article class="home-card">
        <p class="home-card__title">No project notes selected yet.</p>
        <p>Repositories that carry a useful idea, tool, or build log will be linked here.</p>
      </article>
    {% endif %}
  </div>
</section>

<section class="home-section">
  <div class="home-section__header">
    <h2>Longer writing</h2>
    <a href="{{ '/Blogs/' | relative_url }}">Blog archive</a>
  </div>
  <div class="home-card-list">
    {% assign recent_blogs = site.Blogs | sort: "order" | reverse %}
    {% if recent_blogs.size > 0 %}
      {% for item in recent_blogs limit:3 %}
        <article class="home-card">
          <a class="home-card__title" href="{{ item.url | relative_url }}">{{ item.title }}</a>
          <p class="home-card__meta">{% if item.date %}{{ item.date | date: "%Y-%m-%d" }}{% endif %}{% if item.type %} · {{ item.type }}{% endif %}</p>
          <p>{{ item.excerpt | strip_html | normalize_whitespace | truncate: 120 }}</p>
        </article>
      {% endfor %}
    {% else %}
      <article class="home-card">
        <p class="home-card__title">Longer writing is still in the margins.</p>
        <p>For now, I am letting longer pieces earn their place. The fresher trail is in Notes and project writeups.</p>
      </article>
    {% endif %}
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
  <a href="{{ '/Guestbook/' | relative_url }}">
    <span>Guestbook</span>
    <small>Leave a note, question, or small hello.</small>
  </a>
  <a href="{{ '/Links/' | relative_url }}">
    <span>Links</span>
    <small>Useful sites, friends, and references.</small>
  </a>
</section>

<section class="home-section home-guestbook" aria-labelledby="home-guestbook-title">
  <div class="home-section__header">
    <h2 id="home-guestbook-title">Leave a note</h2>
    <a href="{{ '/Guestbook/' | relative_url }}">Read guestbook</a>
  </div>
  <p class="home-guestbook__intro">Write a quick message here. It will appear in the same Guestbook thread.</p>
  {% include guestbook-giscus.html %}
</section>

<section class="home-panel">
  <h2>Contact</h2>
  <p>PKU Email: <a href="mailto:limuzhi2006@stu.pku.edu.cn">limuzhi2006@stu.pku.edu.cn</a></p>
  <p>Personal Email: <a href="mailto:limuzhi2006@163.com">limuzhi2006@163.com</a></p>
  <p>GitHub: <a href="https://github.com/GabrielMu2006">GabrielMu2006</a></p>
</section>
