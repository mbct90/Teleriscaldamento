function dX=DinamicaScambiatorePid(t,X,Ti,Km,K,MC,Test,Gu,cs,Alfa,S,Target,n,Kp,Ki)

tu = X(2) + Kp*(Target-X(1)); % temperatura in uscita dallo scambiatore (lato utenza)

% conrtollo sulla temperatura in uscita (vincoli)
if tu > Ti-5
    tu = Ti-5;
end
if tu < 50
    tu = 50;
end

% calcolo temperatura in ingresso allo scambiatore (lato utenza: temp. ritorno dai radiatori)
ti_temp=[X(1):0.001:tu];
err1=Km*((tu+ti_temp)/2 - X(1)).^n - Gu*(tu-ti_temp);
[~,pos1]=min(abs(err1));
ti = ti_temp(pos1);

% calcolo temperatura in uscita allo scambiatore (lato principale)
H=(Gu*(tu-ti))/(Alfa*S);
To_temp=[ti:0.001:Ti-2];
err2=(((Ti-tu)-(To_temp-ti)) ./ (log(Ti-tu) - log(To_temp - ti))) - H;
[~,pos2]=min(abs(err2));
To = To_temp(pos2);

% calcolo portata lato principale
Gp= (Gu*(tu-ti)/(Ti-To));

% calcolo variabile di stato
dX1 = (Km*((ti+tu)/2 - X(1)).^(n) - K*(X(1) - Test))/MC; 
dX2 = Ki*(Target - X(1));

dX=[dX1 dX2]';

end