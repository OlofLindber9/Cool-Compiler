# Solution stub in Haskell

Files to edit:

- [`Annotated.hs`](Annotated.hs): copy from your lab2 solution
- [`TypeChecker.hs`](TypeChecker.hs): copy from your lab2 solution
- [`Compiler.hs`](Compiler.hs)
- Optional: [`lab3.cabal`](lab3.cabal) if you want to add modules or dependencies.
- Other modules you might need to implement the compiler. (Add them to `lab3.cabal`!)

Run `make` here to create the `lab3` executable.
You can then run a file from the testsuite (like `lab2-testsuite/good/large_const.cc`) as follows:
```
./lab3 testsuite/lab2-testsuite/good/large_const.cc
```

You can also selectively run the testsuite, e.g. only on `lab2-testsuite/good/large_const.cc`:
```
stack run --stack-yaml=testsuite/stack.yaml -- -g testsuite/lab2-testsuite/good/large_const.cc .
```
