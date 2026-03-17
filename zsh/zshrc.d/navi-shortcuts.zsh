# Docker shortcuts
ddel() { navi --best-match --tag-rules "docker" --query "docker stop"; }

# GitHub shortcuts
apr() { pr_url="$1" navi --best-match --tag-rules "gh" --query "Approve a pull request"; }
