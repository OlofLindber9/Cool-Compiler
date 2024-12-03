PLT Lab 2 Test Suite
====================

Programming Language Technology (PLT, Chalmers DAT151, University of Gothenburg DIT231)

This is the test suite for PLT lab 2: Type checking and interpretation for C--.

Prerequisites
-------------

You need the following tools installed and in the `PATH`:

- [Haskell Stack](https://docs.haskellstack.org/en/stable/) in a recent enough version, e.g. version 3.1.1.
- The [make](https://en.wikipedia.org/wiki/Make_(software)) tool.

Your solution directory needs to contain a `Makefile` with instructions
so that the invocation of `make` there builds your solution
and places it as executable `lab2` there.

Running the testsuite
---------------------

Invoke the test runner with the path to the directory containing your solution.
```
stack run -- path/to/solution/directory
```

This will first call `make` in this directory and then invoke the generated `lab2` there on all the test files.
