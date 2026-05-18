## What

<!-- One sentence on the user-visible change. -->

## Why

<!-- The problem this PR solves, or the goal. -->

## How

<!-- Bullet list of the main changes. Mention which files Claude edited vs. human edited if relevant. -->

-

## Test plan

- [ ] Lint passes
- [ ] Tests pass locally
- [ ] Manually verified the change in dev
- [ ] No secrets introduced (gitleaks clean)

## AI-collaboration notes

<!-- If Claude Code or another agent wrote significant code: -->
<!-- - Which model/agent: -->
<!-- - Any guardrails that fired (hooks, deny rules): -->
<!-- - Any prompts worth saving to the team brain (memory/lessons.md): -->

## Checklist for the reviewer

- [ ] CODEOWNERS path-routing matches what was changed
- [ ] No new MCP added without a security review
- [ ] No new env var introduced without doc + .env.example update
- [ ] If `/memory/` was edited, the change is intentional and reversible
