## 2026-07-08 - Bash performance optimization in Zephyrus
**Learning:** Redundant process forks (ps | grep | awk) for every audit check caused significant overhead (152 forks). Using Bash internal regex matching [[ $VAR =~ REGEX ]] combined with variable caching (KUBE_APISERVER_ARGS) is a high-impact pattern for Bash scripts.
**Action:** Always look for opportunities to replace external process pipelines (grep, awk, sed) with Bash internal string manipulation or regex when processing small to medium datasets or frequently accessed information.
