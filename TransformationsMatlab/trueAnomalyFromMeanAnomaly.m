function theta = trueAnomalyFromMeanAnomaly( ecc, MArray )

% Solution of Kepler's equation for time since periapsis
eccStar = ecc * 180/pi;
tol = 1.0e-6; 

for i=1:length(MArray)
    M = MArray(i);
    M = -180 + mod( M + 180, 360 );
    
    E = M + eccStar * sind(M);
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

    
           
       

