## 2026-08-24 - Cache kube-apiserver process arguments
**Learning:** In auditing shell scripts like `zephyrus.sh`, invoking `ps -ef | grep kube-apiserver` in every audit rule function causes massive process fork overhead (~148 execve calls). Caching the process command line output into a single global variable `KUBE_APISERVER_ARGS` at startup dramatically reduces subshell forks and speeds up execution.
**Action:** Always cache process argument lists into a global variable when running multiple audit checks against the same process.
