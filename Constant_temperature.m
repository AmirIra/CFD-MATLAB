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
Te = 400 ; 
To = 800 ; 
n_max = 1000 ; 
T = zeros(m+1 , n_max) ; 
T(: , 1) = To ;
T(1 , :) = Tw ; 
T(m+1 , :) = Te ;
Q_transfer_w = zeros(1 , n_max) ; %Output flux from the left side of the rod
Q_transfer_e = zeros(1 , n_max) ; %The outlet flux is furnished from the right side
for n=1 : n_max
    for i=2 : m
        T(i , n+1) = beta*(T(i+1 , n)-2*T(i , n)+T(i-1 , n))+T(i , n) ;
    end
     Q_transfer_w(1,n) = abs(-k*(T(2,n)-Tw)/dx) ; 
     Q_transfer_e(1,n) = -abs(-k*(T(m,n)-Te)/dx) ; 
end 

for n=1 :10: n_max 
    hold on ;
    plot(T(: , n)) ; 
    title('Temperature changes over time');
end
figure ;
hold on ;
plot(Q_transfer_e) ;
plot(Q_transfer_w) ;
title('heat flux') ;
