#!/usr/bin/env roundup

describe "spark scaling of input numbers"

readonly scriptDir="$([ "${BASH_SOURCE[0]}" ] && dirname -- "${BASH_SOURCE[0]}" || exit 3)"
[ -d "$scriptDir" ] || { echo >&2 'ERROR: Cannot determine script directory!'; exit 3; }
spark="${scriptDir}/../spark"

it_scales_common_logarithmically() {
  graph="$($spark --scale log10 -- 1 10 100 1000 10000 100000)"
  test "$graph" = '▁▂▃▅▆▇'
}

it_scales_natural_logarithmically() {
  graph="$($spark --scale ln -- 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192)"
  test "$graph" = '▁▁▂▂▃▄▄▅▅▅▆▇█'
}

it_scales_binary_logarithmically() {
  graph="$($spark --scale ld -- 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192)"
  test "$graph" = '▁▁▂▂▃▄▄▅▅▆▇▇█'
}

it_scales_zero_number() {
  graph="$($spark --scale ln -- 2 0 8 0 32 0 128 0 512 0 2048 0 8192)"
  test "$graph" = '▁_▂_▃_▄_▅_▆_█'
}

it_prints_no_errors_when_scaling() {
  [ -z "$(spark --scale ld -- 2 16 64 2>&1 >/dev/null)" ]
}
