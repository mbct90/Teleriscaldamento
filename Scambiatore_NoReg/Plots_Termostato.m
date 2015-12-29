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

figure, plot(t(1:end-1),ti_vec,'b',t(1:end-1),tu_vec,'r',...
    t(1:end-1),To_vec,'c',t(1:end-1),Ti_vec,'m','LineWidth',5)
legend('to (FREDDA)','ti  (CALDA)','To (FREDDA)','Ti (CALDA)')
title('Temperature ingresso e uscita lato utenza')
xlabel('Time []')
ylabel('Temperature [°C]')

% plot andamento della portata lato principale
figure, plot(t(1:end-1),Gp_vec,'LineWidth',5)
title('Variazione portata ingresso scambiatore')
xlabel('Time []')
ylabel('Portata [l/h]')

% plot bilanciamento potenze termiche
Q1=Gp_vec.*(Ti-To_vec);
Q2=Gu*(tu_vec-ti_vec);
Q3=Alfa*S*((Ti-tu_vec)-(To_vec-ti_vec))./(log(Ti-tu_vec) - log(To_vec-ti_vec));
Q4=Km*((tu_vec+ti_vec)/2 - X1(1:end-1)).^n;

figure, plot(t(1:end-1),Q1,'b',t(1:end-1),Q2,'g',t(1:end-1),Q3,'r',t(1:end-1),Q4,'k','LineWidth',5)
title('Bilanciamento potenze termiche')
xlabel('Time []')
ylabel('Potenza [Kcal/h]')
legend('Pot termica scambiata ingresso scambiatore','Pot termica scambiata uscita scambiatore',...
    'Potenza termica scambiata','Calore ceduto radiatori')
