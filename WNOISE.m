function [w,t]=WNOISE(Pn,Tobs,Ts)
% [w,t]=WNOISE(Pn,Tobs,Ts)
% Obtiene un vector de ruido blanco y gaussiano de potencia y extensión definidas
% Variables de Entrada
% Pn: Potencia (varianza) del ruido
% Tobs: Define la extensión del tamaño de la ventana de observación de la señal
% Ts: Intervalo de tiempo entre dos muestras consecutivas
%
% Variables de Salida
% w: vector que contiene la evolución de la señal de ruido respecto del tiempo.
% t: vector que registra la evolución temporal de la señal.
% Código para el cálculo de los vectores t,w que permiten representar la señal
t=0:Ts:Tobs-Ts; w=sqrt(Pn)*randn(size(t)); w=w(:);
