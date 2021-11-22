close all
clc;
clear;
% s = [1 2 3 4 4 5 6 7 7 8 9 10 11 12 12 13 14 15 15 16 16 17 17 18 18 18 19 20 20 21 22 22 23 23];
% t = [14 10 4 9 20 19 12 12 16 15 8 21 22 11 22 23 13 13 1 15 17 18 9 17 19 22 4 2 21 3 5 18 6 7] ;
% w = [2 7 1 9 3 5 5 7 2 6 2 6 7 7 6 2 4 10 5 4 9 5 2 5 5 2 8 2 3 1 3 2 1 4] ;

% 
% names={'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'P1' 'P2' 'P3' 'P4' 'P5' 'P6' 'P7' 'P8' 'P9'};
% Gr = digraph(s, t, w , names);
s = [1 2 3 4 4 5 6 7 8 9 10 11 12 12 13 14 15 15 16 16 16 17 17 17 18 18 18 19 19 20 20 21 22 23 23];
t = [14 10 4 20 9 19 12 16 15 8 21 22 22 11 23 13 16 1 15 7 17 9 18 16 17 19 22 18 4 2 21 3 5 7 6] ;
w = [2 7 1 3 9 5 5 2 6 2 6 7 6 7 2 4 4 4 2 2 9 2 5 9 5 5 2 5 8 2 3 1 3 4 1] ;
size(w)
names={'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'P1' 'P2' 'P3' 'P4' 'P5' 'P6' 'P7' 'P8' 'P9'}
Gr = digraph(s, t, w , names);
vars=['a' 'b'];
syms X [1 34]  ;

punto_in = 7;


destinos = [];
costos = [];
f_o = [];
for z= [1:23]
    punto_in = z;
   
    for x = [1:length(s)]
        if s(x) == punto_in
            destinos = [destinos t(x)];
             y= w(x)*X(1,x);
             costos = [costos w(x)];
             f_o= [f_o y];
            
        end   
            
    end 
end
foo=sum(f_o(1:length(f_o)-1));
syms Z [1 22] 
fo_2 = [];
costos_tem = [costos];
costos=[];
for r=[1:22]
      zoo= foo*Z(1,r);
      
      costos = [costos costos_tem];
      
      fo_2 = [fo_2 zoo];
      
end

sum(fo_2);
costos;
length(costos);
length(w);

punto_in = [1 5 3 2 7 3 4 3 5 7 7 2 6 5 4 1 1 5 1 6 7];
punto_fin = [12 8 12 11 9 9 11 10 14 11 8 12 9 12 8 14 13 8 11 12 9];
shorter_paths= [];
[P,d] = shortestpath(Gr,1,12);
pedidos=[1 0 1 0 1 0 1 0 1 0 0 0 0 1];
for x = [1:length(punto_in)]
       [P,d] = shortestpath(Gr,punto_in(x),punto_fin(x));
       shorter_paths=[shorter_paths d]  ;
end
shorter_paths