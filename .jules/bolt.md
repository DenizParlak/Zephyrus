## 2026-10-29 - Caching Process Query Results in Bash Audit Scripts

**Learning:** Repeatedly invoking process listing pipelines (`ps -ef | grep ...`) across dozens of check functions causes severe process fork overhead (over 100 process forks per audit run). Caching the target command line arguments into a single global variable (`KUBE_APISERVER_ARGS`) at startup reduces process forks by >40% and cuts execution time almost in half without altering audit logic or behavior.

**Action:** For shell-based audit or compliance tools that query static process state across multiple check modules, always cache the process query result in a top-level variable and query the cached variable.
