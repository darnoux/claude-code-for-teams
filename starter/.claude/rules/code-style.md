---
description: Universal code style rules. Loaded every session.
---

# Code style

- Functions do one thing. If you can't name it in 3 words, split it.
- Avoid premature abstraction. Three similar lines is fine. Five is when to consider refactoring.
- Trust framework guarantees. Don't validate what the compiler already validates.
- Only add error handling for cases that can actually happen.
- Default to writing no comments. Add one only when the WHY is non-obvious.
- Don't reference the current task or fix in code comments. That belongs in the PR description.

# Naming

- Booleans: `isReady`, `hasAccess`, `shouldRetry` — not `ready`, `access`, `retry`.
- Functions that return: verb + noun (`fetchUser`, `parsePayload`).
- Functions that mutate: action + target (`addItem`, `clearCache`).

# What to avoid

- Catch-all `try { ... } catch (e) { console.error(e) }` blocks. Either handle the error or let it bubble.
- Re-exporting types just because.
- "Util" files that grow into 500-line dumping grounds.
- Renaming variables to `_var` instead of deleting them. Delete them.
