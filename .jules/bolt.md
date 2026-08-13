# Bolt's Journal

## 2026-08-13 - Caching `kube-apiserver` arguments to Reduce Process Fork Overhead
**Learning:** Caching the output of the target process arguments from `ps -ef` in a global variable (`KUBE_APISERVER_ARGS`) once at startup is far safer and cleaner than globally overriding standard commands like `ps`. This eliminates redundant scans of `/proc` and avoids spawning 25+ expensive process forks, while maintaining 100% standard POSIX utility compatibility.
**Action:** Always prefer caching target process command arguments into specific variables rather than monkey-patching or overriding core system utilities like `ps` directly.
