function theta = trueAnomalyAtTime(tSincePeriapsis, a, e, mu, dn)

if nargin < 5
    dn = 0;
end
n = sqrt(mu / a^3) + dn; % true anomaly with correction dn

tsize = size(tSincePeriapsis);
theta = zeros(tsize);

P = 2 * pi / n; % period of orbit
tArray = -P/2 + mod(tSincePeriapsis + P/2, P);
MArray = 360 * tArray / P; % Mean anomaly in degrees

% Solution of Kepler's equation for time since periapsis
eStar = e * 180 / pi;
tol = 1.0e-6;

for i = 1:length(tArray)
    M = MArray(i);

    E = M + e * sind(M);
    DeltaM = 1.0e10;
    while abs(DeltaM) > tol
        DeltaM = M - (E - eStar * sind(E));
        DeltaE = DeltaM / (1 - e * cosd(E));
        E = E + DeltaE;
    end

    cosTheta = (cosd(E) - e) / (1 - e * cosd(E));
    theta(i) = sign(E) * acosd(cosTheta);
end

end
