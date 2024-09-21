:i count 4
:b shell 33
./build/retula tests/rtls/inc.rtl
:i returncode 0
:b stdout 74
Inc () (1 1 0 1 &)
Inc (0) (1 0 1 &)
Inc (0 0) (0 1 &)
Halt (0 0 1) (1 &)

:b stderr 0

:b shell 44
./build/retula tests/rtls/inc-short-tape.rtl
:i returncode 0
:b stdout 74
Inc () (1 1 0 1 &)
Inc (0) (1 0 1 &)
Inc (0 0) (0 1 &)
Halt (0 0 1) (1 &)

:b stderr 0

:b shell 37
./build/retula tests/rtls/inc-bad.rtl
:i returncode 1
:b stdout 0

:b stderr 359
tests/rtls/inc-bad.rtl:1: Invalid rule definition. Expected: `case <state> <read> <write> <step> <next>`
tests/rtls/inc-bad.rtl:3: Invalid statement. Expected: `trace <state> (<tape-left>) (<tape-right>)` or `case <state> <read> <write> <step> <next>`
tests/rtls/inc-bad.rtl:5: Invalid trace definition. Expected: `trace <state> (<tape-left>) (<tape-right>)`

:b shell 34
./build/retula tests/rtls/walk.rtl
:i returncode 0
:b stdout 384
MoveRight () (@ . . . . . &)
MoveRight (@) (. . . . . &)
MoveRight (@ .) (. . . . &)
MoveRight (@ . .) (. . . &)
MoveRight (@ . . .) (. . &)
MoveRight (@ . . . .) (. &)
MoveRight (@ . . . . .) (&)
MoveLeft (@ . . . .) (. &)
MoveLeft (@ . . .) (. . &)
MoveLeft (@ . .) (. . . &)
MoveLeft (@ .) (. . . . &)
MoveLeft (@) (. . . . . &)
MoveLeft () (@ . . . . . &)
Halt () (@ . . . . . &)

:b stderr 0

