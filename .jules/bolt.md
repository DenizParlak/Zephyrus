## 2026-07-03 - Initial Profile
**Learning:** Found that 'zephyrus.sh' executes 'ps -ef | grep | awk' for every single audit check (25+ checks), resulting in over 140 process forks for a single run.
**Action:** Cache the 'kube-apiserver' command line arguments in a global variable and use Bash's internal regular expression matching to extract flag values.
