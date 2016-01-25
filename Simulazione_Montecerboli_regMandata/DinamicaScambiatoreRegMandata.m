function [X1,X2,ti_vec,To_vec,Gp_vec,Gu_vec,kk,tu_vec,Ti_vec] = DinamicaScambiatoreRegMandata(tf,tc,X0,Ti,Km,Ka,Kp,Kf,MCa,MCp,Test,Gu,cs,Alfa,S,tu,n,Target)
% 
%  c=[-10 : tc : 15]
%  y=-1.8*c + 68
%  figure, plot(c,y,'k','LineWidth',5)
%  hold on
%  plot(c,80*ones(1,length(c)),'r--')
%  
%  title('Curva di compensazione del riscaldamento')
% xlabel(('Temperatura esterna [°C]'))
% ylabel('Temperatura [°C]')
% legend('Temp mandata t_u','massima temperatura di mandata')
% set(gca,'FontSize', 18)

y=-1.65.*Test + 68
%y=tu*ones(1,length(0:tc:tf));
% figure, plot(t,y)


h=tc;  % h  e'   il  passo  temporale.
t=0:h:tf;  % inizializzazione    dell'intervallo   temporale.

X1(1)=X0(1);  
X2(1)=X0(2);    %  condizione  iniziale.

s=1;

for  i=1:length(t)-1, 

ti_temp=[X1(i):0.001:y(i)];
err1=Km*((y(i)+ti_temp)./2 - X1(i)).^n - Gu*(y(i)-ti_temp);
[m1,pos1]=min(abs(err1));
ti=ti_temp(pos1);

H=(Gu*(y(i)-ti))/(Alfa*S);
To_temp=[ti:0.001:Ti];
err2=(((Ti-y(i))-(To_temp-ti)) ./ (log(Ti-y(i)) - log(To_temp - ti))) - H;
[m2,pos2]=min(abs(err2));
To=To_temp(pos2);

Gp= (Gu*(y(i)-ti)/(Ti-To));

Gu_vec(i)=Gu;

ti_vec(i)=ti;
Gp_vec(i)=Gp;
To_vec(i)=To;
tu_vec(i)=y(i);
Ti_vec(i)=Ti;

if s==1
    if (X1(i)>=Target+0.7)
        kk(i)=0;
        Kmt=0;
        s=0;
        Gu_vec(i)=0;
        Gp_vec(i)=0;
        To_vec(i)=0;
        ti_vec(i)=0;
        tu_vec(i)=0;
        Ti_vec(i)=0;

        
    else
        Kmt=Km;
        kk(i)=Km;
    end
else
    if (X1(i)<=Target-0.7)
        Kmt=Km;
        kk(i)=Km;
        s=1;
    else
        Kmt=0;
        kk(i)=0;
        Gu_vec(i)=0;
        Gp_vec(i)=0;
        To_vec(i)=0;
        ti_vec(i)=0;
        tu_vec(i)=0;
        Ti_vec(i)=0;
    end
    
end



    k1= (Kmt*((ti+y(i))/2 - X1(i)).^(n) - Ka*(X1(i)-X2(i)) - Kf*(X1(i)-Test(i)) )/(MCa);    %  calcolo  della   derivata;
    X1(i+1)=X1(i) + h*k1;    %          stima          del          nuovo          valore          di          y;
    
    k2=( Ka*(X1(i)-X2(i)) - Kp*(X2(i) - Test(i)))/(MCp);
    X2(i+1)=X2(i) + h*k2;
end

end