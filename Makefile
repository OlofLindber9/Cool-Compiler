# Programming Language Technology (Chalmers DAT151 / GU DIT231)
# (C) 2022-24 Andreas Abel
# All rights reserved.

# Makefile for PLT lab 3 in Haskell

## Variables
###########################################################################

# Files of solution.  Add more files as needed.
files=lab3.hs lab3.cabal CMM.cf Annotated.hs TypeChecker.hs Compiler.hs

## Building
###########################################################################

.PHONY: lab3
lab3: $(files)
	stack install --local-bin-path=.
#	cabal install --installdir=. --install-method=copy --overwrite-policy=always

# Running a test
###########################################################################

# Run a single test, e.g. good/large_const.cc
.PHONY: test
test:
	stack run --stack-yaml=testsuite/stack.yaml -- -g testsuite/lab2-testsuite/good/large_const.cc .

# Rules for cleaning generated files
###########################################################################

.PHONY: clean
	stack clean
#	cabal clean

# EOF
