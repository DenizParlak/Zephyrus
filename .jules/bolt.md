## 2026-08-20 - Caching `ps` Output to Reduce Subprocess Forks

**Learning:** `zephyrus.sh` executed `ps -ef | grep kube-apiserver` in every audit function (`api1` through `api25`), spawning 138+ process forks per run. Caching `KUBE_APISERVER_ARGS=$(ps -ef | grep '[k]ube-apiserver')` at startup reduced `execve` calls to 56 and cut script execution time by 50%.
**Action:** Always cache command outputs from process table queries when auditing invariant state across multiple checks.
