:i count 3
:b shell 33
./build/retula tests/rtls/inc.rtl
:i returncode 0
:b stdout 145
trace Inc () >>(1)<< ((1)(0)(1)(&))
trace Inc ((0)) >>(1)<< ((0)(1)(&))
trace Inc ((0)(0)) >>(0)<< ((1)(&))
trace Halt ((0)(0)(1)) >>(1)<< ((&))

:b stderr 0

:b shell 37
./build/retula tests/rtls/inc-bad.rtl
:i returncode 1
:b stdout 0

:b stderr 315
tests/rtls/inc-bad.rtl:1: Invalid rule definition. Expected: `case <state> <read> <write> <step> <next>`
tests/rtls/inc-bad.rtl:3: Invalid statement. Expected: `trace <state> <tape>` or `case <state> <read> <write> <step> <next>`
tests/rtls/inc-bad.rtl:5: Invalid trace definition. Expected: `trace <state> <tape>`

:b shell 34
./build/retula tests/rtls/walk.rtl
:i returncode 0
:b stdout 661
trace MoveRight () >>(@)<< ((.)(.)(.)(.)(.)(&))
trace MoveRight ((@)) >>(.)<< ((.)(.)(.)(.)(&))
trace MoveRight ((@)(.)) >>(.)<< ((.)(.)(.)(&))
trace MoveRight ((@)(.)(.)) >>(.)<< ((.)(.)(&))
trace MoveRight ((@)(.)(.)(.)) >>(.)<< ((.)(&))
trace MoveRight ((@)(.)(.)(.)(.)) >>(.)<< ((&))
trace MoveRight ((@)(.)(.)(.)(.)(.)) >>(&)<< ()
trace MoveLeft ((@)(.)(.)(.)(.)) >>(.)<< ((&))
trace MoveLeft ((@)(.)(.)(.)) >>(.)<< ((.)(&))
trace MoveLeft ((@)(.)(.)) >>(.)<< ((.)(.)(&))
trace MoveLeft ((@)(.)) >>(.)<< ((.)(.)(.)(&))
trace MoveLeft ((@)) >>(.)<< ((.)(.)(.)(.)(&))
trace MoveLeft () >>(@)<< ((.)(.)(.)(.)(.)(&))
trace Halt () >>(@)<< ((.)(.)(.)(.)(.)(&))

:b stderr 0

