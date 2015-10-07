function [Qu1,Qu2,Q2,P12,P3_new]=perditaCarico_doppio(par,u1,u2,Q1,dP,P3)

% Qu = portata sul tubo intemedio
% Q2 = portata dopo il prelievo delle utenze
% P12= diff. pressione tubo principale
% P3_new = pressione nel ritorno circuito principale sezione avanti
% 
% Qu1=portata della sezione n-esima [m3/h] (utenza 1)
% Qu2=portata della sezione n-esima [m3/h] (utenza 2)
% par = parametri: lambda, lunghezze e diametri tubi, gamma, k
% dP = differenza di pressione circuito principale
% P3 = pressione nel ritorno circuito principale
% u1 = parametri utenza 1: lunghezza tubi e diametro
% u2 = parametri utenza 2: lunghezza tubi e diametro

%% senza regolazione utenza
% definizione variabili
lamb=par(1);
l1=par(2); l2=l1; li=par(3);
D1=par(4)/1000 ; D2=D1; Di=par(5)/1000;
g=9.81;
gamma=par(6);
k=par(7);

% utenza 1
lu1=u1(1);
Du1=u1(2)/1000;

% utenza 2
lu2=u2(1);
Du2=u2(2)/1000;

v1=(Q1/3600)/((pi*D1^2)/4);
v2=v1;

%perdite di carico
P01= ((lamb*l1*(v1)^2)/(D1*2*g))*gamma;
P23= ((lamb*l2*(v2)^2)/(D2*2*g))*gamma;

%calcolo portate e pressioni 
P0=P3+dP;

P12=(P0-P01)-(P3+P23);

k1=((lamb*lu1*16)/(pi^2*Du1^5*g));
k2=((lamb*lu2*16)/(pi^2*Du2^5*g));
ku=((lamb*li*8)/(pi^2*Di^5*g));
A=sqrt((k2+k)/(k1+k));
B=2*ku*((1+A)^2);
C=P12/(B+(k2+k));

Q2t=sqrt((P12 -((k2+k)*C))/(2*ku)) *3600;

Qu2=sqrt(C)*3600;
Qu1=A*Qu2;

% if (Qu1+Qu2)>Q1
%     Qu1=(A*Q1)/(1+A);
%     Qu2=Q1-Qu1;
% end

Q2=Q1-(Qu1+Qu2);
P3_new = P3 + P23;

end