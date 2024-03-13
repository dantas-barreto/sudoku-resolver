void MacroLinha(int Fa[9], int Fa_f[9], int Fa_c[9], int Fa_s[9], bool Exi_f[9][9], bool Exi_c[9][9], bool Exi_s[9][9], int Ls[9][3], int Cs[9][3], int qual[9][9][10], int A[9][9], int Nprch, int t_sleep, int n_sleep, int PressCode) {
    int aux;
    int adjacente1 = 0;
    int adjacente2 = 0;
    for (int n = 0; n < 9; n++) {
        if (Fa[n] <= 7) {
            for (int i = 0; i < 9; i++) {
                if (!Exi_f[n][i]) { // verifica se a linha nao tem o numero
                    switch (i) {
                        // primeiro bloco
                        case 0:
                            adjacente1 = 1;
                            adjacente2 = 2;
                            aux = 0;
                            break;
                        case 1:
                            adjacente1 = 0;
                            adjacente2 = 2;
                            aux = 0;
                            break;
                        case 2:
                            adjacente1 = 0;
                            adjacente2 = 1;
                            aux = 0;
                            break;

                        // segundo bloco
                        case 3:
                            adjacente1 = 4;
                            adjacente2 = 5;
                            aux = 1;
                            break;
                        case 4:
                            adjacente1 = 3;
                            adjacente2 = 5;
                            aux = 1;
                            break;
                        case 5:
                            adjacente1 = 3;
                            adjacente2 = 4;
                            aux = 1;
                            break;

                        // terceiro bloco
                        case 6:
                            adjacente1 = 7;
                            adjacente2 = 8;
                            aux = 2;
                            break;
                        case 7:
                            adjacente1 = 6;
                            adjacente2 = 8;
                            aux = 2;
                            break;
                        case 8:
                            adjacente1 = 6;
                            adjacente2 = 7;
                            aux = 2;
                            break;
                    }

                    if (Exi_f[n][adjacente1] && Exi_f[n][adjacente2]) {
                        for (int k = aux*3; k < aux*3+3; k++) {
                            if (!Exi_s[n][k]) { // identifica o setor
                                int count = 0;
                                for (int j = Cs[k][0]; k < Cs[k][2]; j++) {
                                    if (A[i][j] == 0) {
                                        for (int m = 0; m < qual[i][j][9]; m++) {
                                            if (qual[i][j][m] == n) {
                                                count++;
                                            }
                                        }
                                    }
                                }

                                if (count == 1) { // verifica se existe apenas uma celula
                                    for (int j = Cs[k][0]; j < Cs[k][2]; j++) {
                                        if (A[i][j] == 0) {
                                            for (int m = 0; m < qual[i][j][9]; m++) {
                                                if (qual[i][j][m] == n) {
                                                    Post(n, i, j, Ls, Cs, Fa, qual, Fa_f, Fa_c, Fa_s, Exi_f, Exi_c, Exi_s, A, Nprch);
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
