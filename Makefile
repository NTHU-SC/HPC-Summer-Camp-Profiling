CC = icx
CFLAGS = -O3 -g -fp-model strict -xCORE-AVX512 -qopenmp -qopt-report -std=c11 -qmkl
CXX = icpx
CXXFLAGS = -std=c++17

BINS = mat_mul_a mat_mul_b mat_mul_c
SRCS = $(addsuffix .c,$(BINS))
DATS = a.dat b.dat

.PHONY: all clean distclean

all: $(BINS)

%: %.c | $(DATS)
	$(CC) $< -o $@ $(CFLAGS)

$(DATS): | gen
	./gen

gen: gen.cpp
	$(CXX) $< -o $@ $(CXXFLAGS)

clean:
	@-rm $(BINS)

distclean: clean
	@-rm *.dat gen
