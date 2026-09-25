## 2026-09-25 - Avoid subshell pipeline execution loops by caching process state and using native Bash regex

**Learning:** Repeatedly executing process status lookup pipelines (`ps -ef | grep | awk`) across multiple audit checks in Bash scripts causes severe subshell process fork overhead (over 150 `execve` calls per execution). Caching process command-line arguments once at initialization (`KUBE_APISERVER_ARGS=$(ps -ef | grep '[k]ube-apiserver')`) and parsing flags via native Bash regex (`[[ $VAR =~ ... ]]`) with `printf -v` completely eliminates subshell spawning.

**Action:** In shell scripts running multiple process flag inspections, cache process argument strings once at startup and use built-in Bash pattern matching (`[[ ... =~ ... ]]`) and variable assignments (`printf -v`) to extract argument values with zero fork overhead.
