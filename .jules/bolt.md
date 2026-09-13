## 2026-09-13 - Process fork elimination via argument caching in Bash audit tools

**Learning:** Audit scripts like `zephyrus.sh` that query process flags using repeated pipelines (`ps -ef | grep | awk`) introduce severe fork overhead (153 process forks for 26 checks). Caching process arguments once at startup in a global variable (`KUBE_APISERVER_ARGS`) and extracting values with native Bash regex (`[[ $padded =~ ... ]]` and `BASH_REMATCH`) completely eliminates subshells.

**Action:** When optimizing shell scripts that poll system or process state, cache target process args once at startup and use native Bash regex matching instead of external `grep`/`awk` pipelines.
