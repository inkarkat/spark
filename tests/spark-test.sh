#!/usr/bin/env roundup

describe "spark generates sparklines for input numbers"

readonly scriptDir="$([ "${BASH_SOURCE[0]}" ] && dirname -- "${BASH_SOURCE[0]}" || exit 3)"
[ -d "$scriptDir" ] || { echo >&2 'ERROR: Cannot determine script directory!'; exit 3; }
spark="${scriptDir}/../spark"

it_graphs_argv_data() {
  graph="$($spark 1,5,22,13,5)"

  test "$graph" = '▁▂█▅▂'
}

it_charts_pipe_data() {
  graph="$(echo 1,30,55,80,33,150 | $spark)"

  test "$graph" = '▁▂▃▅▂█'
}

it_charts_spaced_data() {
  graph="$($spark 1 30 55 80 33 150)"

  test "$graph" = '▁▂▃▅▂█'
}

it_charts_way_spaced_data() {
  graph="$($spark 1 30               55 80 33     150)"

  test "$graph" = '▁▂▃▅▂█'
}

it_handles_decimals() {
  graph="$($spark 5.5,20)"
  test "$graph" = '▁█'
}

it_charts_100_lt_300() {
  graph="$($spark 1,2,3,4,100,5,10,20,50,300)"
  test "$graph" = '▁▁▁▁▃▁▁▁▂█'
}

it_charts_50_lt_100() {
  graph="$($spark 1,50,100)"
  test "$graph" = '▁▄█'
}

it_charts_4_lt_8() {
  graph="$($spark 2,4,8)"
  test "$graph" = '▁▃▇'
}

it_charts_constant_data_as_middle() {
  graph="$($spark 3,3,3)"
  test "$graph" = '▅▅▅'
}

it_charts_no_tier_0() {
  graph="$($spark 1,2,3,4,5)"
  test "$graph" = '▁▂▄▅▇'
}

it_equalizes_at_midtier_on_same_data() {
  graph="$($spark 1,1,1,1)"
  test "$graph" = '▅▅▅▅'
}
