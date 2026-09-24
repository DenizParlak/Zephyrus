## 2026-09-24 - Caching process arguments in bash audits

**Learning:** Caching process command-line arguments in a global variable (`KUBE_APISERVER_ARGS=$(ps -ef | grep "[k]ube-apiserver")`) at script startup avoids re-executing `ps` and `grep` process forks in every individual audit function.

**Action:** In shell-based auditing scripts that repeatedly inspect the flags of a running daemon, query `ps` once at initialization instead of calling it per audit check.
