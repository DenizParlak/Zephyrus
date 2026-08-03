# Bolt's Journal

## 2026-08-03 - Global Caching of Process Arguments in Bash Auditing Tools
**Learning:** Shell scripts that audit system states often execute expensive pipelines (e.g., `ps -ef | grep | awk`) inside loops or multiple functions, leading to extreme subprocess fork overhead and slow performance. By caching the output of such expensive commands globally once at startup into a variable (like `KUBE_APISERVER_ARGS`) and using native Bash regex/substring matching (e.g. `[[ $var =~ regex ]]` or `[[ $var == *substring* ]]`), we can completely eliminate subshell forks and speed up the script by 80%+.
**Action:** When auditing or parsing process arguments in Bash, always look to capture the process list or command arguments once at startup, and parse that cache using pure Bash built-ins rather than spawning pipeline processes inside loops or multiple check functions.
