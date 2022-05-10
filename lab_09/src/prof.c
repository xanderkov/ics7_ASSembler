#include <stdio.h>

// Профилирование
#include <time.h>

// Проверка условий
#include <assert.h>

#include "prof.h"

#define LOOP 1e+8

// Не очень приятный макрос для профилирования разных функций
#define PROF(desc, func) do {                               \
    clock_t s = clock();                                    \
                                                            \
    for (int i = 0; i < LOOP; i++)                          \
        assert(func(2.0, 2.0) == 4.0);                      \
                                                            \
    clock_t t = clock();                                    \
                                                            \
    printf("%s: %e s\n",                                    \
        desc, (double) (t - s) / CLOCKS_PER_SEC / LOOP);    \
} while (0)

int main() 
{
    PROF("Soft 32 + 32", sadd32);
    PROF("Soft 32 * 32", smul32);

    PROF("Soft 64 + 64", sadd64);
    PROF("Soft 64 * 64", smul64);

#ifdef X87

    PROF("Soft 80 + 80", sadd80);
    PROF("Soft 80 * 80", smul80);

    PROF("Hard 32 + 32", hadd32);
    PROF("Hard 32 * 32", hmul32);

    PROF("Hard 64 + 64", hadd64);
    PROF("Hard 64 * 64", hmul64);

    PROF("Hard 80 + 80", hadd80);
    PROF("Hard 80 * 80", hmul80);

#endif // X87

    return 0;
}

float sadd32(float a, float b) 
{
    return a + b;
}

float smul32(float a, float b) 
{
    return a * b;
}

double sadd64(double a, double b) 
{
    return a + b;
}

double smul64(double a, double b) 
{
    return a * b;
}

#ifdef X87

long double sadd80(long double a, long double b) 
{
    return a + b;
}

long double smul80(long double a, long double b) 
{
    return a * b;
}

float hadd32(float a, float b) 
{
    float c;

    // Кладём на стек b и a, прибавляем a к b
    asm("faddp" : "=t" (c) : "0" (a), "u" (b));

    return c;
}

float hmul32(float a, float b) 
{
    float c;

    // Кладём на стек b и a, домножаем b на a
    asm("fmulp" : "=t" (c) : "0" (a), "u" (b));

    return c;
}

double hadd64(double a, double b) 
{
    double c;

    // Кладём на стек b и a, прибавляем a к b
    asm("faddp" : "=t" (c) : "0" (a), "u" (b));

    return c;
}

double hmul64(double a, double b) 
{
    double c;

    // Кладём на стек b и a, домножаем b на a
    asm("fmulp" : "=t" (c) : "0" (a), "u" (b));

    return c;
}

long double hadd80(long double a, long double b) 
{
    long double c;

    // Кладём на стек b и a, прибавляем a к b
    asm("faddp" : "=t" (c) : "0" (a), "u" (b));

    return c;
}

long double hmul80(long double a, long double b) 
{
    long double c;

    // Кладём на стек b и a, домножаем b на a
    asm("fmulp" : "=t" (c) : "0" (a), "u" (b));

    return c;
}

#endif // X87