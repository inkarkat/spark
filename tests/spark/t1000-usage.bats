#!/usr/bin/env bats

load fixture

@test "it shows help to stderr and exits 2 with no argv" {
    [ -t 0 ] || skip 'Not reading from terminal'
    run -2 --separate-stderr spark
    lines=("${stderr_lines[@]}"); assert_line -n 0 -p 'USAGE:'
}

@test "it shows help with help option" {
    run -0 --separate-stderr spark --help
    assert_line -n 0 -p 'USAGE:'
}

@test "it shows help and exits 2 with unknown as parameter" {
    run -2 --separate-stderr spark --as doesNotExist 1,5,22,13,5
    lines=("${stderr_lines[@]}"); assert_line -n 0 -e '^ERROR:'
    output="$stderr" assert_output -p 'USAGE:'
}
