function dTamb=DinamicaScambiatore2(t,Tamb,Ti,Km,K,MC,Test,Gu,cs,Alfa,S,Gp,n)

tuu=[61:0.01:63];
tii=[51:0.01:55];
big=1000;
for j=1:length(tuu)
    for k=1:length(tii)
        if(tii(k)>tuu(j))
            err(j,k)=big;
        else
            err1= Gu*(tii(k)-tuu(j)) - Alfa*S*(((Ti-tuu(j))-((Ti - ((Gu*(tuu(j)-tii(k)))/(Gp)))-tii(k))) / (log(Ti-tuu(j)) - log((Ti - ((Gu*(tuu(j)-tii(k)))/(Gp))) - tii(k))));
            err2= Km*((tii(k)+tuu(j))/2 - Tamb)^n - Gu*(tii(k)-tuu(j));

            err(j,k)= err1 + err2;
        end
    end
end

[mincol,irow]=min(abs(err));
[~,icol]=min(mincol);

to=tuu(irow(icol))
ti=tii(icol)

To= Ti - ((Gu*(to-ti))/(Gp))

dTamb = (Km*((ti+to)/2 - Tamb)^n - K*(Tamb - Test))/MC;

end