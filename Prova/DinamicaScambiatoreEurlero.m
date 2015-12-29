function [X1 , X2] = DinamicaScambiatoreEurlero(tf,X0,Ti,Km,Ka,Kp,MCa,MCp,Test,Gu,cs,Alfa,S,tu,n)

h=0.01;  % h  e'   il  passo  temporale.
t=0:h:tf;  % inizializzazione    dell'intervallo   temporale.

X1(1)=X0(1);  
X2(1)=X0(2);    %  condizione  iniziale.

s=1;

for  i=1:length(t)-1, 

ti_temp=[X1(i):0.001:tu];
err1=Km*((tu+ti_temp)./2 - X1(1)).^n - Gu*(tu-ti_temp);
[m1,pos1]=min(abs(err1));
ti=ti_temp(pos1);

H=(Gu*(tu-ti))/(Alfa*S);
To_temp=[ti:0.001:Ti];
err2=(((Ti-tu)-(To_temp-ti)) ./ (log(Ti-tu) - log(To_temp - ti))) - H;
[m2,pos2]=min(abs(err2));
To=To_temp(pos2);

Gp= (Gu*(tu-ti)/(Ti-To));

if s==1
    if (X1(i)>=20.7)
        Kmt=0;
        s=0;
        
    else
        Kmt=Km;
    end
else
    if (X1(i)<=19.3)
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