clear all, close all, clc
% TELERISCALDAMENTO
% tempo di simulazione
t0=0;
tf=24;
tc=0.01;
t=[t0:tc:tf];

x_1=[0 3 6 9 12 15 18 21 24];
y_1=[0.5 5 10 6 2.5 1.5 0.5 -0.5 0];
p_temp = polyfit(x_1,y_1,3)
%p_temp=[0.0062 -0.2679 2.9591 -2,6767];
temper=polyval(p_temp,t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% parametri
parametri_utenze %caricamento di tutti i paramentri delle utenze
 
%selezionare utenza da prendere in considerazione
nu=11; % inserire numero da 1 a 11
par=par_u(nu,:);

% parametri utenza
V=par(1); % volume utenza da scaldare [m^3/h]
Qunitario=par(2); % calore necessario per scaldare 1 m^3
Qtot=V*Qunitario; % calore necessario per scaldare utenza

% set point termostato
Target= par(9); %Temperatura ambiente desiderata nell'utenza

% parametri scambiatore
Km1=par(3); % coeff. scambio radiatore
n=par(4); % esponente radiatore
cs=1; % [kcal/h] calore specifico acqua
%Km=V/3*0.8 %Qtot/(50^n); % coeff scambio totale radiatori; 
Km=Qtot/(50^n);

l=sqrt(V/3)

Sf=l*3*4*0.15
Sl=l*3*4 - Sf %par(5);
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

Ti=82; % temperatura ingresso allo scambiatore [rete principale] 
tu=70;

Gu= Qtot/15%par(6); % portata in l/h rete dell'utenza

Alfa=par(7);
S= V*Qunitario/(Alfa*10)

% parametri esterni
Test=0; % temperatura esterna

% parametri iniziali per la simulazione
Tamb0=par(10); % condizioni iniziali: [Temperatura ambiente iniziale ; valore iniziale stato di controllo]

X0=[18 16]
%% simulazione
  %simulazione con termostato
    [X1,X2,ti_vec,To_vec,Gp_vec,Gu_vec,kk,tu_vec,Ti_vec]=DinamicaScambiatoreRegMandata_Termostato(tf,tc,X0,Ti,Km,Ka,Kp,Kf,MCa,MCp,temper,Gu,cs,Alfa,S,tu,n,Target)
    
    %Ti_vec=Ti*ones(1,length(t)-1); % vettore temperature in ingresso allo scambiatore (lato principale) -> COSTANTE
    %tu_vec=tu*ones(1,length(t)-1); % vettore portate in ingresso allo scambiatore (lato principale) -> COSTANTE

    Plots_Termostato

    Ptot= sum(Q4.*tc)


%% simulazione evoluzione libera
% [T,X]=ode45(@DinamicaScambiatoreRegMandata,[t0 tf],X0,[],Ti,Km,Ka,Kp,MCa,MCp,Test,Gu,cs,Alfa,S,tu,n)
% 
% % PLOTs
% % Andamento della temperatura ambiente dell' utenza
% plot(T,X(:,1))
% title('Andamento della temperatura utenza')
% xlabel('Time[]')
% ylabel('temperature [°C]')
% 
% % estrapolazione dati dalla simulazione
% for i=1:length(X(:,1))
% 
% ti_temp=[X(i,1):0.001:tu];
% err1=Km*((tu+ti_temp)/2 - X(i,1)).^n - Gu*(tu-ti_temp);
% [m1,pos1]=min(abs(err1));
% ti_vec(i)=ti_temp(pos1); % vettore temperature in ingresso allo scambiatore (lato utenza)
% 
% end
% 
% for k=1:length(X)
% 
% H=(Gu*(tu-ti_vec(k)))/(Alfa*S);
% To_temp=[ti_vec(k):0.001:Ti];
% err2=(((Ti-tu)-(To_temp-ti_vec(k))) ./ (log(Ti-tu) - log(To_temp - ti_vec(k)))) - H;
% [m2,pos2]=min(abs(err2));
% To_vec(k)=To_temp(pos2); % vettore temperature in uscita allo scambiatore (lato principale)
% end
% tu_vec=tu*ones(1,length(T));
% 
% Gp_vec= (Gu*(tu_vec-ti_vec)./(Ti-To_vec)); % vettore portate lato principale
% 
% Ti_vec=Ti*ones(1,length(T)); % vettore temperature in ingresso allo scambiatore (lato principale) -> COSTANTE
% 
% % plot andamento delle temperature dello scambiatore
% figure, plot(T,ti_vec,'b',T,tu_vec,'r',...
%     T,To_vec,'c',T,Ti_vec,'m')
% legend('T ritorno (FREDDA)','T mandata (CALDA)','T ritorno (FREDDA)','T mandata (CALDA)')
% title('Temperature ingresso e uscita lato utenza')
% xlabel('Time []')
% ylabel('Temperature [°C]')
% 
% % plot andamento della portata lato principale
% figure, plot(T,Gp_vec)
% title('Variazione portata ingresso scambiatore')
% xlabel('Time []')
% ylabel('Portata [l/h]')
% 
% % plot bilanciamento potenze termiche
% Q1=Gp_vec.*(Ti-To_vec);
% Q2=Gu*(tu_vec-ti_vec);
% Q3=Alfa*S*((Ti-tu_vec)-(To_vec-ti_vec))./(log(Ti-tu_vec) - log(To_vec-ti_vec));
% Q4=Km*((tu_vec+ti_vec)/2 - X(:,1)').^n;
% 
% figure, plot(T,Q1,'b',T,Q2,'g',T,Q3,'r',T,Q4,'k')
% title('Bilanciamento potenze termiche')
% xlabel('Time []')
% ylabel('Potenza [Kcal]')
% legend('Pot termica scambiata ingresso scambiatore','Pot termica scambiata uscita scambiatore',...
%     'Potenza termica scambiata','Calore ceduto radiatori')
% 
% 
