# Starter kit (Claude Code)

> Path C of the playbook. Copy this entire folder into your team's brain repo, customize, commit.

This is the default for engineering-led teams. If your team is on Cowork instead, see [`../cowork`](../cowork). If you have devs on Claude Code and the rest of the team on Cowork, see [`../mixed`](../mixed).

---

## What's inside

```
starter/
├── CLAUDE.md.example              ← team rules template (< 200 lines)
├── .mcp.json.example              ← MCP scaffold with pinned versions + read-only scopes
├── .claude/
│   ├── settings.json              ← deny rules, env vars, hook wiring
│   ├── hooks/
│   │   ├── block-destructive.sh   ← blocks rm -rf, sudo, mkfs before they run
│   │   ├── require-approval.sh    ← forces human approval for prod MCP writes
│   │   ├── scan-write-for-secrets.sh  ← blocks API keys in writes
│   │   └── audit-log.sh           ← JSONL log of every tool call
│   ├── rules/
│   │   └── code-style.md          ← path-scoped rule example
│   ├── skills/
│   │   └── research/SKILL.md      ← sample team-shared skill
│   └── agents/
│       └── code-reviewer.md       ← sample subagent
└── .github/
    ├── CODEOWNERS                 ← route AI-edited paths to a human
    ├── workflows/ai-safety.yml    ← secrets + PII guard on every PR
    └── pull_request_template.md
```

---

## Quick install

```bash
# 1. clone this repo
git clone https://github.com/darnoux/claude-code-for-teams.git

# 2. copy starter/ into your team repo (note: -R also catches dotfiles)
cp -R claude-code-for-teams/starter/* /path/to/your-team-repo/
cp -R claude-code-for-teams/starter/.[!.]* /path/to/your-team-repo/

# 3. rename examples
cd /path/to/your-team-repo
mv CLAUDE.md.example CLAUDE.md
mv .mcp.json.example .mcp.json

# 4. customize the three files that need it
$EDITOR CLAUDE.md .github/CODEOWNERS .mcp.json

# 5. hook scripts are already executable. verify:
ls -l .claude/hooks/*.sh

# 6. enable GitHub Rulesets on main (the gh CLI command is in the playbook, section 7)

# 7. commit + open a PR, let the team review the baseline
```

---

## What each file does (one line each)

| File | What |
|---|---|
| `CLAUDE.md.example` | Team rules in plain English. The "operating system" Claude boots into. Keep it under 200 lines (auto-memory load limit). |
| `.mcp.json.example` | Project-scoped MCP servers, committed and shared with the team. Pin every version. |
| `.claude/settings.json` | Permission deny rules, env vars, hook wiring. **Treat this as load-bearing.** |
| `.claude/hooks/block-destructive.sh` | PreToolUse hook for Bash. Blocks `rm -rf`, `sudo`, `mkfs`, `dd if=/dev/zero` etc. Exit 2 hard-blocks. |
| `.claude/hooks/require-approval.sh` | PreToolUse hook for MCP tool calls. Forces an "ask" prompt on writes to production MCPs. |
| `.claude/hooks/scan-write-for-secrets.sh` | PreToolUse hook for Write/Edit. Blocks API keys in committed content + writes to `.env` etc. |
| `.claude/hooks/audit-log.sh` | PostToolUse hook. Appends every tool call to a JSONL log for SIEM ingestion. |
| `.claude/rules/code-style.md` | Universal code-style rules. Loads every session. Add path-scoped rules in sibling files. |
| `.claude/skills/research/SKILL.md` | Sample team-shared skill. Markdown only, no code. Use as a template for more. |
| `.claude/agents/code-reviewer.md` | Sample subagent with explicit model + tools. Use for `/pr-review` style workflows. |
| `.github/CODEOWNERS` | Routes AI-edited paths to a senior reviewer. Pair with branch protection. |
| `.github/workflows/ai-safety.yml` | Scans every PR for secrets + PII + `@latest` pinning + brain-file regressions. |
| `.github/pull_request_template.md` | Forces reviewer to think about AI-collaboration notes on every PR. |

---

## What to do AFTER copying

1. **Test the hooks fire.** From inside your team repo, ask Claude to run `rm -rf .` and watch `block-destructive.sh` reject it.
2. **Enable GitHub Rulesets.** The playbook section 7 has the exact `gh api` command.
3. **Set `permissions.disableBypassPermissionsMode: "disable"`** in managed settings if you have Team/Enterprise.
4. **Audit every team member's shell** for `ANTHROPIC_API_KEY`. If set, it overrides your subscription billing silently.
5. **Schedule the quarterly audit** ([../audit-checklist.md](../audit-checklist.md)).

---

## Where to go next

- Read the full long-form playbook: [docs.heyarnoux.com/teams](https://docs.heyarnoux.com/teams)
- Run the 60-point quarterly audit: [`../audit-checklist.md`](../audit-checklist.md)
- If half your team is on Cowork: [`../mixed`](../mixed)
