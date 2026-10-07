## 2025-05-18 - Caching process arguments and native regex extraction

**Learning:** Running `ps -ef | grep kube-apiserver | grep -o '...' | awk ...` repeatedly across 25+ check functions spawns ~147 subprocesses (`execve` calls). Caching `KUBE_APISERVER_ARGS=$(ps -ef | grep '[k]ube-apiserver')` once at startup and extracting values using native Bash regex `[[ $KUBE_APISERVER_ARGS =~ --<flag>=([^[:space:]]+) ]]` reduces subshell forks down to 4 and speeds execution up by ~80%.

**Action:** Prefer caching target process arguments into a single shell variable at startup and using `[[ $VAR =~ REGEX ]]` for parsing in Bash scripts.
