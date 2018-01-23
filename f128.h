__float128 *plus(__float128 *a, __float128 *b);

__float128 *minus(__float128 *a, __float128 *b);

__float128 *times(__float128 *a, __float128 *b);

__float128 *uminus(__float128 *a);

__float128 *rdivide(__float128 *a, __float128 *b);

__float128 *power(__float128 *a, __float128 *b);

int lt(__float128 *a, __float128 *b);

int le(__float128 *a, __float128 *b);

int gt(__float128 *a, __float128 *b);

int ge(__float128 *a, __float128 *b);

int ne(__float128 *a, __float128 *b);

int eq(__float128 *a, __float128 *b);

__float128 *fsin(__float128 *a);

__float128 *fsqrt(__float128 *a);

double get(__float128 *n);

float gfloat(__float128 *n);

__float128 *make(double n);

__float128 *make_e();

__float128 *make_pi();

void destroy(__float128 *n);

char *disp(__float128 *a);

__float128 *fromstr(char *s);
