function rECEF = findECEFLocation( elems, epoch, times )
%FINDECEFLOCATION Find the ECEF coordinates of the spacecraft
%location for given orbital elements defined at Julian date "epoch".
%Answer the coordinates at each time "times" (Julian date) as a vector. 

if nargin < 3
  times = epoch; % Find nadir position at epoch, if times not given
end

mu = physicalConstant('muEarth');
R0 = physicalConstant('R0Earth');
J2 = physicalConstant('J2Earth');

day = 86400;

rECEFArraySize = [ length(times) 3 ];
rECEF = zeros( rECEFArraySize );

e = elems;
[ a, ecc, Omega0, inc, omega0, theta ] = deal( e(1),e(2),e(3),e(4),e(5),e(6) );
elems;
a;

[dOmegaByDt, domegaByDt] = orbitalPerturbationRates( ...
    mu, R0, J2, a, ecc, inc );
                              
P = 2*pi * sqrt( a^3 / mu ); % Orbital period in seconds

% Find the elapsed time between epoch and the previous periapsis passage
tSincePeriapsisEpoch = timeSincePeriapsis( theta, a, ecc, mu ); % Seconds

for i=1:length(times)
    
  t = times(i);

  Dt = (t - epoch) * day; % In seconds, how long since the epoch

  Omega = Omega0 + Dt*dOmegaByDt; % Correct for perturbations
  omega = omega0 + Dt*domegaByDt; 
  if 0 && i==1
    fprintf( 'Nodal regression: total %g (rate %g deg/day)\n', Omega - Omega0, ...
             dOmegaByDt*day ) ;
    fprintf( 'Apsidal rotation: total %g (rate %g deg/day)\n', omega - omega0, ...
             domegaByDt*day );
  end
    
  tSincePeriapsis = tSincePeriapsisEpoch + Dt;
    
  theta = trueAnomalyAtTime( tSincePeriapsis, a, ecc, mu );
    
  r = a * (1 - ecc^2 ) / (1 + ecc * cosd(theta) );
  rvecOrbit = [ r * cosd(theta), r * sind(theta), 0 ]';
  % rvecOrbit is the same as [ x_o, y_o, z_o ] in the notes

  % Transform to Earth-centered inertial
  orbitToECI = ...
      qprod( rotationQZ( Omega ), ...
             qprod( rotationQX( inc ), ...
                    rotationQZ( omega ) ) );
  rvecECI = qrotate( rvecOrbit, orbitToECI );

  % Transform to Earth-centered Earth-fixed -- here is where the time
  % is used
  rvecECEF = ECItoECEF( rvecECI, t );
  rECEF( i, : ) = rvecECEF;
    
  %Lo(i) = atan2d( rvecECEF(2), rvecECEF(1) );
  %La(i) = asind( rvecECEF(3) / norm(rvecECEF) );
  %rvec(i) = r;

end

end
