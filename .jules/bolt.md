# Bolt's Journal ⚡

## 2026-10-28 - Caching target process arguments vs monkey-patching system tools
**Learning:** Overriding system commands like `ps` globally in shell scripts can break dynamic behavior. However, caching process arguments in a target-specific variable like `KUBE_APISERVER_ARGS=$(ps -ef | grep '[k]ube-apiserver')` at script startup eliminates redundant `ps -ef` invocations across repeated audit checks safely.
**Action:** When auditing static process configurations, cache the process command line once at startup into a target-specific variable and feed it to pipelines via `echo "$CACHE"`.
