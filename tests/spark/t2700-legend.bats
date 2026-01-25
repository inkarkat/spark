#!/usr/bin/env bats

load fixture

@test "it appends a legend" {
    run -0 spark --with-legend 1 300 600 598 599 2
    assert_output '▁▄███▁ | ▁=1…2 ▄=300 █=598…600'
}

@test "it appends a legend including empty" {
    SPARK_EMPTY_BUCKET='∅' run -0 spark --with-legend 1 300 600 598 599 2
    assert_output '▁▄███▁ | ▁=1…2 ▂=∅ ▃=∅ ▄=300 ▅=∅ ▆=∅ ▇=∅ █=598…600'
}

@test "it appends a legend on new line" {
    run -0 spark --with-legend 1 2 300 598 599 600 $'\n' 450 420 390 370 350 420
    assert_output - <<'EOF'
▁▁▄███
▆▆▆▅▅▆
▁=1…2 ▄=300 ▅=350…370 ▆=390…450 █=598…600
EOF
}

@test "it appends a customized legend" {
    SPARK_LEGEND_BUCKET_SEPARATOR=$'\n' \
    SPARK_LEGEND_SEPARATOR=$'\n---\n' \
    SPARK_LEGEND_RANGE_ASSIGNMENT=': '\
    SPARK_LEGEND_RANGE_SEPARATOR='..' \
	run -0 spark --with-legend 1 2 300 598 599 600 $'\n' 450 420 390 370 350 420
    assert_output << 'EOF'
▁▁▄███
▆▆▆▅▅▆
---
▁: 1..2
▄: 300
▅: 350..370
▆: 390..450
█: 598..600
EOF
}

@test "it appends a customized legend including empty" {
    SPARK_EMPTY_BUCKET='{}'\
    SPARK_LEGEND_BUCKET_SEPARATOR=$'\n' \
    SPARK_LEGEND_SEPARATOR=$'\n---\n' \
    SPARK_LEGEND_RANGE_ASSIGNMENT=': ' \
    SPARK_LEGEND_RANGE_SEPARATOR='..' \
	run -0 spark --with-legend 1 2 300 598 599 600 $'\n' 450 420 390 370 350 420
    assert_output <<'EOF'
▁▁▄███
▆▆▆▅▅▆
---
▁: 1..2
▂={}
▃={}
▄: 300
▅: 350..370
▆: 390..450
▇={}
█: 598..600
EOF
}
