# Bolt's Journal - Zephyrus Performance Optimizations

## 2026-06-26 - Optimized process argument parsing and reduced forks
**Learning:** In Bash scripts that perform many checks against the same process's command-line arguments, repeated calls to `ps`, `grep`, and `awk` create a significant bottleneck due to the overhead of process forking (approx. 4 forks per check). Caching the process output once and using Bash internal regex matching (`[[ $VAR =~ REGEX ]]`) completely eliminates this overhead. Additionally, when parsing flags that may contain comma-separated values, using substring matching (`[[ $VAR == *value* ]]`) or robust regex is essential to handle different value orders.

**Action:** Always check if external process calls in loops or repeated function calls can be replaced with variable caching and Bash built-ins. Use `strace -e trace=execve` to quantify process fork overhead.
