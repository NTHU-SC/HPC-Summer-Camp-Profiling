#include <assert.h>
#include <math.h>
#include <mkl.h>
#include <stdio.h>
#include <string.h>
#include "mkl.h"

#ifndef N
#define N 2048
#endif // N
#ifndef T
// #define T 64
#define T 16
#endif // T
#ifndef EPS
#define EPS 5e-6f
#endif // EPS

float a[N][N], b[N][N], c[N][N], cp[N][N];

int main()
{
    FILE *fa = fopen("a.dat", "rb"), *fb = fopen("b.dat", "rb"), *fc = fopen("c.dat", "rb");
    fread(a, sizeof(float), sizeof a / sizeof(float), fa);
    fread(b, sizeof(float), sizeof b / sizeof(float), fb);
    fread(cp, sizeof(float), sizeof cp / sizeof(float), fc);
    fclose(fa);
    fclose(fb);
    fclose(fc);
    
    for (int i = 0; i < T; i++)
    {
        memset(c, 0, sizeof c);
        cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, N, N, N, 1, (const float *) a, N, (const float *) b, N, 0, (float *) c, N);
    }

    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            if (fabsf(c[i][j] - cp[i][j]) >= (fabsf(c[i][j]) < fabsf(cp[i][j]) ? fabsf(c[i][j]) : fabsf(cp[i][j])) * EPS)
            {
                fprintf(stderr, "Exceed epsilon!! (%d, %d): %f %f\n", i, j, c[i][j], cp[i][j]);
                assert(0);
            }

    if (memcmp(c, cp, sizeof c))
        fprintf(stderr, "Minor errors.\n");

    return 0;
}