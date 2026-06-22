## 2026-06-22 - Optimize zephyrus.sh process forks

**Learning:** Redundant process spawning (ps, grep, awk) in Bash scripts significantly impacts performance, especially in loops or repeated function calls. Caching process output and using Bash internal regex matching ([[ $var =~ regex ]]) is a far more efficient pattern.

**Action:** Cache the output of 'ps -ef | grep [k]ube-apiserver' once and use Bash built-in regex matching to parse arguments, reducing forks from over 130 to fewer than 10.

### Baseline Measurements (2026-06-22)
- Execution time: 0.343s
- Process forks (execve): 132

### Optimized Measurements (2026-06-22)
- Execution time: 0.060s (~82% reduction)
- Process forks (execve): 4 (~97% reduction)
