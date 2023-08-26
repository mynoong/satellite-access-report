function q = rotationQY( angle )
%ROTATIONQY Answer the quaternion representing a rotation
%about the y-axis by angle (degrees)

q = rotationAsQ( [0,1,0], angle );

end
