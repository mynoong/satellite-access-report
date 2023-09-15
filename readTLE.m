function [a, e, Omega, i, omega, theta, epoch] = readTLE(filename)
%readTLE parses a text file containing a two-line element set.
%Answer the classical orbital elements and the epoch.
%Units: km, degrees, Julian date

s = fileread(filename);
ss = splitlines(s);
fprintf( 'Reading TLE for spacecraft %s\n', char(ss(1)) );

line1 = char(ss(2));
line2 = char(ss(3));

fields1 = split(line1);
fields2 = split(line2);

epoch = epochFromTLE();
%fprintf( 'Epoch: %12.6f\n', epoch );

i = numFromCellArray(fields2(3));

Omega = numFromCellArray(fields2(4));

e = eccentricityFromTLE();

omega = numFromCellArray(fields2(6));

M = numFromCellArray(fields2(7));
theta = trueAnomalyFromMeanAnomaly(e, M);

nRevsPerDay = numFromCellArray(fields2(8));
a = semimajorAxisFromRevsPerDay(nRevsPerDay);

function epoch = epochFromTLE()
tField = char( fields1(4) );
yearLast2 = str2num( tField(1:2) );

if yearLast2 > 56
  year = [ '19' tField(1:2) ]; % 1999 or before
else
  year = [ '20' tField(1:2) ]; % 2000 or after
end

day = str2num( tField(3:end) );
dateString = [ '1-Jan-' year ];
epoch = toJulianDate(dateString) + day - 1;
%epoch = epoch - 0.01143; % ?? This makes it right, but why?
end

function e = eccentricityFromTLE()
e = str2num( [ '0.' char(fields2(5)) ] );
end

function n = numFromCellArray(field)
n = str2num( char(field) );
end

function a = semimajorAxisFromRevsPerDay( nRevsPerDay )
J2 = physicalConstant("J2Earth");
R0 = physicalConstant("R0Earth");
mu = physicalConstant("muEarth");

P = 86400 / nRevsPerDay; 
n0 = 2 * pi / P;
a0 = ( mu * (P / (2*pi))^2 )^(1/3);
dn = 3 * n0 * J2 * R0^2 * (3 * cosd(i)^2 - 1) / (4 * a0^2 *(1 - e^2)^1.5);
n = n0 + dn; 
a = (mu / n^2)^(1/3);
end

end

    


