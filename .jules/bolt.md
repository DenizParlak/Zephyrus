## 2026-08-28 - Caching Kube-Apiserver Process Arguments

**Learning:** Repeatedly invoking `ps -ef | grep kube-apiserver` in each audit check function spawns 2-3 subprocesses per audit check, leading to high execve overhead (~130 forks per run).

**Action:** Cache `KUBE_APISERVER_ARGS=$(ps -ef | grep "[k]ube-apiserver")` once at startup and pipe `echo "$KUBE_APISERVER_ARGS"` to `grep` within audit check functions to cut process fork overhead in half.
