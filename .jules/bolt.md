## 2026-10-27 - Process Argument Caching in Shell Scripts

**Learning:** Repeatedly executing process status queries (e.g., `ps -ef | grep kube-apiserver`) in a loop or across multiple function calls creates significant `execve` syscall overhead. Caching the target process arguments into a global script variable once at startup reduced process fork calls from 161 down to 60 (~63% reduction in process forks) and cut execution time in half (~0.35s to ~0.16s).

**Action:** When auditing or querying process command-line flags in CLI tools, cache the process argument string once into a variable at startup rather than spawning subshells repeatedly in each check function.
