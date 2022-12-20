%kaptchouang_yavan_derick_20U2869
function y = courbe_fonction()
    % etudions la courbe avec les 20 premiers points
    [ x ,y ] = fonction_principale() % calcul des images par f(x)
    coef_lagrange = interpolation_lagrange(x,y) %obtention du polynome avec lagrange
    coef_newton = interpolation_newton(x,y) %obtention du polynome avec newton
    n = length(x)
    eval_lagrange = []
    eval_newton = []
    for i=1:n
        eval_lagrange(i) = horner_lagrange(x(i) ,coef_lagrange )
        eval_newton(i) = eval_interpol_newton(x(i) , x , coef_newton)
    end
   % plot(x,eval_newton,'linewidth' , 2)
    plot(x,y,'k',x,eval_lagrange ,'r--','linewidth',2)
    xlabel('valeurs de x')
    ylabel('valeurs de y')
    title('interpolation numerique pour 60 points')
    legend('fonction de depart','interpolation par lagrange')
   %legend('interpolation par newton')
    %set(h,'xtick' ,0:0.5:3e26 ,'ytick',1:1:n)
   
end

% fonction a etudier 
function [ abscisse , ordonne] = fonction_principale()
    n = input('entrer le nombre de points  : ')
    i = 1 ;
    abscisse = [] ;
    ordonne  = [] ;
    while (i <= n )
        abscisse(i) = i ;
        ordonne(i)  =  font(i) ;
        i = i+1 ;
    end
    abscisse ;
    ordonne;
       
return
end
function y = font(x)
    y = (-( 5*(x^3) + 9*(x^2) ))^3 + ( ( 5*(x^3) + 9*(x^2) )  )^4 +log(x) ;
return
end

%interpolation_lagrange
function coef_polynome = interpolation_lagrange(x , y)
    n = length(x) - 1 ;
    X = ones(n+1 ,n+1)
    for(i = 1:n+1)
        for(j = 1:n+1)
            X(i , j) = x(i)^(j-1);
        end
    end
  Y = y' ;
  B = X\Y;
  t = 1 ; 
  A = []  ;
  k = 0 ;
  while(t <= length(B))
      A(t) = B(length(B) - k);
      t =t + 1;
      k = k+1;
  end
  coef_polynome = A  
end 

%interpolation_newton
function [coef,D] = interpolation_newton(x, y)
 n = length(x)-1;
 for i=1:n+1
  D(i,1) = y(i);
    for j = 1:i-1
       D(i,j+1) = (D(i,j)-D(i-1,j))/(x(i)-x(i-j));
    end
  end
 d = diag(D);
% on permute les valeurs
 t = 1 ; 
 A = []  ;
 k = 0 ;
  while(t <= length(d))
      A(t) = d(length(d) - k);
      t =t + 1;
      k = k+1;
  end
  coef  = A  ;
end

%evaluation lagrange
function solution = horner_lagrange(a , val)
  n = length(val);
  m = length(a);
  result = val(1)*ones(1,m);
 for j = 2:n
    result = result.*a + val(j);
 end
 solution = result;
end

%evaluation newton
function y = eval_interpol_newton(a , x , coef)  
    n = length(x)-1;
    y = coef(n+1);
   for i= n:-1:1
    y = y.*(a-x(i))+coef(i);
   end;
end
   
    
    
        
    
    