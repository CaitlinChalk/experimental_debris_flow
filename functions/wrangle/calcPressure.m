function P = calcPressure(rho,theta,h,Y)

P = rho.*9.81.*(h - Y).*cos(theta);
