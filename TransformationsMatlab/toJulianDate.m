function julianDate = toJulianDate(dateString, hoursFromUT)
%toJulianDate gives the Julian date from a date string
%(dd-mmm-yyyy hh:mm:ss) at desired location - and hoursFromUT 
%(time difference from UT) must be given

% Ex) if dateString = '26-Mar-2003 13:15:00' and hoursFromUT = 9, 
% then julianDate = 2452724.677083

if nargin < 2
    hoursFromUT = 0;
end

if nargin < 1
    dateString = '10-Sep-2023 00:00:00'
end

t = datetime(dateString, 'InputFormat', 'dd-mmm-yyyy hh:mm:ss');
deltaDays = datenum(t) - datenum('26-Mar-2003');
julianDate = 2452724.500000 + deltaDays - hoursFromUT/24;

end
