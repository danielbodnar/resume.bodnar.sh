# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal resume website for Daniel Bodnar built with [Zola](https://getzola.org/) static site generator. Single-page design with all content managed via `config.toml` using Tera templates.

## Development Commands

```bash
# Serve locally with live reload (http://127.0.0.1:1111)
zola serve

# Build for production: Zola site plus public/resume.md (output: public/)
scripts/build.sh

# Reprint static/resume.pdf after editing config.toml or print styles
scripts/print-pdf.sh

# Validate configuration and check for errors
zola check
```

## Project Structure

```
├── config.toml          # ALL resume content lives here
├── templates/
│   ├── index.html       # Main layout template
│   └── partials/        # Section templates (header, experience, skills, projects)
├── static/css/style.css # Custom CSS (JetBrains Mono + Inter fonts)
├── static/resume.pdf    # Printed by scripts/print-pdf.sh, served at /resume.pdf
├── scripts/             # build.sh, print-pdf.sh, resume-md.ts
├── wrangler.jsonc       # Cloudflare Worker (static assets from public/)
└── content/             # Empty - theme uses partials only
```

## Content Management

All resume content is in `config.toml` under `[extra]`. No HTML editing needed.

### Key Data Structures

```toml
# Personal info
[extra]
name = "..."
job_title = "..."
bio = "..."
email = "..."
phone = "..."
location = "..."

# Work experience (array)
[[extra.experience]]
title = "Job Title"
company = "Company Name"
start_date = "YYYY"
end_date = "Present"
achievements = ["...", "..."]

# Skills (array with keywords)
[[extra.skills]]
name = "Skill Category"
keywords = ["keyword1", "keyword2"]

# Projects/interests (array)
[[extra.projects]]
title = "Area Name"
description = "..."
technologies = ["tech1", "tech2"]
```

### Template Variables

Templates access config via Tera syntax:
- `{{ config.extra.name }}` - single values
- `{% for job in config.extra.experience %}` - arrays

## Architecture Notes

- **No external theme dependency** - templates are local in `/templates/`
- **Custom CSS** - `/static/css/style.css` using CSS variables for theming
- **Fonts** - JetBrains Mono (headings), Inter (body) via Google Fonts CDN
- **Print styles** - included in CSS; `scripts/print-pdf.sh` prints them to `static/resume.pdf`
- **Responsive** - fluid; rows wrap with flexbox, no width breakpoints

## Deployment

Cloudflare Workers Builds deploys the `resume-bodnar-sh` Worker (BitBuilder Cloud account):
- Push to `main` → `scripts/build.sh` → `wrangler deploy` → `https://resume.bodnar.sh`
- Push to any other branch → `wrangler preview` → a Worker Preview URL
- `scripts/build.sh` downloads the pinned Zola release when `zola` isn't installed, since the build image doesn't include it
- `/resume.md` is generated on every build; `/resume.pdf` is the committed `static/resume.pdf`, so reprint it with `scripts/print-pdf.sh` whenever the content or print styles change

## Common Tasks

### Add new work experience
Add `[[extra.experience]]` block in `config.toml` with title, company, dates, achievements array.

### Modify styling
Edit `/static/css/style.css`. Key CSS variables are in `:root` (colors, fonts).

### Add new section
1. Create partial in `/templates/partials/newsection.html`
2. Add data structure in `config.toml` under `[extra]`
3. Include in `/templates/index.html` with `{% include "partials/newsection.html" %}`
