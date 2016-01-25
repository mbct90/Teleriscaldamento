%% Definizione paramentri della rete di distribuzione per calcolo portate 
dt=10;
% utenza 1
par_r(1,1)= 0.02; %lambda
par_r(1,2)= 235.6;  % lunghezza tubo principale [m]
par_r(1,3)= 37;   % lunghezza tubo utenza [m]
par_r(1,4)= 70.3;   % diametro tubo principale [mm]
par_r(1,5)= 24.2;   % diametro tubo utenza [mm]
par_r(1,6)= 1;    % gamma
par_r(1,7)= 5/(par_u(1,1)*30/(dt*1000))^2 %2.4337e+08;   % k

% utenza 2
par_r(2,1)= 0.02; %lambda
par_r(2,2)= 1;  % lunghezza tubo principale [m]
par_r(2,3)= 15;   % lunghezza tubo utenza [m]
par_r(2,4)= 70.3;   % diametro tubo principale [mm]
par_r(2,5)= 24.2;   % diametro tubo utenza [mm]
par_r(2,6)= 1;    % gamma
par_r(2,7)= 5/(par_u(2,1)*30/(dt*1000))^2;   % k

% utenza 3
par_r(3,1)= 0.02; %lambda
par_r(3,2)= 25.76;  % lunghezza tubo principale [m]
par_r(3,3)= 57.6;   % lunghezza tubo utenza [m]
par_r(3,4)= 70.3;   % diametro tubo principale [mm]
par_r(3,5)= 24.2;   % diametro tubo utenza [mm]
par_r(3,6)= 1;    % gamma
par_r(3,7)= 5/(par_u(3,1)*30/(dt*1000))^2;   % k

% utenza 4
par_r(4,1)= 0.02; %lambda
par_r(4,2)= 20;  % lunghezza tubo principale [m]
par_r(4,3)= 12.4;   % lunghezza tubo utenza [m]
par_r(4,4)= 70.3;   % diametro tubo principale [mm]
par_r(4,5)= 24.2;   % diametro tubo utenza [mm]
par_r(4,6)= 1;    % gamma
par_r(4,7)= 5/(par_u(4,1)*30/(dt*1000))^2;   % k

% utenza 5
par_r(5,1)= 0.02; %lambda
par_r(5,2)= 111;  % lunghezza tubo principale [m]
par_r(5,3)= 33.7;   % lunghezza tubo utenza [m]
par_r(5,4)= 70.3;   % diametro tubo principale [mm]
par_r(5,5)= 24.2;   % diametro tubo utenza [mm]
par_r(5,6)= 1;    % gamma
par_r(5,7)= 5/(par_u(5,1)*30/(dt*1000))^2;   % k

% utenza 6
par_r(6,1)= 0.02; %lambda
par_r(6,2)= 1082;  % lunghezza tubo principale [m]
par_r(6,3)= 36;   % lunghezza tubo utenza [m]
par_r(6,4)= 70.3;   % diametro tubo principale [mm]
par_r(6,5)= 24.2;   % diametro tubo utenza [mm]
par_r(6,6)= 1;    % gamma
par_r(6,7)= 5/(par_u(6,1)*30/(dt*1000))^2;   % k

% utenza 7
par_r(7,1)= 0.02; %lambda
par_r(7,2)= 65;  % lunghezza tubo principale [m]
par_r(7,3)= 16.5;   % lunghezza tubo utenza [m]
par_r(7,4)= 70.3;   % diametro tubo principale [mm]
par_r(7,5)= 24.2;   % diametro tubo utenza [mm]
par_r(7,6)= 1;    % gamma
par_r(7,7)= 5/(par_u(7,1)*30/(dt*1000))^2;   % k

% utenza 8 - 9 (doppio prelievo)
par_r(8,1)= 0.02; %lambda
par_r(8,2)= 186;  % lunghezza tubo principale [m]
par_r(8,3)= 70;   % lunghezza tubo intermedio [m]
par_r(8,4)= 54.5;   % diametro tubo principale [mm]
par_r(8,5)= 37.2;   % diametro tubo intermedio [mm]
par_r(8,6)= 1;    % gamma
par_r(8,7)= 5/(par_u(8,1)*30/(dt*1000))^2;   % k

par_r(9,:)=par_r(8,:);
par_r(9,7)=5/(par_u(9,1)*30/(dt*1000))^2;

u1(1)= 34.5;   % lunghezza tubo utenza 1 [m]
u1(2)= 24.2;   % diametro tubo utenza 1 [mm]

u2(1)= 40;   % lunghezza tubo utenza 1 [m]
u2(2)= 24.2;   % diametro tubo utenza 1 [mm]

% utenza 10
par_r(10,1)= 0.02; %lambda
par_r(10,2)= 109.8;  % lunghezza tubo principale [m]
par_r(10,3)= 7.3;   % lunghezza tubo utenza [m]
par_r(10,4)= 54.5;   % diametro tubo principale [mm]
par_r(10,5)= 24.2;   % diametro tubo utenza [mm]
par_r(10,6)= 1;    % gamma
par_r(10,7)= 5/(par_u(10,1)*30/(dt*1000))^2;  % k

% utenza 11
par_r(11,1)= 0.02; %lambda
par_r(11,2)= 30.32;  % lunghezza tubo principale [m]
par_r(11,3)= 341.2;   % lunghezza tubo utenza [m]
par_r(11,4)= 54.5;   % diametro tubo principale [mm]
par_r(11,5)= 43.1;   % diametro tubo utenza [mm]
par_r(11,6)= 1;    % gamma
par_r(11,7)= 5/(par_u(11,1)*30/(dt*1000))^2;  % k