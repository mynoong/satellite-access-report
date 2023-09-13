function [ a, ecc, Omega, inc, omega, theta, epoch ] = readTLE( filename )
%READTLE Parse a text file containing a two-line element set.
%Answer the classical orbital elements and the epoch.
%Units: km, degrees, Julian date

s = fileread( filename );
ss = splitlines( s );
fprintf( 'Reading TLE for spacecraft %s\n', char( ss(1) ) );

line1 = char( ss(2) );
line2 = char( ss(3) );

fields1 = split( line1 );
fields2 = split( line2 );

epoch = epochFromTLE();
%fprintf( 'Epoch: %12.6f\n', epoch );
inc = numFromCellArray( fields2(3) );
Omega = numFromCellArray( fields2(4) );
ecc = eccentricityFromTLE();
omega = numFromCellArray( fields2(6) );
M = numFromCellArray( fields2(7) );
theta = trueAnomalyFromMeanAnomaly( ecc, M );
nRevsPerDay = numFromCellArray( fields2(8) );
P = 86400 / nRevsPerDay;
mu = physicalConstant( 'muEarth' );
%a = ( mu * (P/(2*pi))^2 )^(1/3);
a = semimajorAxisFromRevsPerDay( nRevsPerDay )

function epoch = epochFromTLE()
tField = char( fields1(4) );
%fprintf( 'Epoch string %s\n', tField );
yearLast2 = str2num( tField(1:2) );
if yearLast2 > 56
  year = [ '19' tField(1:2) ]; % 1999 or before
else
  year = [ '20' tField(1:2) ]; % 2000 or after
end
day = str2num( tField(3:end) );
dateString = [ '1-Jan-' year ];
epoch = toJulianDate( dateString ) + day - 1;
%epoch = epoch - 0.01143; % ?? This makes it right, but why?
end

function ecc = eccentricityFromTLE()
ecc = str2num( [ '0.' char(fields2(5)) ] );
end

function n = numFromCellArray( field )
n = str2num( char(field) );
end

function a = semimajorAxisFromRevsPerDay( nRevsPerDay )
J2 = physicalConstant( "J2Earth" );
R0 = physicalConstant( "R0Earth" );
mu = physicalConstant( "muEarth" );
P = 86400 / nRevsPerDay; % = 2 pi / n0
n0 = 2*pi / P;
a = ( mu * (P/(2*pi))^2 )^(1/3);
dn = 3*J2*R0^2 * n0 * ( 3*cosd(inc)^2 - 1) / ( 4*a^2*(1 - ecc^2)^1.5 );
n = n0 + dn; 
a = ( mu / n^2 )^(1/3);
end

end

    


