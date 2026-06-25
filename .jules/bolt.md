## 2026-06-25 - Bash Script Process Fork Optimization
**Learning:** Redundant process forks in shell scripts (especially inside loops or multiple functions) can be a major performance bottleneck. Caching expensive command outputs (like `ps -ef`) into a variable and using Bash internal string manipulation and regex matching (`[[ $VAR =~ REGEX ]]`) can reduce execution time by an order of magnitude.

**Action:** When auditing shell scripts, look for patterns of repeated external command calls. Use `strace -f -e trace=execve` to quantify the fork overhead and apply caching where applicable.

## 2026-06-25 - Handling Comma-Separated Values in Bash
**Learning:** When parsing Kubernetes flags that may contain comma-separated values (like `--admission-control`), using exact string equality for checks is fragile and often incorrect. Substring matching or more robust regex is needed to ensure a value is present in the list regardless of its position.

**Action:** For list-like values in flags, always use `[[ $VAR == *substring* ]]` or `[[ $VAR =~ regex ]]` instead of `[ "$VAR" == "value" ]`.
