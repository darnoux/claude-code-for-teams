# Cowork-only teams

> For teams running **Claude Cowork** (Anthropic's web + desktop product) without Claude Code. Marketing, sales, ops, finance, legal teams. No terminal users.

[Full playbook ↗](https://docs.heyarnoux.com/teams)

---

## The big asymmetry to know up front

**Cowork is excluded from Anthropic's Audit Logs, Compliance API, Data Exports, and BAA** as of May 2026, even on Enterprise.

If you're in a regulated industry, Cowork is disqualified for sensitive workloads until that gap closes. Put that work in Claude Code (which IS covered).

Sources: [Anthropic privacy docs](https://privacy.claude.com/en/articles/8114513-business-associate-agreements-baa-for-commercial-customers), [Harmonic Security practitioners' guide](https://www.harmonic.security/resources/securing-claude-cowork-a-security-practitioners-guide).

---

## What's in this folder

- `audit-checklist.md` — 35-point quarterly audit for Cowork-only orgs (skip the CC-specific items)
- `starter-kit.md` — process-only artifacts you put in your admin docs (Cowork has no commitable settings)
- `roster-template.md` — Project register, Connector register, knowledge inventory templates

There's no `settings.json`, no `.claude/`, no `hooks/`. Cowork doesn't have a harness layer. Governance is admin-console + Connector policy + process discipline.

---

## The Cowork three-brain model

| Brain | Lives at | Owner |
|---|---|---|
| Personal | Your individual Projects + global custom instructions | You |
| Shared team | Org-wide Projects + a canonical "Templates" Project | Workspace admin |
| Org-managed | Admin console at `console.claude.com` + role-based access (Enterprise) | IT / Owner |

**Biggest gap:** no admin-push primitive for standard knowledge. An admin cannot deploy a "managed CLAUDE.md" that overrides user behavior. Workaround: one canonical "Templates" Project shared org-wide with `Can view`. Treat it as your CLAUDE.md equivalent.

---

## What Cowork access control actually exists

- **Per-Project access:** private / specific people / org-wide. Two tiers: *Can view* / *Can edit*.
- **Per-Connector access:** org-wide on/off only. Owner enables → every member OAuths individually. No per-user allowlist exists.
- **Per-action policy:** for each Connector, Owner sets Always allow / Needs approval / Blocked. Use Needs approval for any write action.
- **RBAC (Enterprise):** custom roles for Cowork capability access.

---

## When Cowork-only is the right call

- Teams with zero or near-zero terminal users (sales, success, ops, finance, legal, HR)
- Workloads dominated by reading and synthesising over connected knowledge
- Multi-tenant client work with isolated Projects per client
- Compliance contexts where you actively want to deny filesystem and shell access
- 2-30 person teams with one ops/admin person, not a security engineer

If you need filesystem isolation, managed CLAUDE.md, hook-based policy enforcement, branch-protection-tied review, or shell allowlists — **Cowork can't give you those.** Add Claude Code for the subset of users who need them.
