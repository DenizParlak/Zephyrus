## 2026-09-17 - Caching process arguments in Bash audit scripts

**Learning:** In CLI audit scripts that repeatedly query running processes via `ps -ef | grep <target>`, each check function forks new processes (`ps` and `grep`). Caching the process arguments once into a global variable (`KUBE_APISERVER_ARGS`) and feeding it into pipelines cut process forks from 143 down to 58 (a ~60% reduction in execve calls) and improved script runtime by ~48%.

**Action:** Whenever an audit or inspection script runs multiple parameter checks against the same running process, query `ps` once at startup and reuse the cached string across check functions.
