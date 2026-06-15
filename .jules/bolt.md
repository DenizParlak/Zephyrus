## 2026-06-15 - Bash Process Fork Optimization
**Learning:** For Bash scripts that perform many similar checks against a single target (like process arguments), caching the target and using internal regex matching is orders of magnitude faster than repeatedly spawning grep/awk pipelines. Reduced forks from 137 to 4.
**Action:** Always prefer caching and internal string/regex operations over sub-processes for high-frequency checks in Bash.
