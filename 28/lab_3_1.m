clear all
clc
close all

T=1;
B=1/T;
fc=10;
fs=30;
A=1;

figure
[mI,t]=sentriangular(10,1,100);
figure
[mQ,t]=sencircular(10,1,100);

df=fs/length(t);
f=-fs/2:df:fs/2-df;

g=mI.*cos(2*pi*fc*t)+mQ.*sin(2*pi*fc*t);
g_h=imag(hilbert(g));
figure

tiledlayout(2,1)
nexttile
plot(t,g)
title('señal original')
nexttile
plot(t,g_h)
title('transformada  Hilbert')

g_m=g+j*g_h;
g_l=g-j*g_h;


figure
plot(g_m)
hold on
plot(g_l)
title('Pre-envolvente')
hold off

S_AmI= fftshift(fft(mI)); 
S_AmQ= fftshift(fft(mQ)); 
S_Ag= fftshift(fft(g)); 
S_Ag_m= fftshift(fft(g_m)); 
S_Ag_l= fftshift(fft(g_l)); 
tiledlayout(2,3)
nexttile
plot(f,abs(S_AmI))
title('MAGNITUD mI')
nexttile
plot(f,abs(S_AmQ))
title('MAGNITUD mQ')
nexttile
plot(f,abs(S_Ag))
title('MAGNITUD g')
nexttile
plot(f,abs(S_Ag_m))
title('MAGNITUD g+')
nexttile
plot(f,abs(S_Ag_l))
title('MAGNITUD g-')

figure
tiledlayout(2,3)
nexttile
plot(f,angle(S_AmI))
title('FASE mI')
nexttile
plot(f,angle(S_AmQ))
title('FASE mQ')
nexttile
plot(f,angle(S_Ag))
title('FASE g')
nexttile
plot(f,angle(S_Ag_m))
title('FASE g+')
nexttile
plot(f,angle(S_Ag_l))
title('FASE g-')

g_c = sqrt((mI.^2)+(mQ.^2));

figure
plot(f,abs(g_c))

[w,t]=WNOISE(100,t);
SNR=100;
Pn=10;
factor=sqrt((SNR*Pn *length(t))/(sum(abs(g).^2)));

g_r=g*factor+w';
g_rh=imag(hilbert(g_r));
figure
hold on
plot(t,g_r)
plot(t,g_rh)
title("Señal y hilbert con ruido")
hold off

g_hr=imag(hilbert(g_r));

grI = g_r.*cos(2*pi.*fc.*t) + g_hr.*sin(2*pi.*fc.*t);
grQ = g_hr.*cos(2*pi.*fc.*t) - g_r.*sin(2*pi.*fc.*t);

figure
plot(t, grI, t, grQ)
legend('grI', 'grQ')

gr_mr=g_r+j.*g_hr;
gr_lr=g_r-j.*g_hr;

figure;
plot(gr_mr)
hold on
plot(gr_lr)
grid on;

F=fft(grI);
F=fftshift(F);
mag_grI=abs(F);
ang_grI=angle(F);

F=fft(grQ);
F=fftshift(F);
mag_grQ=abs(F);
ang_grQ=angle(F);

F=fft(gr_mr);
F=fftshift(F);
mag_gr=abs(F);
ang_gr=angle(F);

F=fft(gr_mr);
F=fftshift(F);
mag_gr_pos=abs(F);
ang_gr_pos=angle(F);

F=fft(gr_lr);
F=fftshift(F);
mag_gr_neg=abs(F);
ang_gr_neg=angle(F);


% Espectro  grI
figure;
subplot(2,1,1)
plot(f,mag_grI)
xlabel('Frecuencia')
ylabel('Mag grI')
title("Magnitud grI")

subplot(2,1,2)
plot(f,ang_grI)
xlabel('Frecuencia ')
ylabel('Fase grI')
title("Fase grI")

% Espectro  grQ
figure;
subplot(2,1,1)
plot(f,mag_grQ)
xlabel('Frecuencia')
ylabel('Mag grQ')
title("Magnitud grQ")

subplot(2,1,2)
plot(f,ang_grQ)
xlabel('Frecuencia')
ylabel('Fase grQ')
title("Fase grQ")

% Espectro  gr
figure;
subplot(2,1,1)
plot(f,mag_gr)
xlabel('Frecuencia ')
ylabel('Mag gr')
title("Magnitud  gr")

subplot(2,1,2)
plot(f,ang_gr)
xlabel('Frecuencia ')
ylabel('Fase gr')
title("Fase  gr")


% Espectro  gr_pos
figure;
subplot(2,1,1)
plot(f,mag_gr_pos)
xlabel('Frecuencia ')
ylabel('Mag gr pos')
title("Magnitud  gr pos")

subplot(2,1,2)
plot(f,ang_gr_pos)
xlabel('Frecuencia ')
ylabel('Fase gr pos')
title("Fase  gr pos")


% Espectro  gr_neg
figure;
subplot(2,1,1)
plot(f,mag_gr_neg)
xlabel('Frecuencia ')
ylabel('Mag gr neg')
title("Magnitud  gr neg")

subplot(2,1,2)
plot(f,ang_gr_pos)
xlabel('Frecuencia ')
ylabel('Fase gr neg')
title("Fase  gr neg")

abs_gr=A/2+sqrt((grI.^2)+(grQ.^2));

figure;
plot(t, abs_gr)
grid on;
xlabel("tiempo")
title("valor absoluto evolvente compleja  gr(t)")

% close all;

figure;
plot(t, grI, t, mI*factor)
title('recuperada fase')
figure;
plot(t, -grQ, t, mQ*factor)

title('recuperada cuadratura')
% 
% g_mr=g_r+j*g_hr;
% g_lr=g_r-j*g_hr;
% 
% S_Agr= fftshift(fft(g_r)); 
% S_Ag_mr= fftshift(fft(g_mr)); 
% S_Ag_lr= fftshift(fft(g_lr)); 
% 
% tiledlayout(2,2)
% nexttile
% plot(f,abs(S_Agr))
% title('MAGNITUD g')
% nexttile
% plot(f,abs(S_Ag_mr))
% title('MAGNITUD g+')
% nexttile
% plot(f,abs(S_Ag_lr))
% title('MAGNITUD g-')
% 
% figure
% tiledlayout(2,2)
% nexttile
% plot(f,angle(S_Agr))
% title('FASE g')
% nexttile
% plot(f,angle(S_Ag_mr))
% title('FASE g+')
% nexttile
% plot(f,angle(S_Ag_lr))
% title('FASE g-')