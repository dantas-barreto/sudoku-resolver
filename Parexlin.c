#include <stdio.h>
#include <stdbool.h>

void Parexlin(int qual[9][9][10],int Fa_f[9],int A[9][9]){
    int cand[8];
    for(int i = 0; i < 9; i++){
        if (Fa_f[i] > 2){
            int ncand = -1;
            for(int j = 0; j <= 8; j++){
                if(A[i][j] == 0 && qual[i][j][9] == 2){
                    ncand++;
                    cand[ncand] = j;
                }
            }

            if(ncand > 0){
                for(int aux = 0; aux <= ncand; aux++){
                    int jaux = cand[aux];
                    for(int aux2 = aux+1; aux2 <= ncand; aux2++){
                        int jaux2 = cand[aux2];
                        if(qual[i][jaux][0] == qual[i][jaux2][0] && qual[i][jaux][1] == qual[i][jaux2][1]){
                           for (int j = 0; j < 9; j++){
                               if (A[i][j] == 0 && j!=cand[aux] && j!=cand[aux2]){
                                    Qual(qual[i][cand[aux]][0], i, j, qual);
                                    Qual(qual[i][cand[aux]][1], i, j, qual);
                               } 
                           }
                        }
                    }
                }
            }
        }
    }
}