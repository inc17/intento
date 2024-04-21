
u=5; %media
v_1=sqrt(1); %varianza 1
v_2=sqrt(2); %varianza 2
m_exp=0;
v_exp=0;
g=5;


x_1=normrnd(u,v_1,[10000,1]);
y_1=normrnd(u,v_2,[10000,1]);
z=x_1+(1-g)*(y_1-x_1);
m_exp=m_exp+mean(z);
v_exp=v_exp+var(z);


mu=m_exp;
var_1=v_exp;
disp(['Encontrar la media y la varianza']);
disp(['la media es: ',num2str(mu)]);
disp(['la varianza es: ',num2str(var_1)]);


s=-5:0.1:5;
s=-4:0.1:4;
fi_x=exp(j*s.*x_1);
fi_y=exp(j*s.*y_1);

fi_x=sum(fi_x,1);
fi_y=sum(fi_y,1);


fi_z = exp(j*s.*z);
fi_z=sum(fi_z,1);

fig1=figure
hold on
plot(s,abs(fi_x))
plot(s,abs(fi_y))
plot(s,abs(fi_z))
legend("funcion x","funcion y","funcion z")
hold off

%g minima
v_min=100;
v_intento=0;
g_min=0;
g=0;
c=1;

while g<=1

v_exp=0;

x_2=normrnd(u,v_1,[10000,1]);
y_2=normrnd(u,v_2,[10000,1]);
z=x_2+(1-g)*(y_2-x_2);
v_exp=var(z);

v_s(c)=v_exp;
g_s(c)=g;
g=g+0.01;
c=c+1;

end

v_min=min(v_s);
p=find(v_s==v_min);
g_min=g_s(p);
fig2=figure
plot(g_s,v_s);
title('g vs varianzas de z')
xlabel('g')
ylabel('varianza de z')
z=x_2+(1-g_min)*(y_2-x_2);

disp(['Encontrar la g para la varianza minima de z']);
disp(['El valor de g para la minima varianza es: ',num2str(g_min)]);

var_x=(v_1)^2;
var_y=2*(var_x);




disp(['Ordenar las varianzas de menor a mayor']);
disp(['Varianza de x: ',num2str(var_x)]);
disp(['Varianza de y: ',num2str(var_y)]);
disp(['Varianza de z: ',num2str(v_min)]);


fig3=figure
% Create plots.
t = tiledlayout(3,1);

ax1 = nexttile;
hist(x_1)
title(ax1,'Varianza de x')
xlim([-6 8]);

ax2 = nexttile;
hist(y_1)
title(ax2,'Varianza de y')
xlim([-6 8]);

ax3 = nexttile;
hist(z)
title(ax3,'Varianza de z')
xlim([-6 8]);

valores=[var_x,var_y,v_min];
ordenados=sort(valores)
