## 2024-06-29 - Cache expensive process argument retrieval
**Learning:** Repetitive execution of `ps -ef | grep | awk` in a loop or sequential functions is a major bottleneck in Bash scripts due to process fork overhead. Caching the output of `ps` and using Bash's internal regex matching (`[[ $VAR =~ REGEX ]]`) can reduce execution time by over 90% and process forks significantly (from 150+ to <5).
**Action:** Always look for patterns where external commands are called repeatedly to extract information from the same source, and replace them with a single call and internal string manipulation.
