function [dateString, hoursUT] = fromJulianDate(julianDate)
%fromJulianDate gives the date string and UT time in hours corresponding
%to a Julian date
%
%Example: if julianDate = 2452725.208333, then dateString='26-Mar-2003' and
%hoursUT = 17

delta = julianDate - 2452724.500000;
deltaDays = floor( delta );
dateString = datestr(datenum('26-Mar-2003') + deltaDays);
hoursUT = 24 * (delta - deltaDays);

end

