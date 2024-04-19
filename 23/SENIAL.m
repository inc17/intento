function [x,t,Xf,f,Tobs]=SENIAL(A,fc,Fase,Nciclos, Npp)
y=0; t=0; Yf=0; f=0;
Tobs=(Nciclos/fc);

dt=1/(fc*Npp); 
t=0:dt:Tobs-dt;
x=A*cos(2*pi*fc*t-Fase);

Xf=fft(x);
Xf=fftshift(Xf); 
fs=1/dt; 
df=fs/length(t); 
f= -fs/2:df:fs/2-df; 
fn= -1/2:df/fs:1/2-df/fs; 

end