function [dOmegaDt, domegaDt] = orbitalPerturbationRates(mu, R0, J2, a, e, i)
%orbitalPerturbationRates gives the rates of regression of nodes and of
%rotation of apsides, in degrees/sec, for an orbit about a body with
%gravitational parameter mu (km^3/s^2), equatorial radius R0 (km),
%zonal coefficient J2, with orbital parameters semimajor axis a (km),
%eccentricity e, and inclination i (degrees).

rad = 180 / pi; % To convert radians to degrees
n = sqrt(mu / a^3);  % Mean motion (rad/s)

dOmegaDt = -3 * rad * n * J2 * R0^2 * cosd(i) / ( 2 * a^2 * (1 - e^2)^2 ) ;
domegaDt = 3 * rad * n * J2 * R0^2 * (4 - 5 * sind(i)^2) / ( 4 * a^2 * (1 - e^2)^2 );

end
