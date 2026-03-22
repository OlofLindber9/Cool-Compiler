# C-- Compiler

A compiler for **C--**, a statically-typed subset of C/C++, that targets the **JVM** (Java Virtual Machine). Source programs are compiled to Java class files that can be run directly with `java`.

## Overview

The compiler pipeline:

1. **Parse** — BNFC-generated lexer/parser from the C-- grammar (`CMM.cf`)
2. **Type check** — validates the program and produces a type-annotated AST
3. **Code generation** — translates the annotated AST to [Jasmin](http://jasmin.sourceforge.net/) assembly
4. **Assemble** — Jasmin converts `.j` files to `.class` files

## Language

C-- supports:

- Primitive types: `int`, `double`, `bool`
- Functions with recursion
- Control flow: `if/else`, `while`
- Exceptions: `throw`, `try/catch`
- Arithmetic, comparison, and logical operators
- Pre/post increment and decrement (`++`, `--`)
- Implicit `int`-to-`double` coercion

Built-in I/O functions:
- `void printInt(int x)` / `void printDouble(double x)`
- `int readInt()` / `double readDouble()`

## Building

Requires [Stack](https://docs.haskellstack.org/) and a JDK.

```console
make
```

This produces a `lab3` (or `lab3.exe` on Windows) executable.

## Usage

```console
./lab3 <source.cc>
```

Produces a `<source.class>` file in the same directory as the source file.

**Example:**

```cpp
// factorial.cc
int main() {
  int n = readInt();
  int acc = 1;
  int i = 1;
  while (i < n + 1) {
    acc = i * acc;
    ++i;
  }
  printInt(acc);
  return 0;
}
```

```console
$ make
$ ./lab3 factorial.cc
$ echo 5 | java -cp .:. factorial
120
```

## Running Tests

```console
./run-test-stack.sh
```

Or a single test:

```console
stack run --stack-yaml=testsuite/stack.yaml -- -g testsuite/lab2-testsuite/good/large_const.cc .
```

## Project Structure

```
CMM.cf              Grammar definition (BNFC)
CMM/                Auto-generated parser modules
Annotated.hs        Type-annotated AST
TypeChecker.hs      Type checker
Compiler.hs         Code generator (AST → Jasmin)
Code.hs             JVM instruction representation
FunType.hs          Function type utilities
lab3.hs             Compiler entry point
Runtime.java        Built-in I/O runtime
jasmin.jar          Jasmin assembler
testsuite/          Test suite
```
