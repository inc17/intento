function [y,t,Yf,f,Xf,Wf]=Senialyruido(SNR,fc,Pn)
% [y,t,Yf,f,Xf,Wf]=Senialyruido(SNR,fc,Pn)
% Obtiene un vector de ruido blanco y gaussiano de potencia y extensión definidas
%
% Variables de Entrada
% SNR: Relación Señal a Ruido
% fc: frecuencia de oscilación de la señal
% Pn: Intervalo de tiempo entre dos muestras consecutivas
% A: Amplitud de la señal
%
% Variables de Salida
% y: vector que contiene la evolución de la amplitud de la señal ruidosa en el tiempo.
% t: vector que registra la evolución temporal de la señal.
% Yf: vector que contiene los valores de la transformada de Fourier de la señal ruidosa “y”
% f: vector que registra el contenido de frecuencia de la señal.
% Xf: vector que contiene los valores de la transformada de Fourier de la señal original “x”
% Wf: vector que contiene los valores de la transformada de Fourier del ruido “w”
y=0; t=0; Yf=0; f=0; Xf=0; Wf=0;

Nciclos=10; Npp=10;
A=sqrt(2*SNR*Pn);
Ts=1/fc;
Fase=2*pi*rand(1); 

[x,t,Xf,f]=SENIAL(A,fc,Fase,Nciclos, Npp);
Tobs=t(length(t))+Ts;
[w]=WNOISE(Pn,Tobs,Ts);
y=x+w;

Yf=fft(y); Yf=fftshift(Yf);
Wf=fft(w); Wf=fftshift(Wf);

end
