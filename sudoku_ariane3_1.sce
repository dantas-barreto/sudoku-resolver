// Programa para resolucao de problemas de Sudoku
// versao Ariane v2
// Janeiro de 2013
// Autor: Lin Chau Jen
//
// Documentacao
// Fa#.....Faltam# (n) : Quantos numeros # faltam ?
// Fa_f....Faltam_linha(i) : Quantos numeros faltam na Linha i ?
// Fa_c....Faltam_coluna(j) : Quantos numeros faltam na Coluna j ?
// Fa_s....Faltam_setor(k) : Quantos numeros faltam no Setor k ?
// Exi#f...Existe#linha(n,i) : Existe jah numero # na linha i ?
// Exi#c...Existe#coluna(n,j) : Existe jah numero # na coluna j ?
// Exi#s...Existe#setor(n,k) : Existe jah numero # no setor k ?
// Ls(k,i) : Linhas do setor k
// Cs(k,j) : Colunas do setor k
// Qual(i,j,m) : Valores candidatos para a posicao (i,j)
//
// -----------------------------------------------------------------------------
// Subrotina Excand
// Dada uma posicao, pesquisa se tem "n" entre seus numeros candidatos. Se positivo,
// exclui-lo, adiantando os demais candidatos e zerando a posicao no final
function [Qual] = Excand(n,ii,jj,Qual)
for aux=1:Qual(ii,jj,10)
    if Qual(ii,jj,aux)==n then
        for aux2=aux:Qual(ii,jj,10)
            Qual(ii,jj,aux2)=Qual(ii,jj,aux2+1); //candidatos se adiantam
        end //for aux2
        for aux2=Qual(ii,jj,10):9
            Qual(ii,jj,aux2)=0; //demais posicoes zeradas
        end //for aux2
        Qual(ii,jj,10)=Qual(ii,jj,10)-1; //numero de candidatos
    end //if Qual(ii,jj,aux)
end //for aux
endfunction
// -----------------------------------------------------------------------------
// Subrotina GraphPress
// impressao na janela grafica
function GraphPress(i,j,ij,p,strng,xch,ych,t_sleep,n_sleep,PressCode,A)
    xfrect(1,-19.1,18.1,1);
    p.font_foreground=color("white");
    xstring(1.2,-20.1,strng(ij)+", I= "+string(i)+", J= "+string(j));
    p.font_foreground=color("black");
    if PressCode==1 then
        xstring(xch(j),ych(i),string(A(i,j)));
    else
        for aux=1:n_sleep
            p.font_foreground=color("white");
            xstring(xch(j),ych(i),string(A(i,j)));sleep(t_sleep);
            p.font_foreground=color("black");
            xstring(xch(j),ych(i),string(A(i,j)));sleep(t_sleep);
        end //for
        if PressCode==3 then
            pause;
        end
    end
    p.font_foreground=color("black");
    xstring(1.2,-20.1,strng(ij)+", I= "+string(i)+", J= "+string(j));
endfunction
// -----------------------------------------------------------------------------
// Subrotina InLine
// Num setor, numero repetido apenas 2x, em celulas adjacentes (linha ou coluna)
function [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=InLine(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch)
    for k=1:9
        for n=1:9
            cont=0;
            for i=Ls(k,1):Ls(k,3)
                for j=Cs(k,1):Cs(k,3)
                    if A(i,j)==0 then //celula vazia
                        for aux=1:Qual(i,j,10)
                            if Qual(i,j,aux)==n then cont=cont+1;
                            end
                        end //for aux
                    end //if A(i,j)
                end //for j
            end //for i
            if cont==2 then // tem possibilidades
                index=0;
                for i=Ls(k,1):Ls(k,3)
                    for j=Cs(k,1):Cs(k,3)
                        if A(i,j)==0 then
                            for aux=1:Qual(i,j,10)
                                if Qual(i,j,aux)==n then
                                    index=index+1;
                                    imn(index)=i;
                                    jmn(index)=j;
                                end //if
                            end //for aux
                        end //if A(i,j)
                    end //for j                    
                end //for i
                // verificacao se adjacentes na linha ou na coluna
                if imn(1)==imn(2) then //adjacentes na linha
                    if PressCode==3 then
                        disp("numero, 2x alinhado em uma linha, num setor ");
                        mpress=[k n];
                        disp(mpress,"k   n");
                        pause;
                    end //if PressCode
                    for j=1:9
                        if A(imn(1),j)==0 & j<>jmn(1) &j<>jmn(2) then
                            [Qual] = Excand(n,imn(1),j,Qual)
                        end //if A(imn...)
                    end //for j
                end //if imn...
                if jmn(1)==jmn(2) then //adjacentes na coluna
                    if PressCode==3 then
                        disp("numero, 2x alinhado em uma coluna, num setor ");
                        mpress=[k n];
                        disp(mpress,"k   n");
                        pause;
                    end //if PressCode
                    for i=1:9
                        if A(i,jmn(1))==0 & i<>imn(1) & i<>imn(2) then
                            [Qual] = Excand(n,i,jmn(1),Qual)
                        end //if A(i,jmn...)
                    end //for i
                end //if jmn
            end //if cont
        end //for n
    end //for k ... Fim de "posicoes possiveis alinhadas"
endfunction
// -----------------------------------------------------------------------------
// Subrotina MacroColuna
// Colocacoes de numeros por "macro-coluna"
function [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=MacroColuna(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch,press_ari)
     for n=1:9,
         if Fa#(n)<=7 then
             for j=1:9,
                 if ~Exi#c(n,j) then //verif. se a coluna nao tem o no.
                 if j<4 then
                    select j,
                    case 1, adjacente1=2; adjacente2=3; aux=1;
                    case 2, adjacente1=1; adjacente2=3; aux=1;
                    case 3, adjacente1=1; adjacente2=2; aux=1;          
                    end, //select
                else if j<7 then
                        select j,
                        case 4, adjacente1=5; adjacente2=6; aux=2;
                        case 5, adjacente1=4; adjacente2=6; aux=2;
                        case 6, adjacente1=4; adjacente2=5; aux=2;           
                        end, //select
                    else
                        select j,
                        case 7, adjacente1=8; adjacente2=9; aux=3;
                        case 8, adjacente1=7; adjacente2=9; aux=3;
                        case 9, adjacente1=7; adjacente2=8; aux=3;           
                        end, //select
                     end, //if j<7
                end, //if j<4
                if Exi#c(n,adjacente1)&Exi#c(n,adjacente2) then
                     for k=aux:3:aux+6,
                         if ~Exi#s(n,k) then //identif. setor
                             cont=0;
                             for i=Ls(k,1):Ls(k,3),
                                 if A(i,j)==0 then
                                     for m=1:Qual(i,j,10)
                                         if Qual(i,j,m)==n then cont=cont+1;
                                         end
                                     end //for
                                 end
                             end //for
                             if cont==1 then //verifica se hah soh uma celula
                                 for i=Ls(k,1):Ls(k,3)
                                     if A(i,j)==0 then
                                         for m=1:Qual(i,j,10)
                                             if Qual(i,j,m)==n then
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=..
Post(n,i,j,Ls,Cs,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch),
if ~press_ari then
    GraphPress(i,j,3,p,strng,xch,ych,t_sleep,n_sleep,PressCode,A)    
end
                                             end
                                         end //for
                                     end
                                 end //for
                             end //if
                         end //if ~Exi#s                        
                     end //for k
                end, //Exi#c(n,adjacente1)&Exi#c(n,adjacente2)
                end, //if ~Exi#c(n,j)
             end, // for j
         end, // if Fa#(n)
     end, // for n ... Fim do bloco de post por "macro-coluna"
endfunction
// -----------------------------------------------------------------------------
// Subrotina MacroLinha
// Colocacoes de numeros por "macro-linha"
function [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=MacroLinha(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch,press_ari)
     for n=1:9,
         if Fa#(n)<=7 then
             for i=1:9,
                 if ~Exi#f(n,i) then //verif. se a linha nao tem o numero
                 if i<4 then
                    select i,
                    case 1, adjacente1=2; adjacente2=3; aux=0;
                    case 2, adjacente1=1; adjacente2=3; aux=0;
                    case 3, adjacente1=1; adjacente2=2; aux=0;          
                    end, //select
                else if i<7 then
                        select i,
                        case 4, adjacente1=5; adjacente2=6; aux=1;
                        case 5, adjacente1=4; adjacente2=6; aux=1;
                        case 6, adjacente1=4; adjacente2=5; aux=1;           
                        end, //select
                    else
                        select i,
                        case 7, adjacente1=8; adjacente2=9; aux=2;
                        case 8, adjacente1=7; adjacente2=9; aux=2;
                        case 9, adjacente1=7; adjacente2=8; aux=2;           
                        end, //select
                     end, //if i<7
                end, //if i<4
                if Exi#f(n,adjacente1)&Exi#f(n,adjacente2) then
                    for k=aux*3+1:aux*3+3,
                         if ~Exi#s(n,k) then //identif. setor
                             cont=0;
                             for j=Cs(k,1):Cs(k,3),
                                 if A(i,j)==0 then
                                     for m=1:Qual(i,j,10)
                                         if Qual(i,j,m)==n then cont=cont+1;
                                         end
                                     end //for
                                 end
                             end //for
                             if cont==1 then //verifica se existe apenas uma celula
                                 for j=Cs(k,1):Cs(k,3)
                                     if A(i,j)==0 then
                                         for m=1:Qual(i,j,10)
                                             if Qual(i,j,m)==n then
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=..
Post(n,i,j,Ls,Cs,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch),
if ~press_ari then
    GraphPress(i,j,2,p,strng,xch,ych,t_sleep,n_sleep,PressCode,A)    
end
                                             end
                                         end //for
                                     end
                                 end //for
                             end //if
                         end //if ~Exi#s                        
                     end //for k
                end, //Exi#f(n,adjacente1)&Exi#f(n,adjacente2)
                end, //if ~Exi#f(n,i)
             end, // for i
         end, // if Fa#(n)
     end, // for n ... Fim do bloco de post por "macro-linha"
endfunction
// -----------------------------------------------------------------------------
// Subrotina MarcoZero
// Atribui os valores iniciais a parametros ao inicio de cada processo iterativo
function [Fa#,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,Qual]=MarcoZero()
for aux = 1:9,
  Fa# (aux) = 9;
  Fa_f(aux) = 9;Fa_c(aux) = 9;Fa_s(aux) = 9;
end,
for n=1:9,for aux=1:9,
    Exi#f(n,aux)= %f;Exi#c(n,aux)= %f;Exi#s(n,aux)= %f;
end,end,
for i=1:9,for j=1:9;
    Qual(i,j,10)=9; // numero de valores candidatos
    Qual(i,j,1)=1; // 1o valor candidato
    Qual(i,j,2)=2; // 2o valor candidato e assim por diante
    Qual(i,j,3)=3;Qual(i,j,4)=4;Qual(i,j,5)=5;Qual(i,j,6)=6;
    Qual(i,j,7)=7;Qual(i,j,8)=8;Qual(i,j,9)=9;
end,end,
endfunction
// -----------------------------------------------------------------------------
// Subrotina Parexlin
// Par explicito na linha
function [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=Parexlin(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch)
    for i=1:9
        if Fa_f(i)>2 then
            ncand=0;
            for j=1:9
                if A(i,j)==0 & Qual(i,j,10)==2 then
                    ncand=ncand+1;cand(ncand,1)=j;                    
                end //if A(i,j)...
            end //for j
            if ncand>1 then
                for aux=1:ncand
                    for aux2=aux+1:ncand
                        if Qual(i,cand(aux,1),1)==Qual(i,cand(aux2,1),1) &..
                           Qual(i,cand(aux,1),2)==Qual(i,cand(aux2,1),2) then
                           // encontrado par explicito
                           if PressCode==3 then
                                disp("par explicito na linha");
                                mpress=[i Qual(i,cand(aux,1),1) Qual(i,cand(aux,1),2)];
                                disp(mpress,"i   Qual(i,cand(aux,1),1)   Qual(i,cand(aux,1),2)");
                                pause;
                           end //if PressCode
                           for j=1:9 //reducao de numeros candidatos
                               if A(i,j)==0 & j<>cand(aux,1) & j<>cand(aux2,1) then
                                    [Qual] = Excand(Qual(i,cand(aux,1),1),i,j,Qual);
                                    [Qual] = Excand(Qual(i,cand(aux,1),2),i,j,Qual);
                               end //if A(i,j)
                           end //for j
                        end //if Qual(i,cand(aux,1),1)==...
                    end //for aux2
                end //for aux
            end //if ncand>1..
        end //if Fa_f
    end //for i
endfunction
// -----------------------------------------------------------------------------
// Subrotina Parexco
// Par explicito na coluna
function [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=Parexco(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch)
    for j=1:9
        if Fa_c(j)>2 then
            ncand=0;
            for i=1:9
                if A(i,j)==0 & Qual(i,j,10)==2 then
                    ncand=ncand+1;cand(ncand,1)=i;                    
                end //if A(i,j)...
            end //for i
            if ncand>1 then
                for aux=1:ncand
                    for aux2=aux+1:ncand
                        if Qual(cand(aux,1),j,1)==Qual(cand(aux2,1),j,1) &..
                           Qual(cand(aux,1),j,2)==Qual(cand(aux2,1),j,2) then
                           // encontrado par explicito
                           if PressCode==3 then
                                disp("par explicito na coluna");
                                mpress=[j Qual(cand(aux,1),j,1) Qual(cand(aux,1),j,2)];
                                disp(mpress,"j   Qual(cand(aux,1),j,1)   Qual(cand(aux,1),j,2)");
                                pause;
                           end //if PressCode
                           for i=1:9 //reducao de numeros candidatos
                               if A(i,j)==0 & i<>cand(aux,1) & i<>cand(aux2,1) then
                                [Qual] = Excand(Qual(cand(aux,1),j,1),i,j,Qual);
                                [Qual] = Excand(Qual(cand(aux,1),j,2),i,j,Qual);
                               end //if A(i,j)
                           end //for j
                        end //if Qual(cand(aux,1),j,1)==...
                    end //for aux2
                end //for aux
            end //if ncand>1..
        end //if Fa_c
    end //for j
endfunction
// -----------------------------------------------------------------------------
// Subrotina Parexse
// Par explicito no setor
function [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=Parexse(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch)
    for k=1:9
        if Fa_s(k)>2 then
            ncand=0;
            for i=Ls(k,1):Ls(k,3)
            for j=Cs(k,1):Cs(k,3)
                if A(i,j)==0 & Qual(i,j,10)==2 then
                    ncand=ncand+1;cand(ncand,1)=i;cand(ncand,2)=j;                    
                end //if A(i,j)...
            end //for j
            end //for i
            if ncand>1 then
                for aux=1:ncand
                    for aux2=aux+1:ncand
                        if Qual(cand(aux,1),cand(aux,2),1)==Qual(cand(aux2,1),cand(aux2,2),1) &..
                           Qual(cand(aux,1),cand(aux,2),2)==Qual(cand(aux2,1),cand(aux2,2),2) then
                           // encontrado par explicito
                           if PressCode==3 then
                                disp("par explicito no setor");
                                mpress=[k Qual(cand(aux,1),cand(aux,2),1) Qual(cand(aux,1),cand(aux,2),2)];
                                disp(mpress,"k   Qual(cand(aux,1),cand(aux,2),1)   Qual(cand(aux,1),cand(aux,2),2)");
                                pause;
                           end //if PressCode
                           for i=Ls(k,1):Ls(k,3) //reducao de numeros candidatos
                           for j=Cs(k,1):Cs(k,3)
                               MB=[cand(aux,1) cand(aux,2)];MC=[cand(aux2,1) cand(aux2,2)];
                               MA=[i j];MAB=(MA==MB);MAC=(MA==MC);
                               if A(i,j)==0 & ~(MAB(1)&MAB(2)) & ~(MAC(1)&MAC(2)) then
                                [Qual] = Excand(Qual(cand(aux,1),cand(aux,2),1),i,j,Qual);
                                [Qual] = Excand(Qual(cand(aux,1),cand(aux,2),2),i,j,Qual);
                               end //if A(i,j)
                           end //for j    
                           end //for i
                        end //if Qual(cand(aux,1),cand(aux,2),1)==...
                    end //for aux2
                end //for aux
            end //if ncand>1..
        end //if Fa_s
    end //for k
endfunction
// -----------------------------------------------------------------------------
// Subrotina Paroco
// Par oculto na coluna
function [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=Paroco(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch)
    for j=1:9
        // Procura de numeros candidatos
        ncand=0;
        for n=1:9 
            if ~Exi#c(n,j) & Fa_c(j)>2 then
                cont=0;
                for i=1:9
                    if A(i,j)==0 then //celula vazia
                        for aux=1:Qual(i,j,10)
                            if Qual(i,j,aux)==n then cont=cont+1;
                            end
                        end //aux
                    end //if A(i,j)
                end //for i
                if cont==2 then
                    ncand=ncand+1;
                    cand(ncand,1)=n;
                    index=1;
                    for i=1:9
                        if A(i,j)==0 then
                            for aux=1:Qual(i,j,10)
                                if Qual(i,j,aux)==n then
                                    index=index+1;
                                    cand(ncand,index)=i;
                                end
                            end //for aux
                        end //if A(i,j)
                    end //for i
                end //if cont
            end //if ~Exi#c...
        end //for n
        if ncand==2 then
            if cand(1,2)==cand(2,2) & cand(1,3)==cand(2,3) then //par oculto
                if PressCode==3 then
                    disp("par oculto na coluna");
                    mpress=[j cand(1,2) cand(1,3)];
                    disp(mpress,"j   i1   i2");
                    pause;
                end //if PressCode
                Qual(cand(1,2),j,1)=cand(1,1); Qual(cand(1,3),j,1)=cand(1,1);
                Qual(cand(1,2),j,2)=cand(2,1); Qual(cand(1,3),j,2)=cand(2,1);
                Qual(cand(1,2),j,10)=2; Qual(cand(1,3),j,10)=2;
                for aux=3:9
                    Qual(cand(1,2),j,aux)=0; Qual(cand(1,3),j,aux)=0;
                end
            end //if cand...
        end //if ncand==2
        if ncand==3 then
            if cand(1,2)==cand(2,2) & cand(1,3)==cand(2,3) then //par oculto
                if PressCode==3 then
                    disp("par oculto na coluna");
                    pause;
                end //if PressCode
                Qual(cand(1,2),j,1)=cand(1,1); Qual(cand(1,3),j,1)=cand(1,1);
                Qual(cand(1,2),j,2)=cand(2,1); Qual(cand(1,3),j,2)=cand(2,1);
                Qual(cand(1,2),j,10)=2; Qual(cand(1,3),j,10)=2;
                for aux=3:9
                    Qual(cand(1,2),j,aux)=0; Qual(cand(1,3),j,aux)=0;
                end
            end //if cand...1/2
            if cand(1,2)==cand(3,2) & cand(1,3)==cand(3,3) then //par oculto
                if PressCode==3 then
                    disp("par oculto na coluna");
                    pause;
                end //if PressCode
                Qual(cand(1,2),j,1)=cand(1,1); Qual(cand(1,3),j,1)=cand(1,1);
                Qual(cand(1,2),j,2)=cand(3,1); Qual(cand(1,3),j,2)=cand(3,1);
                Qual(cand(1,2),j,10)=2; Qual(cand(1,3),j,10)=2;
                for aux=3:9
                    Qual(cand(1,2),j,aux)=0; Qual(cand(1,3),j,aux)=0;
                end
            end //if cand...1/3
            if cand(2,2)==cand(3,2) & cand(2,3)==cand(3,3) then //par oculto
                Qual(cand(2,2),j,1)=cand(2,1); Qual(cand(2,3),j,1)=cand(2,1);
                Qual(cand(2,2),j,2)=cand(3,1); Qual(cand(2,3),j,2)=cand(3,1);
                Qual(cand(2,2),j,10)=2; Qual(cand(2,3),j,10)=2;
                for aux=3:9
                    Qual(cand(2,2),j,aux)=0; Qual(cand(2,3),j,aux)=0;
                end
            end //if cand...2/3
        end //if ncand==3
    end //for j ... Fim do bloco da procura do "par oculto" por coluna 
endfunction
// -----------------------------------------------------------------------------
// Subrotina Parolin
// Par oculto na linha
function [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=Parolin(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch)
    for i=1:9
        // Procura de numeros candidatos
        ncand=0;
        for n=1:9 
            if ~Exi#f(n,i) & Fa_f(i)>2 then
                cont=0;
                for j=1:9
                    if A(i,j)==0 then //celula vazia
                        for aux=1:Qual(i,j,10)
                            if Qual(i,j,aux)==n then cont=cont+1;
                            end
                        end //aux
                    end //if A(i,j)
                end //for j
                if cont==2 then
                    ncand=ncand+1;
                    cand(ncand,1)=n;
                    index=1;
                    for j=1:9
                        if A(i,j)==0 then
                            for aux=1:Qual(i,j,10)
                                if Qual(i,j,aux)==n then
                                    index=index+1;
                                    cand(ncand,index)=j;
                                end
                            end //for aux
                        end //if A(i,j)
                    end //for j
                end //if cont
            end //if ~Exi#f...
        end //for n
        if ncand==2 then
            if cand(1,2)==cand(2,2) & cand(1,3)==cand(2,3) then //par oculto
                if PressCode==3 then
                    disp("par oculto na linha");
                    mpress=[i cand(1,2) cand(1,3)];
                    disp(mpress,"i   j1   j2");
                    pause;
                end //if PressCode
                Qual(i,cand(1,2),1)=cand(1,1); Qual(i,cand(1,3),1)=cand(1,1);
                Qual(i,cand(1,2),2)=cand(2,1); Qual(i,cand(1,3),2)=cand(2,1);
                Qual(i,cand(1,2),10)=2; Qual(i,cand(1,3),10)=2;
                for aux=3:9
                    Qual(i,cand(1,2),aux)=0; Qual(i,cand(1,3),aux)=0;
                end
            end //if cand...
        end //if ncand==2
        if ncand==3 then
            if cand(1,2)==cand(2,2) & cand(1,3)==cand(2,3) then //par oculto
                if PressCode==3 then
                    disp("par oculto na linha");
                    pause;
                end //if PressCode
                Qual(i,cand(1,2),1)=cand(1,1); Qual(i,cand(1,3),1)=cand(1,1);
                Qual(i,cand(1,2),2)=cand(2,1); Qual(i,cand(1,3),2)=cand(2,1);
                Qual(i,cand(1,2),10)=2; Qual(i,cand(1,3),10)=2;
                for aux=3:9
                    Qual(i,cand(1,2),aux)=0; Qual(i,cand(1,3),aux)=0;
                end
            end //if cand...1/2
            if cand(1,2)==cand(3,2) & cand(1,3)==cand(3,3) then //par oculto
                if PressCode==3 then
                    disp("par oculto na linha");
                    pause;
                end //if PressCode
                Qual(i,cand(1,2),1)=cand(1,1); Qual(i,cand(1,3),1)=cand(1,1);
                Qual(i,cand(1,2),2)=cand(3,1); Qual(i,cand(1,3),2)=cand(3,1);
                Qual(i,cand(1,2),10)=2; Qual(i,cand(1,3),10)=2;
                for aux=3:9
                    Qual(i,cand(1,2),aux)=0; Qual(i,cand(1,3),aux)=0;
                end
            end //if cand...1/3
            if cand(2,2)==cand(3,2) & cand(2,3)==cand(3,3) then //par oculto
                Qual(i,cand(2,2),1)=cand(2,1); Qual(i,cand(2,3),1)=cand(2,1);
                Qual(i,cand(2,2),2)=cand(3,1); Qual(i,cand(2,3),2)=cand(3,1);
                Qual(i,cand(2,2),10)=2; Qual(i,cand(2,3),10)=2;
                for aux=3:9
                    Qual(i,cand(2,2),aux)=0; Qual(i,cand(2,3),aux)=0;
                end
            end //if cand...2/3
        end //if ncand==3
    end //for i ... Fim do bloco da procura do "par oculto" por linha
endfunction
// -----------------------------------------------------------------------------
// Subrotina Parose
// Par oculto no setor
function [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=Parose(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch)
    for k=1:9
        // Procura de numeros candidatos
        ncand=0;
        for n=1:9 
            if ~Exi#s(n,k) & Fa_s(k)>2 then
                cont=0;
                for i=Ls(k,1):Ls(k,3),
                for j=Cs(k,1):Cs(k,3)
                    if A(i,j)==0 then //celula vazia
                        for aux=1:Qual(i,j,10)
                            if Qual(i,j,aux)==n then cont=cont+1;
                            end
                        end //aux
                    end //if A(i,j)
                end //for j
                end //for i
                if cont==2 then
                    ncand=ncand+1;
                    cand(ncand,1)=n;
                    index=1;
                    for i=Ls(k,1):Ls(k,3),
                    for j=Cs(k,1):Cs(k,3)
                        if A(i,j)==0 then
                            for aux=1:Qual(i,j,10)
                                if Qual(i,j,aux)==n then
                                    index=index+1;
                                    cand(ncand,index)=i;
                                    index=index+1;
                                    cand(ncand,index)=j;
                                end
                            end //for aux
                        end //if A(i,j)
                    end //for j
                    end //for i
                end //if cont
            end //if ~Exi#s...
        end //for n
        if ncand==2 then
            if cand(1,2)==cand(2,2) & cand(1,3)==cand(2,3) &..
               cand(1,4)==cand(2,4) & cand(1,5)==cand(2,5) then //par oculto
                if PressCode==3 then
                    disp("par oculto no setor");
                    pause;
                end //if PressCode
                Qual(cand(1,2),cand(1,3),1)=cand(1,1);Qual(cand(1,4),cand(1,5),1)=cand(1,1); 
                Qual(cand(1,2),cand(1,3),2)=cand(2,1);Qual(cand(1,4),cand(1,5),2)=cand(2,1);
                Qual(cand(1,2),cand(1,3),10)=2;Qual(cand(1,4),cand(1,5),10)=2;
                for aux=3:9
                    Qual(cand(1,2),cand(1,3),aux)=0;Qual(cand(1,4),cand(1,5),aux)=0;
                end
            end //if cand...
        end //if ncand==2
        if ncand==3 then
            if cand(1,2)==cand(2,2) & cand(1,3)==cand(2,3) &..
               cand(1,4)==cand(2,4) & cand(1,5)==cand(2,5) then //par oculto
                if PressCode==3 then
                    disp("par oculto no setor");
                    pause;
                end //if PressCode
                Qual(cand(1,2),cand(1,3),1)=cand(1,1);Qual(cand(1,4),cand(1,5),1)=cand(1,1); 
                Qual(cand(1,2),cand(1,3),2)=cand(2,1);Qual(cand(1,4),cand(1,5),2)=cand(2,1);
                Qual(cand(1,2),cand(1,3),10)=2;Qual(cand(1,4),cand(1,5),10)=2;
                for aux=3:9
                    Qual(cand(1,2),cand(1,3),aux)=0;Qual(cand(1,4),cand(1,5),aux)=0;
                end
            end //if cand...1/2
            if cand(1,2)==cand(3,2) & cand(1,3)==cand(3,3) &..
               cand(1,4)==cand(3,4) & cand(1,5)==cand(3,5) then //par oculto
                if PressCode==3 then
                    disp("par oculto no setor");
                    pause;
                end //if PressCode
                Qual(cand(1,2),cand(1,3),1)=cand(1,1);Qual(cand(1,4),cand(1,5),1)=cand(1,1); 
                Qual(cand(1,2),cand(1,3),2)=cand(3,1);Qual(cand(1,4),cand(1,5),2)=cand(3,1);
                Qual(cand(1,2),cand(1,3),10)=2;Qual(cand(1,4),cand(1,5),10)=2;
                for aux=3:9
                    Qual(cand(1,2),cand(1,3),aux)=0;Qual(cand(1,4),cand(1,5),aux)=0;
                end
            end //if cand...1/3
            if cand(2,2)==cand(3,2) & cand(2,3)==cand(3,3) &..
               cand(2,4)==cand(3,4) & cand(2,5)==cand(3,5) then //par oculto
                Qual(cand(2,2),cand(2,3),1)=cand(2,1);Qual(cand(2,4),cand(2,5),1)=cand(2,1); 
                Qual(cand(2,2),cand(2,3),2)=cand(3,1);Qual(cand(2,4),cand(2,5),2)=cand(3,1);
                Qual(cand(2,2),cand(2,3),10)=2;Qual(cand(2,4),cand(2,5),10)=2;
                for aux=3:9
                    Qual(cand(2,2),cand(2,3),aux)=0;Qual(cand(2,4),cand(2,5),aux)=0;
                end
            end //if cand...2/3
        end //if ncand==3
    end //for k ... Fim do bloco da procura do "par oculto" por setor
endfunction
// -----------------------------------------------------------------------------
// Subrotina Post
// Identificado um post, isto é, um número n em dada posição (i,j), atualiza-se vetores e matrizes
function [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch] =..
    Post(n,i,j,Ls,Cs,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch),
// Determinação do setor
  if i<4 then aux=0;
         else if i<7 then aux=1; else aux=2; end,
  end,
  if j<4 then aux2=1;
         else if j<7 then aux2=2; else aux2=3; end,
  end,
  k = aux*3+aux2, // o setor
// Atualizacao de vetores e matrizes  
  Fa#(n)=Fa#(n)-1;Fa_f(i)=Fa_f(i)-1;
  Fa_c(j)=Fa_c(j)-1;Fa_s(k)=Fa_s(k)-1;
  Exi#f(n,i)=%t;Exi#c(n,j)=%t;Exi#s(n,k)=%t;
  for aux=1:10,
      Qual(i,j,aux)=0 // Zera o vetor dos valores candidatos
  end,
  A(i,j)=n; // Alteracao dos parametros relativo a celula
  Nprch=Nprch+1;
  Hist(Nprch,1)=n;Hist(Nprch,2)=i;Hist(Nprch,3)=j;
//*** Alteracao nos numeros candidatos das demais posicoes da linha ***
for jj=1:9 //percurso na horizontal
    if A(i,jj)==0 then
        [Qual] = Excand(n,i,jj,Qual);
    end //if A(i,jj)
end //for jj
//*** Alteracao nos numeros candidatos das demais posicoes da coluna ***
for ii=1:9 //percurso na vertical
    if A(ii,j)==0 then
        [Qual] = Excand(n,ii,j,Qual);
    end //if A(ii,j)
end //for ii
//*** Alteração nos números candidatos das demais posições do setor ***
for ii=Ls(k,1):Ls(k,3)
    for jj=Cs(k,1):Cs(k,3)
        if A(ii,jj)==0 then
            [Qual] = Excand(n,ii,jj,Qual);
        end //if A(ii,jj)
    end //for jj
end //for ii
endfunction,
// -----------------------------------------------------------------------------
// Subrotina Preliminares
// Executa tarefas preliminares antes do processo iterativo
function [Ls,Cs,p,xch,ych,strng]=Preliminares()
// Atribuicao das linhas ordenadas para cada setor
for k = 1:3,for i =1:3,Ls(k,i)=i;end,end,
for k = 4:6,for i =1:3,Ls(k,i)=i+3;end,end,
for k = 7:9,for i =1:3,Ls(k,i)=i+6;end,end,
// Atribuicao das colunas ordenadas para cada setor
for aux=1:3,aux2=1+(aux-1)*3;for j=1:3,Cs(aux2,j)=j;end,end,
for aux=1:3,aux2=2+(aux-1)*3;for j=1:3,Cs(aux2,j)=j+3;end,end,
for aux=1:3,aux2=3+(aux-1)*3;for j=1:3,Cs(aux2,j)=j+6;end,end,
// Grafico
p=get("hdl");
//linhas horizontais
p.thickness=2;
plot2d([1,19],[-1,-1],axesflag=0,style=1);plot2d([1,19],[-19,-19],axesflag=0,style=1); 
plot2d([1,19],[-7,-7],axesflag=0,style=1);plot2d([1,19],[-13,-13],axesflag=0,style=1);
//
p.thickness=1;
plot2d([1,19],[-3,-3],axesflag=0,style=2);plot2d([1,19],[-5,-5],axesflag=0,style=2);
plot2d([1,19],[-9,-9],axesflag=0,style=2);plot2d([1,19],[-11,-11],axesflag=0,style=2);
plot2d([1,19],[-15,-15],axesflag=0,style=2);plot2d([1,19],[-17,-17],axesflag=0,style=2);
//linhas verticais
p.thickness=2;
plot2d([1,1],[-1,-19],axesflag=0,style=1);plot2d([19,19],[-1,-19],axesflag=0,style=1);
plot2d([7,7],[-1,-19],axesflag=0,style=1);plot2d([13,13],[-1,-19],axesflag=0,style=1);
//
p.thickness=1;
plot2d([3,3],[-1,-19],axesflag=0,style=2);plot2d([5,5],[-1,-19],axesflag=0,style=2);
plot2d([9,9],[-1,-19],axesflag=0,style=2);plot2d([11,11],[-1,-19],axesflag=0,style=2);
plot2d([15,15],[-1,-19],axesflag=0,style=2);plot2d([17,17],[-1,-19],axesflag=0,style=2);
//
xch(1)=1.9; ych(1)=-2.4;
for i=2:9,xch(i)=xch(i-1)+2;ych(i)=ych(i-1)-2;end
p.font_size=2;
p.font_foreground=color("red");
for i=1:9
    xstring(xch(i),-0.9,string(i));xstring(0.4,ych(i),string(i));
end
strng=["Unico numero candidato";"Colocacao por macro-linha";..
    "Colocacao por macro-coluna";"Unica posicao na linha";..
    "Unica posicao na coluna";"Unica posicao no setor";"- - - - -"];
endfunction
// -----------------------------------------------------------------------------
// Subrotina Problema
// Inicializa a matriz A 
function [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=..
    Problema(Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch,Ls,Cs)
    N=Nprch;Nprch=0;
for aux=1:N
    A(Hist(aux,2),Hist(aux,3))=Hist(aux,1);
    [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch] =Post(Hist(aux,1),Hist(aux,2),..
    Hist(aux,3),Ls,Cs,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch),
end
endfunction
// -----------------------------------------------------------------------------
// Subrotina UnoCand
// Pesquisa por celulas que possuem um unico numero candidato
function [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=UnoCand(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch,press_ari)
    for i=1:9, for j=1:9
        if A(i,j)==0 then //celula vazia
            // verifica se a celula tem um unico numero candidato
            if Qual(i,j,10)==1 then
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=..
Post(Qual(i,j,1),i,j,Ls,Cs,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch),
if ~press_ari then
    GraphPress(i,j,1,p,strng,xch,ych,t_sleep,n_sleep,PressCode,A)
end
             end,
        end,
     end, end, //for i , for j 
endfunction
// -----------------------------------------------------------------------------
// Subrotina UnoCelColuna
// Unica posicao para o numero na coluna
function [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=UnoCelColuna(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch,press_ari)
     for j=1:9
         for n=1:9
             cont=0;
             for i=1:9
                 if A(i,j)==0 then //celula vazia
                     for m=1:Qual(i,j,10)
                         if Qual(i,j,m)==n then cont=cont+1;
                         end
                     end //for m
                 end //if
             end //for i
             if cont==1 then //sucesso
                 for i=1:9
                     if A(i,j)==0 then
                         for m=1:Qual(i,j,10)
                             if Qual(i,j,m)==n then
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=..
Post(n,i,j,Ls,Cs,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch),
if ~press_ari then
    GraphPress(i,j,5,p,strng,xch,ych,t_sleep,n_sleep,PressCode,A)    
end
                             end
                         end
                     end //if
                 end //for i
             end //if
         end //for n
     end //for j
endfunction
// -----------------------------------------------------------------------------
// Subrotina UnoCelLinha
// Unica posicao para o numero na linha
function [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=UnoCelLinha(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch,press_ari)
//
     for i=1:9
         for n=1:9
             cont=0;
             for j=1:9
                 if A(i,j)==0 then //celula vazia
                     for m=1:Qual(i,j,10)
                         if Qual(i,j,m)==n then cont=cont+1;
                         end
                     end //for m
                 end //if
             end //for j
             if cont==1 then //sucesso
                 for j=1:9
                     if A(i,j)==0 then
                         for m=1:Qual(i,j,10)
                             if Qual(i,j,m)==n then
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=..
Post(n,i,j,Ls,Cs,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch),
if ~press_ari then
    GraphPress(i,j,4,p,strng,xch,ych,t_sleep,n_sleep,PressCode,A)    
end
                             end
                         end
                     end //if
                 end //for j
             end //if
         end //for n
     end //for i
endfunction
// -----------------------------------------------------------------------------
// Subrotina UnoCelSetor
// Unica posicao para o numero no setor
function [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=UnoCelSetor(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch,press_ari)
     for k=1:9
         for n=1:9
             cont=0;
             for i=Ls(k,1):Ls(k,3)
                 for j=Cs(k,1):Cs(k,3)
                     if A(i,j)==0 then //celula vazia
                         for m=1:Qual(i,j,10)
                             if Qual(i,j,m)==n then cont=cont+1;
                             end
                         end
                     end //if
                 end //for j
             end //for i
             if cont==1 then //sucesso
                 for i=Ls(k,1):Ls(k,3)
                     for j=Cs(k,1):Cs(k,3)
                         if A(i,j)==0 then
                             for m=1:Qual(i,j,10)
                                 if Qual(i,j,m)==n then
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=..
Post(n,i,j,Ls,Cs,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch),
if ~press_ari then
    GraphPress(i,j,6,p,strng,xch,ych,t_sleep,n_sleep,PressCode,A)
end
                                 end
                             end
                         end
                     end //for j
                 end //for i
             end //if
         end //for n
     end //for k
endfunction
// -----------------------------------------------------------------------------
// *** Inicio ***
//
// *** Preliminares ***
[Ls,Cs,p,xch,ych,strng]=Preliminares();
//
// *** Leitura do problema inicial ***
PressCode=1;
Nprch=0;
for i=1:9,for j=1:9
            if AA(i,j)<>0 then
                Nprch=Nprch+1;Hist(Nprch,1)=AA(i,j);Hist(Nprch,2)=i;Hist(Nprch,3)=j;
            end //if
    end,end
loop=0;
f_sucess=%f;
press_ari=%f; // liberado o "post" dos numeros no quadro
//
maxloop=4;
while loop<=maxloop & ~f_sucess
    //
if loop>0 & loop<=maxloop then
    if ~flag2 then Nprch=Nprlin+2;
    else Nprch=Nprlin+3;
    end //if ~flag2
    //
    select loop
    case 1
        if ~flag2 then
            Hist(Nprlin+1,1)=Ari(1,1); Hist(Nprlin+1,2)=Ari(1,2); Hist(Nprlin+1,3)=Ari(1,3);
            Hist(Nprlin+2,1)=Ari(3,1); Hist(Nprlin+2,2)=Ari(3,2); Hist(Nprlin+2,3)=Ari(3,3);
        else
            Hist(Nprlin+1,1)=Ari(1,1); Hist(Nprlin+1,2)=Ari(1,2); Hist(Nprlin+1,3)=Ari(1,3);
            Hist(Nprlin+2,1)=Ari(3,1); Hist(Nprlin+2,2)=Ari(3,2); Hist(Nprlin+2,3)=Ari(3,3);
            Hist(Nprlin+3,1)=Ari(5,1); Hist(Nprlin+3,2)=Ari(5,2); Hist(Nprlin+3,3)=Ari(5,3);
        end
            case 2
        if ~flag2 then
            Hist(Nprlin+1,1)=Ari(1,1); Hist(Nprlin+1,2)=Ari(1,2); Hist(Nprlin+1,3)=Ari(1,3);
            Hist(Nprlin+2,1)=Ari(4,1); Hist(Nprlin+2,2)=Ari(4,2); Hist(Nprlin+2,3)=Ari(4,3);
        else
            Hist(Nprlin+1,1)=Ari(1,1); Hist(Nprlin+1,2)=Ari(1,2); Hist(Nprlin+1,3)=Ari(1,3);
            Hist(Nprlin+2,1)=Ari(3,1); Hist(Nprlin+2,2)=Ari(3,2); Hist(Nprlin+2,3)=Ari(3,3);
            Hist(Nprlin+3,1)=Ari(6,1); Hist(Nprlin+3,2)=Ari(6,2); Hist(Nprlin+3,3)=Ari(6,3);
        end
            case 3
        if ~flag2 then
            Hist(Nprlin+1,1)=Ari(2,1); Hist(Nprlin+1,2)=Ari(2,2); Hist(Nprlin+1,3)=Ari(2,3);
            Hist(Nprlin+2,1)=Ari(3,1); Hist(Nprlin+2,2)=Ari(3,2); Hist(Nprlin+2,3)=Ari(3,3);
        else
            Hist(Nprlin+1,1)=Ari(1,1); Hist(Nprlin+1,2)=Ari(1,2); Hist(Nprlin+1,3)=Ari(1,3);
            Hist(Nprlin+2,1)=Ari(4,1); Hist(Nprlin+2,2)=Ari(4,2); Hist(Nprlin+2,3)=Ari(4,3);
            Hist(Nprlin+3,1)=Ari(5,1); Hist(Nprlin+3,2)=Ari(5,2); Hist(Nprlin+3,3)=Ari(5,3);
        end
            case 4
        if ~flag2 then
            Hist(Nprlin+1,1)=Ari(2,1); Hist(Nprlin+1,2)=Ari(2,2); Hist(Nprlin+1,3)=Ari(2,3);
            Hist(Nprlin+2,1)=Ari(4,1); Hist(Nprlin+2,2)=Ari(4,2); Hist(Nprlin+2,3)=Ari(4,3);
        else
            Hist(Nprlin+1,1)=Ari(1,1); Hist(Nprlin+1,2)=Ari(1,2); Hist(Nprlin+1,3)=Ari(1,3);
            Hist(Nprlin+2,1)=Ari(4,1); Hist(Nprlin+2,2)=Ari(4,2); Hist(Nprlin+2,3)=Ari(4,3);
            Hist(Nprlin+3,1)=Ari(6,1); Hist(Nprlin+3,2)=Ari(6,2); Hist(Nprlin+3,3)=Ari(6,3);
        end
            case 5
            Hist(Nprlin+1,1)=Ari(2,1); Hist(Nprlin+1,2)=Ari(2,2); Hist(Nprlin+1,3)=Ari(2,3);
            Hist(Nprlin+2,1)=Ari(3,1); Hist(Nprlin+2,2)=Ari(3,2); Hist(Nprlin+2,3)=Ari(3,3);
            Hist(Nprlin+3,1)=Ari(5,1); Hist(Nprlin+3,2)=Ari(5,2); Hist(Nprlin+3,3)=Ari(5,3);
            case 6
            Hist(Nprlin+1,1)=Ari(2,1); Hist(Nprlin+1,2)=Ari(2,2); Hist(Nprlin+1,3)=Ari(2,3);
            Hist(Nprlin+2,1)=Ari(3,1); Hist(Nprlin+2,2)=Ari(3,2); Hist(Nprlin+2,3)=Ari(3,3);
            Hist(Nprlin+3,1)=Ari(6,1); Hist(Nprlin+3,2)=Ari(6,2); Hist(Nprlin+3,3)=Ari(6,3);
            case 7
            Hist(Nprlin+1,1)=Ari(2,1); Hist(Nprlin+1,2)=Ari(2,2); Hist(Nprlin+1,3)=Ari(2,3);
            Hist(Nprlin+2,1)=Ari(4,1); Hist(Nprlin+2,2)=Ari(4,2); Hist(Nprlin+2,3)=Ari(4,3);
            Hist(Nprlin+3,1)=Ari(5,1); Hist(Nprlin+3,2)=Ari(5,2); Hist(Nprlin+3,3)=Ari(5,3);
            case 8
            Hist(Nprlin+1,1)=Ari(2,1); Hist(Nprlin+1,2)=Ari(2,2); Hist(Nprlin+1,3)=Ari(2,3);
            Hist(Nprlin+2,1)=Ari(4,1); Hist(Nprlin+2,2)=Ari(4,2); Hist(Nprlin+2,3)=Ari(4,3);
            Hist(Nprlin+3,1)=Ari(6,1); Hist(Nprlin+3,2)=Ari(6,2); Hist(Nprlin+3,3)=Ari(6,3);
    end //select loop
end //if loop>0 &loop<=maxloop
//
// *** Colocacao do problema ***
//
    A=zeros(9,9);
    [Fa#,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,Qual]=MarcoZero();
    [Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=..
    Problema(Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch,Ls,Cs)
// se loop inicial, impressao do problema
    if loop==0 then
          p.font_foreground=color("blue");
          p.font_size=4;
          for i=1:9,for j=1:9
                if A(i,j)<>0 then 
                    xstring(xch(j),ych(i),string(A(i,j)));
                end
          end,end
          disp(Nprch,"N_preenchidos=");
          xfrect(1,-19.1,18.1,1);
          p.font_foreground=color("white");
          xstring(1.2,-20.1,"Verificacao: # resume #  ou  # abort #");
          pause;
          p.font_foreground=color("black");
          xstring(1.2,-20.1,"Verificacao: # resume #  ou  # abort #");
    end //if loop==0
    //
    FirstFlagDificil=%t;
    flag_dificil=%t;
    while flag_dificil
        n_dificil=Nprch;
        flag_facil=%t;
        //
        while flag_facil
            n_facil=Nprch;
            // 3.1. Post: unico numero candidato
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=UnoCand(Ls,Cs,p,strng,xch,..
ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch,press_ari)
            // 3.2. "Macro-linha"
//[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=MacroLinha(Ls,Cs,p,strng,xch,..
//ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch,press_ari)
            // 3.3. "Macro-coluna"
//[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=MacroColuna(Ls,Cs,p,strng,xch,..
//ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch,press_ari)
            // 3.4. Unica posicao para o numero, considerando...
            //3.4.1. Unica posicao considerando a linha
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=UnoCelLinha(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch,press_ari)
            //3.4.2. Unica posicao considerando a coluna
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=UnoCelColuna(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch,press_ari)
            //3.4.3. Unica posicao considerando o setor
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=UnoCelSetor(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch,press_ari)
//
            if n_facil==Nprch then flag_facil=%f;end
        end //while flag_facil
        //
        if Nprch<>81 then
            if FirstFlagDificil then FirstFlagDificil=%f;
            end 
            //
    // 4. Metodos para redução dos numeros candidatos das celulas
    // 4.1. Um numero, repetido apenas 2x em um setor, em posicoes alinhadas...
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=InLine(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch)
    // 4.2. Reducao de candidatos por "par oculto"
    // 4.2.1. "Par oculto" na linha
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=Parolin(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch)
    // 4.2.2. "Par oculto" na coluna
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=Paroco(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch)   
    // 4.2.3. "Par oculto" no setor
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=Parose(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch)
    // 4.3. Reducao do numero de candidatos pelo criterio do "par explicito"
    // 4.3.1. Par explicito na linha
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=Parexlin(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch)
    // 4.3.2. Par explicito na coluna
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=Parexco(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch)
    // 4.3.3. Par explicito no setor
[Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch]=Parexse(Ls,Cs,p,strng,..
xch,ych,t_sleep,n_sleep,PressCode,Fa#,Qual,Fa_f,Fa_c,Fa_s,Exi#f,Exi#c,Exi#s,A,Hist,Nprch)
        //
    end //if Nprch<>81
    if n_dificil==Nprch then flag_dificil=%f;end
end //while flag_dificil
//
if Nprch==81 then
    f_sucess=%t;
    press_ari=%f; // liberado o "post" dos numeros no quadro
else
    if loop==0 then
        //selecao de Ariane
        Nprlin=Nprch;maior=0;
        press_ari=%t; // suspenso o "post" dos numeros no quadro
        //selecao do melhor par
        for i=1:9
            for j=1:9
                if A(i,j)==0 & Qual(i,j,10)==2 then
                    aux=Fa#(Qual(i,j,1))+Fa#(Qual(i,j,2));
                    if aux>maior then
                        maior=aux;Ari(1,2)=i;Ari(1,3)=j;
                    end //if aux>maior
                end //if A(i,j)==0
            end //for j
        end //for i
        Ari(1,1)=Qual(Ari(1,2),Ari(1,3),1);Ari(2,1)=Qual(Ari(1,2),Ari(1,3),2);
        Ari(2,2)=Ari(1,2);Ari(2,3)=Ari(1,3);
        //
flag1=%f; //selecao do segundo par
for i=1:9
    for j=1:9
        baux= A(i,j)==0 & Qual(i,j,10)==2 & Qual(i,j,1)<>Ari(1,1) & Qual(i,j,1)<>Ari(2,1) & Qual(i,j,2)<>Ari(1,1) & Qual(i,j,2)<>Ari(2,1);
        if baux & ~flag1 then
            flag1=%t;
            maxloop=4;
            Ari(3,1)=Qual(i,j,1); Ari(3,2)=i; Ari(3,3)=j;
            Ari(4,1)=Qual(i,j,2); Ari(4,2)=i; Ari(4,3)=j;
        end // if baux & ~flag1
    end //for j
end //for i
flag2=%f; //selecao do terceiro par
for i=1:9
    for j=1:9
        baux= A(i,j)==0 & Qual(i,j,10)==2 &..
        Qual(i,j,1)<>Ari(1,1) & Qual(i,j,1)<>Ari(2,1) & Qual(i,j,1)<>Ari(3,1) & Qual(i,j,1)<>Ari(4,1) &..
        Qual(i,j,2)<>Ari(1,1) & Qual(i,j,2)<>Ari(2,1) & Qual(i,j,2)<>Ari(3,1) & Qual(i,j,2)<>Ari(4,1);
        if baux & ~flag2 then
            flag2=%t;
            maxloop=8;
            Ari(5,1)=Qual(i,j,1); Ari(5,2)=i; Ari(5,3)=j;
            Ari(6,1)=Qual(i,j,2); Ari(6,2)=i; Ari(6,3)=j;
        end
    end //for j
end //for i
        disp("Processo: corda de Ariane");
        disp(Nprlin,"Nprlin =");
        disp(maxloop,"maxloop =");
        disp(Ari,"Ari =");  
    end //if loop==0
end //if Nprch==81
disp(loop,"loop =");
loop=loop+1;
//    
end //while loop<=maxloop & ~f_sucess
disp(Nprch,"N_preenchidos =");
if f_sucess then
    disp("sucesso")
    for aux=Nprlin+1:81
        GraphPress(Hist(aux,2),Hist(aux,3),7,p,,xch,ych,t_sleep,n_sleep,PressCode,A)
    end
end

//
