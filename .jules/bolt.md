## 2026-09-26 - Process Argument Caching and Native Flag Extraction in Bash

**Learning:** Repeatedly running process listing subshell pipelines (`ps -ef | grep | awk`) inside audit loop functions creates enormous subshell overhead (~140 process forks per run).
**Action:** Cache target process command-line arguments once at startup into a variable (`KUBE_APISERVER_ARGS`), then parse flags using native Bash regex matching and `printf -v`. This eliminated over 96% of process forks (from 143 to 5) and yielded an ~83% speedup.
