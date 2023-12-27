#include <stdio.h>
#include <stdbool.h>

void Post(int n,int i,int j,int Ls[9][3],int Cs[9][3],int Fa[9],int qual[10][10][10],int Fa_f[9],int Fa_c[9],int Fa_s[9],bool Exif[9][9],bool Exic[9][9],bool Exis[9][9],int A[9][9],int Nprch){
    int aux, aux2, k; //declaração de variaveis auxiliares
    if(i < 3){
        aux = 0;
    }else if(i < 6){
        aux = 1;
    }else{
        aux = 2;
    }
    if(j < 3){
        aux2 = 0;
    }else if(j < 6){
        aux2 = 1;
    }else{
        aux2 = 2;
    }
    k = aux*3+aux2;//declaração do setor, com base aonde estava os valores

    Fa#(n-1)=Fa#(n-1)-1;Fa_f(i)=Fa_f(i)-1; //diminuir quantos numeros "n" faltam no sudoku, e diminuir quantos numeros faltam na linha i;
    Fa_c(j)=Fa_c(j)-1;Fa_s(k)=Fa_s(k)-1;//diminuir quantos numeros faltam na coluna j e no setor k;
    Exif(n,i)=true;Exic(n,j)=true;Exis(n,k)=true;//Marcando que existe o numero "n" na coluna i, linha j, setor k;
    for(int aux = 0; aux < 10; aux++){
        qual[i][j][aux] = 0;//zerando todas as possibilidades daquela posição;
    }
    A[i][j] = n; //Atribuindo o valor de "n" na sua posição na matriz
    Nprch=Nprch+1;//Aumenta os numeros preenchidos
    //*** Alteracao nos numeros candidatos das demais posicoes da linha ***
    for(int ii = 0; ii < 9; ii++){
        if (A(ii,j)==0){
            Qual(n, ii, j, qual);
        } 
    }
    //*** Alteracao nos numeros candidatos das demais posicoes da coluna ***
    for(int jj = 0; jj < 9; jj++){
        if (A(i,jj)==0){
            Qual(n, i, jj, qual);
        } 
    }
}