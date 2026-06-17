## 2026-06-17 - Optimized Bash script performance by reducing process forks

**Learning:** Repeated calls to external commands like `ps`, `grep`, and `awk` in a loop or across many functions significantly degrade Bash script performance due to process fork overhead. Caching results in variables and using Bash's built-in regular expression matching (`[[ $var =~ regex ]]`) is exponentially more efficient.

**Action:** Always look for redundant external command calls and replace them with variable caching and Bash internal string/regex processing to minimize sub-process spawning.
