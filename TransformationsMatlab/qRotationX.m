function q = qRotationX(angle)
%qRotationX gives the quaternion representing a rotation
%about the X-axis ([1, 0, 0]) by angle (degrees)

q = qRotation([1, 0, 0], angle);

end
