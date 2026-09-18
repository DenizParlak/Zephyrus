## 2026-09-18 - Process Argument Caching in Bash Auditing Scripts

**Learning:** Repeatedly executing `ps -ef | grep ... | awk ...` across multiple audit check functions introduces severe subshell and process fork overhead in Bash (over 150 `execve` calls for 25 checks). Caching `KUBE_APISERVER_ARGS` once at initialization and extracting flags using native Bash regex matching (`[[ $args =~ regex ]]`) eliminates almost all process creation, reducing execution time by ~80% (from 0.373s to 0.073s) and `execve` calls from 154 down to 4.

**Action:** For shell scripts performing repeated queries against system state (like process lists or configuration files), read/cache the target state once into memory at startup and parse via Bash built-ins rather than spawning external command pipelines inside functions.
