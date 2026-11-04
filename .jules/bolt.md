# Bolt's Journal - Critical Learnings Only

## 2026-11-04 - Process Argument Caching Over Pipeline Monkey-Patching
**Learning:** In Bash auditing scripts with dozens of sequential rule checks against a single long-running daemon (like `kube-apiserver`), repeated process querying via `ps -ef | grep ...` accounts for the vast majority of execution overhead and process spawning. Replacing the 27 calls with variable expansion `echo "$KUBE_APISERVER_ARGS" |` avoids monkey-patching system tools like `ps` while cutting process forks by ~58% (from 142 to 59 execve calls) and script run time by ~48%.
**Action:** Always prefer caching target process command arguments into a dedicated variable early in execution rather than overriding standard utilities or invoking repeated process table scans.
