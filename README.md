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

Make a float with `float128.make(number)`, ie `float128.make(42.42)`.

You can also make pi and e with `float128.pi()` and `float128.e()`.

This supports basic math and comparisons.  `sin` and `sqrt` are the only other
supported functions at the moment.

Convert to double with `double(f)` or `f.double()` (assuming you have a float128
called `f`).

Display a high precision string representation with `disp(f)`.

Make a float128 from a string with `float128.fromstr(s)`, ie
`float128.fromstr('23.14069263277926900572908636794854738026610624260021199344')`  
(that is also the result of `float128.e() .^ float128.pi()`).

TODO
---
See `float128.m` for a full list.
