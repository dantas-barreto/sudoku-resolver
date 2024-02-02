#include <stdio.h>

void Qual(int n, int ii, int jj, int qual[9][9][10]){
    //n == valor a ser achado; 
    //ii == posição i da matriz; 
    //jj == posição j da matriz; 
    //qual == matriz com valores posiveis de cada um dos arrays;
    for(int i = 0; i < 9; i++){
        if(qual[ii][jj][i]==n){
            for(int aux = i; aux < 8; aux++){
                if(qual[ii][jj][aux+1] == 1 || qual[ii][jj][aux+1] == 2 || qual[ii][jj][aux+1] == 3 || qual[ii][jj][aux+1] == 4 || qual[ii][jj][aux+1] == 5 || qual[ii][jj][aux+1] == 6 || qual[ii][jj][aux+1] == 7 || qual[ii][jj][aux+1] == 8 || qual[ii][jj][aux+1] == 9){
                    //verificar se são numeros possiveis
                    qual[ii][jj][aux] = qual[ii][jj][aux+1]; //ajustar os candidatos da posição mais a frente
                }else{
                    qual[ii][jj][aux] = 0; //caso não aja candidatos atrás, zerar
                }
            }
            qual[ii][jj][8] = 0; //zerar o ultimo candidato
            qual[ii][jj][9] -= 1; // diminuir em 1 a quantidade de candidatos da linha
        }
    }
}