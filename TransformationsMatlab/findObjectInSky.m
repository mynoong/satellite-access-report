function [az,el,hecLo,hecLa,r] = ...
    findObjectInSky( index, tJulian, obsLo, obsLa )
%FINDOBJECTINSKY Find the azimuth and elevation of the object
%labeled by index (0=Sun, 1=Mercury,...,9=Pluto), at Julian date
%tJulian, from observer coordinates obsLo, obsLa on Earth's surface
%
%All angles in degrees
%
%Also returns the heliocentric coordinates of the object
%2020-02-03: Now vectorized! Any input can be an array

dims = [ length(index), length(tJulian), length(obsLo), length(obsLa) ...
         ];

az = zeros( dims );
el = zeros( dims );
hecLo = zeros( dims );
hecLa = zeros( dims );
r = zeros( dims );

for ii = 1:length(index)
  i = index(ii);
  for it = 1:length(tJulian)
    t = tJulian(it);
    for iLo = 1:length(obsLo)
      lo = obsLo(iLo);
      for iLa = 1:length(obsLa)
        la = obsLa(iLa);
        [ azV, elV, hecLoV, hecLaV, rV ] = ...
            findObjectInSkySingleValue( i, t, lo, la );
        az(ii,it,iLo,iLa) = azV;
        el(ii,it,iLo,iLa) = elV;
        hecLo(ii,it,iLo,iLa) = hecLoV;
        hecLa(ii,it,iLo,iLa) = hecLaV;
        r(ii,it,iLo,iLa) = rV;
      end
    end
  end
end

end
          
        

function [az,el,hecLo,hecLa,r] = ...
    findObjectInSkySingleValue( index, tJulian, obsLo, obsLa )

% Earth's location in Solar System
[ hecLoEarth, hecLaEarth, rEarth ] = planetLocation( 3, tJulian );

% Object's location in Solar System
if index == 0 % Sun
  hecLo = 0;
  hecLa = 0;
  r = 0;
else
  [ hecLo, hecLa, r ] = planetLocation( index, tJulian );
  if index == 3 % Earth
      az = 0;
      el = -90; % Look down to find the Earth!
      return;
  end
end

earthTilt = physicalConstant( 'earthTilt' );

% Find Cartesian coordinates of target in heliocentric inertial coordinates
x = r * cosd(hecLa) * cosd(hecLo);
y = r * cosd(hecLa) * sind(hecLo);
z = r * sind(hecLa);
vHI = [ x y z ]';

% Find Cartesian coordinates of Earth in heliocentric inertial coordinates
xEarth = rEarth * cosd(hecLaEarth) * cosd(hecLoEarth);
yEarth = rEarth * cosd(hecLaEarth) * sind(hecLoEarth);
zEarth = rEarth * sind(hecLaEarth);
vEarth = [ xEarth yEarth zEarth ]';

% Transform to geocentric inertial coordinates (x' = V.E.)
tiltQuaternion = rotationQX( earthTilt );
vECI = qrotate( vHI - vEarth, tiltQuaternion );

% Transform to ECEF
vECEF = ECItoECEF( vECI, tJulian );


% Transform to observer coordinates (x''' = horiz N, y''' = horiz E, z'' =
% down)
q = qprod( rotationQY( obsLa ), rotationQZ( -obsLo ) );
vPPP = qrotate( vECEF, q );
xPPP = vPPP(1);
yPPP = vPPP(2);
zPPP = vPPP(3);

% Find azimuth and elevation
az = mod( atan2d(yPPP,zPPP), 360 );
el = asind( xPPP / norm(vPPP) );

end
