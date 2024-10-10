#!/usr/bin/env roundup

describe "spark division algorithms"

readonly scriptDir="$([ "${BASH_SOURCE[0]}" ] && dirname -- "${BASH_SOURCE[0]}" || exit 3)"
[ -d "$scriptDir" ] || { echo >&2 'ERROR: Cannot determine script directory!'; exit 3; }
spark="${scriptDir}/../spark"

it_evenly_divides_10_by_default() {
  graph="$(SPARK_TICKS='1 2 3 4 5 6 7 8 9' $spark 0 10 20 30 40 50 60 70 80 90 100)"
  test "$graph" = '_1234567899'
}

it_divides_10_only_the_max_to_biggest() {
  graph="$(SPARK_TICKS='1 2 3 4 5 6 7 8 9' $spark --single-max-range 0 10 20 30 40 50 60 70 80 90 100)"
  test "$graph" = '_1234556789'
}

it_evenly_divides_60_ramp_by_default() {
  graph="$(seq 1 60 | SPARK_TICKS='1 2 3 4 5 6 7 8 9' $spark)"
  test "$graph" = '111111122222223333334444444555555566666677777778888888999999'
}

it_divides_60_ramp_only_the_max_to_biggest() {
  graph="$(seq 1 60 | SPARK_TICKS='1 2 3 4 5 6 7 8 9' $spark --single-max-range)"
  test "$graph" = '111111112222222333333334444444555555566666666777777788888889'
}

it_lumps_extremes_together_by_default() {
  graph="$(SPARK_TICKS='1 2 3 4 5 6 7 8 9' $spark 0 1 2 3 300 598 599 600)"
  test "$graph" = '_1115999'
}

it_isolates_the_max_in_biggest() {
  graph="$(SPARK_TICKS='1 2 3 4 5 6 7 8 9' $spark --single-max-range 0 1 2 3 300 598 599 600)"
  test "$graph" = '_1115889'
}
