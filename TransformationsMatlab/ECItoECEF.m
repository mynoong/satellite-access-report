function vECEF = ECItoECEF( vI, tJulian )
%ECItoECEF Convert a vector in Earth-centered inertial (ECI)
%coordinates to Earth-centered Earth-fixed (ECEF) coordinates
%at Julian date tJulian

a = angleOfVernalEquinox( tJulian );
qECItoECEF = rotationQZ( -a );
vECEF = qrotate( vI, qECItoECEF );

end

