function [Qu,Q2,P12,P3_new]=perditaCaricoRegolazioni(par,Q1,dP,P3,Qreg)

% Qu = portata in arrivo all'utenza
% Q2 = portata dopo il prelievo dell'utenza
% P12= pressione nell'utenza
% P3_new = pressione nel ritorno circuito principale sezione avanti
% 
% Q1=portata della sezione n-esima [m3/h]
% par = parametri: lambda, lunghezze e diametri tubi, gamma, k
% dP = differenza di pressione circuito principale
% P3 = pressione nel ritorno circuito principale


%% senza regolazione utenza
% definizione variabili
lamb=par(1);
l1=par(2); l2=l1; lu=par(3);
D1=par(4)/1000 ; D2=D1; Du=par(5)/1000;
g=9.81;
gamma=par(6);
k=par(7);

v1=(Q1/3600)/((pi*D1^2)/4);
v2=v1;
% % % inserire vincolo sulla velocità

%perdite di carico
P01= ((lamb*l1*(v1)^2)/(D1*2*g))*gamma;
P23= ((lamb*l2*(v2)^2)/(D2*2*g))*gamma;

%calcolo portate e pressioni 
P0=P3+dP;

P12=(P0-P01)-(P3+P23);

Qut=sqrt(P12/(k + ((lamb*lu*16)/(pi^2*Du^5*g)) )) * 3600;

if Qut>=Qreg
    Qu=Qreg;
else
    Qu=Qut;
end

% if Qu>Q1
%     Qu=Q1;
% end


Q2=Q1-Qu;

P3_new = P3 + P23;

end