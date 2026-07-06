## 2026-07-06 - Optimized zephyrus.sh Bash script
**Learning:** The `zephyrus.sh` script suffered from massive process fork overhead (~128 forks) because it executed `ps -ef | grep ... | awk ...` in every audit function. Caching the output of `ps -ef` into a variable and using Bash's internal regex matching (`[[ $VAR =~ REGEX ]]`) reduced the fork count to 4 and improved execution time by ~85%.
**Action:** Always look for redundant external command calls in loops or repeated functions in Bash scripts. Cache results and use built-in string manipulation or regex whenever possible.
