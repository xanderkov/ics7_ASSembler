#ifndef PROF_H
#define PROF_H

//! Программное 32-битное сложение
float sadd32(float, float);

//! Программное 32-битное умножение
float smul32(float, float);

//! Программное 64-битное сложение
double sadd64(double, double);

//! Программное 64-битное умножение
double smul64(double, double);

//! Программное 80-битное сложение
long double sadd80(long double, long double);

//! Программное 80-битное умножение
long double smul80(long double, long double);

//! Аппаратное 32-битное сложение
float hadd32(float, float);

//! Аппаратное 32-битное умножение
float hmul32(float, float);

//! Аппаратное 64-битное сложение
double hadd64(double, double);

//! Аппаратное 64-битное умножение
double hmul64(double, double);

//! Аппаратное 80-битное сложение
long double hadd80(long double, long double);

//! Аппаратное 80-битное умножение
long double hmul80(long double, long double);

#endif // PROF_H