## 2025-01-24 - Bash Process Fork Optimization
**Learning:** In Bash scripts, repeatedly calling external commands like `ps -ef | grep` in a loop or multiple functions is expensive due to process fork overhead. Caching the output in a variable and using Bash's built-in regex (`[[ $var =~ regex ]]`) can significantly improve performance.
**Action:** Always look for repeated calls to the same external command and cache the result. Use `${BASH_REMATCH[1]}` for parsing instead of `awk` or `sed` where possible.
