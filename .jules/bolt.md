# Bolt ⚡ Performance Optimization Journal

## 2026-07-27 - Caching Process Arguments and Eliminating Fork Overhead in zephyrus.sh
**Learning:** Forking processes with `ps -ef | grep | awk` inside a loops/multiple functions in a Bash script creates significant process overhead (~140 forks). By caching the `ps -ef` output of the target process once at startup into a global variable (`KUBE_APISERVER_ARGS`) and using pure Bash regex parsing (`[[ $KUBE_APISERVER_ARGS =~ ... ]]`), we can eliminate nearly all sub-process spawning, bringing process forks down from 139 to less than 5.
**Action:** Always inspect scripts executing external commands within multiple functions/loops and refactor them to use bash built-in variables, glob/regex matching, and cached command outputs.
