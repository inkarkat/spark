#!/usr/bin/env bats

load fixture

@test "it evenly divides 10 by default" {
    SPARK_TICKS='1 2 3 4 5 6 7 8 9' run -0 spark 0 10 20 30 40 50 60 70 80 90 100
    assert_output '_1234567899'
}

@test "it divides 10 only the max to biggest" {
    SPARK_TICKS='1 2 3 4 5 6 7 8 9' run -0 spark --single-max-range 0 10 20 30 40 50 60 70 80 90 100
    assert_output '_1234556789'
}

@test "it evenly divides 60 ramp by default" {
    SPARK_TICKS='1 2 3 4 5 6 7 8 9' run -0 spark < <(seq 1 60)
    assert_output '111111122222223333334444444555555566666677777778888888999999'
}

@test "it divides 60 ramp only the max to biggest" {
    SPARK_TICKS='1 2 3 4 5 6 7 8 9' run -0 spark --single-max-range < <(seq 1 60)
    assert_output '111111112222222333333334444444555555566666666777777788888889'
}

@test "it lumps extremes together by default" {
    SPARK_TICKS='1 2 3 4 5 6 7 8 9' run -0 spark 0 1 2 3 300 598 599 600
    assert_output '_1115999'
}

@test "it isolates the max in biggest" {
    SPARK_TICKS='1 2 3 4 5 6 7 8 9' run -0 spark --single-max-range 0 1 2 3 300 598 599 600
    assert_output '_1115889'
}
