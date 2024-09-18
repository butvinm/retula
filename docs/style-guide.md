# Code style

## Motivation

- My personal aesthetic preferences, cause whose else preferences should I care about?
- Easy support in IDE. Refal has pretty simple VS Code extension, so it is difficult to properly maintain indentation and other formatting rules defined in the official Refal style guide. So, I decided to use a more simple and easy to maintain style guide.

## General architecture

- Exit points should only in the main module. If you need to mark auxiliary function as failure, use `(Success ...)` and `(Fails ...)` terms.
- If function does IO, it should be its only purpose
- Keep function format aka signature consistent. The only exception is to provide default values or simple arguments format as it is in the arithmetic operations like `<Add>` those allow you to pass first argument either as macrodigit or number. As an example, where different arguments are suitable:
```refal
$ENTRY Gen-Range {
  /* default arguments */
  = <Gen-Range (0) (Inf) 1>;

  /* wraps macrodigits into numbers and uses default step */
  s.Start s.Stop = <Gen-Range (s.Start) (s.Stop) 1>;

  /* wraps all arguments into numbers */
  s.Start s.Stop s.Step = <Gen-Range (s.Start) (s.Stop) s.Step>;

  /* general case */
  (e.Start) (e.Stop) e.Step
    = {
      () = <Gen-RangeImpl ((e.Start) (e.Stop) e.Step)>;
      (e.Ctx) = <Gen-RangeImpl (e.Ctx)>;
    };
}
```

## Naming

- Use PascalCase for functions, variables and modules
- Start anonymous and dynamic $SPEC items with `_`
- Auxiliary function for tail recursion should start with `Do`. Auxiliary functions for condition selection should start with `Sw`. Other auxiliary functions can be named with `-Aux` or more meaningful suffixes.
- For functions related to specific named-bracket aka Abstract Data Type use `ADTName-FunctionName` notation. If it is a fields accessor, use `ADTName-FieldName` notation.


**Examples:**
```refal
ParseLine {
  (t.Machine t.Loc) t.Line = (<SwParseLine (t.Machine t.Loc) t.Line> <Loc-IncLine t.Loc>);
}


SwParseLine {
  (t.Machine t.Loc)
  ('trace ' e.TraceDefinition)
    = <ParseTrace (t.Machine t.Loc) (e.TraceDefinition)>;

  (t.Machine t.Loc)
  ('case ' e.RuleDefinition)
    = <ParseRule (t.Machine t.Loc) (e.RuleDefinition)>;

  (t.Machine t.Loc)
  (/* empty */)
    = t.Machine;
}


$EENUM Machine;


$ENTRY Machine-Create {
  = [Machine
    (State /* empty */)
    (Rules /* empty */)
    (Tape () () ())
  ];
}


$ENTRY Machine-State {
  [Machine e.Params-B (State e.State) e.Params-E] = e.State;
}
```

## Imports

- `$EXTERN` must be preceded by a pseudo-comment `*$FROM` with the name of the file where this function is defined
- Do not combine functions from different files into one `$EXTERN` list
- Do not use `.ref` suffix in `$FROM` pseudo-comment
- Long imports should be split into multiple lines by comma
- Imports from the standard library come first, then third-party libraries, then local modules
- It is better to sort imports in alphabetical order, but we understand that it is difficult to maintain this order manually, so it is not a strict requirement
- Between each group of imports, there should be a single blank line
- After the last import, there should be a two blank lines

**Examples:**
```refal
*$FROM LibraryEx
$EXTERN LoadFile, ExistFile, MapAccum, ArgList;

*$FROM Machine
$EXTERN
  Rule,
  Rule-Create,
  Machine,
  Machine-Create,
  Machine-State,
  Machine-Rules,
  Machine-AppendRule,
  Machine-Tape,
  Machine-Repr;

*$FROM Utils
$EXTERN Fatal, Split;

*$FROM Parser
$EXTERN ParseSource;


$ENTRY Go {}
```

## Functions

- The `Go` function should be the first function in the module
- Main function should go before its auxiliary functions
- Curly brackets `{}` should start on the same line as the function name and ends on the new line
- Each sentence should end with a semicolon `;`, except blocks with only one single-line statement
- Prefer to put empty line between sentences, especially if they are splitted into multiple lines
- The right part of the sentence should be on the same line as the left part if it fits, otherwise it should be on the new line with an indentation of 2 spaces
- Condition with simple pattern are split by `:`, `:` goes on the new line with an indentation of 2 spaces. If pattern is a block, its opening curly bracket `{` should be on the same line as the condition and the rest of the block should be indented with 2 spaces
- The left part of the sentence should be indented with 2 spaces. You can brake it at space and continue on the next line.
- Closing brackets (`}`, `]`, `)`) should be on the same indentation level as the opening bracket (not aligned to it!)
- `:`, `=` should be surrounded by spaces. `,` and `;` should not have spaces before them, but should have spaces after them.

**Examples:**

Left part are separated into two contextually meaningful parts

```refal
ParseRule {
  (t.Machine t.Loc)
  (e.RuleState ' ' e.RuleRead ' ' e.RuleWrite ' ' e.RuleStep ' ' e.RuleNext)
    = <Rule-Create (e.RuleState) (e.RuleRead) (e.RuleWrite) (e.RuleStep) (e.RuleNext)> : t.Rule
    = <Machine-AppendRule t.Machine t.Rule>;

  (t.Machine t.Loc)
  e.BadDefinition
    = <Fatal <Loc-Repr t.Loc> ': Invalid rule definition. Expected: <state> <read> <write> <step> <next>'>;
}
```

First assignment kept on the same line, but condition body is carried to the new line.
Arguable, but on my taste it is more readable.
```refal
$ENTRY Split {
  e.Str = <Trim e.Str> : {
    e.Part ' ' e.Rest = (e.Part) <Split e.Rest>;
    e.Part = (e.Part);
  };
}
```

Auxillary functions goes after the main functions

```refal
$ENTRY ParseSource {
  (e.SourceFile) e.Source
    = <Loc-Create e.SourceFile> : t.Loc
    = <MapAccum
      &ParseLine
      (<Machine-Create> t.Loc)
      e.Source
    >;
}


ParseLine {
  (t.Machine t.Loc) t.Line = (<SwParseLine (t.Machine t.Loc) t.Line> <Loc-IncLine t.Loc>);
}


SwParseLine {
  (t.Machine t.Loc)
  ('trace ' e.TraceDefinition)
    = <ParseTrace (t.Machine t.Loc) (e.TraceDefinition)>;

  (t.Machine t.Loc)
  ('case ' e.RuleDefinition)
    = <ParseRule (t.Machine t.Loc) (e.RuleDefinition)>;

  (t.Machine t.Loc)
  (/* empty */)
    = t.Machine;
}
```


## Comments

- Use /* empty */ to indicate an empty list. If there is some more meaningful and short word, use it instead. Unfortunately, Refal compiler does not support nested multi-line comments, so that approach would lead to a syntax error, but there is nothing we can do about it.
- Prefer to use /**/ comments even for single-line comment (just easy for IDE support)


## Unsolved issues

- /* empty */ for empty lists is not convenient, cause Refal compiler does not support nested multi-line comments
- In some sentences we need both unpacked and packed variable for the term (e.g. `t.Machine` and `[Machine ...]`), but repeated assignments looks nasty. Probably it is my skill issue and with better code architecture I'll be able to avoid such situations. Let's see.
