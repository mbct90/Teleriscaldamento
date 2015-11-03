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
Test = [5 0]
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
% % Simulazione di tutte le utenze collegate alla rete
% data una certa temperatura esterna valutiamo allo stato stazionario il
% comportamento del sistema analizzando portate consumi e temperature 

n_u=length(par_u(:,1));
for i=1:n_u
    [ti_vec,tu_vec,To_vec,Gp_vec,T,X] = SimulazioneUtenzaCentralina(t0,tf,par_u(i,:),Ti,Test(1),Kp,Ki);

    ti_utenze(i,:)=ti_vec(end);
    tu_utenze(i,:)=tu_vec(end);
    To_utenze(i,:)=To_vec(end);
    Gp_utenze(i,:)=Gp_vec(end);
    Tamb_utenze(i,:)=X(end,1)';
    T_utenze(i,:)=T(end)';
end
% calcolo temperatura di ritorno dalle utenze (media pesata)
temp1=ti_utenze.* Gp_utenze;
temp2=sum(temp1);
ti_tot =temp2./(sum(Gp_utenze))

%% simulazione metodo lungo
% ------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------
% ti_utenze=0;
% tu_utenze=0;
% To_utenze=0;
% Gp_utenze=0;
% Tamb_utenze=0;
% T_utenze=0;
% for k=1:length(t)-1
%     for i=1:n_u
%         [ti_vec,tu_vec,To_vec,Gp_vec,T,X] = SimulazioneUtenzaCentralina(t(k),t(k+1),par_u(i,:),Ti,Test(1),Kp,Ki);
%             ti_utenze(i,k)=ti_vec(end);
%             tu_utenze(i,k)=tu_vec(end);
%             To_utenze(i,k)=To_vec(end);
%             Gp_utenze(i,k)=Gp_vec(end);
%             Tamb_utenze(i,k)=X(end,1);
%             T_utenze(i,k)=T(end);
%             par_u(i,10)=X(end,1);
%     end
% end

%par_u(:,10)=Tamb_utenze(:,end);
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

%figure,plot(T_utenze(4,:),Tamb_utenze(4,:))
%% Caratteristica Impianto con Regolazioni e Potenza assorbita dalle pompe
% ------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------
  % definire in quale momento valutare la caratteristica e si determina
  % Potenza erogata, Portata e Prevalenza ottima (minore consumo)

[Qcaratteristica,Q_vec,dP,flag2,P12_c,P3_c,Q2_c,Qu_c]=caratteristicaImpiantoRegolazioni(Q_nom,polyval(p_pompa,0),P0,par_r,u1,u2,Gp_utenze(:,end)./1000,p_pompa,p_rendimento);

[Pot,Pot_min,Q_star,H_star,Q_funzionamento,H_funzionamento]=...
    potenze_assorbite_regolazioni(Qcaratteristica,dP+P0,flag2,Q_vec,dP+P0,p_pompa,p_rendimento)

h=find(dP+P0==H_star,1)
% Plot andamento delle portate
plot(Qu_c(h,:),'r*','LineWidth',8)
hold on
plot(Gp_utenze./1000,'*','LineWidth',8)
title('Andamento portate impianto')
xlabel('Utenze')
ylabel('Portata [m^3/h]')

figure, plot([0:length(par_r(:,1))],P3_c(h,:))
hold on, plot ([0:length(par_r(:,1))],P3_c(h,:)+P12_c(h,:))
title('Perdita di pressione impianto')
xlabel('Utenze')
ylabel('Prevalenza [m]')

% plot caratteristica impianto
figure, plot(Qcaratteristica,dP+P0,'-r')
hold on
plot(Qcaratteristica(end-sum(flag2)+1:end),dP(end-sum(flag2)+1:end)+P0,'-b')

% plot sulla potenza dell'impianto al variare della portata
Pot=Pot./1000 %trasformazione in kW
figure, plot(Qcaratteristica(end-sum(flag2)+1:end),Pot)
hold on
plot(Q_star,Pot_min/1000,'xr','LineWidth',5)
ylabel('Potenza [kW]')
xlabel('Portata [m^3/h]')

c=sqrt(H_funzionamento/H_star)

% plot curve pompe impianto e rendimento
figure, 
subplot(2,1,1)
plot(Qcaratteristica,dP+P0)
hold on
plot(Q_vec,polyval(p_pompa,Q_vec))
plot(Q_vec./c,(polyval(p_pompa,Q_vec))./(c^2))
plot(Q_funzionamento,H_funzionamento,'*k')
subplot(2,1,2)
plot(Q_vec,polyval(p_rendimento,Q_vec))
%% andamento portata, pressione, consumi nel tempo
% ------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------
% andamento portata, pressione, consumi 
  % faccio variare la temperatura esterna e vedo come è l'andamento del
  % sistema

% G_pompa=sum(Gp_utenze);
% 
% % funzione che data la portata restituisca il valore ottimo di pressione e potenza
% for i=1:length(G_pompa)
% [Qcaratteristica,Q_,dP,flag2,Pot,Pot_min,Q_star,H_star]=minImpianto(G_pompa(i)./1000,polyval(p_pompa,0),P0,par_r(1:4,:),u1,u2,Gp_utenze(:,i)./1000,p_pompa,p_rendimento);
% H_pompa(i)=H_star;
% Pot_pompa(i)=Pot_min;
% end
% 
% figure, 
% subplot(3,1,1)
% plot(T,G_pompa./1000)
% subplot(3,1,2)
% plot(T,H_pompa)
% subplot(3,1,3)
% plot(T,Pot_pompa)

% ------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------
