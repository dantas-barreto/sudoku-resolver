#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#define TAM 10

void unocand(int A[TAM][TAM], int qual[9][9][TAM],int t_sleep, int n_sleep, int PressCode, int Ls[9][3], int Cs[9][3], int Fa[9], int Fa_f[9], int Fa_c[9], int Fa_s[9], bool Exif[9][9], bool Exic[9][9], bool Exis[9][9], int Nprch, int p, int strng, int xch, int ych)
{
int i, j;
    for(i = 0; i < TAM; i++)
    {
        for(j = 0; j < TAM; j++)
        {
            if( A[i][j] == 0)
            {
                if( qual[i][j][9] == 1)
                {
                    Post(qual[i][j][1],i,j,Fa,qual,Fa_f,Fa_c,Fa_s,Exif,Exic,Exis,A,Nprch);
                }
            }
        }
    }
}

