function dX=DinamicaScambiatoreRegMandata(t,X,Ti,Km,Ka,Kp,MCa,MCp,Test,Gu,cs,Alfa,S,tu,n)

persistent term

if (t<0.2)
    term=1;
end
    
ti_temp=[X(1):0.001:tu];
err1=Km*((tu+ti_temp)./2 - X(1)).^n - Gu*(tu-ti_temp);
[m1,pos1]=min(abs(err1));
ti=ti_temp(pos1);

H=(Gu*(tu-ti))/(Alfa*S);
To_temp=[ti:0.001:Ti];
err2=(((Ti-tu)-(To_temp-ti)) ./ (log(Ti-tu) - log(To_temp - ti))) - H;
[m2,pos2]=min(abs(err2));
To=To_temp(pos2);

Gp= (Gu*(tu-ti)/(Ti-To));

% x1=X(1)
% x2=X(2)
% Gp
% ti

% if term==1
%     if (X(1)>=20.7)
%         Kmt=0;
%         term=0
%         
%     else
%         Kmt=Km;
%     end
% else
%     if (X(1)<=19.3)
%         Kmt=Km;
%         term=1
%     else
%         Kmt=0;
%     end
%     
% end


dXa = (Km*((ti+tu)/2 - X(1)).^(n) - Ka*(X(1)-X(2)) )/(MCa);
dXp = (Ka*(X(1) - X(2)) - Kp*(X(2) - Test))/(MCp);

dX=[dXa dXp]';
end

