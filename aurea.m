close all
clc;
clear;

%-------- Ejercicio 1 ----------

a = -3
b = 2
syms x;
funcion_ob = x^2 + 2*x + 1;

fplot(funcion_ob,[-5 5]);
hold on


sec_aurea(a, b , funcion_ob);
%% 

%---------- Ejercicio 2 ------------

a2 = -3
b2 = 3
syms x;
funcion_ob2 = (x^2)/2 + sin(x);

fplot(funcion_ob2,[-5 5]);
hold on

sec_aurea(a2, b2 , funcion_ob2);
%----------------------------------
%% 

function[] = sec_aurea(a, b, funcion) % Función Sección Aurea

    %incio de todo - definicion de variables

    Len_i = 10^-3;
    alpha = 0.618;
    
    Lamda = a + (1 - alpha) * (b - a)
    Miu = a + alpha * (b - a)
    
    syms x;
    fun_obj(x) = funcion;
    
    k = 0;
    
    %paso1
    matriz_act = []
    matriz = []
    %evaluada en lamda
    f_l = double(fun_obj(Lamda))
    %evaluada en Miu
    f_m = double(fun_obj(Miu))
    
    while abs(b - a) > Len_i
        
      k = k + 1;
      
      %paso 2
      if f_l > f_m
           
           a = Lamda;
           Lamda = Miu;
           f_l = f_m;
           Miu = a + alpha * (b - a);
           f_m = double(fun_obj(Miu));
           
           
       %paso 3
       elseif f_l < f_m
           
           b = Miu;
           Miu = Lamda;
           f_m = f_l;
           Lamda = a + (1 - alpha) * (b - a);
           f_l = double(fun_obj(Lamda));
           
    
      end
       
      scatter(a,fun_obj(a),'ro');
      scatter(b,fun_obj(b),'bo');
      scatter(Lamda,fun_obj(Lamda),'go');
      scatter(Miu,fun_obj(Miu),'ko');
      drawnow
      
      
      matriz_act = [k a b Miu Lamda];
      matriz = [matriz ; matriz_act];
              
    end
    matriz
    xlswrite('matriz_aurea_2.xlsx', matriz)
end