function theta = meanAnomalyToTrueAnomaly(e, MArray)

% Solution of Kepler's equation for time since periapsis
eStar = e * 180 / pi;
tol = 1.0e-6; 

for i = 1:length(MArray)
    M = MArray(i);
    M = -180 + mod(M + 180, 360);
    
    E = M + eStar * sind(M);
    DeltaM = 1.0e10;
    while abs(DeltaM) > tol
      DeltaM = M - (E - eStar*sind(E));
      DeltaE = DeltaM / (1 - e*cosd(E));
      E = E + DeltaE;
    end
    
    cosTheta = (cosd(E) - e) / (1 - e * cosd(E));
    theta(i) = sign(E) * acosd(cosTheta);
end

    
           
       

