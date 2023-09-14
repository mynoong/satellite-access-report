function alpha = angleOfVernalEquinox(tJulian)
%angleOfVernalEquinox gives the angle between the vernal equinox vector(x_i)
%to the ECEF x-axis at Julian date tJulian

siderealDay = physicalConstant('siderealDay');
earthTilt = physicalConstant('earthTilt');

% First, set the reference time in which Sun is in the plane of Prime Meridian,
% ECEF x-axis, so the observer at longitude 0 would see Sun directly to the south.
% And get the angle between reference time's ECEF x-axis and the fixed vernal
% equinox vector.
% reference time: March 17, 2021, 12:08:17.2 UT

% Earth's coordinate in heliocentric ecliptic at the reference time
HELo = 176.8287; 
HELa = 0.0001;

rEarthHE = [cosd(HELa) * cosd(HELo), cosd(HELa) * sind(HELo), sind(HELa)];
rSunHE = -rEarthHE;
HEtoECI = rotationAsQX(earthTilt);
rSunECI = qrotate(rSunHE, HEtoECI); % position of Sun in ECI coordinates
% x-y-plane projected vector of rSunECI is used below for the angle alpharef.
alpharef = atan2d(rSunECI(2), rSunECI(1));

% Second, add angles from reference time to the given Julian date using
% the fact that Earth rotates 360 degrees in 1 sidereal day.
% t: # of seconds since the reference time
t = (tJulian - 2459291.005755) * 86400;

alpha = alpharef + 360 * t / siderealDay; 

end
