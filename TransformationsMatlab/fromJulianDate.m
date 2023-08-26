function [ dateString, timeUTHours ] = fromJulianDate( julianDate  )
%FROMJULIANDATE Answer the date string and UT time in hours corresponding
%to a Julian date
%
%Example: if julianDate = 2455591.208333, then dateString='29-Jan-2011' and
%timeUTHours = 17

delta = julianDate - 2455590.500000;
deltaDays = floor( delta );
dateString = datestr( datenum( '29-Jan-2011' ) + deltaDays );
timeUTHours = 24 * ( delta - deltaDays );


