#!/usr/bin/env bats

load fixture

@test "it appends a legend with a passed unit at the end" {
    run -0 spark --with-legend --legend-unit 'km/h' 1 300 600 598 599 2
    assert_output '▁▄███▁ | ▁=1…2 ▄=300 █=598…600 km/h'
}

@test "it appends legend with a passed unit after every range when separated by newlines" {
    SPARK_EMPTY_BUCKET='{}'\
    SPARK_LEGEND_BUCKET_SEPARATOR=$'\n' \
    SPARK_LEGEND_SEPARATOR=$'\n---\n' \
    SPARK_LEGEND_RANGE_ASSIGNMENT=': ' \
    SPARK_LEGEND_RANGE_SEPARATOR='..' \
	run -0 spark --with-legend --legend-unit ms 1 2 300 598 599 600 $'\n' 450 420 390 370 350 420
    assert_output <<'EOF'
▁▁▄███
▆▆▆▅▅▆
---
▁: 1..2 ms
▂={}
▃={}
▄: 300 ms
▅: 350..370 ms
▆: 390..450 ms
▇={}
█: 598..600 ms
EOF
}
