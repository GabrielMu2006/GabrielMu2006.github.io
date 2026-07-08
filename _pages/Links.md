---
layout: archive
title: "Links"
permalink: /Links/
author_profile: true
---

Useful links, friends, resources, and references. The web feels better when it has doors.

{% include base_path %}

{% for post in site.Links reversed %}
  {% include archive-single.html %}
{% endfor %}
