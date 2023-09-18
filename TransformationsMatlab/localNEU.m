function [N, E, U] = localNEU(Lo, La)
%localNEU finds the local north, east and up vectors (in ECEF)
%at a location on Earth's surface

if nargin < 2
% Location of Seoul or N Seoul Tower
  Lo = 126.9882;
  La = 37.5512;
end

N0 = [0, 0, 1];
E0 = [0, 1, 0];
U0 = [1, 0, 0];

q = qproduct( rotationAsQZ(Lo), rotationAsQY(-La) );

N = qrotate( N0, q );
E = qrotate( E0, q );
U = qrotate( U0, q );

end
