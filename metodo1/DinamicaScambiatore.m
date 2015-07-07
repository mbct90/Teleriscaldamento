function dTamb=DinamicaScambiatore(t,Tamb,Ti,Km,K,MC,Test,Gu,cs,Alfa,S,tu,n)

ti_temp=[Tamb:0.001:tu];
err1=Km*((tu+ti_temp)/2 - Tamb).^n - Gu*(tu-ti_temp);
[m1,pos1]=min(abs(err1));
ti=ti_temp(pos1)
%ti= ( (Km*Tamb) - (tu*((Km/2) - Gu)) ) / ( Gu+(Km/2) )

H=(Gu*(tu-ti))/(Alfa*S);
To_temp=[ti:0.001:Ti];
err2=(((Ti-tu)-(To_temp-ti)) ./ (log(Ti-tu) - log(To_temp - ti))) - H;
[m2,pos2]=min(abs(err2));
To=To_temp(pos2)

%=(2*H + tu + ti -Ti)*1.012;

% fun = @(Tu_) myfun(Tu_,Gu,tu,Ti,ti,Alfa,S);
% To= fzero(fun,77)

Gp= (Gu*(tu-ti)/(Ti-To))


dTamb = (Km*((ti+tu)/2 - Tamb)^(n) - K*(Tamb - Test))/MC;

end