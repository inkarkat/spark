#!/usr/bin/env roundup

describe "spark custom rendering of ticks"

readonly scriptDir="$([ "${BASH_SOURCE[0]}" ] && dirname -- "${BASH_SOURCE[0]}" || exit 3)"
[ -d "$scriptDir" ] || { echo >&2 'ERROR: Cannot determine script directory!'; exit 3; }
spark="${scriptDir}/../spark"

it_renders_8_custom_ticks() {
  graph="$(SPARK_TICKS='1 2 3 4 5 6 7 8' $spark 1 30 55 80 33 150)"
  test "$graph" = '123528'
}

it_renders_4_custom_ticks() {
  graph="$(SPARK_TICKS='1 2 3 4' $spark 1 30 55 80 33 150)"
  test "$graph" = '112314'
}

it_renders_10_custom_ticks() {
  graph="$(SPARK_TICKS='1 2 3 4 5 6 7 8 9 X' $spark 1 30 55 80 33 150)"
  test "$graph" = '12463X'
}

it_renders_16_custom_ticks() {
  graph="$(SPARK_TICKS='1 2 3 4 5 6 7 8 a b c d e f g h' $spark 1 30 55 80 33 150)"
  test "$graph" = '146a4h'
}

it_renders_special_custom_ticks() {
  graph="$(SPARK_TICKS='? * \ !' $spark 1 120 55 80 33 150)"
  test "$graph" = '?!*\?!'
}

it_renders_flipped_ticks() {
  graph="$($spark --flip 1 30 55 80 33 150)"
  test "$graph" = '[07m▇[0m[07m▆[0m[07m▅[0m[07m▃[0m[07m▆[0m█'
}

it_charts_constant_data_as_middle_custom_tick() {
  graph="$(SPARK_TICKS='1 2 3 4 5 6 7 8 a b c d e f g h' $spark 3,3,3)"
  test "$graph" = 'aaa'
}

it_renders_named_default_ticks() {
  graph="$($spark --as default 'x,0,10,20,30,40,50, ,60,70,80,90,100,x')"
  test "$graph" = '×_▁▂▃▄▄ ▅▆▇██×'
}

it_renders_named_bars_ticks_even_when_overridden() {
  graph="$(SPARK_TICKS='? * \ !' $spark --as bars 'x,0,10,20,30,40,50, ,60,70,80,90,100,x')"
  test "$graph" = '×_▁▂▃▄▄ ▅▆▇██×'
}

it_renders_shaded_boxes_ticks() {
  graph="$($spark --as shaded-boxes 'x,0,10,20,30,40,50, ,60,70,80,90,100,x')"
  test "$graph" = '× ░░▒▒▒ ▒▓▓██×'
}

it_renders_double_shaded_square_ticks() {
  graph="$($spark --as double-shaded-squares 'x,0,10,20,30,40,50, ,60,70,80,90,100,x')"
  test "$graph" = '×  ░░░░▒▒▒▒▒▒  ▒▒▓▓▓▓████×'
}
