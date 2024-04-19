function [x,t]=suma_sinusoides(f,a,SNR,Ts,Pn)
n=length(f);
t=0:Ts:(1/60)-Ts;
Po=(1/2)*sum(a.^2);
x=zeros(size(t));
for k=1:n
    x=x+a(k)*cos(2*pi*f(k)*t+2*pi*rand(1));
end
G=sqrt(SNR*Pn/Po);
x=G*x+sqrt(Pn)*rand(size(x));
end
