function [Pot,Pot_min,Q_star,H_star]=potenze_assorbite_regolazioni_Tempo(Qtot,Ptot,flag2,QQ,p1,p2)


% curva rendimento
ni=polyval(p2,QQ);

% caratteristica impianto
% portata per cui tutte le utenze ricevono la corretta portata
Q_necessaria=Qtot(end);

% punto funzionamento pompa a 50 Hz
Q_funzionamento=Q_necessaria;


Q=Qtot((end-sum(flag2)+1:end)); % portate che soddisfano il vincolo di portata
H=Ptot((end-sum(flag2)+1:end)); % prevalenze che soddisfano il vincolo di prevalenza


Pot=((9.81*1000).*(Q./3600).*H)./ni((end-sum(flag2)+1:end));

% [Pot_min,k]=min(Pot);
% Q_star=Q(k); % portata ottima
% H_star=H(k); % prevalenza ottima
%Pot=1
Pot_min=1
Q_star=1
H_star=1
end
