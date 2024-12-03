# Andreas, 2014-02-10 Makefile for lab2 testsuite

.PHONY: suite
suite : lab2-testsuite.tar.gz

lab2-testsuite.tar.gz : build-tarball.sh plt-test-lab2.cabal plt-test-lab2.hs Makefile-test bad/*.cc bad-runtime/*.cc good/**/*.cc good/**/*.cc.*put
	./build-tarball.sh

.PHONY: test
test: test-stack test-cabal

.PHONY: test-cabal
test-cabal:
	cabal build all

.PHONY: test-stack
test-stack:
	stack build

# EOF
