#include <stdio.h>

#include "prec.h"

void line(long double p) 
{
    printf("π = %Le, sin(π / 1) = % Le, sin(π / 2) = % Le;\n",
        p, fsin(p / 1), fsin(p / 2));
}

int main() 
{
    line(PREC2PI);
    line(PREC6PI);
    line(fldpi());

    return 0;
}

long double fsin(long double x) 
{
    long double y;

    // Кладём на стек x, берём синус
    asm("fsin" : "=t" (y) : "0" (x));

    return y;
}

long double fldpi() 
{
    long double p;

    // Кладём на стек π
    asm("fldpi" : "=t" (p));

    return p;
}