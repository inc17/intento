clear all
close all
clc
k=1;
%f=[7000,7000+100*k];
%a=[1,1];
f=rand(1,6)*(10000-300)+300;
a=ones(1,6);
SNR_dB=0;
SNR=10;
Ts=1/30000;
Pn=2;
[x,t]=suma_sinusoides(f,a,SNR,Ts,Pn);
figure
title("señal");
xlabel("Tiempo [s]");
ylabel("magnitud");
plot(t,x)

[S1,f1]=periodograma(x,t);
figure(2); 
plot(f1,S1);
ylim([0 500])
xlabel('Frecuencia [Hz]');
title('S_{1}');

Tobs=1/300;
Ts=1/30000;
frec=[7000, 7300]; % Ejemplo de Vector de frecuencias de las componentes
% sinusoidales
amp=[1, 1]; % Ejemplo de Vector de amplitudes relativas de las componentes
% sinusoidales
Pn=2; % Densidad espectral del ruido blanco
n=length(frec); % Número de componentes sinusoidales
t=0:Ts:5*Tobs-Ts; % Vector de evolución temporal de x(t)
SNR=10.^(SNR_dB/10); % Conversión de SNR(dB) a SNR adimensional
G=sqrt(2*SNR*Pn/n); 
x=G*x+sqrt(Pn)*randn(size(x)); %Incorporación de ruido a la señal original
orden=100;
p=2*n+1; %Si tenemos 2 sinusoides en la señal compuesta, p=5
nFFT=length(t);
fs=1/Ts;
% Estimación Espectral
Periodograma=fftshift((abs(fft(x)).^2)/length(t));
[P_Periodogram,fn]=periodogram(x,[],nFFT,1);
[P_Burg,fn]=pburg(x,orden,nFFT,1);
[P_Cov,fn]=pcov(x,orden,nFFT,1);
[P_Mcov,fn]=pmcov(x,orden,nFFT,1);
[P_Welch,fw]=pwelch(x,[],[],[],1);
[P_YuleAR,fn]=pyulear(x,orden,nFFT,1);
[P_Eig,fn]=peig(x,p,nFFT,1);
[P_MUSIC,fn]=pmusic(x,p,nFFT,1);
df=fs/length(t); fp=-fs/2:df:fs/2-df; % Frecuencia para Periodograma
f=fn/Ts; % Frecuencia para Periodogram, Burg, Cov, Mcov, Yule-Walker,
% Pseudoespectro-Eig, MUSIC
fw=fw/Ts; %Frecuencia para Welch
R1=xcorr(x)'; %Cálculo de la función de autocorrelación de x(t)
Ventana1=bartlett(length(R1));
Ventana2=blackmanharris(length(R1));
Rw1=R1.*Ventana1;
Rw2=R1.*Ventana2;
Correlograma1=fftshift(abs(fft(Rw1))); % Usando ventana de Bartlett
Correlograma2=fftshift(abs(fft(Rw2))); % Usando ventana de Blackman-Harris
df=fs/length(Rw1);fc=-fs/2:df:fs/2-df; % Frecuencia para Correlogramas
% Impresión de resultados
figure
plot(fp,Periodograma); title('Periodograma'); xlabel('Frecuencia (Hz)');
figure
plot(f,P_Periodogram); title('Periodogram'); xlabel('Frecuencia (Hz)');
figure
plot(f,P_Burg); title('Método de Burg'); xlabel('Frecuencia (Hz)');
figure
plot(f,P_Cov); title('Método de Covarianza'); xlabel('Frecuencia (Hz)');
figure
plot(f,P_Mcov); title('Método de Covarianza Modificada'); 
xlabel('Frecuencia(Hz)');
figure
plot(fw,P_Welch); title('Método de Welch');
figure
plot(f,P_YuleAR); title('Método de Yule-Walker AR');
figure
plot(f,P_Eig); title('Pseudoespectro Eig');
figure
plot(f,P_MUSIC); title('MUSIC');
figure
plot(fc,Correlograma1/length(fc)); title('Correlograma-Ventana de Bartlett');
figure
plot(fc,Correlograma2/length(fc)); 
title('Correlograma-Ventana de Blackman-Harris');
Px_n=sum(x.^2)/length(x); % Potencia de la señal infectada con ruido