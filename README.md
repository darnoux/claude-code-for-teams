# Claude Code for Teams

> The starter kit for running Claude Code across a team of 2 to 30 users. Devs, marketers, sales, ops.

[**Read the full playbook (~30 pages) →**](https://docs.heyarnoux.com/teams)

This repo is the executable companion. Clone it, copy `starter/` into your project, customize, ship.

---

## Pick your path

Most teams of 2 to 30 run one of three setups. Pick yours first.

| Path | For | Start here |
|------|-----|-----------|
| **A. Cowork-only** | Marketing, sales, ops, finance, legal teams. No terminal users. | [`/cowork`](./cowork) |
| **B. Mixed** | Devs on Claude Code + everyone else on Cowork. **Most teams of 2-30 in 2026.** | [`/mixed`](./mixed) |
| **C. Claude Code only** | Engineering-led teams. Repo-first. | [`/starter`](./starter) (this is the default) |

The big asymmetry: **Cowork is excluded from Anthropic's Audit Logs, Compliance API, Data Exports, and BAA** as of May 2026. If you're in a regulated industry, Cowork is disqualified for sensitive workloads. Put that work in Claude Code (which IS covered).

---

## What's in here

```
.
├── starter/                     ← Path C, copy this into your team repo (Claude Code)
│   ├── .claude/
│   │   ├── settings.json        ← deny rules, env vars, hook wiring
│   │   ├── hooks/               ← 4 baseline hooks (block-destructive, require-approval, scan-secrets, audit-log)
│   │   ├── skills/research/     ← sample team-shared skill
│   │   ├── agents/              ← sample subagent (code-reviewer)
│   │   └── rules/               ← path-scoped rule examples
│   ├── .github/
│   │   ├── CODEOWNERS           ← route AI-edited paths to a human
│   │   ├── workflows/ai-safety.yml  ← secrets + PII guard on every PR
│   │   └── pull_request_template.md
│   ├── .mcp.json.example        ← read-only MCP scaffold (pinned versions)
│   └── CLAUDE.md.example        ← team rules template (< 200 lines)
├── cowork/                      ← Path A, Cowork-only governance kit
│   ├── README.md
│   ├── audit-checklist.md       ← 35-point quarterly audit (Cowork-scoped)
│   └── starter-kit.md           ← process-only artifacts (Cowork has no commitable settings)
├── mixed/                       ← Path B, mixed-team architecture + ops
│   ├── README.md                ← reference architecture, role-by-tool map, graduation path
│   ├── audit-checklist.md       ← 40-point quarterly audit (mixed-team scoped)
│   └── sync-strategies.md       ← 4 strategies for one-canonical-source across both tools
├── audit-checklist.md           ← 60-point quarterly audit (Claude Code side)
├── LICENSE                      ← MIT
└── README.md
```

---

## Quick start (10 minutes)

```bash
# 1. clone this repo
git clone https://github.com/darnoux/claude-code-for-teams.git

# 2. copy the starter into your team repo
cp -R claude-code-for-teams/starter/* /path/to/your-team-repo/
cp -R claude-code-for-teams/starter/.* /path/to/your-team-repo/ 2>/dev/null

# 3. customize CLAUDE.md, CODEOWNERS, and .mcp.json
cd /path/to/your-team-repo
mv CLAUDE.md.example CLAUDE.md
mv .mcp.json.example .mcp.json
$EDITOR CLAUDE.md .github/CODEOWNERS .mcp.json

# 4. make hook scripts executable
chmod +x .claude/hooks/*.sh

# 5. enable GitHub Rulesets on main (the gh command is in the playbook)
# 6. commit, push, open a PR, let the team review the baseline
```

The full 21-step setup, the rationale behind every config, the 60-point quarterly audit, and the role playbooks (founder, senior dev, junior, designer, marketer, sales, ops, legal, finance) live at:

**[docs.heyarnoux.com/teams](https://docs.heyarnoux.com/teams)**

---

## The thesis

It's not the folder tree.

90% of "Claude Code for teams" content on the internet is folder-tree screenshots. The folder tree matters maybe 10% of the outcome. What matters more, in order:

1. **Access control**, who can read which MCP, who can write
2. **Version control**, branch protection, CODEOWNERS, signed commits
3. **Hooks at the harness layer**, not prose in CLAUDE.md
4. **Isolation per session**, the lethal trifecta defense
5. **Permissions matrix**, what each user can run + see

Blast radius is set at config time, not prompt time. Access control is the load-bearing wall.

---

## The 4 outcomes you're shooting for

1. **One shared repo**, everyone clones the same baseline
2. **One shared memory**, lessons, customer dossiers, patterns, templates
3. **Memory that compounds**, each `/retro` adds, nothing resets
4. **Scoped access per user**, marketer ≠ junior ≠ CTO

The team gets smarter every week. The risk does not.

---

## License

MIT. Use it, fork it, ship it. PRs welcome.

---

## Credits

Built by [GenAI ● Circle](https://www.genaicircle.com). Companion to the full playbook at [docs.heyarnoux.com/teams](https://docs.heyarnoux.com/teams).

If this saves your team a day, [say hi on LinkedIn](https://www.linkedin.com/in/davidarnoux/).
