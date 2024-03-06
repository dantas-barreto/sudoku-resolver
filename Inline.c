#include <stdio.h>
#include <stdbool.h>

void Inline(int Ls[9][3], int Cs[9][3], int qual[9][9][10], int A[9][9]){
    int cont, index; 
    // cont == auxiliar de conta para contar numeros possiveis iguais na linha ou coluna
    // index == auxiliar para usar de index dos arrays abaixo
    int imn[2], jmn[2];
    // imn == array para salvar as posições "i" dos numeros possiveis iguais
    // jmn == mesma coisa mas a posição "j"

    for(int k = 0; k < 9; k++){
        // percorrer as matrizes "Cs" e "Ls" na posição "k"
        for(int n = 0; n < 9; n++){
            cont = 0;
            for(int i = 0; i < 3; i++){
                for(int j = 0; j < 3; j++){
                    // percorrer as matrizes "Cs" e "Ls" na posição "i" e "j"
                    if(A[Ls[k][i]][Cs[k][j]] == 0){ // verificação se o espaço da matriz está disponivel
                        for(int aux = 0; aux < 9; aux++){
                            if(qual[Ls[k][i]][Cs[k][j]][aux] == n){
                                cont++; // aumento do contador caso um numero "n" for encontrato
                            }
                        }
                    }
                }
            }
            if(cont == 2){ // caso tenha apenas 2 numeros "n" possiveis
                index = 0; // variavel auxiliar para a não sobreposição dos arrays
                for(int i = 0; i < 3; i++){
                    for(int j = 0; j < 3; j++){
                        // percorrer as matrizes "Cs" e "Ls" na posição "i" e "j"
                        if(A[Ls[k][i]][Cs[k][j]] == 0){
                            for(int aux = 0; aux < 9; aux++){
                                if(qual[Ls[k][i]][Cs[k][j]][aux] == n){
                                    imn[index] = Ls[k][i]; // guardar a posição "i" no array com base na matriz "Ls"
                                    jmn[index] = Cs[k][j]; // guardar a posição "j" no array com base na matriz "Cs"
                                    index++;// aumento do valor da variavel auxiliar para a não sobreposição dos arrays
                                }
                            }
                        }
                    }
                }
                if(imn[0] == imn[1]){ // verificar se a posição "i" do vetor é a mesma
                    for(int j = 0; j < 9; j++){
                        if(A[imn[0]][j] == 0 && j != jmn[0] && j != jmn[1]){
                            Qual(n, imn[0], j, qual); // retirar todas as outras possibilidades de numero na mesma coluna
                        }
                    }
                }
                if(jmn[0] == jmn[1]){ // verificar se a posição "j" do vetor é a mesma
                    for(int i = 0; i < 9; i++){
                        if(A[i][jmn[0]] == 0 && i != imn[0] && i != imn[1]){
                            Qual(n, i, jmn[0], qual); // retirar todas as outras possibilidades de numero na mesma linha
                        }
                    }
                }
            }
        }
    }
}