## 2025-01-24 - Optimization of process-intensive Bash audits
**Learning:** In scripts like `zephyrus.sh` that perform many checks against the same process, calling `ps -ef` repeatedly is a massive bottleneck. Caching the process command line once and using Bash internal regex matching (`[[ $var =~ regex ]]`) can reduce execution time by over 80% and process forks by over 95%.
**Action:** Always check if multiple external command calls can be replaced by a single call and subsequent internal string processing.

## 2025-01-24 - Bash Regex and Substring Matching for Flags
**Learning:** When parsing command-line flags that can be comma-separated (e.g., `--admission-control=A,B,C`), simple regex or equality checks on the value fail if the target is not the first or only item. Using glob matching with unquoted asterisks `[[ $val == *Target* ]]` inside `[[ ]]` blocks is the most robust internal way to handle this.
**Action:** Use `[[ $val == *substring* ]]` for robust flag detection in lists.
