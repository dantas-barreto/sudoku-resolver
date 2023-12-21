#include <stdio.h>
#include <raylib.h>


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
        //TODO: implementar o sudoku
        //---------------------------------------

        // draw: desenha a janela
        //---------------------------------------
        BeginDrawing();

        ClearBackground(RAYWHITE);

        DrawText("raylib [core] - Sudoku", 190, 200, 20, LIGHTGRAY);

        EndDrawing();
        //---------------------------------------
    }

    // encerramento
    //-------------------------------------------
    CloseWindow();
    //-------------------------------------------

    return 0;
}