# Sync strategies for mixed teams

> There is **no native sync** between Cowork Project Knowledge and Claude Code's `memory/` folder. [GitHub issue #39051](https://github.com/anthropics/claude-code/issues/39051) asks for it; Anthropic closed it as **not planned**. Same outcome on issues #25833 and #25983.
>
> Pick a strategy on day one. Anything is better than drift.

---

## Strategy 1: Notion as canonical upstream (recommended)

Brand voice, customer dossiers, deal stages, ICP definitions all live in Notion (or your equivalent). Both tools read from it live.

```
              [NOTION: COMPANY BRAIN]
                 (one source of truth)
                /                    \
        (Notion Connector)        (Notion MCP)
              ↓                          ↓
       [CLAUDE COWORK]             [CLAUDE CODE]
       reads via Connector          reads via MCP
```

**Pros:**
- Both surfaces always read fresh
- No copy-paste, no manual sync
- Notion is already where most teams keep the brain anyway

**Cons:**
- Requires Notion (or equivalent: Confluence, GitBook)
- MCP and Connector scopes must be kept in parity manually (Cowork user with full workspace access vs CC user with scoped PAT to one database is a real footgun)
- Notion access controls have to map to your team's role-based access

**Best for:** teams of 2-30 where Notion / Confluence already exists and is loved.

---

## Strategy 2: Git as canonical upstream

`CLAUDE.md` + `memory/` in the team repo is the source of truth. Cowork users get a weekly snapshot pasted into Project Custom Knowledge.

```
        [GIT REPO: CLAUDE.md + memory/]
                 (one source)
                /             \
        (git pull)      (manual snapshot, weekly)
              ↓                ↓
       [CLAUDE CODE]    [CLAUDE COWORK]
       reads from        Project Custom
       repo directly     Knowledge holds
                         the snapshot
```

**Pros:**
- Engineering-first teams love this
- PR-reviewed, version-controlled
- Cowork users get a stable snapshot (no live drift)

**Cons:**
- Cowork users see stale content (the time between snapshots)
- Someone has to run the snapshot ritual every week
- Non-dev users may not understand they're seeing yesterday's data

**Best for:** engineering-led teams where Cowork is a secondary surface for execs / sales who don't need the freshest data.

---

## Strategy 3: Skill-vault sync (for the skills layer specifically)

Skills are the team's shared muscle memory. They drift the fastest. This strategy handles just the skills:

```
        [SHARED SKILL VAULT (git repo)]
        skills/*.md (one source)
              ↓                    ↓
        (npm/script-deploy)    (symlink/copy)
              ↓                    ↓
       [Cowork plugin]        [CC .claude/skills/]
       installed per user     committed to team repo
```

Use this in addition to Strategy 1 or 2, not instead.

**A scrappy sync script you can adapt:**

```bash
#!/bin/bash
# weekly-skill-drift-check.sh
# Runs as cron Friday 9am. Owner: one named person.
# Compares the skill vault (canonical) to what's actually deployed.

VAULT_DIR="$HOME/team-brain/skills"
CC_SKILLS_DIR="$HOME/team-repo/.claude/skills"
REPORT="$HOME/Desktop/skill-drift-$(date +%Y-%m-%d).txt"

echo "Drift report $(date)" > "$REPORT"
echo "" >> "$REPORT"

echo "=== Skills in vault ===" >> "$REPORT"
ls "$VAULT_DIR" >> "$REPORT"

echo "" >> "$REPORT"
echo "=== Skills in CC (.claude/skills/) ===" >> "$REPORT"
ls "$CC_SKILLS_DIR" >> "$REPORT"

echo "" >> "$REPORT"
echo "=== Diff (vault vs CC) ===" >> "$REPORT"
diff -r "$VAULT_DIR" "$CC_SKILLS_DIR" >> "$REPORT" 2>&1 || true

echo "" >> "$REPORT"
echo "=== Cowork plugin versions (manual check) ===" >> "$REPORT"
echo "Open Cowork → Admin → Plugins. Verify each skill matches vault." >> "$REPORT"

# Email or Slack the report
open "$REPORT"
```

---

## Strategy 4: "Let it drift" (honest default for small teams)

For 2-5 person teams where one person knows everything, the cost of a sync ritual exceeds the cost of occasional drift. Accept it.

- Document that you're consciously not syncing
- Add a quarterly "manual review" instead
- Watch for failure modes (brand-voice drift, MCP scope drift) and fix when they bite

**When this stops working:** at ~6 people or when the first drift incident causes real damage. Then graduate to Strategy 1 or 2.

---

## Which strategy to pick

| Team size | Likely best strategy |
|-----------|---------------------|
| 1-5 | Strategy 4 (let it drift) until a real failure forces an upgrade |
| 5-15 | Strategy 1 (Notion canonical) + Strategy 3 (skill vault) |
| 15-30 | Strategy 1 + Strategy 3, with a named "AI ops" owner running the weekly drift check |
| 30+ | You probably need a custom MCP gateway and a real platform team. This playbook stops being enough. |

---

## Anti-patterns to avoid

- **Two canonical sources.** "Notion AND the git repo are both canonical." This is the most common drift cause. Pick one.
- **Manual cross-edit.** Editing the same content directly in both Cowork and CC. Inevitably diverges.
- **Implicit ownership.** "Someone on the team will keep them aligned." Nobody owns it, so nobody does it.
- **Bidirectional sync.** Trying to sync changes from Cowork back to git + from git back to Cowork. Conflict resolution is hell. Pick a single source and a single direction.
- **Believing Anthropic will fix this soon.** Issues #39051, #25833, #25983 all closed not planned. Plan around the gap.
