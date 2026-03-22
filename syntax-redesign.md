# Syntax Redesign Planning

---

## Keywords

| Concept | Current Syntax | New Syntax |
|---|---|---|
| Variable declaration | `let` | `lit` |
| Variable declaration + init | `let` | `lit` |
| Return statement | `return` | `Crash Out` |
| While loop | `while` | `Let him cook` |
| If/else | `if` / `else` | `goon` / `nut` |
| Throw exception | `throw` | `cooked` |
| Try/catch block | `try` / `catch` | `fuck_around` / `find_out` |

---

## Types

| Concept | Current Syntax | New Syntax |
|---|---|---|
| Boolean type | `bool` | |
| Integer type | `int` |`chad`|
| Double/float type | `double` | `gigachad`|
| Void type | `void` | `skibidi` |

---

## Boolean Literals

| Concept | Current Syntax | New Syntax |
|---|---|---|
| True value | `true` | `nocap` |
| False value | `false` | `cap` |

---

## Operators — Arithmetic

| Concept | Current Syntax | New Syntax |
|---|---|---|
| Multiply | `*` | |
| Divide | `/` | |
| Add | `+` | |
| Subtract | `-` | |

---

## Operators — Increment / Decrement

| Concept | Current Syntax | New Syntax |
|---|---|---|
| Post-increment | `x++` |`x+aura` |
| Post-decrement | `x--` | `x-aura`|
| Pre-increment | `++x` | |
| Pre-decrement | `--x` | |

---

## Operators — Comparison

| Concept | Current Syntax | New Syntax |
|---|---|---|
| Less than | `<` | |
| Greater than | `>` | |
| Less than or equal | `<=` | |
| Greater than or equal | `>=` | |
| Equal | `==` | |
| Not equal | `!=` | |

---

## Operators — Boolean Logic

| Concept | Current Syntax | New Syntax |
|---|---|---|
| Logical AND | `&&` | |
| Logical OR | `\|\|` | |

---

## Operators — Assignment

| Concept | Current Syntax | New Syntax |
|---|---|---|
| Assign | `=` | |

---

## Structure / Punctuation

| Concept | Current Syntax | New Syntax |
|---|---|---|
| Statement terminator | `;` | |
| Argument separator | `,` | |
| Block open | `{` | |
| Block close | `}` | |
| Parameter list open | `(` | |
| Parameter list close | `)` | |

---

## Program Structure

| Concept | Current Syntax | New Syntax |
|---|---|---|
| Function definition | `Type Id ( [Args] ) { [Stmts] }` | |
| Function call | `Id ( [Args] )` | |
| Variable declaration list | `let Type Id, Id, ... ;` | |
| Variable init | `let Type Id = Exp ;` | |
| While loop | `while ( Exp ) Stm` |`Let him cook ( Exp ) Stm` |
| If/else | `if ( Exp ) Stm else Stm` | `goon ( Exp ) Stm nut Stm`|
| Try/catch | `try { [Stmts] } catch ( Type Id ) { [Stmts] }` | `fuck_around { [Stmts] } find_out ( Type Id ) { [Stmts] }`|

---

## Comments

| Concept | Current Syntax | New Syntax |
|---|---|---|
| Single-line comment | `#` | `bruh` |
| Single-line comment (alt) | `//` | `lowkey`|
| Multi-line comment | `/* ... */` |`rant ... end_rant` |

---

## Built-in Functions

These are not in the grammar file but are hardcoded as built-ins in the type checker and compiler.

| Concept | Current Syntax | New Syntax |
|---|---|---|
| Print an integer | `printInt(x)` | `yappChad(x)` |
| Print a double | `printDouble(x)` | `yappGigachad(x)` |
