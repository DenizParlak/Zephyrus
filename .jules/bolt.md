## 2026-10-20 - Global Process Argument Caching and Native Regex Parsing in Shell Auditing Tools

**Learning:** Replacing repeated shell process table queries (`ps -ef | grep | awk`) in auditing loops with a single startup cache (`KUBE_APISERVER_ARGS=$(ps -ef | grep '[k]ube-apiserver')`) combined with native Bash regular expression matching (`[[ $KUBE_APISERVER_ARGS =~ ... ]]`) dramatically cuts process fork overhead (from 155 down to 4 execve calls) and yields an ~82% reduction in script execution time without external dependencies.

**Action:** Whenever auditing or processing process arguments in Bash, capture the target command line once into a global variable at startup and parse arguments using native Bash regex matching (`BASH_REMATCH`) rather than spawning `grep`, `awk`, or `sed` subshells in each check function.
