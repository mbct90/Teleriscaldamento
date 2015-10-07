clear all, close all, clc

parametri_utenze

Q= [0.1:0.01:6];
dP=[0.0:0.5:12];
P3=2;

Qreg=0.516;
Qreg1=0.516;
Qreg2=0.516;

for j=1:length(dP)
for k=1:length(Q)

P12=dP(j);
Q2=Q(k);

% for i=1:length(par_u(:,1))
%     if(i>0)
%     [Qu(i),Q2(i+1),P12(i+1),P3(i+1)]=perditaCarico(par_u(i,:),Q2(i),P12(i),P3(i));
%     else
%     Qreg=0.4;
%     [Qu(i),Q2(i+1),P12(i+1),P3(i+1)]=perditaCarico2(par_u(i,:),Q2(i),P12(i),P3(i),Qreg);
%     end
% end
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

Qfin(k)=Q2(end);
end
[qmin(j),r(j)]=min(abs(Qfin));
end

for i=1:length(dP)
    Qff(i)=Q(r(i));
end

plot(Qff,dP,'-')

% plot(Qu,'*')
% 
% figure, plot(P3)
% hold on, plot (P3+P12)