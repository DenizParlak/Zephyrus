## 2026-09-16 - Global argument caching for Bash process auditing

**Learning:** In CLI audit scripts querying system process details (e.g. `ps -ef`), executing process lookup pipelines (`ps | grep | awk`) inside individual check functions creates massive subprocess fork overhead (140+ forks for ~25 checks). Caching process command-line arguments in a single global variable (`KUBE_APISERVER_ARGS`) at startup and parsing flags with native Bash regex (`[[ $padded_args =~ ... ]]`) eliminates subshell overhead, yielding an ~85% reduction in execution time and a 97% reduction in process forks (`execve` calls).

**Action:** When performing repeated process argument analysis in shell scripts, cache process output once globally and rely on built-in string/regex parsing instead of piping to `grep`/`awk` in loops or functions.
