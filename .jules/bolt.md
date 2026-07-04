## 2026-07-04 - [Bash Optimization: Reducing Process Forks]
**Learning:** In Bash scripts, repeated calls to external commands like `ps`, `grep`, and `awk` inside functions can create significant overhead due to process forks. Caching the output of an expensive command (like `ps -ef`) into a variable and using Bash's internal regular expression matching (`[[ $string =~ regex ]]`) and the `BASH_REMATCH` array for data extraction can drastically improve performance.
**Action:** Always check if external command results can be cached and parsed using Bash built-ins for performance-critical or frequently executed paths.

## 2026-07-04 - [Correctness in Shell Scripts]
**Learning:** Legacy shell scripts often contain non-standard or error-prone constructs like `[ $var >= 30 ]` or missing spaces in conditionals. These can lead to silent failures or incorrect results. Using `[[ ... ]]` is more robust in Bash.
**Action:** Use `[[ ... ]]` for shell comparisons and always verify syntax with `bash -n`.
