MATH ?=math/
-include $(HOME)/.config/stan/make.local  # user-defined variables 
-include make/local                       # user-defined variables
include math/make/compiler_flags               # CXX, CXXFLAGS, LDFLAGS set by the end of this file
include math/make/dependencies                 # rules for generating dependencies
include math/make/libraries

CXXFLAGS+=-Ibenchmark/include
LDLIBS+=-lbenchmark -ltbb
LDFLAGS+=-Lbenchmark/build/src
CXX ?= clang++

update: 
	git submodule update --init --recursive

benchmark/build/src/libbenchmark.a: benchmark benchmark/googletest update
	mkdir -p benchmark/build && cd benchmark/build && cmake .. -DCMAKE_BUILD_TYPE=RELEASE && make

benchmark/googletest:
	cd benchmark && git clone https://github.com/google/googletest
