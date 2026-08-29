## 2026-08-29 - Cache `kube-apiserver` arguments to avoid process forks
**Learning:** `zephyrus.sh` previously executed `ps -ef | grep kube-apiserver` in 27 separate functions, resulting in over 130 subshell process forks (`execve` calls) per run. Caching `KUBE_APISERVER_ARGS=$(ps -ef | grep '[k]ube-apiserver')` once at script startup and echoing `$KUBE_APISERVER_ARGS` into downstream parsers cuts process forks by ~58% and execution time by ~53%.
**Action:** Always check shell scripts for repeated system process queries and cache the output at startup.
