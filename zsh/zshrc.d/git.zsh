gapr() {
  local pr_url
  pr_url="$(pbpaste)"

  if [[ ! "$pr_url" =~ ^https://github\.com/[^/]+/[^/]+/pull/[0-9]+$ ]]; then
    echo "Error: Clipboard does not contain a valid GitHub PR URL"
    echo "Got: $pr_url"
    return 1
  fi

  local pr_info
  pr_info="$(gh pr view "$pr_url" --json title,state 2>/dev/null)"
  if [[ $? -ne 0 || -z "$pr_info" ]]; then
    echo "Error: Failed to fetch PR details for $pr_url"
    return 1
  fi

  local pr_title pr_state
  pr_title="$(echo "$pr_info" | jq -r '.title')"
  pr_state="$(echo "$pr_info" | jq -r '.state')"

  if [[ "$pr_state" != "OPEN" ]]; then
    echo "Error: PR is $pr_state, cannot approve"
    return 1
  fi

  echo "PR: $pr_title"
  echo "URL: $pr_url"
  read -q "confirm?Approve this PR? [y/N] "
  echo

  if [[ "$confirm" == "y" ]]; then
    apr "$pr_url"
  else
    echo "Cancelled"
  fi
}
