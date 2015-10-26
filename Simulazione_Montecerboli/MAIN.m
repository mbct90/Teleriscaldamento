clear all, close all, clc

% TELERISCALDAMENTO
% tempo di simulazione
t0=0;
tf=100;
t=[t0:1:tf];

% definisco la variabile "par_r" dove sono indicate tutte le info sulla rete di distribuzione 
parametri_rete 

% definisco la variabile "par_u" dove sono indicate tutte le info sulle car
parametri_utenze

% parametri globali
Test = [13 4]
%Test = 5; % temperatura esterna [°C] -> può essere fatta variare durante la simulazione
            % in tal caso definirla come un vettore lungo quanto la
            % simulazione
Ti= 82;    % temperatura in mandata circuito principale [°C] -> costante

    % parametri controllore PI
    Kp=40; % coefficiente proporzionale
    Ki=2; % coefficiente integrale

caratteristica_pompa
P0=9;
    
%% SIMULAZIONE
n_u=length(par_u(:,1));
for i=1:n_u
 
[ti_vec,tu_vec,To_vec,Gp_vec,T,X] = SimulazioneUtenzaCentralina(t0,tf,par_u(i,:),Ti,Test(2),Kp,Ki);
   
ti_utenze(i,:)=ti_vec;
tu_utenze(i,:)=tu_vec;
To_utenze(i,:)=To_vec;
Gp_utenze(i,:)=Gp_vec;
Tamb_utenze(i,:)=X(:,1)';
T_utenze(i,:)=T';
end
par_u(:,10)=Tamb_utenze(:,end);
% for i=1:1
% [ti_vec,tu_vec,To_vec,Gp_vec,T2,X2] = SimulazioneUtenzaCentralina(t0,tf,par_u(i,:),Ti,Test(2),Kp,Ki);
%    
% ti_utenze2(i,:)=ti_vec;
% tu_utenze2(i,:)=tu_vec;
% To_utenze2(i,:)=To_vec;
% Gp_utenze2(i,:)=Gp_vec;
% Tamb_utenze2(i,:)=X2(:,1)';
% T_utenze2(i,:)=T2';
% end

plot(T,X(:,1))

% calcolo temperatura di ritorno dalle utenze (media pesata)
temp1=ti_utenze.* Gp_utenze;
temp2=sum(temp1);
ti_tot =temp2./(sum(Gp_utenze))

% ------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------

% Caratteristica Impianto con Regolazioni e Potenza assorbita dalle pompe
  % definire in quale momento valetare la caratteristica e si determina
  % Potenza erogata, Portata e Prevalenza ottima (minore consumo)

% [Qff,Q,dP,flag2]=caratteristicaImpiantoRegolazioni(Q_nom,polyval(p_pompa,0),P0,par_r,u1,u2,Gp_utenze(:,end)./1000,p_pompa,p_rendimento)
% 
% [Pot,Pot_min,Q_star,H_star,Q_funzionamento,H_funzionamento]=...
%     potenze_assorbite_regolazioni(Qff,dP+P0,flag2,Q,dP+P0,p_pompa,p_rendimento)
% 
% % plot caratteristica impianto
% figure, plot(Qff,dP+P0,'-r')
% hold on
% plot(Qff(end-sum(flag2)+1:end),dP(end-sum(flag2)+1:end)+P0,'-b')
% 
% % plot sulla potenza dell'impianto al variare della portata
% Pot=Pot./1000 %trasformazione in kW
% figure, plot(Qff(end-sum(flag2)+1:end),Pot)
% hold on
% plot(Q_star,Pot_min/1000,'xr','LineWidth',5)
% ylabel('Potenza [kW]')
% xlabel('Portata [m^3/h]')
% 
% c=sqrt(H_funzionamento/H_star)
% 
% % plot curve pompe impianto e rendimento
% figure, 
% subplot(2,1,1)
% plot(Qff,dP+P0)
% hold on
% plot(Q,polyval(p_pompa,Q))
% plot(Q./c,(polyval(p_pompa,Q))./(c^2))
% plot(Q_funzionamento,H_funzionamento,'*k')
% subplot(2,1,2)
% plot(Q,polyval(p_rendimento,Q))

% ------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------
% andamento portata, pressione, consumi 
  % faccio variare la temperatura esterna e vedo come è l'andamento del
  % sistema

G_pompa=sum(Gp_utenze);

% funzione che data la portata restituisca il valore ottimo di pressione e potenza
for i=1:length(G_pompa)
[Qff,Q_,dP,flag2,Pot,Pot_min,Q_star,H_star]=minImpianto(G_pompa(i)./1000,polyval(p_pompa,0),P0,par_r,u1,u2,Gp_utenze(:,i)./1000,p_pompa,p_rendimento);
H_pompa(i)=H_star;
Pot_pompa(i)=Pot_min;
end

figure, 
subplot(3,1,1)
plot(T,G_pompa./1000)
subplot(3,1,2)
plot(T,H_pompa)
subplot(3,1,3)
plot(T,Pot_pompa)
