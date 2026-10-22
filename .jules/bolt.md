## 2026-10-22 - Caching Process Arguments at Startup

**Learning:** Running `ps -ef | grep kube-apiserver` inside every check function (`api1` to `api25`) causes ~148 process forks per script run. Caching `ps -ef | grep "[k]ube-apiserver"` into a global variable `KUBE_APISERVER_ARGS` at startup eliminates redundant process creation.

**Action:** Always check for repeated external command pipeline invocations in shell audit scripts and cache process state upfront.
