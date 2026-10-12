## 2025-05-18 - Caching Subshell Process Lookup Results in Bash

**Learning:** Repeatedly querying running process flags via `ps -ef | grep <process>` inside individual check functions causes significant process fork overhead (over 100 process forks per audit run). By caching the process arguments into a global variable (`KUBE_APISERVER_ARGS`) once at startup and feeding that variable into pipelines, process forks dropped by ~64% (160 to 57) and execution time was cut in half without altering any verification logic or system-wide utilities.

**Action:** Whenever auditing or querying static system state across multiple functions in Bash scripts, inspect process state once at entry and cache the result in a variable rather than re-running system pipeline commands.
