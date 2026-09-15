## 2026-09-15 - Process argument caching in Bash auditing tool

**Learning:** Repeated calls to external commands like `ps -ef | grep <target>` across multiple check functions spawn excessive sub-processes (fork/exec overhead), accounting for >70% of execution time. Caching process arguments into a global variable at startup dramatically reduces execve calls and execution latency without modifying system commands.

**Action:** In CLI/audit tools written in Bash that query process state repeatedly, cache the target process command line in a global variable once at initialization (`TARGET_ARGS=$(ps -ef | grep '[p]rocess')`) and query the variable in memory.
