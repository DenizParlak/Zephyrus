## 2026-08-16 - Caching Process Arguments Eliminates Process Forks in Audit Scripts

**Learning:** `zephyrus.sh` previously invoked `ps -ef | grep | grep -o | awk` pipelines inside every single audit check function (25+ times), causing over 130 external command forks (`execve` calls) per run. Caching `ps -ef | grep '[k]ube-apiserver'` into a single global variable `KUBE_APISERVER_ARGS` at startup and using native Bash regex matching (`[[ $KUBE_APISERVER_ARGS =~ --flag=([^[:space:],]+) ]]`) completely eliminates subshell overhead.

**Action:** In CLI audit tools that inspect process arguments, cache process string output at startup and evaluate flags using native shell regex instead of spawning subshell pipelines.
