# The 60-Point Quarterly Audit

Run this every quarter. Cross out what's drifted. Update.

Last run: ___________________

---

## Repo + governance (10 points)

- [ ] Branch protection ruleset active on `main`
- [ ] `required_approving_review_count` ≥ 1
- [ ] `require_code_owner_review` = true
- [ ] `required_signatures` = true (and signing actually works for the team)
- [ ] `non_fast_forward` and `deletion` rules active
- [ ] CODEOWNERS exists and routes `/CLAUDE.md`, `/.claude/`, `/memory/` to a senior reviewer
- [ ] CODEOWNERS routes `/db/migrations/`, `/infra/`, `/.github/workflows/` to a senior reviewer
- [ ] No one (including admins) bypasses branch protection
- [ ] Required status checks include `ai-safety` workflow
- [ ] `dismiss_stale_reviews_on_push` = true

## Secrets + supply chain (10 points)

- [ ] GitHub secret scanning enabled
- [ ] GitHub push protection enabled
- [ ] Dependabot alerts enabled
- [ ] Dependabot security updates enabled
- [ ] `ai-safety.yml` workflow active and green on every PR
- [ ] Gitleaks pre-commit hook configured on every developer's machine
- [ ] No `@latest` versions in `package.json`, `.mcp.json`, or any shell script
- [ ] `CLAUDE_CODE_SUBPROCESS_ENV_SCRUB=1` set on every machine
- [ ] `.env` in `.gitignore` verified
- [ ] No credentials in any committed file (full-repo gitleaks scan clean)

## MCP access (10 points)

- [ ] `.mcp.json` committed, contains only sanctioned servers
- [ ] Each MCP version pinned (no `@latest`)
- [ ] Production database MCPs are read-only by configuration
- [ ] No email-send MCPs in any session
- [ ] Slack MCP scoped to one bot channel, not `#general`
- [ ] Notion MCP is page-scoped, not workspace-wide
- [ ] GitHub MCP using fine-grained PAT with minimum scopes
- [ ] `managed-mcp.json` deployed via IT (if Team/Enterprise)
- [ ] MCP allowlist documented in CLAUDE.md or sibling file
- [ ] Every MCP server has a named owner (who reviews PRs to its config)

## Permissions + hooks (10 points)

- [ ] `.claude/settings.json` committed, contains team's deny rules
- [ ] Deny list includes `rm -rf*`, `sudo*`, `git push --force*`
- [ ] `block-destructive.sh` hook live and tested (try `rm -rf .`, verify block)
- [ ] `require-approval.sh` hook live for prod MCP writes
- [ ] `scan-write-for-secrets.sh` hook live for Write/Edit
- [ ] `audit-log.sh` hook live, rolling to a known location
- [ ] `bypassPermissions` mode disabled via managed settings
- [ ] `allowManagedHooksOnly` set on Team/Enterprise
- [ ] No team member has `ANTHROPIC_API_KEY` set on their machine (audit shells)
- [ ] `CLAUDE_CODE_DISABLE_FAST_MODE=1` set on every machine

## Skills + agents (5 points)

- [ ] The 4 starter skills exist (/research, /meeting-prep, /draft-email, /pr-review)
- [ ] All skills go through CODEOWNERS review on changes
- [ ] Subagents in `.claude/agents/` have explicit `model` selection
- [ ] Agent Teams (experimental) is disabled by default, enabled per-session if used
- [ ] Routines (if used) run under a service account, not an individual's identity

## Cost + compliance (10 points)

- [ ] Plan tier matches team size (individual ≤5, Team Premium 5-30, Enterprise 30+)
- [ ] Monthly cost ritual scheduled (last Friday)
- [ ] Active user count tracked (not just seat count)
- [ ] Per-user spend cap configured on Team plan
- [ ] SOC 2 / ISO docs on file
- [ ] Updated DPA on file (effective Jan 1, 2026)
- [ ] Compliance API access if regulated
- [ ] Audit log retention policy defined (how long, where)
- [ ] No PII in `memory/customers/` (sample check)
- [ ] GDPR data-subject request runbook exists

## Rituals + onboarding (5 points)

- [ ] `memory/lessons.md` updated in last 7 days
- [ ] Weekly `/retro` being run by at least one team member
- [ ] Monthly `/learn` on the calendar
- [ ] Onboarding 2-hour 1:1 documented and the next joiner has a slot
- [ ] This audit checklist on the calendar for next quarter

---

**Total: ___ / 60**

Failed items go on the next sprint as `audit:` prefixed tickets. Don't let drift compound.
