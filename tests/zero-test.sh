#!/usr/bin/env roundup

describe "spark handling of zero value"

readonly scriptDir="$([ "${BASH_SOURCE[0]}" ] && dirname -- "${BASH_SOURCE[0]}" || exit 3)"
[ -d "$scriptDir" ] || { echo >&2 'ERROR: Cannot determine script directory!'; exit 3; }
spark="${scriptDir}/../spark"

it_uses_special_symbol_for_zero_number() {
  graph="$($spark 10 0 50 40 90 100 3 0 1 10 0 100 000 1 0.00)"
  test "$graph" = '▁_▄▄██▁_▁▁_█_▁_'
}

it_uses_custom_empty_symbol_for_zero_number() {
  graph="$(SPARK_ZERO='' $spark 10 0 50 40 90 100 3 0 1 10 0 100 000 1 0.00)"
  test "$graph" = '▁▄▄██▁▁▁█▁'
}

it_does_not_use_special_zero_if_below_fixed_min() {
  graph="$($spark --min 9 10 0 50 40 90 100 3 0 1 10 0 100 000 1 0.00)"
  test "$graph" = '▁⭳▄▃██⭳⭳⭳▁⭳█⭳⭳⭳'
}
