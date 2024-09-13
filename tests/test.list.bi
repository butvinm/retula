:i count 1
:b shell 28
./build/retula tests/inc.rtl
:i returncode 0
:b stdout 178
Machine stopped:
    State: Halt
    Rules: [Rule (State Inc)(Read 0)(Write 1)(Step ->)(Next Halt)][Rule (State Inc)(Read 1)(Write 0)(Step ->)(Next Inc)]
    Tape: (001)(1)((&))

:b stderr 0

