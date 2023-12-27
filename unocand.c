#include <stdio.h>
#include <stdlib.h>
#define TAM 10

void unocand(int A[TAM][TAM], int qual[TAM][TAM][TAM],int t_sleep, int n_sleep, int PressCode, int Ls, int Cs, int p, int strng, int xch, int ych, int Fa, int Fa_f, int Fa_c, int Fa_s, int Exif, int Exic, int Exis, int Nprch)
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
                    Post(Qual(i,j,1),i,j,Ls,Cs,Fa,Qual,Fa_f,Fa_c,Fa_s,Exif,Exic,Exis,A,Nprch);
                    GraphPress(i,j,1,p,strng,xch,ych,t_sleep,n_sleep,PressCode,A);
                }
            }
        }
    }
}

