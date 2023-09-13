function r = lolaToECEF( Lo, La )
%lolaToECEF finds ECEF coordinates of specified location
%on Earth's surface given by Lo (longitude) and La(latitude)

if nargin < 2
  % Location of Seoul or N Seoul Tower 
  Lo = 126.9882;
  La = 37.5512;
end

R0 = physicalConstant("R0Earth");

x = R0 * cosd(La) * cosd(Lo);
y = R0 * cosd(La) * sind(Lo);
z = R0 * sind(La);
r = [x, y, z];

end
