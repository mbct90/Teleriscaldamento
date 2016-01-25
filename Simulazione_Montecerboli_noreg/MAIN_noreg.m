clear all, close all, clc

% TELERISCALDAMENTO
% tempo di simulazione
t0=0;
tf=24;
tc=0.1;
t=[t0:tc:tf];


% definisco la variabile "par_u" dove sono indicate tutte le info sulle car
parametri_utenze

% definisco la variabile "par_r" dove sono indicate tutte le info sulla rete di distribuzione 
parametri_rete 

% parametri globali
%Test = [5 0]
Test = 7; % temperatura esterna [°C] -> può essere fatta variare durante la simulazione
            % in tal caso definirla come un vettore lungo quanto la
            % simulazione
Ti= 82;    % temperatura in mandata circuito principale [°C] -> costante


caratteristica_pompa

P0=9; % pressione di base del vaso di espansione
    
%% SIMULAZIONE
% determinare la caratteristica della rete

[Qcaratteristica,Q_vec,dP,flag2,P12_c,P3_c,Q2_c,Qu_c]=caratteristica_impianto(Q_nom,polyval(p_pompa,0),P0,par_r,u1,u2,p_pompa,p_rendimento);


% caratteristica impianto 
p3 = polyfit(Qcaratteristica,P0+dP,3) % coeff. caratteristica impianto

%punto funzionamento pompa a 50 Hz
fun = @(x) myfun_punto_lavoro(x,p_pompa,p3);
x0=10;
Q_funzionamento = fsolve(fun,x0)
H_funzionamento = polyval(p3,Q_funzionamento)


% plot caratteristica impianto
figure, plot(Qcaratteristica.*1000,dP+P0,'-r','LineWidth',5)
hold on
%plot(Qcaratteristica(end-sum(flag2)+1:end).*1000,dP(end-sum(flag2)+1:end)+P0,'-b')
plot(Q_vec.*1000,polyval(p_pompa,Q_vec),'k','LineWidth',5)
plot(Q_funzionamento*1000,H_funzionamento,'*m','LineWidth',7)
title('Curva caratteristica della rete')
xlabel('Portata [l/h]')
ylabel('Prevalenza [m]')
legend('caratteristica rete','caratteristica pompa','punto di funzionamento')
set(gca,'FontSize', 20)

h=286;
% Plot andamento delle portate
figure, 
subplot(2,1,1)
plot(Qu_c(h,:).*1000,'r*','LineWidth',8)
title('Andamento portate utenze')
ylabel('Portata [l/h]')
set(gca,'FontSize', 20)

subplot(2,1,2)
 plot([0:length(par_r(:,1))],P3_c(h,:),'LineWidth',5)
hold on, plot ([0:length(par_r(:,1))],P3_c(h,:)+P12_c(h,:),'LineWidth',5)
title('Perdita di pressione della rete')
xlabel('Utenze')
ylabel('Prevalenza [m]')
legend('pressione condotta di mandata','pressione condotta di ritorno')
set(gca,'FontSize', 20)

ni=polyval(p_rendimento,Q_funzionamento);

Pot=((9.81*1000)*(Q_funzionamento/3600)*H_funzionamento)/ni
 

Pcons_pompe_noreg=Pot*tf
