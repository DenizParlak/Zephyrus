## 2026-10-10 - Eliminate process forks in Zephyrus via argument caching and native Bash regex

**Learning:** Each check in `zephyrus.sh` spawned multiple process forks (`ps`, `grep`, `awk`) to read arguments from `kube-apiserver`, leading to over 150 `execve` calls per execution. Caching process arguments in a global variable (`KUBE_APISERVER_ARGS`) and extracting flags with native Bash regex (`[[ ... =~ ... ]]`) drastically reduces overhead without adding external dependencies.

**Action:** When auditing or parsing CLI arguments in shell scripts, cache process strings at startup and parse arguments using internal Bash pattern matching and `printf -v`.
