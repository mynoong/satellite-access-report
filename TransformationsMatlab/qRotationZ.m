function q = qRotationZ(angle)
%qRotationZ gives the quaternion representing a rotation
%about the Z-axis ([0, 0, 1]) by angle (degrees)

q = qRotation([0, 0, 1], angle);

end
