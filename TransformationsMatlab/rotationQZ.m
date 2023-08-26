function q = rotationQZ( angle )
%ROTATIONQZ Answer the quaternion representing a rotation
%about the z-axis by angle (degrees)

q = rotationAsQ( [0,0,1], angle );

end
