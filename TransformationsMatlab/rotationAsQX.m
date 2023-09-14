function q = rotationAsQX(angle)
%rotationAsQX gives the quaternion representing a rotation
%about the X-axis ([1, 0, 0]) by angle (degrees)

q = rotationAsQ([1, 0, 0], angle);

end
