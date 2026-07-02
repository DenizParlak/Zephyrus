## 2026-07-02 - Bash Optimization by Caching Process Output
**Learning:** For scripts that perform many checks against the same process's command-line arguments, caching the output of `ps -ef` into a variable once at the start and using Bash's internal regex matching (`[[ $VAR =~ REGEX ]]`) is significantly faster than spawning subshells with `ps | grep | awk` chains for every check.
**Action:** Always look for redundant process forks in loops or repeated function calls and consolidate them using variable caching and internal string manipulation.

## 2026-07-02 - Robust Flag Parsing in Bash
**Learning:** When parsing command-line flags in Bash that may contain comma-separated values (e.g., `--admission-control`), use a regex pattern like `[^[:space:]]+` to capture the entire value, and then use substring matching `[[ $VAR == *substring* ]]` to check for specific elements within that value. This is more reliable than using `grep -o` with patterns that might prematurely terminate at a comma.
**Action:** Use broad regex patterns for capture and unquoted glob patterns for membership checks in comma-separated strings.
