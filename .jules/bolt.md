## 2026-07-16 - Process Fork Reduction through Variable Caching
**Learning:** Caching the output of expensive external commands (like 'ps -ef') into variables and using Bash internal regex matching ([[ $var =~ regex ]]) for parsing can reduce execution time by over 80% and process forks by nearly 97% in audit scripts.
**Action:** Always look for redundant process-spawning pipelines in loops or repeated function calls and replace them with variable-based string manipulation and built-in regex.

## 2026-07-16 - Handling Comma-Separated Kubernetes Flags
**Learning:** Kubernetes flags like --admission-control often contain comma-separated values. Simple equality checks or 'grep -o' with restrictive patterns fail to capture these correctly.
**Action:** Use substring matching patterns (e.g., [[ "$VAR" == *AlwaysAllow* ]]) or inclusive regex matching to ensure flags within lists are accurately detected.
