## 2026-06-27 - Caching process forks in Bash
**Learning:** In high-frequency audit scripts like Zephyrus, repeatedly calling `ps -ef | grep` for every check creates massive overhead due to process forking. Bash internal regex matching (`[[ $VAR =~ REGEX ]]`) is a zero-cost alternative for parsing once the data is cached in a variable.
**Action:** Always look for patterns where external commands are called in loops or sequential functions to extract data from the same source. Cache the source data and use built-in string manipulation.
