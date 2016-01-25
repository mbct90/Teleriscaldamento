function [ti_vec,tu_vec,To_vec,Gp_vec,T,X] = SimulazioneUtenzaCentralina(t0,tf,tc,par,Ti,Test,Kp,Ki)

%% parametri

% parametri utenza
V=par(1); % volume utenza da scaldare [m^3]
Qunitario=par(2); % calore necessario per scaldare 1 m^3
Qtot=V*Qunitario; % calore necessario per scaldare utenza

% set point termostato
Target= par(9); %Temperatura ambiente desiderata nell'utenza

% parametri scambiatore
Km1=par(3); % coeff. scambio radiatore
n=par(4); % esponente radiatore
cs=1; % [kcal/h] calore specifico acqua
Km=Qtot/(50^n); % coeff scambio totale radiatori;

l=sqrt(V/3);

Sf=l*3*4*0.15;
Sl=l*3*4 - Sf; %par(5);
Ss=l*l;
Si=Ss;

Stot=Sl+Ss+Si;
MCa=1.21*V*(1005/4186) + 40*V*0.2;
MCp=Stot*(65*840 + 0.7*1670 + 142*840)/4186; 
Ka=6.61*Stot + 0,67*Sf;
Kpar=0.43*Stot ;

Gu=par(6); % portata in l/h rete dell'utenza

Alfa=par(7);
S= V*Qunitario/(Alfa*10);

% parametri iniziali per la simulazione
%Tamb0=[par_u(10) 0]; % condizioni iniziali: [Temperatura ambiente iniziale ; valore iniziale stato di controllo]
X0=[ 18 15 0];


%% simulazione

[T,X]=ode45(@DinamicaScambiatorePid,[t0: tc :tf],X0,[],Ti,Km,Ka,Kpar,MCa,MCp,Test,Gu,cs,Alfa,S,Target,n,Kp,Ki);
%%
% estrapolazione dati dalla simulazione
j=0;
for i=1:length(X(:,1))
    tu_vec(i)=X(i,3) + Kp.*(Target-X(i,1));
    if tu_vec(i)>Ti-3
        tu_vec(i)=Ti-3;
    end
%     if tu_vec(i)<50
%         j=j+1;
%        indice_Km_vec(j)=i;
%     end
    if tu_vec(i)<X(i,1)
        tu_vec(i)=X(i,1);
    end
    
    ti_temp=[X(i,1):0.001:tu_vec(i)];
    err1=Km*((tu_vec(i)+ti_temp)/2 - X(i,1)).^n - Gu*(tu_vec(i)-ti_temp);
    [m1,pos1]=min(abs(err1));
    ti_vec(i)=ti_temp(pos1); % vettore temperature in ingresso allo scambiatore (lato utenza)
    
end

for k=1:length(X)
    
    H=(Gu*(tu_vec(k)-ti_vec(k)))/(Alfa*S);
    To_temp=[ti_vec(k)+0.000000001:0.001:Ti-2];
    err2=(((Ti-tu_vec(k))-(To_temp-ti_vec(k))) ./ (log(Ti-tu_vec(k)) - log(To_temp - ti_vec(k)))) - H;
    [m2,pos2]=min(abs(err2));
    To_vec(k)=To_temp(pos2); % vettore temperature in uscita allo scambiatore (lato principale)
    
    Gp_vec(k)= (Gu*(tu_vec(k)-ti_vec(k))./(Ti-To_vec(k))); % vettore portate lato principale
    
    if Gp_vec(k) > 1000
        Gp_vec(k)=1000;        
        
        fun = @(x) myfun(x,Km,X(k,1),Gu,Gp_vec(k),Ti,cs,Alfa,S,n);
        x0=[70 75];
        Z=fsolve(fun,x0);
        
        ti_vec(k)=Z(1);
        tu_vec(k)=Z(2);
        To_vec(k)=(Ti - (Gu*(tu_vec(k)-ti_vec(k)))/(Gp_vec(k)));
        
        
    end
end

% for j=1:length(indice_Km_vec)
%     Ti_vec(indice_Km_vec(j))=0;
%     To_vec(indice_Km_vec(j))=0;
%     tu_vec(indice_Km_vec(j))=0;
%     ti_vec(indice_Km_vec(j))=0;
%     Gu_vec(indice_Km_vec(j))=0;
%     Gp_vec(indice_Km_vec(j))=0;
% end

Ti_vec=Ti*ones(1,length(T)); % vettore temperature in ingresso allo scambiatore (lato principale) -> COSTANTE


end
