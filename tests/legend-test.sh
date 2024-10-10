#!/usr/bin/env roundup

describe "spark legend of sparkline value ranges"

readonly scriptDir="$([ "${BASH_SOURCE[0]}" ] && dirname -- "${BASH_SOURCE[0]}" || exit 3)"
[ -d "$scriptDir" ] || { echo >&2 'ERROR: Cannot determine script directory!'; exit 3; }
spark="${scriptDir}/../spark"

it_appends_a_legend() {
  graph="$($spark --with-legend 1 300 600 598 599 2)"
  test "$graph" = '▁▄███▁ | ▁=1…2 ▄=300 █=598…600'
}

it_appends_a_legend_including_empty() {
  graph="$(SPARK_EMPTY_BUCKET='∅' $spark --with-legend 1 300 600 598 599 2)"
  test "$graph" = '▁▄███▁ | ▁=1…2 ▂=∅ ▃=∅ ▄=300 ▅=∅ ▆=∅ ▇=∅ █=598…600'
}

it_appends_a_legend_on_new_line() {
  graph="$($spark --with-legend 1 2 300 598 599 600 $'\n' 450 420 390 370 350 420 )"
  test "$graph" = '▁▁▄███
▆▆▆▅▅▆
▁=1…2 ▄=300 ▅=350…370 ▆=390…450 █=598…600'
}

it_appends_a_customized_legend() {
  graph="$(SPARK_LEGEND_BUCKET_SEPARATOR=$'\n' SPARK_LEGEND_SEPARATOR=$'\n---\n' SPARK_LEGEND_RANGE_ASSIGNMENT=': ' SPARK_LEGEND_RANGE_SEPARATOR='..' spark --with-legend 1 2 300 598 599 600 $'\n' 450 420 390 370 350 420 )"
  test "$graph" = '▁▁▄███
▆▆▆▅▅▆
---
▁: 1..2
▄: 300
▅: 350..370
▆: 390..450
█: 598..600'
}

it_appends_a_customized_legend_including_empty() {
  graph="$(SPARK_EMPTY_BUCKET='{}' SPARK_LEGEND_BUCKET_SEPARATOR=$'\n' SPARK_LEGEND_SEPARATOR=$'\n---\n' SPARK_LEGEND_RANGE_ASSIGNMENT=': ' SPARK_LEGEND_RANGE_SEPARATOR='..' spark --with-legend 1 2 300 598 599 600 $'\n' 450 420 390 370 350 420 )"
  test "$graph" = '▁▁▄███
▆▆▆▅▅▆
---
▁: 1..2
▂={}
▃={}
▄: 300
▅: 350..370
▆: 390..450
▇={}
█: 598..600'
}
