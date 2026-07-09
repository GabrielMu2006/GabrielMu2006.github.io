---
title: "PaperPulse"
collection: Repositories
type: "Apple app"
permalink: /Repositories/paperpulse/
date: 2026-07-09
status: "In progress"
link: "https://github.com/GabrielMu2006/PaperPulse"
---

PaperPulse is an Apple-platform app for research reading on iPhone and Mac. It aims to turn the daily paper feed into a complete local workflow: scheduled discovery, authority-aware filtering, open-access PDF downloading, generated summaries, offline reading, and library management.

The public repository currently documents the project direction and implementation plan; the local source code is not pushed there yet.

**Insight.** The most useful idea in the README is that a paper assistant should be careful before it is clever. PaperPulse puts deterministic academic sources first, downloads only open-access PDFs, keeps rule-based screening ahead of LLM reranking, and asks the user to bring their own model provider configuration. That makes the app closer to a trustworthy research desk than a generic summarizer.

**Highlights.**

- Lets users configure research fields, keywords, exclusion terms, daily paper limits, and institution, journal, or conference preferences.
- Plans to rely on academic APIs such as arXiv, OpenAlex, Crossref, and Unpaywall before any model-generated reasoning.
- Treats paywalls and subscriptions as hard boundaries by downloading only openly available PDFs.
- Uses user-provided LLM API keys with OpenAI-compatible providers, custom base URLs, and model capability settings.
- Targets independent iOS and macOS experiences for refresh, downloading, offline reading, notifications, settings, and local library management.
- Tracks a SwiftPM-based core with models, pipeline protocols, source adapters, ranking logic, PDF handling, provider abstraction, and tests described in the README.

**Repository.** [GabrielMu2006/PaperPulse](https://github.com/GabrielMu2006/PaperPulse)
