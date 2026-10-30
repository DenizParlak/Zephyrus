## 2026-10-30 - Caching kube-apiserver process arguments in zephyrus.sh

**Learning:** Re-executing `ps -ef | grep kube-apiserver` inside 27 distinct check functions created over 140 process forks (`execve` calls) during a single audit run. Storing the process table output once in a global variable `KUBE_APISERVER_ARGS` and using `echo "$KUBE_APISERVER_ARGS"` across audit functions eliminates redundant subshells while preserving full compatibility and output correctness.

**Action:** Whenever auditing process configurations in shell scripts, cache process argument listings at startup in a global variable rather than querying the process table inside each check function.
