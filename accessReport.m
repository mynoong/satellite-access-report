function accessReport( Lo, La, tleFilename, times )

minute = 1 / 24 / 60;

if nargin < 1
  Lo = -118.2982;
  La = 34.0209;
  % Spring 2023 hw8
  tleFilename = 'iss.tle';
  t1 = toJulianDate( '04-mar-2023', 8 );
  t2 = toJulianDate( '06-mar-2023', 8 );
  times = t1:minute:t2;
end

if 0 % For testing
  t1 = toJulianDate( '29-mar-2023' );
  t2 = toJulianDate( '6-apr-2023' );
  times = t1:minute:t2;
  tleFilename = 'iss-0404.tle';
end

fprintf( "(a) ECEF coordinates of ground station:\n" );
rGS = locToECEF( Lo, La )
pause;

fprintf( "(b) North, east, up vectors from ground station:\n" );
[ N, E, U ] = localNEU( Lo, La )
pause;

[ a, ecc, Omega, inc, omega, theta, epoch ] = readTLE( tleFilename );
elems = [ a, ecc, Omega, inc, omega, theta ];

for time = times
  rSC = findECEFLocation( elems, epoch, time );
  vecSC = rSC - rGS;
  northProj = dot( vecSC, N );
  eastProj = dot( vecSC, E );
  upProj = dot( vecSC, U );
  
  range = norm( vecSC );
  azimuth = atan2d( eastProj, northProj );
  elevation = asind( upProj / range );
  if elevation >= 10
    [ dateString, timeUTHours ] = fromJulianDate( time );
    timePSTHours = timeUTHours - 8;
    if timePSTHours < 0
      timePSTHours = timePSTHours + 24;
      dateString = datestr( datenum(dateString) - 1 );
    end
    h = floor( timePSTHours );
    m = floor( 60 * ( timePSTHours - h ) );
    s = 60 * ( ( 60 * ( timePSTHours - h ) ) - m );
    fprintf( "%s %02d:%02d azimuth=%g elevation=%g range=%g\n", ...
    dateString, h, m, azimuth, elevation, range );
  end
end

end

%============================================================

function r = locToECEF( Lo, La )
%LOCTOECEF Find ECEF coordinates of specified location
%on Earth's surface

if nargin < 2
  Lo = -118.2982;
  La = 34.0209;
end

R0 = physicalConstant( "R0Earth" );

x = R0 * cosd(La) * cosd(Lo);
y = R0 * cosd(La) * sind(Lo);
z = R0 * sind(La);

r = [ x, y, z ];

end

%============================================================

function [ N, E, U ] = localNEU( Lo, La )
%LOCALNEU Find the local north, east and up vectors (ECEF)
%at a location on Earth's surface

if nargin < 2
  Lo = -118.2982;
  La = 34.0209;
end

N0 = [ 0,0,1 ];
E0 = [ 0,1,0 ];
U0 = [ 1,0,0 ];

q = qprod( rotationQZ(Lo), rotationQY(-La) );

N = qrotate( N0, q );
E = qrotate( E0, q );
U = qrotate( U0, q );

end
