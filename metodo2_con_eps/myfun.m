function F=myfun(x,Km,Tamb,Gu,Gp,Ti,cp,Alfa,S,n,eps)
Gmin=min([Gu Gp]);

F=[Km*((x(2)+x(1))/(2) - Tamb)^n -  Gmin*eps*(Ti - x(1)); Gp*cp*(Ti-(Ti - (Gu*(x(2)-x(1)))/(Gp))) - Alfa*S*(((Ti-x(2)) - ((Ti - (Gu*(x(2)-x(1)))/(Gp))-x(1)))/(log((Ti-x(2))/((Ti - (Gu*(x(2)-x(1)))/(Gp))-x(1)))))];


% K=(Gu*(tu-ti))/(Alfa*S);
% l1=log(Ti-ti);
% 
% F= ((Ti-ti)-(Tu-tu)) - K*(l1 - log(Tu - tu));

end
