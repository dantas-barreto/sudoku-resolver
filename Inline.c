#include <stdio.h>
#include <stdbool.h>

void Inline(int Ls[9][3], int Cs[9][3], int qual[9][9][10], int A[9][9]){
    int cont, index; 
    // cont == auxiliar de conta para contar numeros possiveis iguais na linha ou coluna
    // index == auxiliar para usar de index dos arrays abaixo
    int imn[9], jmn[9];
    // imn == array para salvar as posições i dos numeros possiveis iguais
    // jmn == mesma coisa mas a posição j

    for(int k = 0; k < 9; k++){
        // identificar o cs e ls antes de testar
        for(int n = 0; n < 9; n++){
            cont = 0;
            for(int i = 0; i < 3; i++){
                for(int j = 0; j < 3; j++){
                    if(A[i][j] == 0){
                        for(int aux = 0; aux < 9; aux++){
                            if(qual[i][j][aux] == n){
                                cont++;
                            }
                        }
                    }
                }
            }
            if(cont == 2){
                index = 0;
                for(int i = 0; i < 3; i++){
                    for(int j = 0; j < 3; j++){
                        if(A[i][j] == 0){
                            for(int aux = 0; aux < 9; aux++){
                                if(qual[i][j][aux] == n){
                                    imn[index] = i;
                                    jmn[index] = j;
                                    index++;
                                }
                            }
                        }
                    }
                }
                if(imn[0] == imn[1]){
                    for(int j = 0; j < 9; j++){
                        if(A[imn[0]][j] == 0 && j != jmn[0] && j != jmn[1]){
                            Qual(n, imn[0], j, qual);
                        }
                    }
                }
                if(jmn[0] == jmn[1]){
                    for(int i = 0; i < 9; i++){
                        if(A[i][jmn[0]] == 0 && i != imn[0] && i != imn[1]){
                            Qual(n, i, jmn[0], qual);
                        }
                    }
                }
            }
        }
    }
}