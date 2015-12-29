function [X1,X2,ti_vec,tu_vec,To_vec]=DinamicaScambiatoreNoReg_Termostato(tf,tc,X0,Ti,Km,Test,Gu,cs,Alfa,S,Gp,n,MCa,MCp,Ka,Kp,Target)

h=tc;  % h  e'   il  passo  temporale.
t=0:h:tf;  % inizializzazione    dell'intervallo   temporale.

X1(1)=X0(1);  
X2(1)=X0(2);    %  condizione  iniziale.

s=1;

for  i=1:length(t)-1, 

fun = @(x) myfun(x,Km,X1(i),Gu,Gp,Ti,cs,Alfa,S,n);
x0=[70 75];
Z=fsolve(fun,x0);

ti=Z(1);
tu=Z(2);
To=(Ti - (Gu*(tu-ti))/(Gp));

ti_vec(i)=ti;
tu_vec(i)=tu;
To_vec(i)=To;


if s==1
    if (X1(i)>=Target+0.7)
        Kmt=0;
        s=0;
        
    else
        Kmt=Km;
    end
else
    if (X1(i)<=Target-0.7)
        Kmt=Km;
        s=1;
    else
        Kmt=0;
    end
    
end

k1= (Kmt*((ti+tu)/2 - X1(i)).^(n) - Ka*(X1(i)-X2(i)) )/(MCa);    %  calcolo  della   derivata;
    X1(i+1)=X1(i) + h*k1;    %          stima          del          nuovo          valore          di          y;
    
    k2=( Ka*(X1(i)-X2(i)) - Kp*(X2(i) - Test))/(MCp);
    X2(i+1)=X2(i) + h*k2;

end

end