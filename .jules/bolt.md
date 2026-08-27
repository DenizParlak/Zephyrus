## 2026-08-27 - Caching Process Output in Shell Auditing Scripts

**Learning:** Repeatedly invoking `ps -ef | grep <target>` across dozens of audit functions spawns over 100 redundant subprocesses (`execve`), creating major overhead (~370ms -> ~170ms). Caching the `ps` command output once at startup into a variable (`KUBE_APISERVER_ARGS=$(ps -ef | grep '[k]ube-apiserver')`) eliminates process fork overhead while preserving exact output filtering behavior.

**Action:** In shell audit tools, query process argument strings once at initialization and reuse the cached variable with `echo "$VAR" | grep ...` across check routines.
