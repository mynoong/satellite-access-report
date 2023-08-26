function out = ConvertRotationalRepresentation( in, f1, f2 )
%CONVERTROTATIONALREPRESENTATION Convert from one rotational
%representation to another
%in: Input matrix (Euler, RPY, Rbi, quaternion)
%f1: Input representation( 1=Euler angles, 2=RPY, 3=Rbi, 4=quaternion)
%f2: Output representation
%Example: To convert Euler (phi,theta,psi) to Rbi (transformation
%matrix):
%eulerAngles = [ phi theta psi ];
% Rbi = ConvertRotationalRepresentation( eulerAngles, 1, 3 )
%
% All angles in degrees
% Euler rotation order: v_rotated = R_z(phi) R_x(theta) R_z(psi) v
% RPY rotation order: v_rotated = R_z(Y) R_y(P) R_x(R)
% Quaternion convention: q = [ qx qy qz qw ], |q| = 1

% These name the representations
EulerAngles = 1;
RPY = 2;
Rbi = 3;
Quat = 4;

if f1 == f2
  
  out = in; % Same representation, no need to convert

else
  
  % Convert all input formats to quaternion, then convert the
  % quaternion as needed
  if f1 == EulerAngles
    
    phi = in(1);
    theta = in(2);
    psi = in(3);
    
    t2 = theta/2;
    st2 = sind(t2);
    ct2 = cosd(t2);
    pt = ( phi + psi ) / 2; 
    mt = ( phi - psi ) / 2;
    q = [ cosd(mt)*st2  sind(mt)*st2  sind(pt)*ct2  cosd(pt)*ct2 ];

  elseif f1 == RPY
    
    R = in(1);
    P = in(2);
    Y = in(3);
    
    R2 = R/2;
    P2 = P/2;
    Y2 = Y/2;
    cr = cosd(R2);
    sr = sind(R2);
    cp = cosd(P2);
    sp = sind(P2);
    cy = cosd(Y2);
    sy = sind(Y2);
    q = [ ...
        sr*cp*cy - cr*sp*sy, ...
        cr*sp*cy + sr*cp*sy, ...
        -sr*sp*cy + cr*cp*sy,...
        cr*cp*cy + sr*sp*sy ...
    ];
    
  elseif f1 == Rbi
    
    R = in;
    
    w = sqrt( 1 + R(1,1) + R(2,2) + R(3,3) ) / 2;
    if abs( w ) > 0.1 
      % Not close to divide by zero
      x = ( R(3,2) - R(2,3) ) / ( 4*w );
      y = ( R(1,3) - R(3,1) ) / ( 4*w );
      z = ( R(2,1) - R(1,2) ) / ( 4*w );
      q = [ x y z w ];
    else
      % disp( 'q from matrix, w close to zero' )
      x = ( R(3,2) - R(2,3) ) / 4;
      y = ( R(1,3) - R(3,1) ) / 4;
      z = ( R(2,1) - R(1,2) ) / 4;
      mag = sqrt( x*x + y*y + z*z + w*w*w*w );
      q = [ x/mag y/mag z/mag w ];
    end
      
  elseif f1 == Quat
    
    q = in;
  
  else

    disp( 'Bad rotational representation! Must be 1, 2, 3 or 4' );
  
  end
  
  % Now have quaternion, convert to the desired representation
  out = qConvertToAnotherRepresentation( q, f2 );

end

end

function out = qConvertToAnotherRepresentation( q, f2 )
EulerAngles = 1;
RPY = 2;
Rbi = 3;
Quat = 4;

x = q(1);
y = q(2);
z = q(3);
w = q(4);

if f2 == EulerAngles
  
  phi = atan2d(z,w) + atan2d(y,x);
  theta = 2*asind( sqrt( x^2 + y^2 ) );
  psi = atan2d(z,w) - atan2d(y,x);
  out = [ phi theta psi ];
  
elseif f2 == RPY
  
  % see http://graphics.wikia.com/wiki/Conversion_between_quaternions_and_Euler_angles
  R = atan2d( 2*(w*x+y*z), 1 - 2*x*x - 2*y*y );
  P = asind( 2*(w*y - z*x ) );
  Y = atan2d( 2*( w*z + x*y ), 1 - 2*y*y - 2*z*z );
  out = [ R P Y ];
  
elseif f2 == Rbi
  
  out = [ ...
      [ w*w + x*x - y*y - z*z, 2*( x*y - w*z ), 2*( x*z + w*y ) ]; ...
      [ 2*( x*y + w*z ), w*w - x*x + y*y - z*z, 2*( y*z - w*x ) ]; ...
      [ 2*( x*z - w*y ), 2*( y*z + w*x ), w*w - x*x - y*y + z*z ]; ...
      ];
  
elseif f2 == Quat
  
  out = q;
  
else
  disp( 'Bad rotational representation! Must be 1, 2, 3 or 4' );
end

end
