% -- Método de Newton --
close all
clc;
clear;

% Paso 0

xk = 2.5; %Punto inicial
k = 0; % Contador de iteraciones
err = 0.00001; %error
syms x;
func(x) = (x^2)/10 - 2*sin(x);% Función
figure
fplot(func,[-5 5]);
title('Método de Newton')
hold on;
mat = [];

while 1
    dx_1(x) = diff(func,x); %Primera derivada
    dx_2(x) = diff(dx_1,x); %Segunda derivada
    dev1_evalxk = double(dx_1(xk)); %Primera derivada evaluada en xk
    dev2_evalxk = double(dx_2(xk)); %Segunda derivada evaluada en xk
    x_k1 = xk - dev1_evalxk/dev2_evalxk; %x_(k + 1);
    if abs(x_k1 - xk) < err
        k;
        xk = double(xk);
        x_k1 = double(x_k1);
        break
    end
    xk = x_k1;
    k = k + 1;
    mat = [mat; k xk x_k1 ];
end

scatter(xk,func(xk),'ro');
scatter(x_k1, func(x_k1),'bo');
vec_final1 = [double(xk) double(func(xk))];
vec_final2 = [double(x_k1) double(func(x_k1))];
legend('f(x)', num2str(vec_final1), num2str(vec_final2));
disp('RESULTADOS MÉTODO DE NEWTON');
disp('It.      xk        x_k+1');
disp(num2str(mat));