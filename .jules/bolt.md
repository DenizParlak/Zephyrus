## 2026-06-08 - Redundant process spawning in zephyrus.sh
**Learning:** The script calls `ps -ef | grep kube-apiserver` 27 times, each time spawning multiple processes (ps, grep, awk). This results in over 150 execve calls for a simple script.
**Action:** Cache the command line of kube-apiserver into a variable and use bash built-ins for string manipulation to avoid unnecessary forks.
