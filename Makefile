CC = icx
# CC = gcc
CFLAGS = -O3 -g -fp-model strict -xCORE-AVX512 -qopenmp -qopt-report -std=c11 -qmkl
# MKLROOT=/pkg/compiler/intel/2024/mkl/2024.0
# CFLAGS = -O3 -fopenmp -march=native -m64 -I${MKLROOT}/include \
#     -L${MKLROOT}/lib/intel64 \
#     -Wl,--no-as-needed -lmkl_intel_lp64 -lmkl_gnu_thread -lmkl_core \
#     -lgomp -lpthread -lm -ldl
CXX = icpc
# CXX = g++
CXXFLAGS = -std=c++17

BINS = mat_mul_a mat_mul_b mat_mul_c
SRCS = $(addsuffix .c,$(BINS))
DATS = a.dat b.dat

.PHONY: all clean distclean

all: $(BINS)

%: %.c | $(DATS)
	$(CC) $(CFLAGS) -o $@ $<

$(DATS): | gen
	./gen

gen: gen.cpp
	$(CXX) $< -o $@ $(CXXFLAGS)

clean:
	@-rm $(BINS)

distclean: clean
	@-rm *.dat gen
