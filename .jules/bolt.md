## 2026-10-19 - Eliminate redundant process forks in Bash scripts by caching command output and using native regex

**Learning:** Repeatedly running `ps -ef | grep kube-apiserver | grep ... | awk ...` across multiple audit functions spawns hundreds of subshell forks, causing heavy process overhead (~150 execve calls per audit). Caching process arguments at script startup in a variable (`KUBE_APISERVER_ARGS=$(ps -ef | grep '[k]ube-apiserver')`) and parsing flags via native Bash regex matching (`[[ $VAR =~ REGEX ]]`) and `printf -v` eliminates virtually all subprocess overhead.

**Action:** When auditing or inspecting process status/arguments repeatedly in Bash scripts, cache the process output once at startup and use built-in Bash regex matching instead of piping to external utilities (`grep`, `awk`, `cut`).
