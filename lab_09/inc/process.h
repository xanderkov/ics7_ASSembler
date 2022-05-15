#ifndef LAB_09_PROCESSING_H
#define LAB_09_PROCESSING_H

#include <stdio.h>
#include <time.h>

#define COUNT 10000

/* 32bit - float */
void sum_32_bit_nums(float a, float b, float *rez);
void mul_32_bit_nums(float a, float b, float *rez);

void asm_sum_32_bit_nums(float a, float b, float *rez);
void asm_mul_32_bit_nums(float a, float b, float *rez);

void print_32_bit_result();
void asm_print_32_bit_result();

/* 64bit - double */
void sum_64_bit_nums(double a, double b, double *rez);
void mul_64_bit_nums(double a, double b, double *rez);

void asm_sum_64_bit_nums(double a, double b, double *rez);
void asm_mul_64_bit_nums(double a, double b, double *rez);

void print_64_bit_result();
void asm_print_64_bit_result();

#ifndef X87
/* 80bit - long double */
void sum_80_bit_nums(long double a, long double b, long double *rez);
void mul_80_bit_nums(long double a, long double b, long double *rez);

void asm_sum_80_bit_nums(long double a, long double b, long double *rez);
void asm_mul_80_bit_nums(long double a, long double b, long double *rez);

void print_80_bit_result();
void asm_print_80_bit_result();
#endif

void sin_compare();

#endif //LAB_09__PROCESSING_H