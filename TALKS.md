# Talks Section

This document describes how the talks section is generated.

## Overview

The talks section combines two data sources:
- **Invited Seminars**: `../cv/data/invited-seminars.csv` — talks given by invitation
- **Contributed Presentations**: `../cv/data/contributed-presentations.csv` — conference presentations

## Script

The `r/make-talks.R` script generates individual talk pages from these CSV files.

### Data Sources

#### Invited Seminars (`invited-seminars.csv`)
Columns:
- `year` — year of the talk
- `venue` — institution or seminar series
- `title` — talk title

#### Contributed Presentations (`contributed-presentations.csv`)
Columns:
- `key` — unique identifier (used for talk page slugs)
- `year` — year of presentation
- `type` — presentation type (talk/poster)
- `title` — presentation title
- `conference` — conference name
- `location` — conference location
- `note` — optional additional notes

### Template

The `templates/talk.md` file defines the YAML front matter for each talk page:
- `title` — talk title (LaTeX formatting converted to plain text)
- `date` — date (January 1 of the talk year)
- `event` — venue or conference name
- `location` — location of the venue/conference
- `publication_types` — set to `["speech"]`
- `featured` — whether to feature on main page

### Running the Script

To regenerate talk pages:
```r
source("r/make-talks.R")
```

This will:
1. Load both CSV files
2. Generate unique IDs for each talk
3. Create individual directories under `content/talk/`
4. Generate index.md files from the template
5. Report the number of talks created

## Front Matter Notes

- **date**: Set to January 1 of the talk year (matching date in frontmatter)
- **publishDate**: Set to current time when page is first created, preserved if page already exists
- **featured**: Currently set to `false` for all talks — set manually in individual pages if desired
- **LaTeX formatting**: Titles and venues are processed to convert LaTeX markup (e.g., `\textit{...}`) to plain text
