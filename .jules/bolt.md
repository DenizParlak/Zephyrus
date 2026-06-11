## 2025-05-14 - Optimized kube-apiserver argument parsing in Zephyrus

**Learning:** Repeatedly spawning process chains (ps | grep | awk) in a loop or multiple times is a significant performance bottleneck in Bash scripts. Caching the output of expensive commands and using Bash internal regex matching ([[ $VAR =~ REGEX ]]) drastically reduces fork overhead.

**Action:** Always look for opportunities to cache external command outputs and use built-in Bash features for string manipulation and parsing. Fix any discovered syntax errors in POSIX-style [ ] blocks by converting them to [[ ]] where appropriate for better reliability.
