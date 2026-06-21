## 2026-06-21 - [Caching process arguments in Bash]
**Learning:** Shell scripts that repeatedly call `ps | grep | awk` to inspect the same process state suffer from significant overhead due to process forking. Caching the output once and using Bash internal regex matching (`[[ $var =~ regex ]]`) is much more efficient.
**Action:** Always check if external command outputs can be cached in a variable and parsed using Bash built-ins to minimize sub-process spawning.

## 2026-06-21 - [POSIX vs Bash extended test operators]
**Learning:** Using `[` with numeric comparisons like `>=` is invalid in POSIX sh/bash and causes silent failures or syntax errors. `[[` is safer and supports `-ge`, `-le`, etc.
**Action:** Prefer `[[ ... ]]` for comparisons in Bash and ensure correct numeric operators (`-ge`, `-le`) are used instead of string-like operators for integers.
