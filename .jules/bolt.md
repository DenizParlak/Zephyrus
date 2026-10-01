## 2026-10-01 - Global process argument caching in Bash scripts

**Learning:** In CLI audit scripts that inspect process flags (like `zephyrus.sh`), calling `ps -ef | grep <proc>` inside every audit rule spawns dozens of redundant subprocess forks.
**Action:** Extract process arguments once at startup into a global variable (`KUBE_APISERVER_ARGS=$(ps -ef | grep '[k]ube-apiserver')`) and query the variable in downstream functions.
