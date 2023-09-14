function rECEF = ECItoECEF(rECI, tJulian)
%ECItoECEF converts a vector in Earth-centered inertial (ECI)
%coordinates to Earth-centered Earth-fixed (ECEF) coordinates
%at Julian date tJulian

alpha = angleOfVernalEquinox(tJulian);
qECItoECEF = rotationAsQZ(-alpha);
rECEF = qrotate(rECI, qECItoECEF);

end
