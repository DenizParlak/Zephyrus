## 2024-06-16 - Bash process fork optimization in Zephyrus
**Learning:** In high-frequency audit scripts, spawning external processes like `ps`, `grep`, and `awk` in loops or multiple functions is a major performance bottleneck. Caching the output once and using Bash built-in regex (`[[ $var =~ regex ]]`) can reduce execution time by an order of magnitude (from ~0.4s to ~0.04s) and drastically reduce process forks (from 148 to 4).
**Action:** Always look for repeated process calls and replace them with variable caching and Bash internals where possible.
