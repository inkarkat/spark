#!/usr/bin/env roundup

describe "spark: Generates sparklines for a set of data."

spark="../spark"

it_shows_help_to_stderr_with_no_argv() {
  ($spark 3>&1 1>&2 2>&3 3>&- | grep USAGE) 3>&1 1>&2 2>&3 3>&-
}

it_exits_2_with_no_argv() {
  $spark 2>/dev/null && status=0 || status=$?
  test $status -eq 2
}

it_shows_help_with_help_option() {
  $spark --help | grep USAGE
}

it_graphs_argv_data() {
  graph="$($spark 1,5,22,13,5)"

  test $graph = '▁▂█▅▂'
}

it_charts_pipe_data() {
  data="0,30,55,80,33,150"
  graph="$(echo $data | $spark)"

  test $graph = '▁▂▃▄▂█'
}

it_charts_spaced_data() {
  data="0 30 55 80 33 150"
  graph="$($spark $data)"

  test $graph = '▁▂▃▄▂█'
}

it_charts_way_spaced_data() {
  data="0 30               55 80 33     150"
  graph="$($spark $data)"

  test $graph = '▁▂▃▄▂█'
}

it_handles_decimals() {
  data="5.5,20"
  graph="$($spark $data)"

  test $graph = '▁█'
}

it_charts_100_lt_300() {
  data="1,2,3,4,100,5,10,20,50,300"
  graph="$($spark $data)"

  test $graph = '▁▁▁▁▃▁▁▁▂█'
}

it_charts_50_lt_100() {
  data="1,50,100"
  graph="$($spark $data)"

  test $graph = '▁▄█'
}

it_charts_4_lt_8() {
  data="2,4,8"
  graph="$($spark $data)"

  test $graph = '▁▃█'
}

it_charts_no_tier_0() {
  data="1,2,3,4,5"
  graph="$($spark $data)"

  test $graph = '▁▂▄▆█'
}

it_equalizes_at_midtier_on_same_data() {
  data="1,1,1,1"
  graph="$($spark $data)"

  test $graph = '▅▅▅▅'
}

it_renders_x_as_unknown_data() {
  graph="$($spark 0 30 55 80 x x 33 x 150)"

  test "$graph" = '▁▂▃▄××▂×█'
}

it_keeps_space_argument() {
  graph="$($spark 0 30 55 80 ' ' ' ' 33 ' ' 150)"

  test "$graph" = '▁▂▃▄  ▂ █'
}

it_keeps_newline_argument() {
  graph="$($spark 0 30 55 80 $'\n' $'\n' 33 $'\n' 150)"

  test "$graph" = '▁▂▃▄

▂
█'
}

it_keeps_space_argument() {
  graph="$($spark 0 30 55 80 ' ' ' ' 33 ' ' 150)"

  test "$graph" = '▁▂▃▄  ▂ █'
}

it_uses_auto_min_max() {
  graph="$($spark 25 30 45 50 40 35 30 25 50)"

  test "$graph" = '▁▂▆█▅▃▂▁█'
}

it_uses_fixed_min() {

  graph="$($spark --min 0 -- 25 30 45 50 40 35 30 25 50)"

  test "$graph" = '▄▅▇█▆▅▅▄█'
}

it_uses_fixed_max() {

  graph="$($spark --max 100 -- 25 30 45 50 40 35 30 25 50)"

  test "$graph" = '▁▁▂▃▂▁▁▁▃'
}

it_uses_fixed_min_max() {

  graph="$($spark --min 0 --max 100 -- 25 30 45 50 40 35 30 25 50)"

  test "$graph" = '▂▃▄▄▃▃▃▂▄'
}

it_uses_special_symbol_for_below_fixed_min() {

  graph="$($spark --min 25 -- 24 25 30 45 50 40 35 30 25 0 50)"

  test "$graph" = '⭳▁▂▆█▅▃▂▁⭳█'
}

it_uses_special_symbol_for_above_fixed_max() {
  graph="$($spark --max 50 -- 25 30 45 50 100 40 35 30 25 50 51)"

  test "$graph" = '▁▂▆█⭱▅▃▂▁█⭱'
}
