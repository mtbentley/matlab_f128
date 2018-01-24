#include "f128.h"
#include <stdio.h>
#include <stdlib.h>
#include <quadmath.h>

char LAST_STR[128];

__float128 *plus(__float128 *a, __float128 *b) {
    __float128 *n = malloc(sizeof(__float128));
    *n = *a + *b;
    return n;
}

__float128 *minus(__float128 *a, __float128 *b) {
    __float128 *n = malloc(sizeof(__float128));
    *n = *a - *b;
    return n;
}

__float128 *times(__float128 *a, __float128 *b) {
    __float128 *n = malloc(sizeof(__float128));
    *n = *a * *b;
    return n;
}

__float128 *uminus(__float128 *a) {
    __float128 *n = malloc(sizeof(__float128));
    *n = *a * -1;
    return n;
}

__float128 *rdivide(__float128 *a, __float128 *b) {
    __float128 *n = malloc(sizeof(__float128));
    *n = *a / *b;
    return n;
}

__float128 *power(__float128 *a, __float128 *b) {
    __float128 *n = malloc(sizeof(__float128));
    *n = powq(*a, *b);
    return n;
}

int lt(__float128 *a, __float128 *b) {
    return *a < *b;
}

int gt(__float128 *a, __float128 *b) {
    return *a > *b;
}

int le(__float128 *a, __float128 *b) {
    return *a <= *b;
}

int ge(__float128 *a, __float128 *b) {
    return *a >= *b;
}

int ne(__float128 *a, __float128 *b) {
    return *a != *b;
}

int eq(__float128 *a, __float128 *b) {
    return *a == *b;
}

__float128 *fsin(__float128 *a) {
    __float128 *n = malloc(sizeof(__float128)); 
    *n = sinq(*a);
    return n;
}

__float128 *fsqrt(__float128 *a) {
    __float128 *n = malloc(sizeof(__float128)); 
    *n = sqrtq(*a);
    return n;
}

double get(__float128 *n) {
    return (double)*n;
}

float gfloat(__float128 *n) {
    return (float)*n;
}

__float128 *make(double n) {
    __float128 *r = malloc(sizeof(__float128));
    *r = (__float128)n;
    return r;
}

__float128 *make_e() {
    __float128 *r = malloc(sizeof(__float128));
    *r = M_Eq;
    return r;
}

__float128 *make_pi() {
    __float128 *r = malloc(sizeof(__float128));
    *r = M_PIq;
    return r;
}

char *disp(__float128 *a) {
    quadmath_snprintf(LAST_STR, sizeof(LAST_STR), "%+-#46.*Qe", 64, *a);

    return LAST_STR;
}

__float128 *fromstr(char *s) {
    __float128 *r = malloc(sizeof(__float128));
    *r = strtoflt128(s, NULL);
    return r;
}

void destroy(__float128 *n) {
    if (!n) {
        return;
    }
    free(n);
    n = NULL;
}
