#!/usr/bin/env roundup

describe "spark command-line argument handling"

readonly scriptDir="$([ "${BASH_SOURCE[0]}" ] && dirname -- "${BASH_SOURCE[0]}" || exit 3)"
[ -d "$scriptDir" ] || { echo >&2 'ERROR: Cannot determine script directory!'; exit 3; }
spark="${scriptDir}/../spark"

it_shows_help_to_stderr_with_no_argv() {
  { $spark 3>&1 1>&2 2>&3 3>&- | grep USAGE; } 3>&1 1>&2 2>&3 3>&-
}

it_exits_2_with_no_argv() {
  $spark 2>/dev/null && status=0 || status=$?
  test $status -eq 2
}

it_shows_help_with_help_option() {
  $spark --help | grep USAGE
}

it_shows_help_with_unknown_as_parameter() {
  { $spark --as doesNotExist 1,5,22,13,5 3>&1 1>&2 2>&3 3>&- | grep USAGE; } 3>&1 1>&2 2>&3 3>&-
}

it_exits_2_with_unknown_as_parameter() {
  $spark --as doesNotExist 1,5,22,13,5 2>/dev/null && status=0 || status=$?
  test $status -eq 2
}

