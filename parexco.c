// caso exista em uma coluna dois espacos com dois candidatos similares, logo um necessariamente x e outro y, assim podendo descartar esses
//numeros de outros espaços na msm coluna
void parexco (int A[9][9], int qual[9][9][10], int Fa_c[9])
{
int ncand, n_cand_posicao;
int cand[9][1] = {
                        {0, 0},
                        {0, 0},
                        {0, 0},
                        {0, 0},
                        {0, 0},
                        {0, 0},
                        {0, 0},
                        {0, 0},
                        {0, 0},
                        {0, 0},
};
int j, i, aux, aux2;



for(j = 0; j < 9; j++) // percorre as colunas da matriz
    {
        if(Fa_c[j] > 2) // se faltarem mais de 2 numeros na coluna j
        {
            ncand = 0; // numero de espacos com dois candidatos
            for(i = 0; i < 9; i++) // percorre as linhas da matriz
            {
                if(A[i][j] == 0 && qual[i][j][9] == 2) // se o espaço estiver vazio e tiver apenas dois candidatos
                {
                    ncand = ncand + 1; //caso exita dois candidatos adiciona-se 1 a ncand
                    cand[ncand][1] = i; // armazena a linha onde se encontra o espaço na matriz cand
                }
            }
            if(ncand > 1)// caso exista mais de um espaço com dois candidatos
            {
                //fors para percorrer as linhas da matriz cand e comparar seus candidatos
                for(aux = 1; aux < ncand; aux++)
                {
                    for(aux2 = aux + 1; aux < ncand; aux++)
                    {
                        if(qual[cand[aux][1]][j][1] == qual[cand[aux2][1]][j][1] && qual[cand[aux][1]][j][2] == qual[cand[aux2][1]][j][2]) // se os candidatos a posiço
                        {
                                                                                                                                        //de ambos espaços forem iguais
                            // printar na tela os pares iguais
                            printf("\nPressCode = 3\n"); // n utilizar nada q envolve o presscode
                           /* if(PressCode == 3)
                            {
                                printf("par explicito na coluna: ");
                                //mpress = [j qual[cand[aux][1]][j][1] qual[cand[aux][1]][j][2]]; // ?????????????????????????
                                printf("%d %d %d", j qual[cand[aux][1]][j][1] qual[cand[aux][1]][j][2]); // ira exibir qual a coluna e qual o par explicito
                                //pause
                            }*/
                            for(i = 0; i < 9; i++)
                            {
                                if(A[i][j] == 0 && i != cand[aux][1] && i != cand[aux2][1])
                                {

                                    Qual(qual[cand[aux][1]][j][0], i, j, qual);
                                    Qual(qual[cand[aux][1]][j][1], i, j, qual); // pesquisa se existe os numeros dos pares em outras posiçoes da coluna
                                                                                        // e os exclui
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


