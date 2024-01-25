#include <stdio.h>
#include <stdlib.h>
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

void graphPress(Rectangle rec) {
    DrawRectangleLinesEx(rec, 2.0, BLACK);

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
            Ls[k][i] = i + 1;
        }
    }
    for (int k = 3; k <= 5; k++) {
        for (int i = 0; i <= 2; i++) {
            Ls[k][i] = i + i + 4;
        }
    }
    for (int k = 6; k <= 8; k++) {
        for (int i = 0; i <= 2; i++) {
            Ls[k][i] = i + 7;
        }
    }
    
    // Atribuicao das colunas ordenadas para cada setor
    for (aux = 0; aux <= 2; aux++) {
        aux2 = aux * 3;
        for (int j = 0; j <= 2; j++) {
            Cs[aux2][j] = j + 1;
        }
    }
    for (aux = 0; aux <= 2; aux++) {
        aux2 = 1 + (aux * 3);
        for (int j = 0; j <= 2; j++) {
            Cs[aux2][j] = j + 4;
        }
    }
    for (aux = 0; aux <= 2; aux++) {
        aux2 = 2 + (aux * 3);
        for (int j = 0; j <= 2; j++) {
            Cs[aux2][j] = j + 7;
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

    // loop principal
    while (!WindowShouldClose()) {  // detecta se o botao de fechar a janela ou ESC foi precionado

        // update: atualiza os frames da janela
        //---------------------------------------
        // 2. Leitura do exercicio
        int A[9][9];
        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                A[i][j] = sudoku_teste[i][j];
            }
        }


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

            // TODO: inicializar array strng (linha 857)

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

        EndDrawing();
        //---------------------------------------
    }

    // encerramento
    //-------------------------------------------
    CloseWindow();
    //-------------------------------------------

    return 0;
}
