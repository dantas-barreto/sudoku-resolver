#include <stdio.h>
#include <stdbool.h>

void Parexlin(int qual[9][9][10],int Fa_f[9],int A[9][9]){
    //qual == array tridimencional com todas as possibilidades de valores pra cada posição
    //fa_f == array que fala quantas possibilidades faltam na linha i
    //A == matriz utilizada no programa como o sudoku
    int cand[8]; // array com a posição com apenas 2 possibilidades de candidatos.
    for(int i = 0; i < 9; i++){
        if (Fa_f[i] > 2){// verificar se faltam mais de 2 numeros na linha i
            int ncand = -1;// declaração de numero candidatos para o array
            for(int j = 0; j <= 8; j++){
                if(A[i][j] == 0 && qual[i][j][9] == 2){
                    ncand++;
                    cand[ncand] = j; // arranjamento do array com a posição com apenas 2 possibilidades
                }
            }

            if(ncand > 0){//caso se tenha mais de apenas 1 possibilidade de lugares com apenas 2 possibilidades
                for(int aux = 0; aux <= ncand; aux++){
                    int jaux = cand[aux];//auxiliar de posição 
                    for(int aux2 = aux+1; aux2 <= ncand; aux2++){
                        int jaux2 = cand[aux2];// auxiliar de posição
                        if(qual[i][jaux][0] == qual[i][jaux2][0] && qual[i][jaux][1] == qual[i][jaux2][1]){//verificação se os 2 pares são iguais
                           for (int j = 0; j < 9; j++){
                            //retirando possibilidades de outras casas fora as 2 achadas
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