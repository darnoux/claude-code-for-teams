---
description: Research a company and produce a structured one-page brief saved to memory.
user-invocable: true
disable-model-invocation: false
---

# /research [company]

A team-shared workflow. Produces a consistent intelligence brief every time, regardless of which team member runs it.

## Steps

1. **Pull surface signal.** Hit the company's website, LinkedIn page, recent press, Crunchbase if relevant.
2. **Identify the ICP.** Who do they sell to, what segments, what verticals.
3. **Map the GTM motion.** Inbound? Outbound? PLG? Sales-led? Channel?
4. **Find the stack.** What tools do they use publicly? Job postings reveal it.
5. **Look for inflection points.** Recent funding, key hires, product launches, exec changes.
6. **Write the brief** in the format defined in `memory/templates/research-brief.md`.
7. **Save to** `memory/customers/[slug]/profile.md` (slug = company name lowercased + hyphenated).
8. **Append sources** at the bottom with URLs and access date.

## What this skill does NOT do

- Does not write personal information about individuals (no PII)
- Does not save customer credentials, API keys, or contracts
- Does not send any external communication (no Slack, no email)

## When to use

- Before a discovery call with a new prospect
- When prepping a pitch deck for a specific account
- When updating an existing customer's dossier after a key event

## Tools used

- `WebFetch` for site + press
- `Read`, `Write`, `Edit` for the brief
- Optional: Notion MCP read for any internal notes already on file
