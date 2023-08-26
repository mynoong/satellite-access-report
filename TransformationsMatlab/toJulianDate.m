function julianDate = toJulianDate( dateString, timeUTHours )
%TOJULIANDATE Answer the Julian date corresponding to a date string
%and a UT time in hours
%
%Example: if dateString='29-Jan-2011' and timeUTHours = 17, then
% julianDate = 2455591.208333

if nargin < 2
    timeUTHours = 0;
end

if nargin < 1
    dateString = datestr( date );
end

deltaDays = datenum( dateString ) - datenum( '29-Jan-2011' );
julianDate = 2455590.500000 + deltaDays + timeUTHours/24;

