## 2024-05-23 - Drastic Reduction in Process Spawning via Caching and Bash Built-ins

**Learning:** In legacy Bash scripts, it's common to see expensive external command pipelines (like `ps -ef | grep | awk`) repeated many times. This causes significant overhead due to process spawning (`execve`). Caching the result of a single expensive command into a variable and using Bash's internal regular expression matching (`[[ $var =~ regex ]]`) can reduce the number of spawned processes by orders of magnitude and drastically improve execution time.

**Action:** Always look for repeated calls to external commands (`ps`, `grep`, `sed`, `awk`) in Bash scripts. Cache results and use Bash built-ins whenever possible.
