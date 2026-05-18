# Mixed teams (the dominant pattern in 2026)

> Devs on Claude Code, marketing/sales/ops on Cowork, a few power users on both. Most teams of 2 to 30 land here.

[Full playbook ↗](https://docs.heyarnoux.com/teams)

---

## The hard problem

There is **no native sync** between Cowork Project Knowledge and Claude Code's `memory/` folder. [GitHub issue #39051](https://github.com/anthropics/claude-code/issues/39051) asks for it; Anthropic closed it as **not planned**. Same outcome on issues #25833 and #25983.

Decide your sync strategy on day one or accept silent drift.

---

## The single-team-brain reference architecture

```
                    [NOTION: COMPANY BRAIN]
                    (canonical, human-owned)
                    /                    \
            (Notion Connector)        (Notion MCP)
                  /                          \
        [CLAUDE COWORK]                [CLAUDE CODE]
        - Projects                     - CLAUDE.md (repo)
        - Custom Knowledge             - memory/ (repo)
        - Connectors:                  - MCP servers:
          Notion, Slack,                 Notion, Slack,
          Gmail, GDrive                  Gmail, GitHub
              \                          /
               \                        /
        [SHARED SKILL VAULT (git repo)]
                  - skills/*.md (one source)
                  - synced to Cowork plugins (manual or scripted)
                  - symlinked into CC skills dir
                          |
                  [SYNC SCRIPT, weekly cron]
                  - drift report
                  - owner: 1 named person
```

**Three rules that make this work:**

1. **Notion (or whatever you already use) is canonical.** Brand voice, customer dossiers, deal stages, ICP definitions live there. Both tools read from it live via their respective integrations.
2. **The skill vault lives in git**, one maintainer per skill, PR-reviewed. Cowork users get plugin versions; devs get the file versions directly.
3. **Weekly sync ritual.** One person runs a drift-check on Friday: are Cowork Custom Knowledge and CC `memory/` telling the same story? Are skill versions aligned? Fix or escalate.

---

## The MCP parity trick that actually works

If you log into Claude Code with your Claude.ai account, **MCP servers added in Claude.ai (Cowork side) are automatically available in Claude Code**.

This is the parity mechanism Anthropic ships natively. [Official MCP docs](https://code.claude.com/docs/en/mcp).

In practice it covers ~80% of cases. The 20% gap:
- Personal MCP servers added locally on a dev's machine aren't visible to Cowork
- OAuth scope mismatches: Cowork Notion authenticates as the user, CC Notion MCP via API key may be scoped differently

Live with that for now.

---

## Who uses what in a 15-person team

| Role | Primary tool | Plan tier |
|---|---|---|
| Founders, execs | Cowork (web + desktop) | Premium ($100) if they touch dev stuff, else Standard |
| Sales, SDRs | Cowork + Connectors | Standard ($25) |
| CS, ops | Cowork | Standard |
| Marketers (baseline) | Cowork Projects | Standard |
| Marketers (power users, ~20%) | **Both** | Premium |
| Designers | Cowork + Claude Design | Standard or Premium |
| Engineers | Claude Code primarily | Premium |
| PMs, growth, data | **Both** | Premium |

**Realistic 15-person stack:** 5 Premium + 10 Standard = **~$875/mo annual**. Start everyone on Standard. Upgrade to Premium only when someone is spending 10+ hours/week in CC.

---

## Failure modes specific to mixed teams

- **Brand-voice drift.** Marketing updates the voice doc in Cowork Custom Knowledge. Devs are still generating customer-facing copy in CC using the old voice in `CLAUDE.md`. Output diverges by week 3.
- **MCP/Connector permission asymmetry.** Cowork user has Notion with full workspace access; CC user has a scoped PAT to one database. Same person, very different blast radius.
- **Audit gap.** When a leak happens, you find the chat in Cowork logs but the exfil action was a CC `Bash` tool call on a different log stream. Three log streams (web/desktop/CLI), no unified pane unless you route through an MCP gateway.
- **Skill duplication.** Same skill exists as a Cowork plugin AND a CC skill, edited independently. Outputs diverge.
- **Cowork desktop Project knowledge is local-only.** Person leaves, knowledge goes with them.

---

## The Cowork → Claude Code graduation path

When a non-dev outgrows Cowork (signals: copy-pasting CC-style workflows manually, asking to run things on a schedule, wanting to touch their own data files), the safe ramp:

1. Stay on Cowork desktop for one more week. Cowork can run Skills and connect to local file system on macOS/Windows. Use that first.
2. Install CC with the *same* Claude.ai account. MCP connectors inherit automatically.
3. Don't start with `/init` on a real repo. Start with a `~/work-brain/` folder of existing docs, a `CLAUDE.md` describing their role, and one Skill they already use in Cowork ported over.
4. Pair-program first 3 sessions with a dev mentor. Most non-dev failures are git/terminal mechanics, not Claude itself.
5. Cap their tool access with `settings.json` deny rules until they've shipped one real workflow.

---

## Honest gaps for mixed teams

- **No native sync between Cowork Project Knowledge and CC `CLAUDE.md`.** Anthropic closed [#39051](https://github.com/anthropics/claude-code/issues/39051) as not planned. Workarounds are scripts.
- **Unified audit logs across web/desktop/CLI** require an MCP gateway. Not built into Anthropic's offering.
- **Cowork desktop Project sharing** is not yet released as of May 2026 (team sharing is "coming")
- **Cost predictability under the new June 15, 2026 billing split** (first-party vs third-party tools) — heavy CC marketing teams have reported wide variance; no public benchmark for a 15-person team yet
- **No published case study** of a 2-30 person non-tech-first team running both
