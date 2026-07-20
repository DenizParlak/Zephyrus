# This file will contain critical Bolt learnings
## 2026-07-20 - Redundant ps -ef and grep overhead in zephyrus.sh
**Learning:** Repetitively calling `ps -ef | grep kube-apiserver` up to 27 times results in high process fork overhead (~132 execve forks). This can be optimized by caching the command-line arguments of `kube-apiserver` once in a global variable and parsing them using Bash regex or substring matching.
**Action:** Extract the command line of `kube-apiserver` using `ps -ef | grep "[k]ube-apiserver"` once at startup into `KUBE_APISERVER_ARGS`, then query it via built-in Bash regex matching to avoid spawning subshells.
