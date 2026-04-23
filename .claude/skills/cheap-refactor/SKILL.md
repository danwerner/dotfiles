---
name: cheap-refactor
description: Use for cheap refactors and other small mechanical code changes when we want to save tokens: field or method or file renames, narrow signature updates, import fixes, localized Scala refactors, and similar low-drama edits.
context: fork
agent: cheap-refactor
---

Carry out the user's current request as a cheap, token-saving mechanical refactor.

Prefer:
- cheap discovery with Glob/Grep first
- narrow reads
- minimal edit scope
- a concise result that tells the parent exactly what changed

Return the result using the agent's required output format.
