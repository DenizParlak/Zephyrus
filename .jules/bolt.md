# Bolt's Journal - Critical Learnings Only

## 2026-10-03 - Caching process list in Bash CLI tool
**Learning:** Re-executing `ps -ef | grep` inside iterative check functions creates massive process fork overhead (~144 execve calls). Caching `ps -ef | grep '[k]ube-apiserver'` into a global variable `KUBE_APISERVER_ARGS` at script initialization reduces process creation overhead by >50% (down to 60 execve calls) and cuts execution time almost in half without altering logic or requiring architectural changes.
**Action:** When auditing CLI tools that run many sequential checks against process arguments, always cache process query outputs globally once at startup.
