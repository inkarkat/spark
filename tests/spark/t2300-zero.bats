#!/usr/bin/env bats

load fixture

@test "it uses special symbol for zero number" {
    run -0 spark 10 0 50 40 90 100 3 0 1 10 0 100 000 1 0.00
    assert_output '▁_▄▄██▁_▁▁_█_▁_'
}

@test "it uses custom empty symbol for zero number" {
    SPARK_ZERO='' run -0 spark 10 0 50 40 90 100 3 0 1 10 0 100 000 1 0.00
    assert_output '▁▄▄██▁▁▁█▁'
}

@test "it does not use special zero if below fixed min" {
    run -0 spark --min 9 10 0 50 40 90 100 3 0 1 10 0 100 000 1 0.00
    assert_output '▁⭳▄▃██⭳⭳⭳▁⭳█⭳⭳⭳'
}
