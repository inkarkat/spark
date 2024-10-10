#!/usr/bin/env roundup

describe "spark min and max bounds"

readonly scriptDir="$([ "${BASH_SOURCE[0]}" ] && dirname -- "${BASH_SOURCE[0]}" || exit 3)"
[ -d "$scriptDir" ] || { echo >&2 'ERROR: Cannot determine script directory!'; exit 3; }
spark="${scriptDir}/../spark"

it_uses_auto_min_max() {
  graph="$($spark 25 30 45 50 40 35 30 25 50)"
  test "$graph" = '▁▂▇█▅▄▂▁█'
}

it_uses_fixed_min() {
  graph="$($spark --min 0 -- 25 30 45 50 40 35 30 25 50)"
  test "$graph" = '▄▅██▇▆▅▄█'
}

it_uses_fixed_max() {
  graph="$($spark --max 100 -- 25 30 45 50 40 35 30 25 50)"
  test "$graph" = '▁▁▃▃▂▂▁▁▃'
}

it_uses_fixed_min_max() {
  graph="$($spark --min 0 --max 100 -- 25 30 45 50 40 35 30 25 50)"
  test "$graph" = '▂▃▄▄▄▃▃▂▄'
}

it_charts_pipe_with_fixed_min_max() {
  graph="$(echo $'25,30,45,50\n40 35\n30\n25 50' | $spark --min 0 --max 100)"
  test "$graph" = '▂▃▄▄▄▃▃▂▄'
}

it_uses_special_symbol_for_below_fixed_min() {
  graph="$($spark --min 25 -- 24 25 30 45 50 40 35 30 25 0 50)"
  test "$graph" = '⭳▁▂▇█▅▄▂▁⭳█'
}

it_uses_custom_empty_symbol_for_below_fixed_min() {
  graph="$(SPARK_UNDERFLOW='' $spark --min 25 -- 24 25 30 45 50 40 35 30 25 0 50)"
  test "$graph" = '▁▂▇█▅▄▂▁█'
}

it_uses_special_symbol_for_above_fixed_max() {
  graph="$($spark --max 50 -- 25 30 45 50 100 40 35 30 25 50 51)"
  test "$graph" = '▁▂▇█⭱▅▄▂▁█⭱'
}

it_uses_custom_empty_symbol_for_above_fixed_max() {
  graph="$(SPARK_OVERFLOW='' $spark --max 50 -- 25 30 45 50 100 40 35 30 25 50 51)"
  test "$graph" = '▁▂▇█▅▄▂▁█'
}
