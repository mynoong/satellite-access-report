function q = rotationAsQZ(angle)
%rotationAsQZ gives the quaternion representing a rotation
%about the Z-axis ([0, 0, 1]) by angle (degrees)

q = rotationAsQ([0, 0, 1], angle);

end
