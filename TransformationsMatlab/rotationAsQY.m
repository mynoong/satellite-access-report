function q = rotationAsQY(angle)
%rotationAsQY gives the quaternion representing a rotation
%about the Y-axis ([0, 1, 0]) by angle (degrees)

q = rotationAsQ([0, 1, 0], angle);

end
