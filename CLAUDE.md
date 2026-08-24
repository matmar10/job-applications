# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a job application workflow repo for a Staff Software Engineer candidate (Matthew J. Martin) with 20 years experience in payments, fintech, and AI tooling, targeting roles in NYC / New York State.

It is **not a software project** — there is no build system, test suite, or application code. The repo contains resume assets, job application materials, and a structured workflow for applying to roles.

## Workflow

The README defines a two-phase process:

1. **Phase I** — Maintain a base resume (`base-resume.md/.pdf/.docx`) and a `skills.yaml` self-assessment (0–10 ratings per skill keyword).
2. **Phase II** — Raw job reqs are placed as `.txt` files in the `reqs/` folder. For each req file:
   - **(A) Catalog**: Read the req from `reqs/`, create `jobs/[company-name]/` folder (kebab-case), move the req file into it as `jobs/[company-name]/[job-title].txt`, add to the [Notion Job Application Tracker](https://www.notion.so/matthewjosephmartin/Job-Application-Tracker-024c2cd0faf7827faa8d8178801b58e9). Set "Next Action" to "Submit Application" and include the job req URL in the database entry.
   - **(B) Skills Match**: Extract keywords from the job req, cross-reference with `skills.yaml`, prompt candidate on gaps.
   - **(C) Tailored Resume**: Generate role-specific resume from `base-resume.md`, saved as `jobs/[company-name]/[job-title]/matthew-j-martin-resume-for-[job-title]-[company-name].md`. Then run `./generate-resume.sh <path-to-resume.md>` to produce the `.pdf` and `.docx` files. Mark status "Resume Drafted" in Notion.
     - **Startup roles**: If the company is a startup (early-stage, seed, Series A–C, or otherwise described as a startup), prepend **"Preference for early stage, high-pace startups"** as the very first bullet in the Summary of Qualifications section.
     - **Formatting**: Do not include horizontal line breaks (`---`) anywhere in the resume markdown.
     - **Footer**: Every PDF and DOCX must include a footer reading "Resume of Matthew Joseph Martin – Staff Software Engineer  Page X of Y". This is handled automatically by `generate-resume.sh` (Typst header-includes for PDF; `add-footer.py` post-processor for DOCX) — no manual action needed.
     - **About This Resume section**: Include a `## About This Resume` section at the very bottom. Use this exact prose, substituting the role title and company name: "I tailored this resume to the [job title] role at [company name] using an AI-assisted workflow I built. It cross-references my base resume and skills inventory against your specific job requirements to surface where I'm a strong fit. The workflow is open source: [github.com/matmar10/job-applications](https://github.com/matmar10/job-applications)"
     - **Headline subtitle**: Default to **"Staff Software Engineer"** only. Only append a specialization (e.g., "Specializing in Payments" or "Specializing in Financial Systems & Payments") if the role explicitly calls out payments or financial systems as a core focus.
     - **Objective section**: Include an `## Objective` section immediately after the contact header (before Summary of Qualifications). Default text: "Fully in-office or hybrid role in NYC Metro Area in fast-paced, AI-native environment." If the role is a startup, append: "for an early to mid-stage, high-growth startup" (making the full sentence: "Fully in-office or hybrid role in NYC Metro Area in fast-paced, AI-native environment for an early to mid-stage, high-growth startup.")

## Key Files

- `README.md` — Full workflow instructions and naming conventions
- `recent-resume.docx` — Source resume for synthesizing `base-resume.md`
- `skills.yaml` — Skill keyword self-assessments (created during Phase I)
- `base-resume.md` — Canonical generic resume (created during Phase I)
- `generate-resume.sh` — Converts a `.md` resume to `.pdf` (pandoc+typst with custom template and footer) and `.docx` (pandoc + `add-footer.py`)
- `add-footer.py` — Post-processes `.docx` files to inject the footer via python-docx (called automatically by `generate-resume.sh`)
- `resume-template.typst` — Custom Typst template used by `generate-resume.sh` for PDF generation
- `reqs/` — Incoming raw job requirement `.txt` files to be processed
- `jobs/` — Per-company folders with job reqs and tailored resumes

## Integrations

- **Notion** — Job Application Tracker database for status tracking and application catalog. Use the Notion MCP tools to interact with it.

## Conventions

- Company folder names use **kebab-case** (e.g., `jobs/acme-corp/`)
- Resume filenames follow the pattern: `matthew-j-martin-resume-for-[job-title]-[company-name].{ext}`
- When skills are missing from `skills.yaml`, prompt the candidate before assuming a rating
