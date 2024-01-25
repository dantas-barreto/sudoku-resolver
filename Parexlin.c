#include <stdio.h>
#include <stdbool.h>

void Parexlin(int Fa[9],int qual[9][9][10],int Fa_f[9],int Fa_c[9],int Fa_s[9],bool Exif[9][9],bool Exic[9][9],bool Exis[9][9],int A[9][9],int Nprch){
    int ncand = 0;
    int cand[9][9];
    for(int i = 0; i < 9; i++){
        if (Fa_f[i] > 2){
            ncand = 0;
            for(int j = 0; j < 9; j++){
                if(A[i][j] == 0 && qual[i][j][10]){
                    ncand++;
                    cand[ncand][1];
                }
            }

            if(ncand > 1){
                for(int aux = 1; aux < ncand; aux++){
                    for(int aux2 = aux+1; aux2 < ncand; aux2++){
                        if(qual[i][cand[aux][1]][1] == qual[i][cand[aux2][1]][1] && qual[i][cand[aux][1]][2] == qual[i][cand[aux2][1]][2]){
                            //if (PressCode==3){
                             //   disp("par explicito na linha");
                             //   mpress=[i Qual(i,cand(aux,1),1) Qual(i,cand(aux,1),2)];
                             //   disp(mpress,"i   Qual(i,cand(aux,1),1)   Qual(i,cand(aux,1),2)");
                             //   pause;
                            //}
                           for (int j = 0; j < 9; j++){
                               if (A[i][j] == 0 && j!=cand[aux][1] && j!=cand[aux2][1]){
                                    Qual(qual[i][cand[aux][1]][1], i, j, qual);
                                    Qual(qual[i][cand[aux][1]][2], i, j, qual);
                               } 
                           }
                        }
                    }
                }
            }
        }
    }
}