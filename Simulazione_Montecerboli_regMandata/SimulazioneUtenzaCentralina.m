function [X1,ti_vec,To_vec,Gp_vec,Gu_vec,kk,tu_vec,Ti_vec] = SimulazioneUtenzaCentralina(t0,tf,tc,par,Ti,Test)

%% parametri

% parametri utenza
V=par(1); % volume utenza da scaldare [m^3]
Qunitario=par(2); % calore necessario per scaldare 1 m^3
Qtot=V*Qunitario; % calore necessario per scaldare utenza

% set point termostato
Target= par(9); %Temperatura ambiente desiderata nell'utenza

% parametri scambiatore
Km1=par(3); % coeff. scambio radiatore
n=par(4); % esponente radiatore
cs=1; % [kcal/h] calore specifico acqua
Km=Qtot/(50^n); % coeff scambio totale radiatori;

l=sqrt(V/3);

Sf=l*3*4*0.15;
Sl=l*3*4 - Sf; %par(5);
Ss=l*l;
Si=Ss;

Stot=Sl+Ss+Si
MCa=1.21*V*(1005/4186) + 40*V*0.2
MCp=Stot*(65*840 + 0.7*1670 + 142*840)/4186 
%MCp=Stot*(65*840 + 142*840)/4186 
Ka=6.61*Stot 
Kp=(0.43*Stot) %+ (0.67*Sf)
%Kpar=(0.843*Stot) 
Kf=6.363*Sf;

Gu=Qtot/15;%par(6); % portata in l/h rete dell'utenza

Alfa=par(7);
S= V*Qunitario/(Alfa*10);

% parametri iniziali per la simulazione
%Tamb0=[par_u(10) 0]; % condizioni iniziali: [Temperatura ambiente iniziale ; valore iniziale stato di controllo]
X0=[ 18 15 0];

tu=70;


%% simulazione

[X1,X2,ti_vec,To_vec,Gp_vec,Gu_vec,kk,tu_vec,Ti_vec]=DinamicaScambiatoreRegMandata(tf,tc,X0,Ti,Km,Ka,Kp,Kf,MCa,MCp,Test,Gu,cs,Alfa,S,tu,n,Target)
%%


end
