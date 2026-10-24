## 2025-05-18 - Caching process arguments in Bash auditing tools
**Learning:** Repetitive process table searches via `ps -ef | grep` spawn hundreds of sub-processes (`execve` calls) and cause significant overhead in audit scripts. Caching the target process args once into a global variable (`KUBE_APISERVER_ARGS=$(ps -ef | grep '[k]ube-apiserver')`) reduces `execve` calls by ~60% (152 -> 62) and cuts runtime in half (0.391s -> 0.163s).
**Action:** When auditing static process flags in Bash scripts, query `ps` once at startup and reuse the cached output across all individual check functions.
