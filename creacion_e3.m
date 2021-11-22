function [short_number, shortest_paths, numero_de_pedidos] = creacion_e3(periodos)
    horas_totales = 8;
    totales_pedidos = [];
    if periodos >=2 && periodos < 8
        numero_de_pedidos = [];
        short_number = [];
        shortest_paths = [];
        for j = 1:periodos
            z = (j-1)*(10/periodos); %contador para fracciones
            l_lim = ((-1/5)*((z-5)^2)) + 10;
            u_lim = ((-2/5)*((z-5)^2)) + 17; 
            l_lim = round(l_lim);
            u_lim = round(u_lim);
            num_pedidos = randi([l_lim u_lim] , 1, 1);
            numero_de_pedidos = [numero_de_pedidos; num_pedidos];
            if j == 1
                y = 1;
            else
                x = horas_totales + ((j-1)*horas_totales/periodos);
                y = ((-1/6.3)*((x-13)^2)) + 5;
                y = round(y);
            end
            [pesos_min, inicio_fin] = pedir(num_pedidos);
            short_number = [short_number; y*pesos_min];
            shortest_paths = [shortest_paths; inicio_fin];
            
        end
    else
        disp(["Muy pocos periodos para optimizar."]);
    end
end
function [short_number, shortest_paths] = pedir(pedidos_recibidos)
    %restaurantes = {'A', 'B', 'C', 'D', 'E', 'F', 'G'}
    restaurantes = [1 2 3 4 5 6 7];
    %destinos = {'H', 'I', 'J', 'K', 'L', 'M', 'N'}
    destinos = [8 9 10 11 12 13 14];

    names={'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' '1' '2' '3' '4' '5' '6' '7' '8' '9'}; % "1" es igual a "P1", pero fallaba con el array porque tiene 2 caracteres.
    numbers =  [1:23];
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
    %T = plot(Gr);
    %view(2);
    %% Creación de los pedidos
    ped_rest = [];
    ped_dest = [];
    size_r = size(restaurantes);
    size_r = size_r(2);
    size_d = size(destinos);
    size_d = size_d(2);
    for i = 1 :pedidos_recibidos
        rest = randi([1 size_r],1,1);
        dest = randi([1 size_d],1,1);
        rest = restaurantes(rest);
        dest = destinos(dest);
        ped_rest = [ped_rest; rest];
        ped_dest = [ped_dest; dest];

    end
    shortest_paths = [];
    s_pr = size(ped_rest);
    s_pd = size(ped_dest);
    if s_pr(1) == s_pd(1)
        for j = 1:s_pr(1)
            [~, d] = shortestpath(Gr, ped_rest(j), ped_dest(j));
            shortest_paths = [shortest_paths; d];
        end
    end
    short_number = shortest_paths;
    shortest_paths = [ped_rest ped_dest];
end

