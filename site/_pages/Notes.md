---
layout: archive
title: "Notes"
permalink: /Notes/
author_profile: true
---

Course notes, reading notes, and research notes. Keep the useful fragments close.

{% include base_path %}

{% for post in site.Notes reversed %}
  {% include archive-single.html %}
{% endfor %}
