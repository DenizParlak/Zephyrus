## 2025-05-14 - [Bash Process Optimization]
**Learning:** Caching output of expensive external commands (like 'ps -ef') and using Bash internal regex matching ([[ $var =~ regex ]]) drastically reduces execution time and system overhead by avoiding hundreds of sub-process forks.
**Action:** Always look for repeated calls to 'ps', 'grep', or 'awk' in Bash loops or repeated functions and replace them with variable caching and internal string manipulation.
