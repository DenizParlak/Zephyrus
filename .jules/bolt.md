## 2026-10-23 - Global Argument Caching and Native Regex Flag Parsing

**Learning:** Repeatedly querying `ps -ef | grep | awk` inside multiple audit functions creates substantial subshell process spawning overhead (~149 process forks per run).
**Action:** Cache process arguments once into `KUBE_APISERVER_ARGS` at startup and use native Bash regex matching `[[ "$KUBE_APISERVER_ARGS" =~ [[:space:]]--${flag}=([^[:space:]]+) ]]` to perform flag extraction completely in-memory.
