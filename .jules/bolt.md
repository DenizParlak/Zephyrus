## 2026-08-25 - Cache process arguments and use Bash internal regex parsing

**Learning:** Running `ps -ef | grep kube-apiserver | grep -o ... | awk ...` repeatedly across 25 check functions in Bash creates ~140 redundant process forks, taking ~0.415s total execution time. Caching process arguments into a global variable `KUBE_APISERVER_ARGS` at startup and using Bash built-in regex (`[[ $KUBE_APISERVER_ARGS =~ ... ]]`) with `printf -v` eliminates all process fork overhead, reducing `execve` calls from 146 to 4 and execution time down to ~0.053s (~87% speedup).

**Action:** Always cache process or file lookup results globally at startup when building CLI audit tools in Bash, and leverage native `[[ $var =~ regex ]]` pattern matching instead of spawning subshell pipelines (`grep`/`awk`/`sed`).
