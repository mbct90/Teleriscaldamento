function dX=DinamicaScambiatorePid(t,X,Ti,Km,Ka,Kpar,MCa,MCp,Test,Gu,cs,Alfa,S,Target,n,Kp,Ki)
if t==0
    d=1;
else
    d=find(t);
end

y=-1.65.*Test(d) + 68;


tu = X(3) + Kp*(Target-X(1)); % temperatura in uscita dallo scambiatore (lato utenza)

% conrtollo sulla temperatura in uscita (vincoli)
c=1;
if tu > y
    tu = y;
    c=0;
end
if tu < X(1)
    tu = X(1);
end

% if tu<50
%     Km=0;
% end
if t==0
    d=1
else
    d=find(t)
end


% calcolo temperatura in ingresso allo scambiatore (lato utenza: temp. ritorno dai radiatori)
ti_temp=[X(1):0.001:tu];
err1=Km*((tu+ti_temp)/2 - X(1)).^n - Gu*(tu-ti_temp);
[~,pos1]=min(abs(err1));
ti = ti_temp(pos1);

% calcolo temperatura in uscita allo scambiatore (lato principale)
H=(Gu*(tu-ti))/(Alfa*S);
To_temp=[ti+0.000000001:0.001:Ti-2];
err2=(((Ti-tu)-(To_temp-ti)) ./ (log(Ti-tu) - log(To_temp - ti))) - H;
[~,pos2]=min(abs(err2));
To = To_temp(pos2);

% calcolo portata lato principale
Gp= (Gu*(tu-ti)/(Ti-To));

if Gp > 417
    Gp=417;
    Km*((tu+ti_temp)/2 - X(1)).^n - Gu*(tu-ti_temp);
    To = ( Ti - (Gu*(tu-ti))/(Gp)  );
end

% calcolo variabile di stato
dXa = (Km*((ti+tu)/2 - X(1)).^(n) - Ka*(X(1)-X(2)) - (6.363*18)*(X(1)-Test(d)) )/(MCa);
dXp = (Ka*(X(1) - X(2)) - Kpar*(X(2) - Test(d)))/(MCp);
dXtu = c*Ki*(Target - X(1));


%dX1 = (Km*((ti+tu)/2 - X(1)).^(n) - K*(X(1) - Test))/MC; 
%dX2 = Ki*(Target - X(1));

dX=[dXa dXp dXtu]';

end