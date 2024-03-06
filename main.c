#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <raylib.h>

// matriz[i][j]
int sudoku_teste[9][9] = {

                        {0, 0, 0, 6, 2, 0, 0, 7, 1},
                        {0, 0, 0, 5, 0, 9, 3, 0, 0},
                        {0, 0, 0, 0, 0, 0, 8, 2, 0},
                        {5, 0, 0, 0, 0, 1, 0, 9, 0},
                        {4, 0, 0, 0, 0, 0, 0, 0, 2},
                        {0, 9, 0, 3, 0, 0, 0, 0, 4},
                        {0, 4, 8, 0, 0, 0, 0, 0, 0},
                        {0, 0, 9, 8, 0, 6, 0, 0, 0},
                        {1, 2, 0, 0, 7, 3, 0, 0, 0}
};

int t_sleep = 40;
int n_sleep = 8;
int PressCode = 2;

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

void Post(int n,int i,int j,int ls[9][3], int cs[9][3], int Fa[9],int qual[9][9][10],int Fa_f[9],int Fa_c[9],int Fa_s[9],bool Exif[9][9],bool Exic[9][9],bool Exis[9][9],int A[9][9],int Nprch){
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

    Fa[n-1]=Fa[n-1]-1;Fa_f[i]=Fa_f[i]-1; //diminuir quantos numeros "n" faltam no sudoku, e diminuir quantos numeros faltam na linha i;
    Fa_c[j]=Fa_c[j]-1;Fa_s[k]=Fa_s[k]-1;//diminuir quantos numeros faltam na coluna j e no setor k;
    Exif[n-1][i]=true;Exic[n-1][j]=true;Exis[n-1][k]=true;//Marcando que existe o numero "n" na coluna i, linha j, setor k;
    for(int x = 0; x < 10; x++){
        qual[i][j][x] = 0;//zerando todas as possibilidades daquela posição;
    }
    A[i][j] = n; //Atribuindo o valor de "n" na sua posição na matriz
    Nprch=Nprch+1;//Aumenta os numeros preenchidos
    //*** Alteracao nos numeros candidatos das demais posicoes da linha ***
    for(int ii = 0; ii < 9; ii++){
        if (A[ii,j]==0){
            Qual(n, ii, j, qual);
        }
    }
    //*** Alteracao nos numeros candidatos das demais posicoes da coluna ***
    for(int jj = 0; jj < 9; jj++){
        if (A[i,jj]==0){
            Qual(n, i, jj, qual);
        }
    }
    //*** Alteração nos números candidatos das demais posições do setor ***
    for (int ii=ls[k][0]; ii < ls[k][3]; ii++){
        for (int jj=cs[k][0]; jj < cs[k][3]; jj++){
            if (A[ii,jj]==0){
                Qual(n, ii, jj, qual);
            }
        }
    }
}

void graphPress(Rectangle rec) {
    DrawRectangleLinesEx(rec, 2.0, BLACK);
}

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


int main(void) {

    // definicao do tamanho da janela
    const int screenWidth = 800;
    const int screenHeight = 450;
    // definicao do tamanho da matriz do sudoku
    struct Rectangle rec;
    rec.x = screenWidth / 4 * 2 - 135;
    rec.y = screenHeight / 4 * 2 - 135;
    rec.width = 270;
    rec.height = 270;

    InitWindow(screenWidth, screenHeight, "raylib [core] - Sudoku");

    SetTargetFPS(60);               // configura a janera para rodar a 60 fps
    //-------------------------------------------

    // 1. inicializacao
    //-------------------------------------------

    // declaracoes de variaveis
    //-------------------------------------------
    int Fa[9];          // Faltam (n):          Quantos numeros n faltam?
    int Fa_f[9];        // Faltam_linha(i):     Quantos numeros faltam na Linha i?
    int Fa_c[9];        // Faltam_coluna(j):    Quantos numeros faltam na Coluna j?
    int Fa_s[9];        // Faltam_setor(k):     Quantos numeros faltam no setor k?
    bool Exi_f[9][9];   // Existe_linha(n, i):  Existe jah numero n na linha i?
    bool Exi_c[9][9];   // Existe_coluna(n, j): Existe jah numero n na coluna j?
    bool Exi_s[9][9];   // Existe_setor(n, k):  Existe jah numero n no setor k?
    int Ls[9][3];       // Linhas do setor k
    int Cs[9][3];       // Colunas do setor k
    int qual[9][9][10];
    int aux, aux2, Nprch; // outras variaveis

    // 1.1 Prametros, vetores e matrizes

    // Atribuicao das linhas ordenadas para cada setor
    for (int k = 0; k <= 2; k++) {
        for (int i = 0; i <= 2; i++) {
            Ls[k][i] = i;
        }
    }
    for (int k = 3; k <= 5; k++) {
        for (int i = 0; i <= 2; i++) {
            Ls[k][i] = i + 3;
        }
    }
    for (int k = 6; k <= 8; k++) {
        for (int i = 0; i <= 2; i++) {
            Ls[k][i] = i + 6;
        }
    }

    // Atribuicao das colunas ordenadas para cada setor
    for (aux = 0; aux <= 2; aux++) {
        aux2 = aux * 3;
        for (int j = 0; j <= 2; j++) {
            Cs[aux2][j] = j;
        }
    }
    for (aux = 0; aux <= 2; aux++) {
        aux2 = 1 + (aux * 3);
        for (int j = 0; j <= 2; j++) {
            Cs[aux2][j] = j + 3;
        }
    }
    for (aux = 0; aux <= 2; aux++) {
        aux2 = 2 + (aux * 3);
        for (int j = 0; j <= 2; j++) {
            Cs[aux2][j] = j + 6;
        }
    }

    // Inicializacao de vetores e matrizes
    for (aux = 0; aux <= 8; aux++) {
        Fa[aux] = 9;
        Fa_f[aux] = 9;
        Fa_c[aux] = 9;
        Fa_s[aux] = 9;
    }
    for (int n = 0; n <= 8; n++) {
        for (aux = 0; aux <= 8; aux++) {
            Exi_f[n][aux] = false;
            Exi_c[n][aux] = false;
            Exi_s[n][aux] = false;
        }
    }
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            qual[i][j][9] = 9;
            for (int k = 0; k < 9; k++) {
                qual[i][j][k] = k + 1;
            }
        }
    }
    Nprch = 0;

    //---------------------------------------
    // 2. Leitura do exercicio
    int A[9][9];
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            if (sudoku_teste[i][j] != 0) {
                Post(sudoku_teste[i][j], i, j, Ls, Cs, Fa, qual, Fa_f, Fa_c, Fa_s, Exi_f, Exi_c, Exi_s, A, Nprch);
                Nprch--;
            }
            else {
                A[i][j] = 0;
            }
        }
    }

    // TODO: inicializar array strng (linha 857)


    // loop principal
    while (!WindowShouldClose()) {  // detecta se o botao de fechar a janela ou ESC foi precionado

        // update: atualiza os frames da janela


        // draw: desenha a janela
        //---------------------------------------
        BeginDrawing();

        ClearBackground(RAYWHITE);

        DrawText("raylib [core] - Sudoku", 20, 20, 20, DARKGRAY);
        DrawLine(18, 42, screenWidth - 18, 42, BLACK);

        // desenhando o quadrado
        DrawRectangleLinesEx(rec, 2.0, BLACK);

        // divisorias verticais
        DrawLine(295, 90, 295, 359, BLACK);
        DrawLine(325, 90, 325, 359, BLACK);
        DrawLine(355, 90, 355, 359, BLACK);
        DrawLine(356, 90, 356, 359, BLACK);
        DrawLine(385, 90, 385, 359, BLACK);
        DrawLine(415, 90, 415, 359, BLACK);
        DrawLine(445, 90, 445, 359, BLACK);
        DrawLine(446, 90, 446, 359, BLACK);
        DrawLine(475, 90, 475, 359, BLACK);
        DrawLine(505, 90, 505, 359, BLACK);

        // divisorias horizontais
        DrawLine(265, 120, 535, 120, BLACK);
        DrawLine(265, 150, 535, 150, BLACK);
        DrawLine(265, 180, 535, 180, BLACK);
        DrawLine(265, 181, 535, 181, BLACK);
        DrawLine(265, 210, 535, 210, BLACK);
        DrawLine(265, 240, 535, 240, BLACK);
        DrawLine(265, 270, 535, 270, BLACK);
        DrawLine(265, 271, 535, 271, BLACK);
        DrawLine(265, 300, 535, 300, BLACK);
        DrawLine(265, 330, 535, 330, BLACK);

        int posX = 270;
        int posY = 95;
        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                if (posX > 535) {
                    posX = 270;
                }
                if (A[i][j] != 0) {
                    DrawText(TextFormat("%d", A[i][j]), posX, posY, 20, BLUE);
                }
                posX += 30;
            }
            posY += 30;
        }

        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                if (A[i][j] != 0) {
                    //Post();
                }
            }
        }

        EndDrawing();
        //---------------------------------------
    }

    // encerramento
    //-------------------------------------------
    CloseWindow();
    //-------------------------------------------

    return 0;
}
