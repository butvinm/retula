# Refal Turing Machine

Retula is a language for writing Turing machines written in [Refal-5λ](https://github.com/bmstu-iu9/refal-5-lambda).

It is deeply inspired by [tula](https://github.com/tsoding/tula) created by Alexey Kutepov.

## Installation

1. Install the Refal-5λ compiler. You can find the instructions [here](https://github.com/bmstu-iu9/refal-5-lambda/releases/tag/3.3.1)

2. Clone this repository

```sh
git clone https://github.com/butvinm/retula.git
```

3. Compile the Retula interpreter

```sh
mkdir -p build
rlc --rich retula.ref -o build/retula
```

## Usage

Consider you have Retula program in `inc.rtl` file. You can run it with the following command:

```sh
build/retula inc.rtl
```

## Syntax


Retula program consists of a set of rules. General syntax of a rule is:

```
case <Current machine state> <Current head value> <New head value> <Step direction, on of '<-' | '.' | '->'> <New machine state>
```

Finally, you can use `trace` command to start the machine in a specific state:

```
trace <Initial machine state>
```

Example of a simple program that increments a binary number:

```retula
case Inc 0 1 -> Halt
case Inc 1 0 -> Inc

trace Inc
```

Running it will produce the following output:

```
Trace step:
    State: (Inc)
    Rules: ((Rule (Inc)(0)(1)(->)(Halt))(Rule (Inc)(1)(0)(->)(Inc)))
    Tape: (()(1)((1)(0)(0)(0)(1)(&)))
    Matched rule: (Rule (Inc)(1)(0)(->)(Inc))
Trace step:
    State: (Inc)
    Rules: ((Rule (Inc)(0)(1)(->)(Halt))(Rule (Inc)(1)(0)(->)(Inc)))
    Tape: (((0))(1)((0)(0)(0)(1)(&)))
    Matched rule: (Rule (Inc)(1)(0)(->)(Inc))
Trace step:
    State: (Inc)
    Rules: ((Rule (Inc)(0)(1)(->)(Halt))(Rule (Inc)(1)(0)(->)(Inc)))
    Tape: (((0)(0))(0)((0)(0)(1)(&)))
    Matched rule: (Rule (Inc)(0)(1)(->)(Halt))
Machine stopped:
    State: Halt
    Rules: ((Rule (Inc)(0)(1)(->)(Halt))(Rule (Inc)(1)(0)(->)(Inc)))
    Tape: (((0)(0)(1))(0)((0)(1)(&)))
```

## Roadmap

- [ ] Better trace output
- [ ] Add support initial tape content
- [ ] S-expressions in the rules and pattern matching on them (e.g. `case Inc (a b) (b a) -> Inc`)
- [ ] Sets and rule-comprehensions (e.g. `set Bin = {0, 1}; for a, b in Bin case Inc a b -> Inc`)
- [ ] Arithmetic operations on the symbols (e.g. `case Inc a (a + 1) -> Halt`)
- [ ] Making usable: modules, submachines, goto, etc.
