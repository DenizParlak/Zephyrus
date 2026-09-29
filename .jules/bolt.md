# Bolt's Journal - Critical Learnings

## 2024-05-20 - Global Argument Caching for Process Audits
**Learning:** Calling `ps -ef | grep kube-apiserver | grep -o ... | awk ...` in every audit function creates over 140 process forks (execve calls). Caching `ps -ef | grep '[k]ube-apiserver'` into a global variable at script initialization allows querying the command line string without spawning repeated subshells/processes.
**Action:** Always cache static/global process status or argument strings once at startup when performing multiple checks against the same running process.
