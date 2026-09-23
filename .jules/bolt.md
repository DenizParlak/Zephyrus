## 2026-03-23 - Caching process arguments in Bash scripts

**Learning:** Repeating expensive external process inspection calls (e.g. `ps -ef | grep`) across dozens of audit check functions introduces severe sub-process fork overhead (`execve`). Storing the target process arguments in a global variable once at script initialization eliminates redundant forks without altering output or runtime logic.

**Action:** Whenever auditing or parsing process arguments in Bash scripts, inspect process tables once at startup into a cached global variable (e.g. `KUBE_APISERVER_ARGS=$(ps -ef | grep "[k]ube-apiserver")`) and reference that variable in subsequent check functions.
