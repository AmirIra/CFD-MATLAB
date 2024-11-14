clc
clear
l = 2 ;
m = 80 ;
dx = l/m ; 
alpha = 11.234*power(10,-5) ; %pure_copper
k = 386 ; %pure_copper
dt = 0.6 ; 
beta = (alpha*dt)/(power(dx,2)) ; 
Tw = 400 ;  
To = 800 ; 
n_max = 10000 ; 
T = zeros(m+1 , n_max) ; 
T(: , 1) = To ;
T(1 , :) = Tw ; 
Q_transfer = zeros(1 , n_max) ; 
for n=1 : n_max
    for i=2 : m-1
        T(i , n+1) = beta*(T(i+1 , n)-2*T(i , n)+T(i-1 , n))+T(i , n) ;
    end
     T(m , n+1) = beta*(T(m+1 , n)-2*T(m , n)+T(m-1 , n))+T(m , n) ;
     T(m+1 , n+1) = T(m , n+1) ;
     Q_transfer(1,n) = k*(T(2,n) - T(1,n))/dx ; 
end

for n=1 :100: n_max 
    hold on ;
    plot(T(: , n)) ; 
    title('Temperature changes over time');
end

figure ;
hold on ;
plot(Q_transfer) ;
title('Heat flux output from the end of the rod');