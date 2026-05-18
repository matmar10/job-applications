# Matthew J. Martin — Job Application Workflow

Hi! If you're a prospective employer who followed the link from my resume, welcome. 

This is the workflow I built to assist with applications during my job search.

## What This Is

This repo is an AI-assisted job application pipeline built on top of [Claude Code](https://claude.ai/code). Instead of sending the same generic resume everywhere, it tailors my resume to each specific role by analyzing the job requirements against my base resume and a self-assessed skills inventory. The case for doing this is clear: according to [Huntr's Q2 2025 Job Search Trends Report](https://huntr.co/research/job-search-trends-q2-2025), tailored resumes convert at 5.75% from application to interview versus 2.68% for generic ones — a 115% improvement.

## How It Works

**Phase I — Foundation**

A canonical `base-resume.md` and `skills.yaml` serve as the source of truth. `skills.yaml` is a keyword-level self-assessment (0–10) across every technology and discipline I've worked in — it's what drives honest gap analysis rather than keyword stuffing.

**Phase II — Per-Role Pipeline**

For each job posting:

1. **Catalog** — The req is saved and tracked in a [Notion database](https://matthewjosephmartin.notion.site/8f7c2cd0faf783b796c08180da47f65b?v=0ffc2cd0faf782ee8c5308e59b0a2578&source=copy_link) with status, salary range, and application link.
2. **Skills match** — Keywords are extracted from the posting and cross-referenced against `skills.yaml`. Gaps are surfaced explicitly rather than papered over.
3. **Tailored resume** — A role-specific resume is generated from `base-resume.md`, emphasizing the strongest fit for that particular role. It's exported to PDF (via [Typst](https://typst.app)) and DOCX, then uploaded to Google Drive and linked back into the Notion tracker.

## Repository Structure

```
base-resume.md          # Canonical source resume
skills.yaml             # Self-assessed skill ratings (0–10)
generate-resume.sh      # Converts .md → .pdf (pandoc + typst) and .docx
upload-resume.sh        # Uploads pdf/docx to Google Drive, returns shareable URLs
jobs/
  [company-name]/
    [job-title].txt     # Original job posting
    matthew-j-martin-resume-for-[job-title]-[company-name].md
    matthew-j-martin-resume-for-[job-title]-[company-name].pdf
    matthew-j-martin-resume-for-[job-title]-[company-name].docx
```

## Why I Built This

Applying thoughtfully at scale is a solved problem if you treat it like an engineering problem. This workflow keeps me honest about fit, saves time on formatting, and ensures every resume I send is genuinely tailored — not just a find-and-replace on a template.

---

Matthew J. Martin · [LinkedIn](https://linkedin.com/in/matthewjosephmartin) · [GitHub](https://github.com/matmar10) · me@matmar10.com
