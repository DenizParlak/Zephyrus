## 2026-08-04 - Caching API Server Arguments & Pure-Bash Refactoring
**Learning:** External calls like `ps -ef`, `grep`, and `awk` introduce significant sub-process fork overhead, costing up to 0.35s and over 130 forks. By caching `kube-apiserver` arguments once into `KUBE_APISERVER_ARGS` and using native Bash regex/substring matching (`[[ $var =~ regex ]]`, `${BASH_REMATCH[1]}`), we can avoid almost all forks.
**Action:** When auditing or reading command-line arguments in shell scripts, cache process strings early and parse them natively within double brackets to maximize performance.
