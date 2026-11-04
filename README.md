# Daniel Bodnar - Personal Resume Website

A modern, responsive single-page resume website built with [Zola](https://getzola.org/) static site generator and the BelResume theme.

## Features

- 🎨 **Full-Width Responsive Design** - Fluid layout that adapts to all screen sizes
- 🌓 **Light/Dark Mode Toggle** - Seamless theme switching
- 🎯 **Dynamic Templates** - All content managed through `config.toml` using Tera templating
- 🚀 **Fast Static Site** - Built with Rust-based Zola for optimal performance
- 💼 **Professional Layout** - Clean, modern design with Font Awesome icons
- 🎨 **Multiple Color Themes** - Blue, Purple, and Amber color schemes


## Tech Stack

- **Zola 0.21.0** - Static site generator (Rust-based)
- **Tera** - Template engine (similar to Jinja2, Liquid, Twig)
- **Tailwind CSS** - Utility-first CSS framework (via CDN)
- **Font Awesome** - Icon library
- **Sass** - CSS preprocessor (auto-compiled by Zola)

## Quick Start

### Prerequisites

- [Zola 0.21.0+](https://www.getzola.org/documentation/getting-started/installation/) installed

### Local Development

```bash
# Serve site locally with live reload
zola serve

# Build for production
zola build

# Validate configuration
zola check
```

Visit `http://127.0.0.1:1111` to preview the site.

## Content Management

All resume content is now managed through `config.toml` - no HTML editing required!

### Editing Resume Content

Edit the `[extra]` section in `config.toml`:

```toml
[extra]
# Personal Information
name = "Your Name"
job_title = "Your Job Title"
bio = "Your bio/tagline"
email = "your.email@example.com"
phone = "(123) 456-7890"
location = "Your City, State"
website = "https://yoursite.com"

# Work Experience
[[extra.experience]]
title = "Job Title"
company = "Company Name"
start_date = "2020"
end_date = "Present"
achievements = [
    "Achievement 1",
    "Achievement 2"
]

# Skills
[[extra.skills]]
name = "Skill Name"
level = 95  # Percentage (0-100)

# Projects
[[extra.projects]]
title = "Project Title"
description = "Project description"
technologies = ["Tech 1", "Tech 2"]

# ... and more sections
```

### Available Content Sections

- **Personal Info**: Name, job title, bio, contact details
- **Work Experience**: Job positions with achievements
- **Projects/Interests**: Areas of interest with technologies
- **Skills**: Technical skills with proficiency levels
- **Education**: Educational background
- **Certifications**: Core competencies
- **Languages**: Language proficiency
- **Awards**: Recognition and achievements

## Template Architecture

The theme uses dynamic Tera templates that automatically render content from `config.toml`:

| Template | Data Source | Example |
|----------|-------------|---------|
| `header.html` | `config.extra.name`, `config.extra.email`, etc. | Personal information |
| `experience.html` | `config.extra.experience` array | Work history loop |
| `projects.html` | `config.extra.projects` array | Projects/interests loop |
| `skills.html` | `config.extra.skills` array | Skills with progress bars |
| `education.html` | `config.extra.education` array | Education entries |
| `certifications.html` | `config.extra.certifications` array | Core competencies |
| `languages.html` | `config.extra.languages` array | Language proficiency |
| `awards.html` | `config.extra.awards` array | Awards and recognition |

## Project Structure

```
.
├── config.toml                 # Site configuration and ALL content
├── themes/BelResume/
│   ├── templates/
│   │   ├── index.html         # Main layout (full-width)
│   │   └── partials/          # Dynamic Tera templates
│   │       ├── header.html
│   │       ├── experience.html
│   │       ├── projects.html
│   │       ├── skills.html
│   │       ├── education.html
│   │       ├── certifications.html
│   │       ├── languages.html
│   │       └── awards.html
│   └── static/
│       ├── css/               # Theme styles
│       └── js/                # Theme scripts
├── public/                    # Generated site (after build)
└── README.md                  # This file
```

## Deployment

The site runs on Cloudflare Workers as static assets, at `https://resume.bodnar.sh`. Workers Builds deploys every push to `main` and creates a Worker Preview for every other branch.

### Build Command

```bash
scripts/build.sh
```

Output directory: `public/`. The build writes the Zola site and `resume.md`, and copies `static/resume.pdf`.

The repo has no `package.json`, so Workers Builds gets Bun 1.4.4 from the `BUN_VERSION` build variable on the Worker's build trigger.

### PDF

Browsers can't run in the Workers build, so the PDF is printed locally and committed:

```bash
scripts/print-pdf.sh
```

Run it after editing `config.toml` or the print styles.

## Customization

### Adding New Content

To add a new work experience entry:

```toml
[[extra.experience]]
title = "New Position"
company = "Company Name"
start_date = "2025"
end_date = "Present"
achievements = [
    "Achievement 1",
    "Achievement 2"
]
```

### Changing Color Theme

The site includes three built-in color themes (Blue, Purple, Amber). Users can switch themes using the color selector in the top-right corner.

### Modifying Styles

Custom CSS can be added to `themes/BelResume/static/css/style.css`.

## Recent Improvements (2025)

- ✅ **Dynamic Templates**: Converted all static HTML to Tera templates
- ✅ **Config-Based Content**: All content now managed in `config.toml`
- ✅ **Full-Width Layout**: Removed width constraints for fluid design
- ✅ **Improved Maintainability**: No HTML editing required for content updates

## License

This project uses the BelResume theme. Please refer to the theme's license for usage terms.

## Support

For issues or questions about Zola, visit: https://www.getzola.org/documentation/

---

**Built with** ❤️ **using Zola**