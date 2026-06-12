## 2024-06-12 - Bash Performance Optimization Pattern
**Learning:** In high-frequency audit scripts, spawning subshells (ps, grep, awk) for every check is a major bottleneck. Caching process arguments once and using Bash internal regex matching (`[[ $var =~ regex ]]`) can reduce process forks by 95% or more.
**Action:** Always cache expensive command outputs that are reused. For string parsing in Bash, prefer built-in regex matching over `grep`/`awk` when possible. Be careful with regex patterns to ensure they handle comma-separated lists correctly (e.g., `[^[:space:]]+` instead of `[^[:space:],]+` if the value can contain commas).

## 2024-06-12 - Implicit Bug Discovery during Refactoring
**Learning:** Performance refactoring often reveals latent bugs (syntax errors in `[ ]` blocks, incorrect variable usage, invalid numeric operators like `>=`).
**Action:** Take the opportunity to fix these bugs during refactoring, but ensure they are clearly documented and verified to avoid regressions.
