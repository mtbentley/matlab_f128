Float128
===
A 128 bit floating point (aka quad float) wrapper class for matlab.

Internally, uses GCCs `__float128`.

Compiling
---
Requires a reasonably current version of GCC and make.

Compile the `f128.so` library with `make`.

Currently only tested on Linux.

Usage
---
You will need to call `float128.init()` before using any float128s.

Make a float with `float128.make(number)`;

You can also make pi and e with `float128.pi()` and `float128.e()`.

This supports basic math and comparisons.  `sin` and `sqrt` are the only other
supported functions at the moment.

TODO
---
See `float128.m` for a full list.
