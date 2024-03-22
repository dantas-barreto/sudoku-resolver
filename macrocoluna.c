#include <stdio.h>
#include <stdlib.h>
// Colocacoes de numeros por "macro-coluna"
void macrocoluna(int Ls[9][3],int Cs[9][3], int Fa[9], int qual[9][9][10], int Fa_f[9], int Fa_c[9], int Fa_s[9], bool Exi_f[9][9], bool Exi_c[9][9], bool Exi_s[9][9], int A[9][9], int Nprch)
{
int adjacente1, adjacente2;
int i, j, m, n, cont;
int aux, k;

    for(n = 1; n <= 9; n++) // numero "n a ser analisado se existe na coluna
    {
        if(Fa[n - 1] <= 7) // se faltam 7 ou menos numeros "n
        {
            for(j = 0; j < 9; j++) // percorre as colunas da matriz
            {
                if(!Exic[n - 1][j]) // se nao existe numero "n na coluna
                {
                    if(j < 3) // caso j < 4 estamos analizando o primeiro setor
                    {          // da macrocoluna
                        switch (j)
                        {
                            case 0: adjacente1=1; adjacente2=2; aux=0;// caso j = 1 seus adjacentes serão as colunas 2 e 3 do setor
                            break;                                      // auxiliar indicando o setor
                            case 1: adjacente1=0; adjacente2=2; aux=0;
                            break;
                            case 2: adjacente1=0; adjacente2=1; aux=0;
                            break;
                        }
                    }
                    else if(j < 6) // segundo setor
                    {
                        switch (j)
                        {
                            case 3: adjacente1=4; adjacente2=5; aux=1;
                            break;
                            case 4: adjacente1=3; adjacente2=5; aux=1;
                            break;
                            case 5: adjacente1=3; adjacente2=4; aux=1;
                            break;
                        }
                    }
                    else // terceiro setor
                    {
                        switch (j)
                        {
                        case 6: adjacente1=7; adjacente2=8; aux=2;
                        break;
                        case 7: adjacente1=6; adjacente2=8; aux=2;
                        break;
                        case 8: adjacente1=6; adjacente2=7; aux=2;
                        break;
                        }
                    }
                    if(Exic[n - 1][adjacente1] && Exic[n - 1][adjacente2]) // se existe numero "n nas colunas dos adjacentes
                    {
                        for(k = aux; k < 3;k++, aux+6) // for para percorrer os setores
                        {
                            if(!Exis[n - 1][k]) // se nao existir "n no setor k
                            {
                                cont = 0;
                                for(i = Ls[k][0]; i <= Ls[k][2]; i++) // percorre da primeira a terceira linha do setor
                                {
                                    if(A[i][j] == 0) // verifica se o espaço (i ,j) esta vazio
                                    {
                                        for(m = 0; m < qual[i][j][9]; m++) // percorre os valores candidatos a posição
                                        {
                                            if(qual[i][j][m] == n) // analisa os valores candidatos até chegar a "n
                                            {
                                                cont = cont + 1;// caso o candidato seja igual a "n adiciona 1 ao contador
                                            }
                                        }
                                    }
                                }
                                if(cont == 1) // verifica se existe somente um candidato no setor para a posição
                                {
                                    for(i = Ls[k][0]; i < Ls[k][2]; i++) // percorre da primeira a terceira linha do setor
                                    {
                                        if(A[i][j] == 0) // se o espaço estiver vazio
                                        {
                                            for(m = 0; m < qual[i][j][9]; m++) // percorre os valores candidatos a posição
                                            {
                                                if(qual[i][j][m] == n) // analisa os valores candidatos até chegar a "n
                                                {
                                                    Post(n,i,j,Ls,Cs,Fa,Qual,Fa_f,Fa_c,Fa_s,Exi_f,Exi_c,Exi_s,A,Nprch); // atualiza a posição
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
