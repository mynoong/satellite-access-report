function [ Lo, La, r ] = planetLocation( planetIndex, tJulian )
%PLANETLOCATION Answer the heliocentric ecliptic longitude,
%latitude and radius, in degrees and AU, for the planet indexed by
%planetIndex (1=Mercury,...,9=Pluto), at the Julian date tJulian
%
%WARNING! Do not use these data for high-precision applications!

allElements = planetElements;
elements = allElements( planetIndex, :, 1 );
elementDerivatives = allElements( planetIndex, :, 2 );

T = ( tJulian - 2451545.0 ) / 36525; % Number of centuries past
                                     % J2000
elements = elements  +  T * elementDerivatives;

a = elements(1);
ecc = elements(2);
inc = elements(3);
L = elements(4);
omegaBar = elements(5);
Omega = elements(6);

omega = omegaBar - Omega;
M = L - omegaBar;
M = -180 + mod( M+180, 360 ); % Put in range -180 <= M < 180

% Solution of Kepler's equation for time since periapsis
eccStar = ecc * 180/pi;

E = M + eccStar * sind(M);
tol = 1.0e-6; 
DeltaM = 1.0e10;
while abs(DeltaM) > tol
  DeltaM = M - ( E - eccStar*sind(E) );
  DeltaE = DeltaM / ( 1 - ecc*cosd(E) );
  E = E + DeltaE;
end

%disp( sprintf( 'Kepler''s eq: M = %f, rhs = %f', M, E - eccStar*sind(E) ...
%               ) );

% Planet location in its orbital plane
xp = a * ( cosd(E) - ecc );
yp = a*sqrt(1-ecc^2) * sind(E);
zp = 0;

% Heliocentric ecliptic planet location
x = ( cosd(omega)*cosd(Omega) - sind(omega)*sind(Omega)*cosd(inc) ) ...
    * xp + ( -sind(omega)*cosd(Omega) - cosd(omega)*sind(Omega)*cosd(inc) ...
             ) * yp;
y = ( cosd(omega)*sind(Omega) + sind(omega)*cosd(Omega)*cosd(inc) ) ...
    * xp + ( -sind(omega)*sind(Omega) + cosd(omega)*cosd(Omega)*cosd(inc) ...
             ) * yp;
z = sind(omega)*sind(inc) * xp + cosd(omega)*sind(inc) * yp;

% Convert to spherical polar
r = sqrt( x^2 + y^2 + z^2 );
La = asind( z / r );
Lo = atan2d( y, x );
Lo = mod( Lo, 360 );
