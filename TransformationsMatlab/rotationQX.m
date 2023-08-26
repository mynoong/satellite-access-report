function q = rotationQX( angle )
%ROTATIONQX Answer the quaternion representing a rotation
%about the x-axis by angle (degrees)

q = rotationAsQ( [1,0,0], angle );

end
