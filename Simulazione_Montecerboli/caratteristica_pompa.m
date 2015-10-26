% caratteristica pompa
Q_nom=29.2;
P_nom=32.5;

%curva pompa
x1=[0 4 8 12 16 20 24 28 29.2]
y1=[46 46 45 44 42.5 40 36 33 32.5]
p_pompa = polyfit(x1,y1,2) % coeff. caratteristica pompa

% curva rendimento
x2=[7 9 11.2 14 16 19 23 27.2 29.2]
y2=[0.3 0.35 0.4 0.45 0.475 0.5 0.525 0.5 0.475]
p_rendimento = polyfit(x2,y2,4) % coeff. curva rendimento pompa
