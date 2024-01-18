#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <raylib.h>

// matriz[i][j]
const int sudoku_teste[9][9] = {

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

int main(void) {

    // inicializacao
    //-------------------------------------------
    const int screenWidth = 800;
    const int screenHeight = 450;
    
    InitWindow(screenWidth, screenHeight, "raylib [core] - Sudoku");

    SetTargetFPS(60);               // configura a janera para rodar a 60 fps
    //-------------------------------------------

    // loop principal
    while (!WindowShouldClose()) {  // detecta se o botao de fechar a janela ou ESC foi precionado

        // update: atualiza os frames da janela
        //---------------------------------------
        //TODO: implementar o sudo
        //---------------------------------------

        // draw: desenha a janela
        //---------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("raylib [core] - Sudoku", 20, 20, 20, DARKGRAY);
            DrawLine(18, 42, screenWidth - 18, 42, BLACK);
            
            // gerando as linhas de um quadrado - centralizado no ponto 265x90
            struct Rectangle rec;
            rec.x = screenWidth / 4 * 2 - 135;
            rec.y = screenHeight / 4 * 2 - 135;
            rec.width = 270;
            rec.height = 270;

            // desenhando o quadrado
            DrawRectangleLinesEx(rec, 2.0, BLACK);

            // divisorias verticais
            DrawLine(295, 90, 295, 360, DARKGRAY);
            DrawLine(325, 90, 325, 360, DARKGRAY);
            DrawLine(355, 90, 355, 360, DARKGRAY);
            DrawLine(385, 90, 385, 360, DARKGRAY);
            DrawLine(415, 90, 415, 360, DARKGRAY);
            DrawLine(445, 90, 445, 360, DARKGRAY);
            DrawLine(475, 90, 475, 360, DARKGRAY);
            DrawLine(505, 90, 505, 360, DARKGRAY);

            // divisorias horizontais
            DrawLine(265, 120, 535, 120, DARKGRAY);
            DrawLine(265, 150, 535, 150, DARKGRAY);
            DrawLine(265, 180, 535, 180, DARKGRAY);
            DrawLine(265, 210, 535, 210, DARKGRAY);
            DrawLine(265, 240, 535, 240, DARKGRAY);
            DrawLine(265, 270, 535, 270, DARKGRAY);
            DrawLine(265, 300, 535, 300, DARKGRAY);
            DrawLine(265, 330, 535, 330, DARKGRAY);

            // numeros do exercicio
            int posX = 270;
            int posY = 95;
            for (int i = 0; i < 9; i++) {
                for (int j = 0; j < 9; j++) {
                    if (posX > 535) {
                        posX = 270;
                    }
                    DrawText(TextFormat("%d", sudoku_teste[i][j]), posX, posY, 20, BLACK);
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
