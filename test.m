function test()
% This is an example of running accessReport.m for desired satellite,
% ground station, and times.
% Satellite: International Space Station (ISS)
% Ground Station: N Seoul Tower (or Namsan Observatory)
% Time: 17-Sep-2023 00:00:00 to 29-Sep-2023 00:00:00,
%       10 seconds interval, in KST

Lo = 126.9882
La = 37.5512
hoursFromUT = 9
tleFilename = 'iss.tle'
txtFilename = 'accessReport_iss_Seoul.txt'

t1 = toJulianDate('18-Sep-2023 00:00:00');
t2 = toJulianDate('21-Sep-2023 00:00:00');
disp(fromJulianDate(t1))
disp(fromJulianDate(t2))
second = 1 / 86400;
times = t1:second:t2;

accessReport(Lo, La, hoursFromUT, tleFilename, txtFilename, times);

end
