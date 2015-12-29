clear all, close all, clc
% TELERISCALDAMENTO
% tempo di simulazione
t0=0;
tf=30;
tc= 0.01
t=[t0:tc:tf];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% parametri
parametri_utenze
par=par_u(4,:);

% parametri utenza
V=par(1); % volume utenza da scaldare [m^3/h]
Qunitario=par(2); % calore necessario per scaldare 1 m^3
Qtot=V*Qunitario; % calore necessario per scaldare utenza

% set point termostato
Target= par(9); %Temperatura ambiente desiderata nell'utenza

% parametri scambiatore
Km1=par(3); % coeff. scambio radiatore
n=par(4); % esponente radiatore
cs=1; % calore specifico acqua
K=Qtot/25; %costante di dispersione termica   %1.37*300; 
Km=Qtot/(50^n); % coeff scambio totale radiatori   %0.8031 * 70; 

h=3; % altezza soffitto
MC=par(5);
MCa=1.21*V*(1005/4186) + 8000*0.2
Sl=380 %4*h*sqrt(V/3)
MCp=Sl*(65*840 + 0.7*1670 + 142*840)/4186
Ka=6.61*Sl
Kp=0.43*Sl %(0.04+1.966)*Sl

Ti=82; % temperatura ingresso allo scambiatore [rete principale] 
tu=75;

Gu=par(6); % portata in l/h rete dell'utenza

Alfa=par(7);
S=0.0015*V%par(8);

% parametri esterni
Test=7; % temperatura esterna

% parametri iniziali per la simulazione
Tamb0=par(10); % condizioni iniziali: [Temperatura ambiente iniziale ; valore iniziale stato di controllo]
    
X0=[14 14]
%% simulazione

 %[X1,X2]=DinamicaScambiatoreEurlero(tf,X0,Ti,Km,Ka,Kp,MCa,MCp,Test,Gu,cs,Alfa,S,tu,n)
 %plot(t,X1,t,X2)

[T,X]=ode45(@DinamicaScambiatoreRegMandata,[t0 tf],X0,[],Ti,Km,Ka,Kp,MCa,MCp,Test,Gu,cs,Alfa,S,tu,n)

%% PLOTs
% Andamento della temperatura ambiente dell' utenza
plot(T,X(:,1))
hold on
plot(T,X(:,2))
title('Andamento della temperatura utenza')
xlabel('Time[]')
ylabel('temperature [°C]')

% estrapolazione dati dalla simulazione
for i=1:length(X(:,1))

ti_temp=[X(i,1):0.001:tu];
err1=Km*((tu+ti_temp)/2 - X(i,1)).^n - Gu*(tu-ti_temp);
[m1,pos1]=min(abs(err1));
ti_vec(i)=ti_temp(pos1); % vettore temperature in ingresso allo scambiatore (lato utenza)

end

for k=1:length(X)

H=(Gu*(tu-ti_vec(k)))/(Alfa*S);
To_temp=[ti_vec(k):0.001:Ti];
err2=(((Ti-tu)-(To_temp-ti_vec(k))) ./ (log(Ti-tu) - log(To_temp - ti_vec(k)))) - H;
[m2,pos2]=min(abs(err2));
To_vec(k)=To_temp(pos2); % vettore temperature in uscita allo scambiatore (lato principale)
end
tu_vec=tu*ones(1,length(T));

Gp_vec= (Gu*(tu_vec-ti_vec)./(Ti-To_vec)); % vettore portate lato principale

Ti_vec=Ti*ones(1,length(T)); % vettore temperature in ingresso allo scambiatore (lato principale) -> COSTANTE

% plot andamento delle temperature dello scambiatore
figure, plot(T,ti_vec,'b',T,tu_vec,'r',...
    T,To_vec,'c',T,Ti_vec,'m')
legend('to (FREDDA)','ti  (CALDA)','To (FREDDA)','Ti (CALDA)')
title('Temperature ingresso e uscita lato utenza')
xlabel('Time []')
ylabel('Temperature [°C]')

% plot andamento della portata lato principale
figure, plot(T,Gp_vec)
title('Variazione portata ingresso scambiatore')
xlabel('Time []')
ylabel('Portata [l/h]')

% plot bilanciamento potenze termiche
Q1=Gp_vec.*(Ti-To_vec);
Q2=Gu*(tu_vec-ti_vec);
Q3=Alfa*S*((Ti-tu_vec)-(To_vec-ti_vec))./(log(Ti-tu_vec) - log(To_vec-ti_vec));
Q4=Km*((tu_vec+ti_vec)/2 - X(:,1)').^n;

figure, plot(T,Q1,'b',T,Q2,'g',T,Q3,'r',T,Q4,'k')
title('Bilanciamento potenze termiche')
xlabel('Time []')
ylabel('Potenza [Kcal]')
legend('Pot termica scambiata ingresso scambiatore','Pot termica scambiata uscita scambiatore',...
    'Potenza termica scambiata','Calore ceduto radiatori')


