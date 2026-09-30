## 2026-09-30 - Caching process arguments and native Bash regex matching

**Learning:** Repeatedly running `ps -ef | grep kube-apiserver | grep -o | awk` inside audit loop functions causes massive subshell and process fork overhead (~137 execve calls and 0.40s runtime). Caching `ps -ef | grep '[k]ube-apiserver'` once at startup in a global variable `KUBE_APISERVER_ARGS` and using native Bash regex matching reduces process forks by ~97% (down to 4 execve calls) and execution time to ~0.05s (~87% speedup).

**Action:** In shell script performance optimization tasks, cache expensive external query results at startup and use built-in Bash regex matching `[[ $var =~ $regex ]]` with `printf -v` to extract flag parameters without spawning external processes or subshells.
