function [Pot,Pot_min,Q_star,H_star]=potenze_assorbite(Qtot,Ptot,flag2,QQ,PP)

%curva pompa
x1=[0 4 8 12 16 20 24 28 29.2]
y1=[46 46 45 44 42.5 40 36 33 32.5]
p1 = polyfit(x1,y1,2) % coeff. caratteristica pompa
H_nom=polyval(p1,QQ)

% curva rendimento nominale
x2=[7 9 11.2 14 16 19 23 27.2 29.2]
y2=[0.3 0.35 0.4 0.45 0.475 0.5 0.525 0.5 0.475]
p2 = polyfit(x2,y2,4) % coeff. curva rendimento pompa
ni=polyval(p2,QQ)

% caratteristica impianto 
p3 = polyfit(Qtot,Ptot,3) % coeff. caratteristica impianto

%punto funzionamento pompa a 50 Hz
fun = @(x) myfun(x,p1,p3);
x0=10;
Q_funzionamento = fsolve(fun,x0)
H_funzionamento = polyval(p3,Q_funzionamento)




Q=Qtot((end-sum(flag2)+1:end));
H=Ptot((end-sum(flag2)+1:end));



for i=1:length(Q)
    n(i)=Q(i)/Q_funzionamento;
    
end

%H_real=n.^2.*H_funzionamento

Pot=((9.81*1000).*(Q./3600).*H)./ni((end-sum(flag2)+1:end))

[Pot_min,k]=min(Pot);
Q_star=Q(k)
H_star=H(k)

% plot curve pompe impianto e rendimento
c=sqrt(H_funzionamento/H_star)

figure, 
subplot(2,1,1)
plot(Qtot,polyval(p3,Qtot))
hold on
plot(QQ,H_nom)
plot(QQ./c,(polyval(p1,QQ))./(c^2))
plot(Q_funzionamento,H_funzionamento,'*k')
subplot(2,1,2)
plot(QQ,ni)
hold on
plot(QQ./c,ni)

end
