function theta = trueAnomalyAtTime( tSincePeriapsis, a, ecc, mu, dn )

n = sqrt( mu / a^3 ); % Uncorrected mean motion
if nargin > 4
    n = n + dn; % Add J2 correction if supplied
end
P = 2*pi / n; % Period of orbit

theta = zeros( size(tSincePeriapsis ) );

t = -P/2 + mod( tSincePeriapsis + P/2, P );
Ms = 360 * t / P; % Mean anomaly in degrees

% Solution of Kepler's equation for time since periapsis
eccStar = ecc * 180/pi;
tol = 1.0e-6; 

for i=1:length(t)
    M = Ms(i);
    
    E = M + ecc * sind(M);
    DeltaM = 1.0e10;
    while abs(DeltaM) > tol
        DeltaM = M - ( E - eccStar*sind(E) );
        DeltaE = DeltaM / ( 1 - ecc*cosd(E) );
        E = E + DeltaE;
    end

    cosE = cosd(E);
    cosTheta = ( cosE - ecc ) / ( 1 - ecc*cosE );
    theta(i) = sign(E) * acosd(cosTheta);
end

    
           
       

