## 2026-08-17 - Caching Process Arguments & Native Bash Regex Parsing

**Learning:** Repeating process listing pipelines (`ps -ef | grep kube-apiserver | grep -o ... | awk ...`) across dozens of check functions creates massive subprocess fork overhead (~155 `execve` calls in a 25-check audit script). Caching process arguments into a global variable (`KUBE_APISERVER_ARGS`) once at script startup and querying arguments using native Bash regex matching (`[[ $VAR =~ REGEX ]]` with `BASH_REMATCH`) eliminates nearly all subshell and external tool overhead.

**Action:** When writing or refactoring Bash auditing/CLI tools that query system processes or process arguments repeatedly:
1. Cache query target strings or process command-line arguments into global variables once at startup.
2. Use pure in-memory string matching and regex pattern extraction with `[[ $VAR =~ REGEX ]]` instead of spawning external sub-processes like `grep`, `sed`, or `awk`.
