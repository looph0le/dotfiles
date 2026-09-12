---
name: tech-ai-news
description: >-
  Fetches and summarizes the latest news across Tech, AI, and tech business.
  Trigger keywords: news, tech news, AI news, latest news, daily briefing,
  tech briefing, AI briefing, what's new in tech, what's new in AI, catch me up.
---

# Tech & AI News Briefing

Fetches headlines from 5 curated sources and produces a quick-scan briefing
categorized into **AI & Models**, **Big Tech**, **Startups & Funding**, and
**Research / Open Source**.

## Sources

| Source               | Focus                  |
| -------------------- | ---------------------- |
| The Verge            | General tech + AI      |
| MIT Technology Review| AI deep dives, research|
| TechCrunch           | Startups, funding      |
| The 500 Feed         | AI news aggregator     |
| CurrentLens          | AI research, models    |

## Procedure

### 1. Fetch headlines from all sources

Run parallel `websearch` calls (result count: ~5 per source) to gather the most
recent headlines. Prefer queries that return the current date's or week's
stories:

```
websearch("site:theverge.com AI 2026")
websearch("site:technologyreview.com AI 2026")
websearch("site:techcrunch.com AI 2026")
websearch("site:the500feed.com AI news")
websearch("site:currentlens.com AI news")
```

Also run a broader catch-all:

```
websearch("latest tech AI news July 2026")
```

### 2. Fetch the top stories for detail

From the aggregated headlines, pick the **5-10 most impactful** stories (model
release, major funding round, policy change, breakthrough) and `webfetch` each
article URL to get the full text.

### 3. Synthesize

Organize into categories and write a **quick-scan briefing** with headlines and
1-2 sentence summaries per story. Use this format:

```
═══ Tech & AI Briefing — <current date> ═══

🤖 AI & Models
  • <headline> — <1-2 sentence summary>

🏢 Big Tech
  • <headline> — <1-2 sentence summary>

💰 Startups & Funding
  • <headline> — <1-2 sentence summary>

🔬 Research & Open Source
  • <headline> — <1-2 sentence summary>
```

Omit any category that has no stories. End with a "Worth Watching" line if any
story needs follow-up.

### 4. Output

Print the briefing directly in the chat response.
