# Bolt's Journal - Critical Learnings

## 2024-10-05 - Caching process arguments for CLI audit scripts
**Learning:** Shell audit scripts that repeatedly query process arguments via `ps -ef | grep` suffer heavy process fork overhead (~150 subshell calls per run).
**Action:** Caching the output of `ps -ef | grep '[k]ube-apiserver'` once at startup in a global variable `KUBE_APISERVER_ARGS` dramatically reduces process fork overhead without breaking process queries.
