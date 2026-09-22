## 2026-09-22 - Global Caching of Process Arguments in Bash Scripts

**Learning:** Replacing repeated `ps -ef | grep <process>` calls with a single cached variable `KUBE_APISERVER_ARGS` cut `execve` process fork count by ~60% (from 145 down to 60 calls) and reduced execution time from ~0.34s to ~0.15s (>55% speedup) without risk of stale state within a single script run.
**Action:** Always cache process argument queries once at startup when performing multiple rule evaluations against the same running process in Bash scripts.
