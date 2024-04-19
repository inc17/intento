function [S1,f1]=periodograma(x,t)
Xf=fft(x);
Ts=t(2)-t(1); 
fs=1/Ts;
S1=(1/length(x))*abs(Xf).^2;
S1=fftshift(S1);
df1=fs/length(t);
f1=-(fs/2):df1:(fs/2)-df1;
end