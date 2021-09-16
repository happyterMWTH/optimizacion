%-----------------------------SIMPLEX-----------------------------------
%------ Ana Garzón, Gabriela Linares, Juan Manuel Dávila ---------------

%--- Entradas en formato estándar ---


A = [1 1 4 2; 2 46 0 -2]; % matriz de coeficientes
cT = [10 1 0 0]; % vector de costos
b = [2; 12]; %vector lado derecho de b
verbose = 1; %modo verbose
min = 1; %minimizar el problema

% Verificar que las dimensiones coincidan con el formato estándar
% #columnas de A == #columnas de c
% #filas de A == #filas de b
[f, c] = verificar(A, b, transpose(cT)); % **Añadir caso rango de la matriz
cT = min_max(cT, min)
%---- FASE 1 ----
if verbose
    disp(['*****INICIA FASE 1********']);  
end

% Añadir variables artificiales (matriz identidad al final de A)
[m,n] = size(A); % m número de filas de A, n número de columnas de A
I = eye(m); % Matriz identidad de tamaño mxm
[I_m, I_n] = size(I);
A_1 = [A I]; % Concatenar A y la matriz identidad
% Tomar como base columnas de la matriz identidad

[m_1,n_1] = size (A_1);
Ib = n+1:n_1; % Índices básicos de inicialización
In = 1:n; % Índices no básicos de inicialización

% Definir x_a
c_inicial = [zeros(1,n) ones(1,I_n)]; % Nueva función objetivo para la fase 1
%c_estandar = []

%minimizar x_a

%---- CORRER FUNCIONES ---

%[x,y] = simplex(A_1, b, c_1, Ib, In)

[Ib, In, x_bar, opt_fint] = iteracion_simplex(A_1, b, c_inicial, Ib, In, verbose); % Aplicaar simplex 
        
%---- FASE 2 ----

In_simple = cambiarIn(In, A); %Se quitan las variable artificiales del In
Ib
[o,p] = size(A)
sl_opt = 1;

for i = Ib
    if i > p
        if verbose
            disp(['El problema no tiene solución'])
        end
        sl_opt = 0;
    end
end

if sl_opt == 1
    disp(['***** INICIA FASE 2 ****'])
    [Ib, In, x_bar, opt_fint] = iteracion_simplex(A, b, cT, Ib, In_simple, verbose); % Aplicaar simplex
end


%---- FUNCIONES ----

% Función de que cumpla con las especificaciones del formato estándar

function [fcorrect, ccorrect]= verificar(A, b, c);
% Verificar que las dimensiones coincidan con el formato estándar

[fA, cA] = size(A);
[fB, ~] = size(b);
[~, cC] = size(c);

% Se verifican las filas de A y b
if isequal(fA, fB)
    fcorrect = 1;
  
else
    fcorrect = 0;
end

if isequal(cA, cC)
    ccorrect = 1;
else
    ccorrect = 0;
end
end
    
function [Ib, In, x_bar, opt_fint] = iteracion_simplex(A, b, cT, Ib, In, verbose)

    [m,n] = size(A);
    opt_fint = 1;
    
    B = A(:, Ib); % Columnas básicas inciales de A
    N = A(:, In); % Columnas no básicas iniciales de A
    X_B = inv(B)*b;
    
    % 1) Xb
   
    x_bar = [zeros(1, n)];
    x_bar(Ib) = X_B; 
    
%     for i = 1:1:n % Ciclo que genera x_bar ---TENER EN CUENTA ORDEN---
%         if i == Ib(1,1)
%             x_bar = [x_bar X_B(1,1)]; 
%         elseif i == Ib(1,2)
%             x_bar = [x_bar X_B(2,1)]; 
%         else
%             x_bar = [x_bar 0];
%         end
%     end
%     
    % 2) COSTOS REDUCIDOS
    
    z_0 = cT.*x_bar;
    cj = cT(In);
    zj = cT(Ib)*inv(B)*N;
    cj_bar = cj - zj; % Vector de costos reducidos
        
    cj_min = min(cj_bar); %Vector con valores mínimos de cj_bar -> elemento que entra
        
    if cj_min < 0
        eb = min(find(cj_min==cj_bar)); % Indice que entra a la base REGLA DE BLAND
        entra_base = In(eb);   
    elseif cj_min >= 0
        if min(x_bar) < 0
            disp(['El problema no tiene solución óptima finita']);
            return;
        end
        disp(['Solución básica factible óptima encontrada!! ']);
        opt_fint = 1;
        Ib;
        In;
        x_bar
        return;
    end    
    
    % Determinar si, al entrar a la base, el problema no tiene óptimo finito
    
    y_k = inv(B)*A(:,entra_base);
    
    y_postv_indx = find(y_k > 0);  % Elementos en Y que sean mayores a 0
    
    %Si no hay optimo finito
    
    if(isempty(y_postv_indx))
        opt_fint = 0;
        if verbose
            disp(['El problema no tiene solución óptima finita']);
        end
        return;
        %Ib, In, x_bar,0
    end
    
    % Si tiene óptimo finito
    
    x_k = x_bar(Ib)./y_k(y_postv_indx)';
    
    x_k_min = min(x_k); % Epsilon o paso
    
    if min(x_k_min) < 0
        indx_xk_min = find(x_k == x_k_min);
    end
    
    
    y_completa = [zeros(1, max(Ib))];
    y_completa(Ib) = y_k ;
    
    sale_base = min(find(y_completa == max(y_k))); % REGLA DE LA BLAND
    
    %[sale_base,j]=min(In(indx_cj_min)); % Indice que sale de la base, REGLA DE BLAND
       
    % Intercambio de indices
        
    newcharIb = min(find(Ib == sale_base))
    Ib(1,[newcharIb]) = entra_base
    
    newcharIn = min(find(In == entra_base))
    In(1,[newcharIn]) = sale_base
    
    if verbose
        disp(['==============================================']);
        disp(['*** INICIO DE ITERACIÓN ***']);
        disp(['==============================================']);
        disp(['Índices básicos: [' num2str(Ib) '] ']);
        disp(['Índices no básicos: [' num2str(In) '] ']);
        disp(['C: [' num2str(cT) '] ']);
        disp(['==============================================']);
        disp('PASOS: ');
        disp(['1) Xb = [' num2str(x_bar) ']']);
        disp(' ');
        disp(['2) Costos reducidos = [' num2str(cj_bar) ']']);
        disp(' ');
        disp(['3) Indice que entra a la base = [' num2str(entra_base) ']']);
        disp(' ');
        disp(['4) Y_i = [' num2str(y_k') ']']);
        disp(' ');
        disp(['5) Indice que sale de la base = [' num2str(sale_base) ']']);
        disp(' ');
        disp(['6) Épsilon o paso:  [' num2str(x_k_min) ']  ']);
        disp(['==============================================']);
        disp('*** FIN DE ITERACIÓN ***');
        disp(['==============================================']);
        disp(' ');
    end
    
    [Ib, In, x_bar, opt_fint] = iteracion_simplex(A, b, cT, Ib, In, verbose);
    
end

function [In_simple] = cambiarIn(In, A);
[f, c] = size(A);

In_simple = zeros(1, 0);
In_mid = zeros(1,1);
counter = 0;
for i = In
    counter =counter + 1;
    if i <= c
        In_mid(1, counter) = i;
        
    end
end

for i = In_mid
    if i ~= 0
        In_simple = [In_simple i];
    end
end

end


function [cT] = min_max(cT, min)
    if min == 0
        cT = -cT;
    end
end


