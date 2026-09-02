## 2026-09-02 - Eliminate Subshell Overhead in Bash Flag Parsing via `printf -v`

**Learning:** Assigning regex capture groups in Bash using subshells (e.g. `val=$(get_flag_val ...)` or `val=$(echo ... | awk ...)`) creates significant process fork overhead (over 500 `execve` calls in a script with ~25 audit checks). By contrast, passing variable names to a helper function that uses `printf -v "$var_name"` directly assigns values in-memory, achieving zero subshell forks per lookup and an 85% execution time reduction (0.40s down to 0.055s).

**Action:** When refactoring Bash argument/flag parsing functions, use native `[[ $var =~ regex ]]` combined with `printf -v "$out_var" "%s" "${BASH_REMATCH[1]}"` instead of returning values via `echo` and capturing them with command substitution `$()`.
