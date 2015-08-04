clear all, close all, clc

parametri_utenze

Q= 3.4347%4.3182 % portata Q sezione n-esima [m3/h]
dP=24;
P3=3

P12=dP;
Q2=Q;

for i=1:length(par_u(:,1))
    if(i>4)
    [Qu(i),Q2(i+1),P12(i+1),P3(i+1)]=perditaCarico(par_u(i,:),Q2(i),P12(i),P3(i))
    else
    Qreg=0.4;
    [Qu(i),Q2(i+1),P12(i+1),P3(i+1)]=perditaCarico2(par_u(i,:),Q2(i),P12(i),P3(i),Qreg)
    end
end

plot(Qu,'*')

figure, plot(P3)
hold on, plot (P3+P12)
