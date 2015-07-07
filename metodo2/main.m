clear all, close all, clc
% TELERISCALDAMENTO
t0=0;
tf=200;
t=[t0:1:100];

%% parametri
cs=1;
K=1.37*300;
Km=0.8031 * 70;
n=1.32;
MC=10000;
Ti=84;
Test=[0:0.02:10];
Test(end+1:end+301)=10;1

Test_cost=7;

Gu=600;

Alfa=1000;
S=1;

Tamb0=20;

%% simulazione
Gp=500;

[T,X]=ode45(@DinamicaScambiatore3,[t0 tf],Tamb0,[],Ti,Km,K,MC,Test_cost,Gu,cs,Alfa,S,Gp,n)


%% PLOTs
plot(T,X)

% for i=1:length(X)
% ti_temp=[X(i):0.001:tu];
% err1=Km*((tu+ti_temp)/2 - X(i)).^n - Gu*(tu-ti_temp);
% [m1,pos1]=min(abs(err1));
% ti_vec(i)=ti_temp(pos1);
% end
% 
% for k=1:length(X)
% H=(Gu*(tu-ti_vec(k)))/(Alfa*S);
% To_temp=[ti_vec(k):0.001:75];
% err2=(((Ti-tu)-(To_temp-ti_vec(k))) ./ (log(Ti-tu) - log(To_temp - ti_vec(k)))) - H;
% [m2,pos2]=min(abs(err2));
% To_vec(k)=To_temp(pos2);
% end
% 
% Gp_vec= (Gu*(tu-ti_vec)./(Ti-To_vec));
% 
% figure, plot(T,ti_vec,'b')
% hold on, plot(T,To_vec,'r')
% 
% figure, plot(T,Gp_vec)
% 
% %bilanciamento potenze termiche
% Q1=Gp_vec.*(Ti-To_vec);
% Q2=Gu*(tu-ti_vec);
% Q3=Alfa*S*((Ti-tu)-(To_vec-ti_vec))./(log(Ti-tu) - log(To_vec-ti_vec));
% Q4=Km*((tu+ti_vec)/2 - X').^n;
% 
% figure, plot(T,Q1,'b',T,Q2,'g',T,Q3,'r',T,Q4,'k')

%% metodo lungo
% teta_amb=0;
% for i=1:length(t)-1
%     if i==1
%         Tamb=Tamb0;
%     else
%         Tamb=X(end);
%     end
%     
%     if i>650
%         tu=68;
%     end
%     tu_vec(i)=tu;
%     
%     [T,X]=ode45(@DinamicaScambiatore,[t(i) t(i+1)],Tamb,[],Ti,Km,K,MC,Test_cost,Gu,cs,Alfa,S,tu,eps);
%     teta_amb(i)=X(end);
% end
% plot(t(1:end-1),teta_amb)
% 
% ti_vec=( (Km*teta_amb) - (tu_vec*((Km/2) - Gu)) ) / ( Gu+(Km/2) );
% 
% H_vec=(Gu.*(tu_vec-ti_vec))./(Alfa*S);
% To_vec=(2.*H_vec + tu_vec + ti_vec -Ti).*1.012;
% Gp_vec= (Gu.*(tu_vec-ti_vec)./(Ti-To_vec));
% 
% To_vec=Ti - Gu*(tu_vec-ti_vec)./Gp_vec 
% 
% figure, plot(t(1:end-1),ti_vec,'b')
% hold on, plot(t(1:end-1),To_vec,'g')
% %plot(t(1:end-1),tu*ones(1,length(t)-1),'r')
% %plot(t(1:end-1),Ti*ones(1,length(t)-1),'k')
% 
% figure, plot(t(1:end-1),Gp_vec)

% x=[30:1:85];
% 
% figure, plot(x,1000*((x-20)/50).^1.32,'m')
% grid on
% hold on
% plot(x,1250*((x-20)/50).^1.32 + 5,'r')
% plot(x,750*((x-20)/50).^1.32 - 5,'b')
% 
% plot(x,1500*((x-20)/50).^1.32 + 10,'k--')
% plot(x,500*((x-20)/50).^1.32 -10,'k-.')
