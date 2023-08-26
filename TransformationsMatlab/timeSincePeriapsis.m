function timeArray = timeSincePeriapsis( thetaArray, a, ecc, mu, dn )
%TIMESINCEPERIAPSIS Answer the time in elliptical orbit
% thetaArray: True anomaly in degrees (can be array)
% a: Semimajor axis
% ecc: eccentricity
% mu: Gravitational parameter, in same units as a

% Do calculation for each value of theta given

if nargin < 5
  dn = 0;
end
if nargin < 4
  mu = physicalConstant( 'muEarth' );
end

a = abs(a); 
n = sqrt( mu / a^3 ) + dn; % mean motion

T = 2*pi / n; % only meaningful if orbit is closed

for i=1:length( thetaArray )

    theta = thetaArray(i);
    
    if ecc > 1
        
        % Use formulas for hyperbolic orbit
        
        if theta < 0
            sign = -1;
            theta = -theta;
        else
            sign = 1;
        end
        F = acosh( (ecc + cosd(theta))/( 1 + ecc*cosd(theta) ) );
        t = sign * ( ecc*sinh(F) - F ) / n;
        
    else

        % First count how many times spacecraft has gone around already since
        % theta=0
        numTimes = 0;
        while theta > 180
            theta = theta - 360;
            numTimes = numTimes + 1;
        end

        % Now count how many times spacecraft will go around before nu=1
        while theta < -180
            theta = theta + 360;
            numTimes = numTimes - 1;
        end

        % Now theta is between -180 and 180
        % If it is negative, make it positive but remember it was negative
        if theta < 0
            sign = -1;
            theta = -theta;
        else
            sign = 1;
        end

        % Eccentric anomaly
        cosEccAnom = (ecc + cosd(theta)) / ( 1 + ecc*cosd(theta));
        EccAnom = acos( cosEccAnom ); % note: must be in radians

        % Time given by formula valid from 0 to pi
        t = ( EccAnom - ecc * sin(EccAnom) ) / n;

        % Now correct in case nu was originally not between 0 and 180
        t = sign*t + numTimes*T;
        
    end

    timeArray(i) = t;

end

