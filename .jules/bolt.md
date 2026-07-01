## $(date +%Y-%m-%d) - Bash Process Fork Optimization
**Learning:** Redundant subshell calls (e.g., \`ps -ef | grep | awk\`) in loops or multiple sequential functions create significant overhead due to process forking. Bash internal regex matching (\`[[ $var =~ regex ]]\`) is much faster.
**Action:** Cache output of expensive external commands into variables and use Bash built-in string manipulation and regex for parsing. Ensure regex patterns are robust for comma-separated lists (use \`[^[:space:]]+\` instead of \`[^[:space:],]+\` if the whole list is needed).
