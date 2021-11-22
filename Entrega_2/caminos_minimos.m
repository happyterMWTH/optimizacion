%% Asociación de los nombres de nodos con su número de referencia, así como las aristas
names={'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' '1' '2' '3' '4' '5' '6' '7' '8' '9'}; % "1" es igual a "P1", pero fallaba con el array porque tiene 2 caracteres.
numbers = [1:23];
change = containers.Map(names, numbers);
s1 = ['A' 'B' 'C' 'D' 'D' 'E' 'F' 'G' 'G' 'H' 'I' 'J' 'K' 'L' 'L' 'M' 'N' '1' '1' '1' '2' '2' '2' '3' '3' '3' '4' '4' '4' '5' '5' '6' '6' '7' '8' '9' '9'];
t1 = ['N' 'J' 'D' 'I' '6' '5' 'L' 'L' '2' '1' 'H' '7' '8' 'K' '8' '9' 'M' 'A' 'M' '2' 'G' '1' '3' 'I' '2' '4' '3' '5' '8' '4' 'D' 'B' '7' 'C' 'E' 'F' 'G'];
w = [2 7 1 9 3 5 5 7 2 6 2 6 7 7 6 2 4 5 10 4 2 4 9 2 9 5 5 5 2 5 8 2 3 1 3 1 4];
%% Transformación para el grafo
s = [];
t = [];
ss = size(s1);
st = size(t1);
ss = ss(2);
st = st(2);
if ss == st
    for j = 1:ss
        s_1 = s1(j);
        t_1 = t1(j);
        s = [s change(s_1)];
        t = [t change(t_1)]; % Transforma el nodo de su nombre asignado a su número por referencia.
    end
else
    disp(['Verifique el problema. Diferentes entradas a salidas.'])
end
Gr = digraph(s, t, w , names);
%T = plot(Gr)
%view(2)
%% Se sacan los caminos mínimos de los pedidos
punto_in = [1 5 3 2 7 3 4 3 5 7 7 2 6 5 4 1 1 5 1 6 7];
punto_fin = [12 8 12 11 9 9 11 10 14 11 8 12 9 12 8 14 13 8 11 12 9];
paths_w = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u'}; % Crea un nombre de un diccionario de cada camino mínimo para su fácil acceso.
paths_f_l = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u'}; % Crea un nombre para el punto de inicio y fin de cada camino mínimo.
paths = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u'}; % Crea un nombre para cada

% En este código lo que se hace es tener tres diccionarios con las mismas
% entradas con el fin de que:
% 'paths_w' posea el peso del camino mínimo asignado (en orden de las
% listas 'punto_in' y 'punto_fin'.
% 'paths_f_l' tendrá en cada entrada (misma de 'paths_w') el nodo de inicio
% y de fin, para acceso rápido.
% 'paths' poseerá todas las aristas de dicho camino.

s_in = size(punto_in);
s_fin = size(punto_fin);
size(paths_w);
p_w = [];
p_f_l = [];
paths_node = [];
if s_in(2) == s_fin(2) & s_in == size(paths_w)
    for j = 1:s_in(2)
        [P, d] = shortestpath(Gr, punto_in(j), punto_fin(j));
        text = '';
        s_p = size(P);
        for j = 1:s_p(2)
            nom = num2str(P(j));
            if size(text) == 0
                text = nom;
            else
                text = strcat(text, "->", nom);
            end
        end
        paths_node = [paths_node text];
        p_w = [p_w d];
        f_l = [P(1) P(end)];
        p_f_l = [p_f_l; f_l];
        
    end 
    dict_paths = containers.Map(paths_node, p_w);
    p_f_l = num2cell(p_f_l, 2);
    path_dict = containers.Map(paths_w, p_w); % Asigna a cada peso de cada camino mínimo un nombre de 'paths_w'. Funcionará casi como una matriz de costos.
    f_l_dict = containers.Map(paths_f_l, p_f_l); % Asigna a cada tupla de inicio-final un nombre de 'paths_f_l'.
    p_w % Este es el vector de costos que se leerá en simplex
else
    disp(['Verifique el problema. Diferentes pedidos a destinos.'])
end
