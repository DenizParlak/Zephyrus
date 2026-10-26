## 2026-10-26 - Cached Process Argument Parsing in Bash Auditing Tool

**Learning:** Repeatedly invoking `ps | grep | awk` inside audit functions creates massive process fork overhead (145+ execve calls). Caching process arguments into a single global variable at startup and using native Bash regex (`[[ $padded_args =~ ... ]]`) eliminates subshell spawning.

**Action:** Cache external command outputs once at script initialization and parse values using pure Bash string operations.
