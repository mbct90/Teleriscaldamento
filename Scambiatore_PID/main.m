clear all, close all, clc
% TELERISCALDAMENTO
t0=0;
tf=100;
t=[t0:1:tf];

Target= 20; %Temperatura ambiente desiderata nell'utenza

%
V=300; % volume utenza da scaldare [m^3/h]
Qunitario=30; % calore necessario per scaldare 1 m^3
Qtot=V*Qunitario; % calore necessario per scaldare utenza

%% parametri
Km1=0.8031; % coeff. scambio radiatore
n=1.32; % esponente radiatore
cs=1; % calore specifico
K=Qtot/25; %costante di dispersione termica   %1.37*300; 
Km=Qtot/(50^n); % coeff scambio totale radiatori   %0.8031 * 70; 

MC=10000;

Ti=84; % temperatura ingresso allo scambiatore [rete principale] 

Test=0; % temperatura esterna

Gu=600; % portata in l/h rete dell'utenza

Alfa=1000;
S=1;

Tamb0=[15 0]; % condizioni iniziali: [Temperatura ambiente iniziale ; valore iniziale stato di controllo]

% tu=75; 

% PID
Kp=48; % coefficiente proporzionale
Ki=5; % coefficiente integrale

%% simulazione

[T,X]=ode45(@DinamicaScambiatorePid,[t0 tf],Tamb0,[],Ti,Km,K,MC,Test,Gu,cs,Alfa,S,Target,n,Kp,Ki)


%% PLOTs
plot(T,X(:,1))
title('Andamento della temperatura utenza')
xlabel('Time[]')
ylabel('temperature [°C]')

%tu=X(:,2) + Kp.*(Target-X(:,1))

for i=1:length(X(:,1))
    tu(i)=X(i,2) + Kp.*(Target-X(i,1))
    if tu(i)>Ti-8
    tu(i)=Ti-8
    end
    if tu(i)<50
    tu(i)=50
    end

ti_temp=[X(i,1):0.001:tu(i)];
err1=Km*((tu(i)+ti_temp)/2 - X(i,1)).^n - Gu*(tu(i)-ti_temp);
[m1,pos1]=min(abs(err1));
ti_vec(i)=ti_temp(pos1);

end

for k=1:length(X)

H=(Gu*(tu(k)-ti_vec(k)))/(Alfa*S);
To_temp=[ti_vec(k):0.001:75];
err2=(((Ti-tu(k))-(To_temp-ti_vec(k))) ./ (log(Ti-tu(k)) - log(To_temp - ti_vec(k)))) - H;
[m2,pos2]=min(abs(err2));
To_vec(k)=To_temp(pos2);
end
tu_vec=tu;

Gp_vec= (Gu*(tu_vec-ti_vec)./(Ti-To_vec));
Ti_vec=Ti*ones(length(T));
figure, plot(T,ti_vec,'b',T,tu_vec,'r',...
    T,To_vec,'c',T,Ti_vec,'m')
legend('T ritorno (FREDDA)','T mandata (CALDA)','T ritorno (FREDDA)','T mandata (CALDA)')
title('Temperature ingresso e uscita lato utenza')
xlabel('Time []')
ylabel('Temperature [°C]')


figure, plot(T,Gp_vec)
title('Variazione portata ingresso scambiatore')
xlabel('Time []')
ylabel('Portata [l/h]')

%bilanciamento potenze termiche
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


