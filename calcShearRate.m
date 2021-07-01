function [gamma,gamma_bar] = calcShearRate(U,dy,h)

n = length(U);
gamma = nan(1,n-1);

%local shear rate
gamma(1:n-1) = (U(2:n) - U(1:n-1))/dy;

%depth-averaged shear rate (assuming U slip = 0)
gamma_bar = U(n)/h;