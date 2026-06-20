## 2026-06-20 - Optimize Kubernetes auditing script by caching process arguments
**Learning:** The `zephyrus.sh` script was spawning over 140 processes (mostly `ps`, `grep`, and `awk`) to perform 25 checks. By caching the `ps -ef` output once and using Bash built-in regex matching, the process fork count was reduced to 4.
**Action:** Always look for repeated expensive commands (like `ps`, `find`, or network calls) in loops or sequences and cache their results. Use Bash's `[[ $var =~ regex ]]` for efficient string parsing without subshells.
