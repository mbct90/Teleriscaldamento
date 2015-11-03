clear all, close all, clc

parametri_rete

Q= 5.68%5.676%5.678; % portata Q sezione n-esima [m3/h]
dP=6%9.5%15;
P3=2;

P12=dP;
Q2=Q;

Qreg=0.516*ones(1,length(par_r(:,1)));

for i=1:length(par_r(:,1))
    if(i==8)
        [Qu(i),Qu(i+1),Q2(i+1),P12(i+1),P3(i+1)]=perditaCarico2_doppio(par_r(i,:),u1,u2,Q2(i),P12(i),P3(i),Qreg(i),Qreg(i+1));
    else
        if (i==9)
        Q2(i+1)=Q2(i);
        P3(i+1)=P3(i);
        P12(i+1)=P12(i);
        else
            [Qu(i),Q2(i+1),P12(i+1),P3(i+1)]=perditaCarico2(par_r(i,:),Q2(i),P12(i),P3(i),Qreg(i));
        end
    end
end

plot(Qu,'r*','LineWidth',8)
hold on
plot(Qreg,'*','LineWidth',8)
title('Andamento portate impianto')
xlabel('Utenze')
ylabel('Portata [m^3/h]')

figure, plot([0:length(par_r(:,1))],P3)
hold on, plot ([0:length(par_r(:,1))],P3+P12)
title('Perdita di pressione impianto')
xlabel('Utenze')
ylabel('Prevalenza [m]')