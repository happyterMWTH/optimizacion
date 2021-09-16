% -- Ajuste Cuadrático --
close all
clc;
clear;

% Paso 0

len_final = 0.2; % Longitud final del intervalo I
x1 = 0;
x2 = 1;
x3 = 4;
Int = [x1 x2 x3]; % Intervalo inicial
k = 0; % Contador de iteraciones
syms x;
func(x) = (x^2)/10 - 2*sin(x);% Función
fplot(func,[-5 5]);
title('Método de Ajuste Cuadrático')
hold on;

% Estimación de x_bar

b_23= (x2)^2 - (x3)^2;
b_31= (x3)^2 - (x1)^2;
b_12= (x1)^2 - (x2)^2;
a_23= x2 - x3;
a_31= x3 - x1;
a_12= x1 - x2;
fx1 = double(func(x1));
fx2 = double(func(x2));
fx3 = double(func(x3));


xbar_k = double((b_23*fx1+b_31*fx2+b_12*fx3)/(2*(a_23*fx1+a_31*fx2+a_12*fx3)));
f_xbar_k = double(func(xbar_k));
disp('RESULTADOS MÉTODO AJUSTE CUADRÁTICO');
disp('It.    x_bar       x1          x3');
mat = [];

for a = 1:1:100
    % Paso 1
    if x3 - x1 < len_final
        xbar_k = double(xbar_k);
        x1 = double(x1);
        x3 = double(x3);
        k;
        break;
    else
        if xbar_k > x2
            %Paso 2
            if f_xbar_k > fx2
                Int = [x1 x2 xbar_k];
            else 
                Int = [x2 xbar_k x3];
            end
            x1 = Int(1,1);
            x2 = Int(1,2);
            x3 = Int(1,3);
            
            b_23= (x2)^2 - (x3)^2;
            b_31= (x3)^2 - (x1)^2;
            b_12= (x1)^2 - (x2)^2;
            a_23= x2 - x3;
            a_31= x3 - x1;
            a_12= x1 - x2;
            fx1 = double(func(x1));
            fx2 = double(func(x2));
            fx3 = double(func(x3));


            xbar_k = double((b_23*fx1+b_31*fx2+b_12*fx3)/(2*(a_23*fx1+a_31*fx2+a_12*fx3)));
        

        elseif xbar_k < x2
            %Paso 3
            if f_xbar_k > fx2
                Int = [xbar_k x2 x3];
            else 
                Int = [x1 xbar_k x2];
            end
            x1 = Int(1,1);
            x2 = Int(1,2);
            x3 = Int(1,3);
            
            b_23= (x2)^2 - (x3)^2;
            b_31= (x3)^2 - (x1)^2;
            b_12= (x1)^2 - (x2)^2;
            a_23= x2 - x3;
            a_31= x3 - x1;
            a_12= x1 - x2;
            fx1 = double(func(x1));
            fx2 = double(func(x2));
            fx3 = double(func(x3));


            xbar_k = double((b_23*fx1+b_31*fx2+b_12*fx3)/(2*(a_23*fx1+a_31*fx2+a_12*fx3)));
        
            
        elseif xbar_k == x2
            %Paso 4
            if abs(x2 - x1) < abs(x3 - x2)
                xbar_k = x2 + len_final/2;
            elseif abs(x2 - x1) > abs(x3 - x2)
                xbar_k = x2 - len_final/2;
            end
        else
            disp('error');
            break
        end
    end
    k = k + 1;
    f_xbar_k = double(func(xbar_k));
    fx2 = double(func(x2));
    mat = [ mat; k double(xbar_k) double(x1) double(x3) ];
end

scatter(xbar_k,func(xbar_k),'ro');
vec_final = [double(xbar_k) double(func(xbar_k))];
legend('f(x)', num2str(vec_final));
disp(num2str(mat));
