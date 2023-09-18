function dateString = fromJulianDate(julianDate, hoursFromUT)
%fromJulianDate gives the date string and UT time in hours corresponding
%to a Julian date (does not care about time difference among locations)
%
% Example: if julianDate = 2452725.208333,
% then dateString = '26-Mar-2003 17:00:00.000'

if nargin < 2
    hoursFromUT = 0;
end

if nargin < 1
    julianDate = 2460197.500000;
end

delta = julianDate - 2452724.500000;
deltaDays = floor( delta );

deltaHMS = 24 * (delta - deltaDays);
deltaHours = floor(deltaHMS);
deltaMinutes = floor( 60 * (deltaHMS - deltaHours) );
deltaSeconds = 60 * ( 60 * (deltaHMS - deltaHours) - deltaMinutes );

tref = datetime('26-Mar-2003 00:00:00.000');
dateString = tref + days(deltaDays) + hours(deltaHours) ...
          + minutes(deltaMinutes) + seconds(deltaSeconds);

% take time difference into account
dateString = dateString + hours(hoursFromUT);

end

