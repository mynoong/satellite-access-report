function accessReport(Lo, La, hoursFromUT, tleFilename, txtFilename, times)
format long;

minute = 1 / 24 / 60;

if nargin < 1
  % Location of Seoul or N Seoul Tower
  Lo = 126.9882;
  La = 37.5512;
  hoursFromUT = 9;
  tleFilename = 'iss.tle';
  txtFilename = 'accessReport_iss_Seoul.txt';

  % Date string is based on KST, so toJulianDate() not only converts
  % to juliandate but takes time difference into account too.
  t1 = toJulianDate( '18-Sep-2023 00:00:00', 9 );
  t2 = toJulianDate( '28-Sep-2023 00:00:00', 9 );
  times = t1:minute:t2;
end


fileID = fopen(txtFilename, 'wt');

fprintf( fileID, "(a) ECEF coordinates of ground station:\n" );
rGS = LoLaToECEF(Lo, La);
fprintf( fileID, "[ x y z ] = [ %6.2f  %6.2f  %6.2f ]\n\n", rGS);

fprintf( fileID, "(b) North, east, up vectors from ground station:\n" );
[N, E, U] = localNEU(Lo, La);
fprintf( fileID, "North [ x y z ] = [ %6.4f  %6.4f  %6.4f ]\n", N);
fprintf( fileID, "East [ x y z ] = [ %6.4f  %6.4f  %6.4f ]\n", E);
fprintf( fileID, "Up [ x y z ] = [ %6.4f  %6.4f  %6.4f ]\n\n", U);

[a, e, Omega, i, omega, theta, epoch] = readTLE(tleFilename);
elems = [a, e, Omega, i, omega, theta];

for time = times
  rSat = findECEFLocation(elems, epoch, time);
  vecSat = rSat - rGS;
  northProj = dot(vecSat, N);
  eastProj = dot(vecSat, E);
  upProj = dot(vecSat, U);

  range = norm(vecSat);
  azimuth = atan2d(eastProj, northProj);
  elevation = asind(upProj / range);

  if elevation >= 10.0
   dateString = fromJulianDate(time, hoursFromUT);
   fprintf( fileID, "%s  azimuth= %4.1f  elevation= %3.1f  range= %5.1f\n", ...
             dateString, azimuth, elevation, range );
  end
end

fclose(fileID);

end


