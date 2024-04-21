function [y,t]=sentriangular(A,T,Np)
%[y,t]=sentriangular(A,T,Np)
%
%A: Amplitud máxima de la señal
%T: Duración de la señal
%Np: Número de puntos en el vector de señal
%
%y: vector de señal triangular
%t: vector de tiempo de la señal; t pertenece a [0,t)
Ts=T/Np;
t=0:Ts:T-Ts;
ly=length(t); ly2=fix(ly/2);
y=zeros(size(t));
t1=t(1:fix(ly/2)); t2=t(fix(ly/2)+1:ly);
y(1:ly2)=(2*A/T)*t1;
y(ly2+1:ly)=-(2*A/T)*t2+2*A/T;
fig1=figure
plot(t,y);
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal Triangular');

grid on;
