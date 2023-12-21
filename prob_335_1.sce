//
clear // Limpa todas as variaveis
clf // Limpa a janela grafica
funcprot(0) // Evita mensagens de erro
// Sudoku, Coquetel + de 300, 335
AA =  [ [0 5 0 4 0 6 0 8 0];  // linha 1
        [9 0 0 0 0 0 0 0 1];  // linha 2
        [0 0 0 3 0 9 0 0 0];  // linha 3
        [3 0 6 0 0 0 9 0 4];  // linha 4
        [0 0 0 0 0 0 0 0 0];  // linha 5
        [7 0 5 0 0 0 3 0 6];  // linha 6
        [0 0 0 8 0 2 0 0 0];  // linha 7
        [6 0 0 0 0 0 0 0 7];  // linha 8
        [0 9 0 6 0 1 0 2 0] ];  // linha 9
t_sleep=4;
n_sleep=6;
PressCode=2;
//
exec('\home\lin\Documentos\sudoku\sudoku2013_versao6.sce',-1);
//exec('\home\lin\Documentos\sudoku\sudoku_ariane2.sce',-1);
//
