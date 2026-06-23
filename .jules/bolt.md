## 2026-06-23 - Redundant process forks in audit script
**Learning:** The `zephyrus.sh` script executes `ps -ef | grep kube-apiserver` 27 times, once for each security check. Each call forks multiple processes (ps, grep, awk). In a shell script, this is a major performance bottleneck.
**Action:** Cache the command-line arguments of the target process in a variable at the start and use Bash built-in regex matching (`[[ $var =~ regex ]]`) to extract parameters. This reduces process forks from ~100 to 1.
