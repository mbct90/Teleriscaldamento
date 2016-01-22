%PLOT TERMOSTATO

%plot delle temperaute riguardanti l'abitazione
figure, plot(t,X1,'LineWidth',5)
title('Andamento della temperatura utenza')
xlabel('Time[]')
ylabel('temperature [°C]')
legend('temperatura interna')

figure, plot(t,X1,t,X2,'LineWidth',5)
title('Andamento della temperatura utenza e delle pareti')
xlabel('Time[]')
ylabel('temperature [°C]')
legend('temperatura interna','temperatura pareti')

%plot delle temperature dell'acqua dello scambiatore

figure,
subplot(6,1,1)
plot(t,X1,'g','LineWidth',5)
hold on
plot(t,20*ones(1,length(t)),'k-.')
legend('T interna','set point')
title('Andamento della temperatura utenza')
set(gca,'FontSize', 18)

ylabel('Temperatura [°C]')

subplot(6,1,2)
plot(t(1:end-1),ti_vec,'b','LineWidth',5)
legend('t_i (fredda)')
title('Temperatura ingresso allo scambiatore lato utenza')

ylabel('Temperatura [°C]')
set(gca,'FontSize', 18)

subplot(6,1,3)
plot(t(1:end-1),tu_vec,'r','LineWidth',5)
legend('t_u (calda)')
title('Temperatura uscita allo scambiatore lato utenza')

ylabel('Temperatura [°C]')
set(gca,'FontSize', 18)

subplot(6,1,4)
plot(t(1:end-1),Ti_vec,'m','LineWidth',5)
legend('T_i (calda)')
title('Temperatura uscita allo scambiatore lato rete distribuzione')

ylabel('Temperatura [°C]')
set(gca,'FontSize', 18)

subplot(6,1,5)
plot(t(1:end-1),To_vec,'c','LineWidth',5)
legend('T_u (fredda)')
title('Temperatura ingresso allo scambiatore lato rete distribuzione')

ylabel('Temperatura [°C]')
set(gca,'FontSize', 18)

subplot(6,1,6)
plot(t(1:end-1),Gp_vec,'k','LineWidth',5)
legend('T_i (calda)')
title('Variazione portata ingresso scambiatore')
xlabel('Time [h]')
ylabel('Portata [l/h]')
set(gca,'FontSize', 18)


% figure, plot(t(1:end-1),ti_vec,'b',t(1:end-1),tu_vec,'r',...
%     t(1:end-1),To_vec,'c',t(1:end-1),Ti_vec,'m','LineWidth',5)
% legend('ti  (FREDDA)','to (CALDA)','To (FREDDA)','Ti (CALDA)')
% title('Temperature ingresso e uscita lato utenza')
% xlabel('Time []')
% ylabel('Temperature [°C]')

% plot andamento della portata lato principale
figure, plot(t(1:end-1),Gp_vec,'LineWidth',5)
title('Variazione portata ingresso scambiatore')
xlabel('Time []')
ylabel('Portata [l/h]')

% plot bilanciamento potenze termiche
Q1=Gp_vec.*(Ti-To_vec);
Q2=Gu_vec.*(tu_vec-ti_vec);
Q3=Alfa*S*((Ti-tu_vec)-(To_vec-ti_vec))./(log(Ti-tu_vec) - log(To_vec-ti_vec));
Q4=kk.*((tu_vec+ti_vec)/2 - X1(1:end-1)).^n;

figure, plot(t(1:end-1),Q1,'b',t(1:end-1),Q2,'g',t(1:end-1),Q3,'r',t(1:end-1),Q4,'k','LineWidth',5)
title('Bilanciamento potenze termiche')
xlabel('Time []')
ylabel('Potenza [Kcal/h]')
legend('Pot termica scambiata ingresso scambiatore','Pot termica scambiata uscita scambiatore',...
    'Potenza termica scambiata','Calore ceduto radiatori')

