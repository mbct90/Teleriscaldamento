function dX=DinamicaScambiatoreNoReg(t,X,Ti,Km,Ka,Kp,MCa,MCp,Test,Gu,cs,Alfa,S,Gp,n)

fun = @(x) myfun(x,Km,X(1),Gu,Gp,Ti,cs,Alfa,S,n);
x0=[70 75];
Z=fsolve(fun,x0);

ti=Z(1);
tu=Z(2);
To=(Ti - (Gu*(tu-ti))/(Gp));


dXa = (Km*((ti+tu)/2 - X(1)).^(n) - Ka*(X(1)-X(2)) )/(MCa);
dXp = (Ka*(X(1) - X(2)) - Kp*(X(2) - Test))/(MCp);

dX=[dXa dXp]';

end