% Potenza dispersa

xDN65=[50 60 70 80 90 100]
yDN65=[21 26 31 36 41 46]
pDN65 = polyfit(xDN65,yDN65,3) % coeff. caratteristica pompa
Pdpm65=polyval(pDN65,temp) % potenza dispersa per metro

xDN50=[50 60 70 80 90 100]
yDN50=[17 22 26 30 34 38]
pDN50 = polyfit(xDN50,yDN50,3) % coeff. caratteristica pompa
Pdpm50=polyval(pDN50,temp) % potenza dispersa per metro

% lunghezza totale tubi principali

l_DN65=sum(par_u(1:7,4)) *2

l_DN50=sum(par_u(8:end,4)) *2

Pdisp65 = l_DN65 * Pdpm65
Pdisp50 = l_DN50 * Pdpm50
Pdisp_tot = Pdisp65 + Pdisp50
