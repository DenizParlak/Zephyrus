## 2026-06-13 - Redundant process spawning in Bash audit script
**Learning:** The 'zephyrus.sh' script exhibited high process fork overhead (159 forks for 25 checks) because every audit function repeatedly executed `ps -ef`, `grep`, and `awk` to extract the same process arguments. Additionally, inconsistent use of `echo -e` led to raw escape sequences being printed.

**Action:** Cache expensive command outputs like `ps -ef` in a global variable and use Bash's built-in regular expression matching `[[ $var =~ regex ]]` for parsing. Always use `echo -e` for printing colored output.
