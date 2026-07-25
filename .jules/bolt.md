# Bolt's Performance Journal

This journal tracks critical learnings and performance insights for Zephyrus.

## 2025-07-25 - Caching Kube-Apiserver Arguments to Reduce Process Forks
**Learning:** Running `ps -ef | grep kube-apiserver` in every audit check spawns hundreds of subprocesses (grep, awk, subshells) which severely degrades execution speed (from milliseconds to seconds). Caching the arguments once into a global variable and parsing using Bash internal regex matching (`[[ $VAR =~ REGEX ]]`) and `BASH_REMATCH` eliminates process forks entirely, reducing audit time by over 80%.
**Action:** Extract process arguments once at the beginning of the script into a cached variable and use native Bash regex for parsing.
