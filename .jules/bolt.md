## 2026-08-15 - Global argument caching and subshell elimination in Bash

**Learning:** Repeatedly querying process state via `ps -ef | grep` inside loops or multiple check functions introduces severe process fork overhead (`execve` calls). Caching `KUBE_APISERVER_ARGS=$(ps -ef | grep '[k]ube-apiserver')` once globally and extracting parameters using native Bash regex matching and `printf -v` eliminates virtually all subshell forks.

**Action:** When auditing CLI tool flags or process parameters in Bash, cache process args once at script startup and use native regex parsing with `printf -v` instead of external pipelines (`ps | grep | awk`).
