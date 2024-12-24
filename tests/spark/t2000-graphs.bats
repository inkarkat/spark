#!/usr/bin/env bats

load fixture

@test "it graphs argv data" {
    run -0 spark 1,5,22,13,5
    assert_output '▁▂█▅▂'
}

@test "it charts pipe data" {
    run -0 spark <<<'1,30,55,80,33,150'
    assert_output '▁▂▃▅▂█'
}

@test "it charts spaced data" {
    run -0 spark 1 30 55 80 33 150
    assert_output '▁▂▃▅▂█'
}

@test "it charts way spaced data" {
    run -0 spark 1 30               55 80 33     150
    assert_output '▁▂▃▅▂█'
}

@test "it handles decimals" {
    run -0 spark 5.5,20
    assert_output '▁█'
}

@test "it charts 100 lt 300" {
    run -0 spark 1,2,3,4,100,5,10,20,50,300
    assert_output '▁▁▁▁▃▁▁▁▂█'
}

@test "it charts 50 lt 100" {
    run -0 spark 1,50,100
    assert_output '▁▄█'
}

@test "it charts 4 lt 8" {
    run -0 spark 2,4,8
    assert_output '▁▃▇'
}

@test "it charts constant data as middle" {
    run -0 spark 3,3,3
    assert_output '▅▅▅'
}

@test "it charts no tier 0" {
    run -0 spark 1,2,3,4,5
    assert_output '▁▂▄▅▇'
}

@test "it equalizes at midtier on same data" {
    run -0 spark 1,1,1,1
    assert_output '▅▅▅▅'
}
