clear all

% c = vector de costos
% A = matriz de coeficientes 
% b = lado derecho 
% max o min 

%min = true
%max= false

%verbose=true - quiere ver  las soluciones paso a paso

A = [
     1     1     1     1     1     1     1     1     1     1     1     1     1     1     1     1     1     1     1     1     1     -1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0;
     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0      0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0;
     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0      0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0;
     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0      0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0      0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0      0     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0      0     0     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0      0     0     0     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0      0     0     0     0     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0      0     0     0     0     0     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0      0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0      0     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0     0     0     0     0      0     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0     0     0     0      0     0     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0     0     0      0     0     0     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0     0      0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0      0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0      0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0      0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1     0     0      0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1     0     0;
     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1     0      0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1     0;
     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1      0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1
     ];
b = [13 1  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
c = [14 19 31 52 13 10 37 13 32 14 15 45 31 33 11 2 6 19 21 5 13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

% X =
% 
%          0
%     5.5000
%    22.5000

z = format(true,A,b,c,true);

function [c] = format(minmax,A,b,c,verbose)

if minmax==false 
    c=-1.*c;
    
     if verbose == true
        disp('Vamos a maximizar por medio del metodo simplex')
        disp('Nuevo vector de costos :')
        disp(c)
     end
else
     if verbose == true
        disp('Vamos a minimizar')

    end 
end

b=b' ;

dimA= size(A);
dimb= size(b);
dimc= size(c);

    if ~(dimA(1)==dimb(1) && dimA(2) == dimc(2))
        disp(['La matriz no tiene el formato adecuado, cambie la matriz '])
        error('Dimensiones invalidas')
    end
[A1,B,c1,ca,IB,IN]=fase1(A,b,c,verbose);

X=fase2(A,b,c,IB,IN,verbose)

end

%Fase 1: encontrar solucion basica factible -------------


function [A,B,c,ca,IB,IN]= fase1(A,b,c,verbose)

    if verbose == true
        disp('Inicio metodo simplex') 
        disp('------Fase 1 -------')
        disp('Añadimos variables arificiales')
    end

% Agregar n variables artificiales  
[m,n]=size(A);
I=eye(m);
A=[A I]

dimA= size(A);
dimb= size(b);
dimc= size(c);

r=rank(A);
cas=ones(1,m);
cros=zeros(1,n);
ca=[cros cas];% Nuevo c para fase 1

IB=[dimA(2)-m+1:dimA(2)] ;
IN=[1:dimA(2)-m];

%comienzan las iteraciones fase 1

[A,B,c,cr,IB,IN,X]=simplex(A,b,ca,IB,IN,verbose);

%termina iteracion fase 1
for i=dimA(2)-m+1:dimA(2)

    bb=find(IB==i);
    if isempty(bb) == 0
        cc = find(cr==0);
        if isempty(cc) ==0
            IB(bb(1))=IN(cc(1));
            IN(cc(1))=IB(bb(1));
                if verbose==true
                    disp(' Cambio en la variable artificial')
                end
        end
               if verbose==true
                    disp('No hay solucion optima - No hay variables artificiales que se puedan cambiar') 
                    error('No hay solucion optima')
               end
    end

end
 if verbose==true
    disp('Pasamos a la fase 2') 
 end

end

function[A,B,c,cr,IB,IN,X]=simplex(A,b,c,IB,IN,verbose)
cr=[-1];
while any(cr<0)
    
        if verbose == true
            disp(['Indices variables basicas: (IB)']) 
            disp(IB)
            disp(['Indices variables no basicas: (IN)'])
            disp(IN)
            disp('Costos')
            disp(c)
        end

    B=[];
    N=[];
    cB=[];
    cN=[];

    B=[];
        for i= IB    
            B=[B A(:,i)];
        end

    N=[];
        for i= IN    
            N=[N A(:,i)];
        end

    cB=[];
        for i= IB
            cB=[cB c(i)];
        end

    cN=[];
        for i= IN    
            cN=[cN c(i)];
        end

    [XB,X] = XBs(B,b,IB,verbose) ;
  
    [cr, xc] = crs(cN,cB,B,N,IN,verbose);
    
    if any(cr<0)
       [IB,IN]=yk(A,B,xc,XB,IB,IN,verbose);
    end
 
end
end

function[XB,X]= XBs(B,b,IB,verbose)%solucion basica
    XB=inv(B)*b;
    X = zeros(length(b),1);
    for i=IB
        bb = find(IB==i);
     X(IB(bb(1)))= XB(bb(1)) ;
    end
    if verbose==true
        disp('Solucion basica : ') 
        disp(XB)
        disp('Vector solucion (X): ')
        disp(X)
    end
    
end

% Hallar costos reducidos (encontrar candidata a entrar a la base)
 function[cr,xc]=crs(cN,cB,B,N,IN,verbose)
  cr=cN-cB*inv(B)*N;  
    if verbose==true
        disp('Costos reducidos : ') 
        disp(cr)
    end
       cc = find(cr==min(cr));
       xc=IN(cc(1));
       if min(cr)<0
           
           
           if verbose==true
                disp('No es optima  ') 
                disp(['x',num2str(xc),' es candidata a entrar a la base : '])
           end 
            
       else
           if verbose==true
                disp('Es optima  ') 
           end
           
       end

   end
       

% Criterio de la razon minima (candidato a salir de la base)

function[IB,IN]=yk(A,B,xc,XB,IB,IN,verbose) %k es el indice de la variable candidata a entrar a la base
    yk = [];
    pr=ones(1,length(IB))*inf;
    ak=A(:,xc);
    yk = inv(B)* ak;
    
    if verbose
        disp('yk')
        disp(yk);
    end
    
    if any(max(yk)<=0)
       error('Optimo infinito') 
    end
    for i = 1:length(XB)
        if yk(i)>0
            pr(i)=XB(i)./yk(i);
        end
    end
    
    ss=find(pr==min(pr));
    ss
    if ss==inf
        if verbose
            disp('Solucion optima no finita')
            error('X')
        end
    end   
        
    xs=IB(ss(1));
    
    bb=find(IB==xs);
    IB(bb(1))= xc;
    nn=find(IN==xc);
    IN(nn(1))=xs;
    
end


% ------------------Fase 2 -----------------------------------

function [X]=fase2(A,b,c,IB,IN,verbose)
% Eliminar variables artificiales 

dimA=size(A);

IN = setdiff(IN,IN(IN>dimA(2)));

% Metodo simplex

[A,B,c,cr,IB,IN,X] = simplex(A,b,c,IB,IN,verbose);



if isempty(find(cr==0)) == 0
    if verbose
        disp('Multiples soluciones')
    end
else
        if verbose
        disp('Optimo finito')
    end
end

end


