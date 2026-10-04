## 2026-10-04 - Global process argument caching in Bash audit scripts

**Learning:** Redundant calls to `ps -ef | grep <target>` inside loop-like sequentially executed audit functions are a major bottleneck due to expensive process forks.
**Action:** Query process arguments into a global variable (`KUBE_APISERVER_ARGS`) once at script initialization and query the cached variable in subsequent functions.
