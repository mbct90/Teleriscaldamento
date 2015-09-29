clear all, close all, clc

parametri_utenze

Q= 10.742%6.54
dP=25.66%10
P3=2

P12=dP;
Q2=Q;

for i=1:length(par_u(:,1))
%     if(i>0)
%     [Qu(i),Q2(i+1),P12(i+1),P3(i+1)]=perditaCarico(par_u(i,:),Q2(i),P12(i),P3(i))
%     else
%     Qreg=0.4;
%     [Qu(i),Q2(i+1),P12(i+1),P3(i+1)]=perditaCarico2(par_u(i,:),Q2(i),P12(i),P3(i),Qreg)
%     end
    if(i==8)
        [Qu(i),Qu(i+1),Q2(i+1),P12(i+1),P3(i+1)]=perditaCarico_doppio(par_u(i,:),u1,u2,Q2(i),P12(i),P3(i));
    else
        if (i==9)
        Q2(i+1)=Q2(i);
        P3(i+1)=P3(i);
        P12(i+1)=P12(i);
        else
            [Qu(i),Q2(i+1),P12(i+1),P3(i+1)]=perditaCarico(par_u(i,:),Q2(i),P12(i),P3(i));
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


% figure, plot(P3)
% hold on, plot (P3+P12)
