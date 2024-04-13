clc
close all
clear all
SNR=20;
fc=8000;
Pn=5;
[y,t,w,Tobs]=Senialyruido(SNR,fc,Pn);

 figure
 plot(f, abs(Yf)); title("Respuesta en magnitud de la salida");
 xlabel("frecuencia"); ylabel("Magnitud");
% 
% figure
% plot(f,angle(Yf)); title("Respuesta en fase de la salida");
% xlabel("frecuencia"); ylabel("Fase");
% 
% %t0=t(randi(size(t)));
% t0=0;
% autocorrelacion(X,t,t0);
