clear all, close all, clc

parametri_utenze

Q= [0.1:0.1:29.2];
dP=[0.0:0.5:50];
P3=3;
for j=1:length(dP)
    for k=1:length(Q)

    P12=dP(j);
    Q2=Q(k);

        for i=1:length(par_u(:,1))

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
        
        if Qu>0.516
            flag1(k)=1;
        else
            flag1(k)=0;
        end

    Qfin(k)=Q2(end);
    end
    
    [qmin(j),r(j)]=min(abs(Qfin));
    flag2(j)=flag1(r(j));
end

for i=1:length(dP)
    Qff(i)=Q(r(i));
end

%[Pot,Pot_min,Q_star,H_star]=potenze_assorbite(Qff(end-sum(flag2)+1:end),dP(end-sum(flag2)+1:end)+P3(1))
[Pot,Pot_min,Q_star,H_star]=potenze_assorbite(Qff,dP+P3(1),flag2,Q,dP+P3(1))


figure, plot(Qff,dP+P3(1),'-r')
hold on
plot(Qff(end-sum(flag2)+1:end),dP(end-sum(flag2)+1:end)+P3(1),'-b')

Pot=Pot./1000 %trasformazione in kW
figure, plot(Qff(end-sum(flag2)+1:end),Pot)
hold on
plot(Q_star,Pot_min/1000,'xr','LineWidth',5)
ylabel('Potenza [kW]')
xlabel('Portata [m^3/h]')

% plot(Qu,'*')
% 
% figure, plot(P3)
% hold on, plot (P3+P12)