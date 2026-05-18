# The Mixed-Team Audit (40 points)

For teams running both Claude Cowork and Claude Code. Run quarterly. This is the union of the [Claude Code 60-point audit](../audit-checklist.md) and the [Cowork 35-point audit](../cowork/audit-checklist.md), tightened to the items that actually shift in a mixed setup.

Last run: ___________________

---

## Plan tier + seat allocation (5)

- [ ] Team plan tier matches your mix (Premium for devs + power users, Standard for the rest)
- [ ] Active user count tracked per surface (Cowork vs Claude Code) not just per seat
- [ ] Per-user spend cap configured on Premium seats
- [ ] No team member has `ANTHROPIC_API_KEY` set in their shell (silent overspend, audit shells)
- [ ] June 15, 2026 billing split accounted for (first-party tools vs third-party SDK pool)

## Shared source of truth (8)

- [ ] One canonical upstream brain identified (Notion / Confluence / similar) and documented
- [ ] Both surfaces read from upstream (Cowork via Connector, CC via MCP), not from separate copies
- [ ] Named owner for the upstream brain (one human, not "the team")
- [ ] Weekly sync ritual on the calendar
- [ ] Skill vault lives in git, PR-reviewed
- [ ] Skill versions in Cowork plugins match the git source (drift report green)
- [ ] No "shadow brain" in someone's personal Notion or personal Cowork Project
- [ ] Cowork desktop Project knowledge documented as ephemeral (lost when user leaves)

## MCP / Connector parity (7)

- [ ] Login pattern documented: CC users log in with their Claude.ai account so MCP servers inherit
- [ ] MCP allowlist (CC side) and Connector allowlist (Cowork side) reviewed for parity quarterly
- [ ] Same SaaS tool has matching scopes on both sides (e.g. Notion is read-only on Cowork → must also be read-only via the CC Notion MCP)
- [ ] Personal MCP servers on dev machines documented (the 20% gap that Cowork can't see)
- [ ] Slack write scope is bot-channel-only on BOTH surfaces
- [ ] Email-send MCPs / Connectors disabled on BOTH surfaces (zero blast radius)
- [ ] Connector-revocation runbook covers BOTH the Cowork OAuth side and the CC MCP token side

## Audit + logging (5)

- [ ] Acknowledged in writing: Cowork is excluded from Anthropic's Audit Logs, Compliance API, Data Exports, and BAA
- [ ] CC `audit-log.sh` hook ships JSONL to a known location (SIEM or shared drive)
- [ ] Quarterly review of CC audit logs scheduled
- [ ] Quarterly review of Cowork Connector activity (at the third-party side, since Cowork itself doesn't log) scheduled
- [ ] Incident response runbook covers the three-log-stream reality (web / desktop / CLI)

## Onboarding + offboarding (5)

- [ ] New joiners get the right onboarding script (Cowork only, CC only, or both)
- [ ] Bridge users (both tools) have the explicit handoff ritual documented (plan in Cowork → execute in CC → review in Cowork)
- [ ] Graduation path documented (Cowork user → CC user when they outgrow Cowork)
- [ ] Offboarding revokes BOTH workspace access AND CC repo access AND OAuth grants at every third party
- [ ] Departed user's Cowork desktop Projects archived/handed off before access cut

## Drift prevention (5)

- [ ] Brand voice doc: one source, both surfaces read from it (not duplicated)
- [ ] Customer dossiers: one source (`memory/customers/` OR Notion DB), both surfaces read from it
- [ ] Skill duplication scan: same skill doesn't exist as both a Cowork plugin AND a CC skill edited independently
- [ ] Quarterly "drift report" generated (manual or scripted): aligned / missing / drifted / duplicated artifacts
- [ ] One named person owns "weekly sync"

## CVE + supply chain (5)

- [ ] Latest npm/PyPI security advisories reviewed (CVE-2026-45321 "Shai-Hulud" was the May 2026 one)
- [ ] No `@latest` versions in `.mcp.json` (CC) or in any custom MCP server (Cowork side)
- [ ] Hook scripts pinned + checksummed if running on prod CI
- [ ] Dependabot enabled on the brain repo
- [ ] GitHub `ai-safety.yml` workflow green on the last 10 PRs

## Sanity checks (5)

- [ ] Both surfaces produce work in the team's actual voice (sample 3 outputs from each side, compare)
- [ ] Onboarding 1:1 in the last 90 days has happened (or scheduled)
- [ ] `memory/lessons.md` updated in last 7 days
- [ ] `lessons.md` content reflected back into Cowork Custom Knowledge where relevant
- [ ] This audit on the calendar for next quarter

---

**Total: ___ / 40**

Mixed teams have more failure surface than either single-tool setup. The audit's job is to keep drift from compounding silently between the two surfaces.

Failed items go on the next sprint as `audit:` prefixed tickets. Owner per item, due date per item.
