# The Cowork-only Quarterly Audit (35 points)

Run this every quarter on a Cowork-only org. Skip Claude-Code-only items (hooks, settings.json, branch protection, bash allowlists).

Last run: ___________________

---

## Identity & org (6)

- [ ] SSO enforced on workspace
- [ ] SCIM provisioning current (Enterprise)
- [ ] Orphaned member accounts removed
- [ ] Owner count is 2-3 (not 1, not 10)
- [ ] Tenant restrictions block personal accounts (Enterprise)
- [ ] Custom roles reviewed and members assigned correctly

## Projects (7)

- [ ] All Projects listed in the Project register
- [ ] Each Project has a named owner of record
- [ ] Confidential Projects are private (not org-wide)
- [ ] Org-wide Projects contain no PII / no live credentials
- [ ] Archived Projects truly archived (not just renamed)
- [ ] `Can edit` membership reviewed per Project
- [ ] Project naming convention enforced (`[BU]-[purpose]-[sensitivity]`)

## Custom Knowledge (5)

- [ ] Knowledge inventory exported (file list per Project)
- [ ] PII scan on top 10 Projects by knowledge size
- [ ] Stale documents (older than 6 months unused) removed
- [ ] No live credentials in any knowledge base (run a quick `sk-|ghp_|AKIA` grep on a sample)
- [ ] Uploaded PDFs from external sources flagged + quarantined

## Connectors (8)

- [ ] List of enabled connectors with named business owner
- [ ] Each connector has a documented read/write justification
- [ ] No custom MCP connectors with shared bearer-token URLs (known issue [#44980](https://github.com/anthropics/claude-code/issues/44980))
- [ ] OAuth token rotation policy defined (and followed)
- [ ] Revoked-member token cleanup is documented (manual today)
- [ ] Slack / Notion / Gmail write specifically reviewed
- [ ] Microsoft 365 OAuth scopes audited
- [ ] Google Workspace OAuth scopes audited

## Web / Chrome (3)

- [ ] Web search policy documented per Project type
- [ ] Chrome extension policy set (default OFF unless required)
- [ ] Domain blocklist additions for sensitive sites

## Monitoring & data (4)

- [ ] Cowork log gap acknowledged in writing (Cowork is excluded from Audit Logs / Compliance API / Data Exports)
- [ ] Data retention setting verified
- [ ] Zero-data-retention contractual clause status confirmed
- [ ] SIEM ingestion of available telemetry (whatever IS available)

## Incident readiness (2)

- [ ] Documented Connector-token revocation runbook (disable org-wide → revoke OAuth at third party → force-logout members)
- [ ] Documented "suspected prompt injection" response steps (stop chat, screenshot, disable connectors, notify Owner)

---

**Total: ___ / 35**

Failed items go on the next sprint as `audit:` prefixed tickets. Cowork drift is invisible (no audit log), so the quarterly is your only catch.
