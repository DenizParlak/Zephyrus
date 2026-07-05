## 2026-07-05 - Redundant Process Forking in Bash Loops
**Learning:** In Bash scripts, spawning a chain of external processes (ps | grep | awk) inside a loop or multiple sequential functions is a major performance bottleneck due to fork overhead. For a script with ~25 checks, this resulted in >130 forks.
**Action:** Cache the output of expensive commands into a variable once at the start of the script. Use Bash's internal regex matching (`[[ $var =~ regex ]]`) and the `BASH_REMATCH` array for zero-fork string parsing.
