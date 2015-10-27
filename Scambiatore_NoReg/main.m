clear all, close all, clc
% TELERISCALDAMENTO
t0=0;
tf=100;
t=[t0:1:tf];

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

MC=par(5);

Ti=82; % temperatura ingresso allo scambiatore [rete principale] 
tu=75;

Gu=par(6); % portata in l/h rete dell'utenza

Alfa=par(7);
S=par(8);

% parametri esterni
Test=0; % temperatura esterna

% parametri iniziali per la simulazione
Tamb0=par(10); % condizioni iniziali: [Temperatura ambiente iniziale ; valore iniziale stato di controllo]


%% simulazione
Gp=620;

[T,X]=ode45(@DinamicaScambiatoreNoReg,[t0 tf],Tamb0,[],Ti,Km,K,MC,Test,Gu,cs,Alfa,S,Gp,n)


%% PLOTs
plot(T,X)

Tamb=X
% estrapolazione dati dalla simulazione
for i=1:length(X)
    fun = @(x) myfun(x,Km,Tamb(i),Gu,Gp,Ti,cs,Alfa,S,n);
    x0=[52 64];
    Z=fsolve(fun,x0);
    ti_vec(i)=Z(1);
    tu_vec(i)=Z(2);
    To_vec(i)=(Ti - (Gu*(tu_vec(i)-ti_vec(i)))/(Gp));
end

Ti_vec=Ti*ones(1,length(T));
Gp_vec=Gp*ones(1,length(T));

% plot andamento delle temperature dello scambiatore
figure, plot(T,ti_vec,'b',T,tu_vec,'r',...
    T,To_vec,'c',T,Ti_vec,'m')
legend('T ritorno (FREDDA)','T mandata (CALDA)','T ritorno (FREDDA)','T mandata (CALDA)')
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
