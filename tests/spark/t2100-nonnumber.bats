#!/usr/bin/env bats

load fixture

@test "it renders x as unknown data" {
    run -0 spark 1 30 55 80 x x 33 x 150
    assert_output '▁▂▃▅××▂×█'
}

@test "it renders another char as unknown data" {
    SPARK_UNKNOWN_DATA='what' run -0 spark 1 what 55 80 x x 33 x 150
    assert_output '▁×▃▅xx▂x█'
}

@test "it renders a number as unknown data" {
    SPARK_UNKNOWN_DATA=30 run -0 spark 1 30 55 80 x x 33 x 150
    assert_output '▁×▃▅xx▂x█'
}

@test "it does not render x as unknown data" {
    SPARK_UNKNOWN_DATA='' run -0 spark 1 30 55 80 x x 33 x 150
    assert_output '▁▂▃▅xx▂x█'
}

@test "it renders x as custom empty" {
    SPARK_UNKNOWN='' run -0 spark 1 30 55 80 x x 33 x 150
    assert_output '▁▂▃▅▂█'
}

@test "it keeps space argument" {
    run -0 spark 1 30 55 80 ' ' ' ' 33 ' ' 150
    assert_output '▁▂▃▅  ▂ █'
}

@test "it treats empty line as space in pipe data" {
    run -0 spark <<<$'1 30 55\n80\n\n\n33\n\n150'
    assert_output '▁▂▃▅  ▂ █'
}

@test "it keeps newline argument" {
    run -0 spark 1 30 55 80 $'\n' $'\n' 33 $'\n' 150
    assert_output '▁▂▃▅

▂
█'
}

@test "it keeps tab argument" {
    run -0 spark 1 30 55 80 $'\t' $'\t' 33 $'\t' 150
    assert_output $'▁▂▃▅\t\t▂\t█'
}

@test "it keeps non numbers in comma argument" {
    run -0 spark '1,30,55,80,Hello,foo bar,33,(me@you%what.is?),150'
    assert_output '▁▂▃▅Hellofoo bar▂(me@you%what.is?)█'
}

@test "it keeps non numbers in comma pipe data" {
    run -0 spark <<<'1,30,55,80,Hello,foo bar,33,(me@you%what.is?),150'
    assert_output '▁▂▃▅Hellofoo bar▂(me@you%what.is?)█'
}

@test "it keeps space in comma argument" {
    run -0 spark '1,30,55,80, , ,33, ,150'
    assert_output '▁▂▃▅  ▂ █'
}

@test "it keeps space in comma pipe data" {
    run -0 spark <<<'1,30,55,80, , ,33, ,150'
    assert_output '▁▂▃▅  ▂ █'
}

@test "it keeps spaces newlines tabs in comma argument" {
    run -0 spark $'1,30,\n,55,80,  ,33,\t,150'
    assert_output $'▁▂\n▃▅  ▂\t█'
}

@test "it keeps spaces tabs in comma pipe data" {
    run -0 spark <<<$'1,30, ,55,80,  ,33,\t,150'
    assert_output $'▁▂ ▃▅  ▂\t█'
}

@test "it removes single newlines in comma pipe data" {
    run -0 spark <<<$'1,30,\n,55,80,\n,33,\n,150'
    assert_output '▁▂▃▅▂█'
}

@test "it turns 2 newlines to space in comma pipe data" {
    run -0 spark <<<$'1,30,\n\n,55,80,\n\n,33,\n\n,150'
    assert_output '▁▂ ▃▅ ▂ █'
}

@test "it renders space as spark empty" {
    SPARK_EMPTY='-' run -0 spark '1,30,55,80, , ,33, ,150'
    assert_output '▁▂▃▅--▂-█'
}

@test "it renders another char as spark empty" {
    SPARK_EMPTY_DATA='nul' SPARK_EMPTY='-' run -0 spark '1,nul,55,80, , ,33, ,150'
    assert_output '▁-▃▅  ▂ █'
}

@test "it renders a number as spark empty" {
    SPARK_EMPTY_DATA=30 SPARK_EMPTY='-' run -0 spark '1,30,55,80, , ,33, ,150'
    assert_output '▁-▃▅  ▂ █'
}

@test "it does not render space as spark empty" {
    SPARK_EMPTY_DATA='' run -0 spark '1,30,55,80, , ,33, ,150'
    assert_output '▁▂▃▅  ▂ █'
}
