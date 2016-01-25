  clear all, close all, clc

% TELERISCALDAMENTO
% tempo di simulazione
t0=0;
tf=24;
tc=0.1;
t=[t0:tc:tf];

x_1=[0 3 6 9 12 15 18 21 24];
y_1=[0.5 5 10 6 2.5 1.5 0.5 -0.5 0];
p_temp = polyfit(x_1,y_1,3)
%p_temp=[0.0062 -0.2679 2.9591 -2,6767];
temper=polyval(p_temp,t);


% definisco la variabile "par_u" dove sono indicate tutte le info sulle car
parametri_utenze

% definisco la variabile "par_r" dove sono indicate tutte le info sulla rete di distribuzione 
parametri_rete 


% parametri globali
%Test = [5 0]
Test = 3; % temperatura esterna [�C] -> pu� essere fatta variare durante la simulazione
            % in tal caso definirla come un vettore lungo quanto la
            % simulazione
Ti= 82;    % temperatura in mandata circuito principale [�C] -> costante

caratteristica_pompa

P0=9; % pressione di base del vaso di espansione
    
%% SIMULAZIONE
% % Simulazione di tutte le utenze collegate alla rete
% data una certa temperatura esterna valutiamo allo stato stazionario il
% comportamento del sistema analizzando portate consumi e temperature 

n_u=length(par_u(:,1));
for i=1:n_u
    [X1,ti_vec,To_vec,Gp_vec,Gu_vec,kk,tu_vec,Ti_vec] = SimulazioneUtenzaCentralina(t0,tf,tc,par_u(i,:),Ti,temper);
    
%     ti_utenze(i,:)=ti_vec(50);
%     tu_utenze(i,:)=tu_vec(50);
%     To_utenze(i,:)=To_vec(50);
%     Gp_utenze(i,:)=Gp_vec(50);
%     Tamb_utenze(i,:)=X(50,1)';
%     T_utenze(i,:)=T(50)';
    
    ti_tempo(i,:)=ti_vec;
    tu_tempo(i,:)=tu_vec;
    To_tempo(i,:)=To_vec;
    Gp_tempo(i,:)=Gp_vec;
    Tamb_tempo(i,:)=X1;
end



%% Caratteristica Impianto con Regolazioni e Potenza assorbita dalle pompe
% ------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------
  % definire in quale momento valutare la caratteristica e si determina
  % Potenza erogata, Portata e Prevalenza ottima (minore consumo)

[Qcaratteristica,Q_vec,dP,flag2,P12_c,P3_c,Q2_c,Qu_c]=caratteristicaImpiantoRegolazioni(Q_nom,polyval(p_pompa,0),P0,par_r,u1,u2,Gp_tempo(:,10)./1000,p_pompa,p_rendimento);

[Pot,Pot_min,Q_star,H_star,Q_funzionamento,H_funzionamento]=...
    potenze_assorbite_regolazioni(Qcaratteristica,dP+P0,flag2,Q_vec,dP+P0,p_pompa,p_rendimento)


% plot caratteristica impianto
figure, plot(Qcaratteristica.*1000,dP+P0,'-r')
hold on
plot(Qcaratteristica(end-sum(flag2)+1:end).*1000,dP(end-sum(flag2)+1:end)+P0,'-b')
plot(Q_vec.*1000,polyval(p_pompa,Q_vec))




h=89%find(dP+P0==H_star,1)
% Plot andamento delle portate
figure,plot(Qu_c(h,:).*1000,'r*','LineWidth',8)
hold on
plot(Gp_tempo(:,10),'*','LineWidth',8)
title('Andamento portate impianto')
xlabel('Utenze')
ylabel('Portata [l/h]')

figure, plot([0:length(par_r(:,1))],P3_c(h,:))
hold on, plot ([0:length(par_r(:,1))],P3_c(h,:)+P12_c(h,:))
title('Perdita di pressione impianto')
xlabel('Utenze')
ylabel('Prevalenza [m]')


% 
% % plot sulla potenza dell'impianto al variare della portata
% Pot=Pot./1000 %trasformazione in kW
% figure, plot(Qcaratteristica(end-sum(flag2)+1:end).*1000,Pot)
% hold on
% plot(Q_star.*1000,Pot_min/1000,'xr','LineWidth',5)
% ylabel('Potenza [kW]')
% xlabel('Portata [m^3/h]')
% 
% c=sqrt(H_funzionamento/H_star)
% 
% % plot curve pompe impianto e rendimento
% figure, 
% subplot(2,1,1)
% plot(Qcaratteristica.*1000,dP+P0)
% hold on
% plot(Q_vec.*1000,polyval(p_pompa,Q_vec))
% plot(Q_vec.*1000./c,(polyval(p_pompa,Q_vec))./(c^2))
% plot(Q_funzionamento.*1000,H_funzionamento,'*k')
% subplot(2,1,2)
% plot(Q_vec,polyval(p_rendimento,Q_vec))


%% andamento portata, pressione, consumi nel tempo
% ------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------
% andamento portata, pressione, consumi 
  % faccio variare la temperatura esterna e vedo come � l'andamento del
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

    
temp_1=To_tempo.* Gp_tempo;
temp_2=sum(temp_1);
To_tot =temp_2./(sum(Gp_tempo))
% 

w=0;
for k=1:length(Gp_tempo(1,:))
    w=w+1
[Qcaratteristica,Q_vec,dP,flag2]=caratteristicaImpiantoRegolazioniTempo(Q_nom,polyval(p_pompa,0),P0,par_r,u1,u2,Gp_tempo(:,k)./1000,p_pompa,p_rendimento);

% curva rendimento
%ni=polyval(p_rendimento,Qcaratteristica);
Q_necessaria=Qcaratteristica(end);

Q=Qcaratteristica((end-sum(flag2)+1:end)); % portate che soddisfano il vincolo di portata
H=P0+dP((end-sum(flag2)+1:end)); % prevalenze che soddisfano il vincolo di prevalenza

H_funzionamento = polyval(p_pompa,Q_necessaria);
c=H_funzionamento./H;

Q_r= Qcaratteristica(end-sum(flag2)+1:end).*sqrt(c);
ni_=polyval(p_rendimento,Q_r);

%Pot=((9.81*1000).*(Q./3600).*H)./ni((end-sum(flag2)+1:end));
Pot=((9.81*1000).*(Q./3600).*H)./ni_;

nni=polyval(p_rendimento,Q_necessaria);

[Pot_min,z]=min(Pot);
Q_star=Q(z); % portata ottima

if(H(z)<H_funzionamento)
    H_star=H(z); % prevalenza ottima
else
    H_star=H_funzionamento;
    Pot_min=((9.81*1000)*(Q_necessaria/3600)*H_funzionamento)/nni;
end
H_tempo(w)=H_star;
P_tempo(w)=Pot_min;
H50_tempo(w)=H_funzionamento;
P50_tempo(w)=((9.81*1000)*(Q_necessaria/3600)*H_funzionamento)/nni;
end
figure, 
subplot(4,1,1)
plot(t(1:end-1),H_tempo,'k','LineWidth',5)
hold on
plot(t(1:end-1),H50_tempo,'r','LineWidth',5)
title('Prevalenza')
legend('Prevalenza a giri ridotti','Prevalenza a pieno regime')
ylabel('Prevalenza [m]')
set(gca,'FontSize', 18)
subplot(4,1,2)
plot(t(1:end-1),sum(Gp_tempo),'k','LineWidth',5)
title('Portata')
legend('portata necessaria')
ylabel('Portata [l/h]')
set(gca,'FontSize', 18)
subplot(4,1,3)
plot(t(1:end-1),P_tempo,'k','LineWidth',5)
hold on
plot(t(1:end-1),P50_tempo,'r','LineWidth',5)
title('Potenza')
legend('Potenza a giri ridotti','Potenza a pieno regime')

ylabel('Potenza [W]')
set(gca,'FontSize', 18)
subplot(4,1,4)
plot(t(1:end-1),To_tot,'b','LineWidth',5)
title('Temp. ritorno alla centrale Tu')
legend('T. ritorno (Tu)')
xlabel('Time [h]')
ylabel('Temperatura [�C]')
set(gca,'FontSize', 18)

Pcons_pompe=sum(P_tempo.*tc)
Pcons_pompe50=sum(P50_tempo.*tc)
