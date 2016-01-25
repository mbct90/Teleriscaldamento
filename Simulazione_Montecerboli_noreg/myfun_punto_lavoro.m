function F=myfun_punto_lavoro(x,a1,a2)
% trovare il punto di intersezione tra la curva della pompa a 50 Hz e la
% curva caratteristica dell'impianto

% equazione caratteristica pompa: H = -0.1894*Q^2 - 0.0227*Q + 46.667 
% equazione  caratteristica dell'impiantoa: a(1)*Q^3 + a(2)*Q^2 + a(3)*Q +a(4)

F= a1(1)*x^2 + a1(2)*x +a1(3) - (a2(1)*x^3 + a2(2)*x^2 + a2(3)*x +a2(4));

end
