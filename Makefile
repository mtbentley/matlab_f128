CFLAGS=-fPIC -Wall -Wextra -O3 -std=c11 -g
cc=gcc

.PHONY: all clean

all: f128.so

f128.so: f128.c f128.h
	$(cc) $(CFLAGS) -shared -o f128.so f128.c

clean:
	rm f128.so
