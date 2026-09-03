## 2026-09-03 - Cache process command-line arguments to eliminate process fork overhead
**Learning:** Re-executing `ps -ef | grep | grep -o | awk` pipelines inside 25+ check functions in Bash script creates over 140 unnecessary process forks (`execve`), causing severe latency.
**Action:** Query process arguments once at script initialization into `KUBE_APISERVER_ARGS` and use pure Bash regex pattern matching (`[[ " $KUBE_APISERVER_ARGS " =~ [[:space:]]--${flag}=([^[:space:]]+) ]]`) for zero-fork flag extraction.
