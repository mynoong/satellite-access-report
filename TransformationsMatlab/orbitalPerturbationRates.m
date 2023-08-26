function [dOmegaByDt, domegaByDt] = orbitalPerturbationRates( mu, R0, J2, a, ecc, inc )
%ORBITALPERTURBATIONRATES Answer the rates of regression of nodes and of
%rotation of apsides, in degrees/sec, for an orbit about a body with
%gravitational parameter mu (km^3/s^2), equatorial radius R0 (km),
%zonal coefficient J2, with orbital parameters semimajor axis a (km),
%eccentricity ecc, and inclination inc (degrees)

rad = 180/pi; % To convert radians to degrees

n = sqrt( mu / a^3 );  % Mean motion (rad/s)

common = rad * 3*n * J2 * R0^2  / ( 2*a^2 * (1 - ecc^2)^2 );

dOmegaByDt = -common * cosd(inc);

domegaByDt = common * ( 4 - 5*sind(inc)^2 ) / 2;

end
