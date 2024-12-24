#!/usr/bin/env bats

load fixture

@test "it uses auto min max" {
    run -0 spark 25 30 45 50 40 35 30 25 50
    assert_output '▁▂▇█▅▄▂▁█'
}

@test "it uses fixed min" {
    run -0 spark --min 0 -- 25 30 45 50 40 35 30 25 50
    assert_output '▄▅██▇▆▅▄█'
}

@test "it uses fixed max" {
    run -0 spark --max 100 -- 25 30 45 50 40 35 30 25 50
    assert_output '▁▁▃▃▂▂▁▁▃'
}

@test "it uses fixed min max" {
    run -0 spark --min 0 --max 100 -- 25 30 45 50 40 35 30 25 50
    assert_output '▂▃▄▄▄▃▃▂▄'
}

@test "it charts pipe with fixed min max" {
    run -0 spark --min 0 --max 100 <<<$'25,30,45,50\n40 35\n30\n25 50'
    assert_output '▂▃▄▄▄▃▃▂▄'
}

@test "it uses special symbol for below fixed min" {
    run -0 spark --min 25 -- 24 25 30 45 50 40 35 30 25 0 50
    assert_output '⭳▁▂▇█▅▄▂▁⭳█'
}

@test "it uses custom empty symbol for below fixed min" {
    SPARK_UNDERFLOW='' run -0 spark --min 25 -- 24 25 30 45 50 40 35 30 25 0 50
    assert_output '▁▂▇█▅▄▂▁█'
}

@test "it uses special symbol for above fixed max" {
    run -0 spark --max 50 -- 25 30 45 50 100 40 35 30 25 50 51
    assert_output '▁▂▇█⭱▅▄▂▁█⭱'
}

@test "it uses custom empty symbol for above fixed max" {
    SPARK_OVERFLOW='' run -0 spark --max 50 -- 25 30 45 50 100 40 35 30 25 50 51
    assert_output '▁▂▇█▅▄▂▁█'
}
