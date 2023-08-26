function q = rotationAsQ( direction, angle )
%ROTATIONASQ Answer the quaternion representing rotation
%about direction (3-vector) by angle (degrees)

direction = reshape( direction, [1,3] ); % Make sure it's a row vector
direction = direction / norm(direction); % Make it a unit vector
q = [ direction*sind(angle/2), cosd(angle/2) ];

end
