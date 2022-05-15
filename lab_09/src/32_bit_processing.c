#include "process.h"


void sum_32_bit_nums(float a, float b, float *rez) 
{
    *rez = a + b;
}

void mul_32_bit_nums(float a, float b, float *rez) 
{
    *rez = a * b;
}

void asm_sum_32_bit_nums(float a, float b, float *rez) 
{
    __asm__(".intel_syntax noprefix\n\t"
            "fld %1\n\t"                    // загрузить а
            "fld %2\n\t"                    // загрузить b
            "faddp\n\t"                     // сложить
            "fstp [%0]\n\t"                   // Сохранить вещественное значение с извлечением из стека
            : "=&m"(rez)
            : "m"(a),"m"(b)
            );
}

void asm_mul_32_bit_nums(float a, float b, float *rez) 
{
    __asm__(".intel_syntax noprefix\n\t"
            "fld %1\n\t"
            "fld %2\n\t"
            "fmulp\n\t"
            "fstp [%0]\n\t"
    : "=&m"(rez)
    : "m"(a),"m"(b)
    );

}

void print_32_bit_result() 
{
    float a = 10e+12;
    float b = 10e-12;


    printf("Time for %d trying:\n\n", COUNT);
    puts("WITHOUT ASSEMBLY INSERTION");
    float rez = 0;
    clock_t beg_sum = clock();
    for (int i = 0; i < COUNT; i++)
        sum_32_bit_nums(a, b, &rez);
    clock_t end_sum = (clock() - beg_sum);
    printf("Sum processing %.3g s\n", (double) end_sum / CLOCKS_PER_SEC / (double) COUNT);


    clock_t beg_mul = clock();
    for (int i = 0; i < COUNT; i++)
        mul_32_bit_nums(a, b, &rez);
    clock_t end_mul = (clock() - beg_mul);
    printf("Mul processing %.3g s\n", (double) end_mul / CLOCKS_PER_SEC / (double) COUNT);

}
void asm_print_32_bit_result() 
{
    puts("ASSEMBLY INSERTION");
    float a = 10e+3;
    float b = 10e-3;
    float rez = 0;
    clock_t beg_sum = clock();
    for (int i = 0; i < COUNT; i++)
        asm_sum_32_bit_nums(a, b, &rez);
    clock_t end_sum = (clock() - beg_sum);
    printf("Sum processing %.3g s\n", (double) end_sum / CLOCKS_PER_SEC / (double) COUNT);

    clock_t beg_mul = clock();
    for (int i = 0; i < COUNT; i++)
        asm_mul_32_bit_nums(a, b, &rez);
    clock_t end_mul = (clock() - beg_mul);
    printf("Mul processing %.3g s\n", (double) end_mul / CLOCKS_PER_SEC / (double) COUNT);
}