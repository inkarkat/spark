#!/usr/bin/env bats

load fixture

@test "it scales common logarithmically" {
    run -0 spark --scale log10 -- 1 10 100 1000 10000 100000
    assert_output '▁▂▃▅▆▇'
}

@test "it scales natural logarithmically" {
    run -0 spark --scale ln -- 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192
    assert_output '▁▁▂▂▃▄▄▅▅▅▆▇█'
}

@test "it scales binary logarithmically" {
    run -0 spark --scale ld -- 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192
    assert_output '▁▁▂▂▃▄▄▅▅▆▇▇█'
}

@test "it scales zero number" {
    run -0 spark --scale ln -- 2 0 8 0 32 0 128 0 512 0 2048 0 8192
    assert_output '▁_▂_▃_▄_▅_▆_█'
}

@test "it prints no errors when scaling" {
    run -0 --separate-stderr spark --scale ld -- 2 16 64
    output="$stderr" assert_output ''
}
