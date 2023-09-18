function [La,Lo,h] = findISS( time, tleFilename )

if nargin < 1
  time = toJulianDate( '3-Mar-2023', 19 + 10/60 + 13/3600 );
end
if nargin < 2
  tleFilename = "iss.tle";
end

R0 = physicalConstant('R0Earth');

[ a, ecc, Omega, inc, omega, theta, epoch ] = readTLE( tleFilename );
elems = [ a, ecc, Omega, inc, omega, theta ];

rECEF = findECEFLocation( elems, epoch, time )
La = asind( rECEF(3) / norm(rECEF) );
Lo = atan2d( rECEF(2), rECEF(1) );
h = norm(rECEF) - R0;

end
