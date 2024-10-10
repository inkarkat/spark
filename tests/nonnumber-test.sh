#!/usr/bin/env roundup

describe "spark rendering of non-number inputs"

readonly scriptDir="$([ "${BASH_SOURCE[0]}" ] && dirname -- "${BASH_SOURCE[0]}" || exit 3)"
[ -d "$scriptDir" ] || { echo >&2 'ERROR: Cannot determine script directory!'; exit 3; }
spark="${scriptDir}/../spark"

it_renders_x_as_unknown_data() {
  graph="$($spark 1 30 55 80 x x 33 x 150)"
  test "$graph" = '▁▂▃▅××▂×█'
}

it_renders_another_char_as_unknown_data() {
  graph="$(SPARK_UNKNOWN_DATA='what' $spark 1 what 55 80 x x 33 x 150)"
  test "$graph" = '▁×▃▅xx▂x█'
}

it_renders_a_number_as_unknown_data() {
  graph="$(SPARK_UNKNOWN_DATA=30 $spark 1 30 55 80 x x 33 x 150)"
  test "$graph" = '▁×▃▅xx▂x█'
}

it_does_not_render_x_as_unknown_data() {
  graph="$(SPARK_UNKNOWN_DATA='' $spark 1 30 55 80 x x 33 x 150)"
  test "$graph" = '▁▂▃▅xx▂x█'
}

it_renders_x_as_custom_empty() {
  graph="$(SPARK_UNKNOWN='' $spark 1 30 55 80 x x 33 x 150)"
  test "$graph" = '▁▂▃▅▂█'
}

it_keeps_space_argument() {
  graph="$($spark 1 30 55 80 ' ' ' ' 33 ' ' 150)"
  test "$graph" = '▁▂▃▅  ▂ █'
}

it_treats_empty_line_as_space_in_pipe_data() {
  graph="$(echo -e '1 30 55\n80\n\n\n33\n\n150' | $spark)"

  test "$graph" = '▁▂▃▅  ▂ █'
}

it_keeps_newline_argument() {
  graph="$($spark 1 30 55 80 $'\n' $'\n' 33 $'\n' 150)"
  test "$graph" = '▁▂▃▅

▂
█'
}

it_keeps_tab_argument() {
  graph="$($spark 1 30 55 80 $'\t' $'\t' 33 $'\t' 150)"
  test "$graph" = $'▁▂▃▅\t\t▂\t█'
}

it_keeps_non_numbers_in_comma_argument() {
  graph="$($spark '1,30,55,80,Hello,foo bar,33,(me@you%what.is?),150')"
  test "$graph" = '▁▂▃▅Hellofoo bar▂(me@you%what.is?)█'
}

it_keeps_non_numbers_in_comma_pipe_data() {
  graph="$(echo '1,30,55,80,Hello,foo bar,33,(me@you%what.is?),150' | $spark)"
  test "$graph" = '▁▂▃▅Hellofoo bar▂(me@you%what.is?)█'
}

it_keeps_space_in_comma_argument() {
  graph="$($spark '1,30,55,80, , ,33, ,150')"
  test "$graph" = '▁▂▃▅  ▂ █'
}

it_keeps_space_in_comma_pipe_data() {
  graph="$(echo '1,30,55,80, , ,33, ,150' | $spark)"
  test "$graph" = '▁▂▃▅  ▂ █'
}

it_keeps_spaces_newlines_tabs_in_comma_argument() {
  graph="$($spark $'1,30,\n,55,80,  ,33,\t,150')"
  test "$graph" = $'▁▂\n▃▅  ▂\t█'
}

it_keeps_spaces_tabs_in_comma_pipe_data() {
  graph="$(echo -e '1,30, ,55,80,  ,33,\t,150' | $spark)"
  test "$graph" = $'▁▂ ▃▅  ▂\t█'
}

it_removes_single_newlines_in_comma_pipe_data() {
  graph="$(echo -e '1,30,\n,55,80,\n,33,\n,150' | $spark)"
  test "$graph" = '▁▂▃▅▂█'
}

it_turns_2_newlines_to_space_in_comma_pipe_data() {
  graph="$(echo -e '1,30,\n\n,55,80,\n\n,33,\n\n,150' | $spark)"
  test "$graph" = '▁▂ ▃▅ ▂ █'
}

it_renders_space_as_spark_empty() {
  graph="$(SPARK_EMPTY='-' $spark '1,30,55,80, , ,33, ,150')"
  test "$graph" = '▁▂▃▅--▂-█'
}

it_renders_another_char_as_spark_empty() {
  graph="$(SPARK_EMPTY_DATA='nul' SPARK_EMPTY='-' $spark '1,nul,55,80, , ,33, ,150')"
  test "$graph" = '▁-▃▅  ▂ █'
}

it_renders_a_number_as_spark_empty() {
  graph="$(SPARK_EMPTY_DATA=30 SPARK_EMPTY='-' $spark '1,30,55,80, , ,33, ,150')"
  test "$graph" = '▁-▃▅  ▂ █'
}

it_does_not_render_space_as_spark_empty() {
  graph="$(SPARK_EMPTY_DATA='' $spark '1,30,55,80, , ,33, ,150')"
  test "$graph" = '▁▂▃▅  ▂ █'
}
