function [Qtot,Q_,dP,flag2,Pot,Pot_min,Q_star,H_star]=minImpianto(Q,Pfin,Piniz,par_r,u1,u2,Qreg,p1,p2)

dP=[0.0:0.5:Pfin];
P3=Piniz;

for j=1:length(dP)

        P12=dP(j);
        Q2=Q;


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
            flag2(j)=1;
        else
            flag2(j)=0;
        end
end

for i=1:length(dP)
    Qtot(i)=Q;
end

% curva rendimento
ni=polyval(p2,Q);

% caratteristica impianto 
% portata per cui tutte le utenze ricevono la corretta portata
Q_necessaria=Q;

% punto funzionamento pompa a 50 Hz
Q_funzionamento=Q_necessaria;
H_funzionamento = polyval(p1,Q_necessaria);

Ptot=dP+Piniz;
 Q_=Qtot((end-sum(flag2)+1:end)); % portate che soddisfano il vincolo
 H=Ptot((end-sum(flag2)+1:end)); % prevalenze che soddisfano il vincolo
% 
% for i=1:length(Q)
%     n(i)=Q(i)/Q_funzionamento;
% end


Pot=((9.81*1000).*(Q_./3600).*H)./ni;

[Pot_min,k]=min(Pot);
Q_star=Q_(k); % portata ottima
H_star=H(k); % prevalenza ottima

end

