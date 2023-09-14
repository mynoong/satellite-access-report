function tArray = timeSincePeriapsis(thetaArray, a, e, mu, dn)
% timeSincePeriapsis gives the time taken for orbiting degrees of 
% true anomaly since periapsis
% thetaArray: True anomaly in degrees (can be array)
% a: Semimajor axis
% e: eccentricity        
% mu: Gravitational parameter, in same units as a
% dn: change in mean motion due to oblateness of the center planet/star
%     (related to J2 perturbation)

if nargin < 5
  dn = 0;
end

if nargin < 4
  mu = physicalConstant('muEarth');
end

n = sqrt(mu / (abs(a))^3) + dn; % mean motion

for i = 1:length(thetaArray)
  theta = thetaArray(i);

  if e > 1 % hyperbolic orbit case
    sign = 1;
    if theta < 0
      sign = -1;
      theta = -theta;
    end

    % formula for hypeerbolic eccentric anomaly in "radian"
    F = acosh( (e + cosd(theta)) / (1 + e * cosd(theta)) );
    t = sign * (e * sinh(F) - F) / n; % t is negative if theta < 0


  else % elliptical orbit case
  % Unlike hyperbolic orbit where -180 < theta < 180 degrees 
  % is in default manner, elliptical orbit can have any real number.
  % So the number of periods or times it orbitted are first calculated.
      
    nPeriods = 0
    % counts how many times has it gone around since theta = 0, periapsis
    while theta > 180
      theta = theta - 360;
      nPeriods += 1;
    end
    
    % counts how many times has it gone backward since theta = 0
    while theta < -180
      theta = theta + 360;
      nPeriods -= 1;
    end
    
    % theta is set between -180 and 180
    sign = 1;
    if theta < 0 % set sign = -1 to later make t negative
      sign = -1;
      theta = - theta;
    end

    % formula for eccentric anomaly in "radian"
    E = acos( (e + cosd(theta)) / (1 + e * cosd(theta)) );
    
    % t is negative if theta < 0. And negative theta isn't directly used
    % because the below formula is valid for 0 <= E <= pi.
    t = sign * (e * sin(E) - E) / n;

    t = t + nPeriods * (2 * pi / n); % including # of periods
        
  end

  tArray(i) = t;

end

end
