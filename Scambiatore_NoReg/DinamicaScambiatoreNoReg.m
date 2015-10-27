function dTamb=DinamicaScambiatoreNoReg(t,Tamb,Ti,Km,K,MC,Test,Gu,cs,Alfa,S,Gp,n)

fun = @(x) myfun(x,Km,Tamb,Gu,Gp,Ti,cs,Alfa,S,n);
x0=[70 75];
Z=fsolve(fun,x0);

ti=Z(1);
tu=Z(2);
To=(Ti - (Gu*(tu-ti))/(Gp));

dTamb = (Km*((ti+tu)/2 - Tamb)^n - K*(Tamb - Test))/MC;

end