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
nu=4; % inserire numero da 1 a 11
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
Km=Qtot/(50^n); % coeff scambio totale radiatori;

l=sqrt(V/3)

Sf=l*3*4*0.15
Sl=l*3*4 - Sf %par(5);
Ss=l*l;
Si=Ss;

Stot=Sl+Ss+Si
MCa=1.21*V*(1005/4186) + 40*V*0.2
MCp=Stot*(65*840 + 0.7*1670 + 142*840)/4186 
Ka=6.61*Stot + 0,67*Sf
Kpar=0.43*Stot 

Ti=82; % temperatura ingresso allo scambiatore [rete principale]

Gu=par(6); % portata in l/h rete dell'utenza

Alfa=par(7);
S= V*Qunitario/(Alfa*10)

% parametri esterni
Test=7; % temperatura esterna

% parametri iniziali per la simulazione
Tamb0=par(10); % condizioni iniziali: [Temperatura ambiente iniziale ; valore iniziale stato di controllo]

X0=[ 18 15 0]

% parametri iniziali per la simulazione
Tamb0=[par(10) 0]; % condizioni iniziali: [Temperatura ambiente iniziale ; valore iniziale stato di controllo]

% parametri controllore PI
Kp=50; % coefficiente proporzionale
Ki=40; % coefficiente integrale
%% simulazione

[T,X]=ode45(@DinamicaScambiatorePid,[t0: tc :tf],X0,[],Ti,Km,Ka,Kpar,MCa,MCp,temper,Gu,cs,Alfa,S,Target,n,Kp,Ki)


%% PLOTs
% Andamento della temperatura ambiente dell' utenza
plot(T,X(:,1))
title('Andamento della temperatura utenza')
xlabel('Time[]')
ylabel('temperature [°C]')

% estrapolazione dati dalla simulazione
j=0;
for i=1:length(X(:,1))
    tu_vec(i)=X(i,3) + Kp.*(Target-X(i,1));
    if tu_vec(i)>Ti-3
        tu_vec(i)=Ti-3;
    end
%     if tu_vec(i)<50
%         j=j+1;
%        indice_Km_vec(j)=i;
%     end
    if tu_vec(i)<X(i,1)
        tu_vec(i)=X(i,1);
    end
    
    ti_temp=[X(i,1):0.001:tu_vec(i)];
    err1=Km*((tu_vec(i)+ti_temp)/2 - X(i,1)).^n - Gu*(tu_vec(i)-ti_temp);
    [m1,pos1]=min(abs(err1));
    ti_vec(i)=ti_temp(pos1); % vettore temperature in ingresso allo scambiatore (lato utenza)
    
end

for k=1:length(X)
    
    H=(Gu*(tu_vec(k)-ti_vec(k)))/(Alfa*S);
    To_temp=[ti_vec(k)+0.000000001:0.001:Ti-2];
    err2=(((Ti-tu_vec(k))-(To_temp-ti_vec(k))) ./ (log(Ti-tu_vec(k)) - log(To_temp - ti_vec(k)))) - H;
    [m2,pos2]=min(abs(err2));
    To_vec(k)=To_temp(pos2); % vettore temperature in uscita allo scambiatore (lato principale)
    
    Gp_vec(k)= (Gu*(tu_vec(k)-ti_vec(k))./(Ti-To_vec(k))); % vettore portate lato principale
    
    if Gp_vec(k) > 1500
        Gp_vec(k)=1500;
        %To_vec(k) = ( Ti - (Gu*(tu_vec(k)-ti_vec(k)))/(Gp_vec(k))  );
        
        
        fun = @(x) myfun(x,Km,X(k,1),Gu,Gp_vec(k),Ti,cs,Alfa,S,n);
        x0=[70 75];
        Z=fsolve(fun,x0);
        
        ti_vec(k)=Z(1);
        tu_vec(k)=Z(2);
        To_vec(k)=(Ti - (Gu*(tu_vec(k)-ti_vec(k)))/(Gp_vec(k)));
        
        
    end
end

% for j=1:length(indice_Km_vec)
%     Ti_vec(indice_Km_vec(j))=0;
%     To_vec(indice_Km_vec(j))=0;
%     tu_vec(indice_Km_vec(j))=0;
%     ti_vec(indice_Km_vec(j))=0;
%     Gu_vec(indice_Km_vec(j))=0;
%     Gp_vec(indice_Km_vec(j))=0;
% end

Ti_vec=Ti*ones(1,length(T)); % vettore temperature in ingresso allo scambiatore (lato principale) -> COSTANTE

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

% for j=1:length(indice_Km_vec)
%     Q1(indice_Km_vec(j))=0;
%     Q2(indice_Km_vec(j))=0;
%     Q3(indice_Km_vec(j))=0;
%     Q4(indice_Km_vec(j))=0;
% end

figure, plot(T,Q1,'b',T,Q2,'g',T,Q4,'r',T,Q4,'k')
title('Bilanciamento potenze termiche')
xlabel('Time []')
ylabel('Potenza [Kcal]')
legend('Pot termica scambiata ingresso scambiatore','Pot termica scambiata uscita scambiatore',...
    'Potenza termica scambiata','Calore ceduto radiatori')

figure,
subplot(6,1,1)
plot(t,X(:,1),'g','LineWidth',5)
hold on
plot(t,20*ones(1,length(t)),'k-.')
legend('T interna','set point')
title('Andamento della temperatura utenza')
set(gca,'FontSize', 18)

ylabel('Temperatura [°C]')

subplot(6,1,2)
plot(t,ti_vec,'b','LineWidth',5)
legend('t_i (fredda)')
title('Temperatura ingresso allo scambiatore lato utenza')

ylabel('Temperatura [°C]')
set(gca,'FontSize', 18)

subplot(6,1,3)
plot(t,tu_vec,'r','LineWidth',5)
legend('t_u (calda)')
title('Temperatura uscita allo scambiatore lato utenza')

ylabel('Temperatura [°C]')
set(gca,'FontSize', 18)

subplot(6,1,4)
plot(t,Ti_vec,'m','LineWidth',5)
legend('T_i (calda)')
title('Temperatura uscita allo scambiatore lato rete distribuzione')

ylabel('Temperatura [°C]')
set(gca,'FontSize', 18)

subplot(6,1,5)
plot(t,To_vec,'c','LineWidth',5)
legend('T_u (fredda)')
title('Temperatura ingresso allo scambiatore lato rete distribuzione')

ylabel('Temperatura [°C]')
set(gca,'FontSize', 18)

subplot(6,1,6)
plot(t,Gp_vec,'k','LineWidth',5)
legend('T_i (calda)')
title('Variazione portata ingresso scambiatore')
xlabel('Time [h]')
ylabel('Portata [l/h]')
set(gca,'FontSize', 18)


Ptot=sum(Q4*tc)
