# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal resume website built with [Zola](https://getzola.org/), a fast static site generator written in Rust. The site uses the BelResume theme, a beautiful single-page resume template with light/dark mode support, styled with Tailwind CSS and Font Awesome.

## Core Technologies

- **Zola 0.21.0**: Static site generator (Rust-based)
- **BelResume Theme**: Single-page resume template
- **Tailwind CSS**: Utility-first CSS framework
- **Font Awesome**: Icon library
- **Sass**: CSS preprocessor (compiled automatically by Zola)
- **HTML/CSS/JavaScript**: Frontend technologies

## Development Commands

### Local Development
```bash
# Serve site locally with live reload
zola serve
# Site available at http://127.0.0.1:1111

# Build for production
zola build
# Output goes to /public directory

# Check Zola version
zola --version

# Validate site configuration
zola check
```

### Project Structure

- **config.toml**: Main site configuration and metadata
- **themes/BelResume/**: Theme files (should not be modified directly)
  - `templates/index.html`: Main layout template
  - `templates/partials/`: Modular resume sections
    - `header.html`: Name, job title, contact info
    - `experience.html`: Work history and achievements
    - `education.html`: Educational background
    - `projects.html`: Project portfolio with tech tags
    - `skills.html`: Technical skills with progress bars
    - `certifications.html`: Professional certifications
    - `languages.html`: Language proficiency
    - `awards.html`: Awards and recognition
  - `static/`: CSS, JavaScript, and image assets
- **content/**: Markdown content (currently empty - theme uses partials)
- **static/**: Site-wide static assets
- **sass/**: Sass stylesheets (auto-compiled)
- **public/**: Generated site output (ignored in git)

## Customization Workflow

The BelResume theme now uses **dynamic Tera templates** with all content managed through `config.toml`. To update resume information:

1. **All resume content**: Edit the `[extra]` section in `config.toml` - all personal info, experience, skills, projects, etc.
2. **Site metadata**: Edit top-level `config.toml` settings for title, description, and base URL
3. **Styling**: Update CSS in `themes/BelResume/static/css/` or add custom styles
4. **Adding/removing entries**: Simply add or remove items from the TOML arrays in `[extra]` section

### Template Architecture (Dynamic)

All templates use Tera templating engine with variables from `config.toml`:

- **Personal Information**: `config.extra.name`, `config.extra.job_title`, `config.extra.bio`, contact details
- **Work Experience**: `{% for job in config.extra.experience %}` - title, company, dates, achievements array
- **Projects/Interests**: `{% for project in config.extra.projects %}` - title, description, technologies array
- **Skills**: `{% for skill in config.extra.skills %}` - name, level (percentage)
- **Education**: `{% for edu in config.extra.education %}` - title, institution, dates, description
- **Certifications**: `{% for cert in config.extra.certifications %}` - title, description
- **Languages**: `{% for lang in config.extra.languages %}` - name, level, proficiency (percentage)
- **Awards**: `{% for award in config.extra.awards %}` - title, description

### Recent Improvements

- **Dynamic Templates (2025)**: Converted all static HTML to Tera templates with `config.toml` data sources
- **Full-Width Layout**: Removed `max-w-5xl` and `max-w-lg` constraints for fluid, responsive design
- **Maintainability**: All content changes now require only editing `config.toml`, no HTML modification needed

## Deployment

The site is configured for deployment to `https://daniel.bodnar.sh`. Common deployment targets:

- **GitHub Pages**: Deploy from `public/` folder after `zola build`
- **Vercel**: Auto-deploy with build command `zola build` and output directory `public`
- **Netlify**: Similar configuration with Zola build command

## File Management

- **Resume data files**: `resume.json` and `main.pdf` (likely generated resume files)
- **Theme integrity**: The BelResume theme is a git submodule - avoid direct modifications
- **Configuration**: Main site settings in root `config.toml`, theme settings in `themes/BelResume/theme.toml`

## Development Notes

- Zola automatically compiles Sass files when `compile_sass = true` in config
- Search index building is enabled for potential JavaScript search functionality
- Syntax highlighting is enabled for code blocks in Markdown
- The theme supports both light and dark modes with CSS custom properties
- No build tools like npm/yarn needed - Zola handles everything