clear all, close all, clc

parametri_utenze

Q= 5.68%5.676%5.678; % portata Q sezione n-esima [m3/h]
dP=11%9.5%15;
P3=2;

P12=dP;
Q2=Q;

Qreg=0.516;
Qreg1=0.516;
Qreg2=0.516;

for i=1:length(par_u(:,1))
    if(i==8)
        [Qu(i),Qu(i+1),Q2(i+1),P12(i+1),P3(i+1)]=perditaCarico2_doppio(par_u(i,:),u1,u2,Q2(i),P12(i),P3(i),Qreg1,Qreg2);
    else
        if (i==9)
        Q2(i+1)=Q2(i);
        P3(i+1)=P3(i);
        P12(i+1)=P12(i);
        else
            [Qu(i),Q2(i+1),P12(i+1),P3(i+1)]=perditaCarico2(par_u(i,:),Q2(i),P12(i),P3(i),Qreg);
        end
    end
end

plot(Qu,'*','LineWidth',8)
title('Andamento portate impianto')
xlabel('Utenze')
ylabel('Portata [m^3/h]')

figure, plot([0:length(par_u(:,1))],P3)
hold on, plot ([0:length(par_u(:,1))],P3+P12)
title('Perdita di pressione impianto')
xlabel('Utenze')
ylabel('Prevalenza [m]')