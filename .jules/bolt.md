## 2024-06-24 - Initial Performance Audit
**Learning:** Redundant calls to `ps -ef | grep kube-apiserver` in every check function (`api1` through `api25`) create significant process fork overhead.
**Action:** Cache the `kube-apiserver` process arguments once in a variable and use Bash built-in string manipulation or regex matching to extract values.

## 2024-06-24 - Optimization results and PR hygiene
**Learning:** Process fork caching reduced execution time by ~86% and fork count from 138 to 5. However, the initial submission was rejected due to "development clutter" (temporary files used for benchmarking).
**Action:** Always clean up benchmarking artifacts, logs, and fragmented file chunks before requesting code review. These should be documented in the PR description, not included in the repository.
