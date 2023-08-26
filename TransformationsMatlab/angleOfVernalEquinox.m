function a = angleOfVernalEquinox( tJulian )
%ANGLEOFVERNALEQUINOX Answer the angle from the vernal equinox vector
%(x_i) to the ECEF x-axis at Julian date tJulian

siderealDay = physicalConstant( 'siderealDay' );

% t: Time of day (sec) since March 17, 2021, 00:00 UT
t = ( tJulian - 2459290.500000 ) * 86400;
timeOfSunSouthing = 12*3600 + 8*60 + 17.2;
hecLo = 176.8287;
hecLa = 0.0001;

vecToEarthHE = [ cosd(hecLa)*cosd(hecLo), cosd(hecLa)*sind(hecLo), sind(hecLa) ];
HEtoECI = rotationQX( 23.43928 );
vecToEarth = qrotate( vecToEarthHE, HEtoECI );
vecToSun = -vecToEarth; % In ECI coords

% Now angle between x-vectors at noon 
noonXVectorAngle = atan2d( vecToSun(2), vecToSun(1) );

a = noonXVectorAngle + 360*( t - timeOfSunSouthing )/siderealDay; 

end
