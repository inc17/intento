function [g,t] = pasabanda(m, t, fc,f,W,a)
g=m.*cos(2*pi*fc*t);
tf=1/(2*fc);

b=(0<f).*(-2*pi*fc*tf+(a.*(f-fc)))+(f<0).*(2*pi*fc*tf+(a.*(f+fc)));

H=(abs(f+fc)<=W|abs(f-fc)<=W).*exp(i*b);

figure
tiledlayout(2,1)
nexttile
plot(f,abs(H))
title("magnitud")
nexttile
plot(f,angle(H))
title("fase")

g_f=fft(g);
G=fftshift(g_f);

y_f=G.*H;
Y=fftshift(y_f);

h=ifft(Y);
h=ifftshift(h);
figure;
plot(t,h);
end
