function [ti_vec,tu_vec,To_vec,Gp_vec,T,X] = SimulazioneUtenzaCentralina(t0,tf,par_u,Ti,Test,Kp,Ki)

%% parametri

% parametri utenza
V=par_u(1); % volume utenza da scaldare [m^3/h]
Qunitario=par_u(2); % calore necessario per scaldare 1 m^3
Qtot=V*Qunitario; % calore necessario per scaldare utenza

% set point termostato
Target= par_u(9); %Temperatura ambiente desiderata nell'utenza

% parametri scambiatore
Km1=par_u(3); % coeff. scambio radiatore
n=par_u(4); % esponente radiatore
cs=1; % calore specifico acqua
K=Qtot/25; %costante di dispersione termica   %1.37*300; 
Km=Qtot/(40^n); % coeff scambio totale radiatori   %0.8031 * 70; 

MC=par_u(5);

%Ti=84; % temperatura ingresso allo scambiatore [rete principale] 

Gu=par_u(6); % portata in l/h rete dell'utenza

Alfa=par_u(7);
S=par_u(8);

% parametri esterni
%Test=0; % temperatura esterna

% parametri iniziali per la simulazione
Tamb0=[par_u(10) 0]; % condizioni iniziali: [Temperatura ambiente iniziale ; valore iniziale stato di controllo]

% parametri controllore PI
%Kp=40; % coefficiente proporzionale
%Ki=5; % coefficiente integrale

%% simulazione

[T,X]=ode45(@DinamicaScambiatorePid,[t0 tf],Tamb0,[],Ti,Km,K,MC,Test,Gu,cs,Alfa,S,Target,n,Kp,Ki);


%% PLOTs
% Andamento della temperatura ambiente dell' utenza
% plot(T,X(:,1))
% title('Andamento della temperatura utenza')
% xlabel('Time[]')
% ylabel('temperature [°C]')

% estrapolazione dati dalla simulazione
for i=1:length(X(:,1))
    tu(i)=X(i,2) + Kp.*(Target-X(i,1));
    if tu(i)>Ti-8
        tu(i)=Ti-8;
    end
    if tu(i)<50
        tu(i)=50;
    end

ti_temp=[X(i,1):0.001:tu(i)];
err1=Km*((tu(i)+ti_temp)/2 - X(i,1)).^n - Gu*(tu(i)-ti_temp);
[m1,pos1]=min(abs(err1));
ti_vec(i)=ti_temp(pos1); % vettore temperature in ingresso allo scambiatore (lato utenza)

end

for k=1:length(X)

H=(Gu*(tu(k)-ti_vec(k)))/(Alfa*S);
To_temp=[ti_vec(k):0.001:75];
err2=(((Ti-tu(k))-(To_temp-ti_vec(k))) ./ (log(Ti-tu(k)) - log(To_temp - ti_vec(k)))) - H;
[m2,pos2]=min(abs(err2));
To_vec(k)=To_temp(pos2); % vettore temperature in uscita allo scambiatore (lato principale)
end
tu_vec=tu;

Gp_vec= (Gu*(tu_vec-ti_vec)./(Ti-To_vec)); % vettore portate lato principale

end
%Ti_vec=Ti*ones(length(T)); % vettore temperature in ingresso allo scambiatore (lato principale) -> COSTANTE

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

