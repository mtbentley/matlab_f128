CFLAGS=-fPIC -Wall -Wextra -O3 -std=c11

all: f128.so

f128.so: f128.c f128.h
	gcc $(CFLAGS) -shared -o f128.so f128.c
