#!/usr/bin/env bats

load fixture

@test "it renders 8 custom ticks" {
    SPARK_TICKS='1 2 3 4 5 6 7 8' run -0 spark 1 30 55 80 33 150
    assert_output '123528'
}

@test "it renders 4 custom ticks" {
    SPARK_TICKS='1 2 3 4' run -0 spark 1 30 55 80 33 150
    assert_output '112314'
}

@test "it renders 10 custom ticks" {
    SPARK_TICKS='1 2 3 4 5 6 7 8 9 X' run -0 spark 1 30 55 80 33 150
    assert_output '12463X'
}

@test "it renders 16 custom ticks" {
    SPARK_TICKS='1 2 3 4 5 6 7 8 a b c d e f g h' run -0 spark 1 30 55 80 33 150
    assert_output '146a4h'
}

@test "it renders special custom ticks" {
    SPARK_TICKS='? * \ !' run -0 spark 1 120 55 80 33 150
    assert_output '?!*\?!'
}

@test "it renders flipped ticks" {
    run -0 spark --flip 1 30 55 80 33 150
    assert_output '[07m▇[0m[07m▆[0m[07m▅[0m[07m▃[0m[07m▆[0m█'
}

@test "it charts constant data as middle custom tick" {
    SPARK_TICKS='1 2 3 4 5 6 7 8 a b c d e f g h' run -0 spark 3,3,3
    assert_output 'aaa'
}

@test "it renders named default ticks" {
    run -0 spark --as default 'x,0,10,20,30,40,50, ,60,70,80,90,100,x'
    assert_output '×_▁▂▃▄▄ ▅▆▇██×'
}

@test "it renders named bars ticks even when overridden" {
    SPARK_TICKS='? * \ !' run -0 spark --as bars 'x,0,10,20,30,40,50, ,60,70,80,90,100,x'
    assert_output '×_▁▂▃▄▄ ▅▆▇██×'
}

@test "it renders shaded boxes ticks" {
    run -0 spark --as shaded-boxes 'x,0,10,20,30,40,50, ,60,70,80,90,100,x'
    assert_output '× ░░▒▒▒ ▒▓▓██×'
}

@test "it renders double shaded square ticks" {
    run -0 spark --as double-shaded-squares 'x,0,10,20,30,40,50, ,60,70,80,90,100,x'
    assert_output '×  ░░░░▒▒▒▒▒▒  ▒▒▓▓▓▓████×'
}
