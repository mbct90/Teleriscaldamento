function [Qff,Q,dP,flag2]=caratteristicaImpiantoRegolazioni(Qfin,Pfin,Piniz,par_r,u1,u2,Qreg,p_pompa,p_rendimento)
% Qfin e Pfin dipendono dalle specifiche della pompa
Qfin
Q= [0.1:0.1:Qfin];
dP=[0.0:0.5:Pfin];
P3=Piniz;

for j=1:length(dP)
    for k=1:length(Q)

        P12=dP(j);
        Q2=Q(k);


        for i=1:length(par_r(:,1))
            if(i==8)
               [Qu(i),Qu(i+1),Q2(i+1),P12(i+1),P3(i+1)]=...
                   perditaCaricoRegolazioni_doppio(par_r(i,:),u1,u2,Q2(i),P12(i),P3(i),Qreg(i),Qreg(i+1));
            else
                if (i==9)
                    Q2(i+1)=Q2(i);
                    P3(i+1)=P3(i);
                    P12(i+1)=P12(i);
                else
                    [Qu(i),Q2(i+1),P12(i+1),P3(i+1)]=...
                        perditaCaricoRegolazioni(par_r(i,:),Q2(i),P12(i),P3(i),Qreg(i));
                end
            end
        end
        if Qu>=Qreg'
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

end
%plot(Qff,dP,'-')

% plot(Qu,'*')
% 
% figure, plot(P3)
% hold on, plot (P3+P12)