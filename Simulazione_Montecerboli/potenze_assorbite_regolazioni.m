function [Pot,Pot_min,Q_star,H_star,Q_funzionamento,H_funzionamento]=potenze_assorbite_regolazioni(Qtot,Ptot,flag2,QQ,PP,p1,p2)

%curva pompa
H_nom=polyval(p1,QQ)

% curva rendimento
ni=polyval(p2,QQ)

% caratteristica impianto
% portata per cui tutte le utenze ricevono la corretta portata
Q_necessaria=Qtot(end)

% punto funzionamento pompa a 50 Hz
Q_funzionamento=Q_necessaria;
H_funzionamento = polyval(p1,Q_necessaria)


Q=Qtot((end-sum(flag2)+1:end)); % portate che soddisfano il vincolo di portata
H=Ptot((end-sum(flag2)+1:end)); % prevalenze che soddisfano il vincolo di prevalenza

for i=1:length(Q)
    n(i)=Q(i)/Q_funzionamento;
end

Pot=((9.81*1000).*(Q./3600).*H)./ni((end-sum(flag2)+1:end))

[Pot_min,k]=min(Pot);
Q_star=Q(k) % portata ottima
H_star=H(k) % prevalenza ottima

end
