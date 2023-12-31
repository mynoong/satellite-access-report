function rECEFArray = findECEFLocation( elems, epoch, timeArray )
% findECEFLocation gives ECEF coordinates of spacecraft at the given time
% (in Julian date) from times array, given orbital elements elems and
% Julian date epoch where the elems are defined.
% A ECEF vector is provided at each time in timeArray.

if nargin < 3
  timeArray = epoch; % finds spacecraft's position at epoch without timeArray
end

mu = physicalConstant('muEarth');
R0 = physicalConstant('R0Earth');
J2 = physicalConstant('J2Earth');
a = elems(1);
e = elems(2);
Omega0 = elems(3);
i = elems(4);
omega0 = elems(5);
theta = elems(6);
day = 86400; % 1 julian day = 86400 seconds

[dOmegaDt, domegaDt] = orbitalPerturbationRates(mu, R0, J2, a, e, i);

n = sqrt(mu / a^3); % mean motion
P = 2 * pi / n; % Orbital period in seconds


% Find the elapsed time between epoch and the previous periapsis passage
tSincePeriapsisEpoch = timeSincePeriapsis(theta, a, e, mu); % seconds

%Initialize rECEFArray, the output
rECEFArraySize = [length(timeArray), 3];
rECEFArray = zeros(rECEFArraySize);

for k = 1:length(timeArray)
  t = timeArray(k);

  Dt = (t - epoch) * day; % time since the epoch, in seconds

  Omega = Omega0 + Dt * dOmegaDt; % Correct for perturbations
  omega = omega0 + Dt * domegaDt;

  % Find spacecraft's location on the orbit by r and theta
  % it does not consider the orbit's orientation yet.
  tSincePeriapsis = tSincePeriapsisEpoch + Dt;
  theta = trueAnomalyAtTime(tSincePeriapsis, a, e, mu);
  r = a * (1 - e^2) / (1 + e * cosd(theta));
  rvecOrbit = [r * cosd(theta), r * sind(theta), 0];

  % Transform rvecOrbit to Earth-centered inertial
  orbitToECI = ...
      qproduct( rotationAsQZ(Omega), ...
             qproduct( rotationAsQX(i), ...
                    rotationAsQZ(omega) ) );
  rvecECI = qrotate(rvecOrbit, orbitToECI);

  % Transform ECI to Earth-centered Earth-fixed at the given time t
  rvecECEF = ECItoECEF(rvecECI, t);

  rECEFArray(k, :) = rvecECEF;

  %in case of longitude/latitude is needed
  %Lo(i) = atan2d(rvecECEF(2), rvecECEF(1));
  %La(i) = asind(rvecECEF(3) / norm(rvecECEF));
  %rArray(i) = r;

end

end
