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
    dateString = '10-Sep-2023 00:00:00';
end
2
format long;

dateStringNoHours = datetime(dateString, 'Format', 'dd-MMM-yyyy');
stringHours = datetime(dateString, 'Format', 'HH:mm:ss');

%deltaDays = datenum(dateStringNoHours) - datenum('26-Mar-2023');
delta = daysact('26-Mar-2023', dateStringNoHours);
deltaDays = floor(delta);
[h, m, s] = hms(stringHours);

julianDate = 2460029.500000 + deltaDays + h/24 + m/1440 + s/86400 ...
              - hoursFromUT/24;

end
