function q = qRotationY(angle)
%qRotationY gives the quaternion representing a rotation
%about the Y-axis ([0, 1, 0]) by angle (degrees)

q = qRotation([0, 1, 0], angle);

end
