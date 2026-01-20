# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal resume website for Daniel Bodnar built with [Zola](https://getzola.org/) static site generator. Single-page design with all content managed via `config.toml` using Tera templates.

## Development Commands

```bash
# Serve locally with live reload (http://127.0.0.1:1111)
zola serve

# Build for production (output: public/)
zola build

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
├── content/             # Empty - theme uses partials only
└── .github/workflows/   # Auto-deploys to gh-pages on push to main
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
- **Print styles** - included in CSS for PDF generation
- **Responsive** - mobile-first with breakpoints at 768px

## Deployment

Automatic deployment via GitHub Actions:
- Push to `main` → builds with Zola → deploys to `gh-pages` branch
- Live at: `https://resume.bodnar.sh`

The workflow uses `shalzz/zola-deploy-action@v0.21.0`.

## Common Tasks

### Add new work experience
Add `[[extra.experience]]` block in `config.toml` with title, company, dates, achievements array.

### Modify styling
Edit `/static/css/style.css`. Key CSS variables are in `:root` (colors, fonts).

### Add new section
1. Create partial in `/templates/partials/newsection.html`
2. Add data structure in `config.toml` under `[extra]`
3. Include in `/templates/index.html` with `{% include "partials/newsection.html" %}`
