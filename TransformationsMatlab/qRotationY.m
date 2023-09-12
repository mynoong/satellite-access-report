function q = qRotationY(angle)
%qRotationY gives the quaternion representing a rotation
%about the y-axis by angle (degrees)

q = qRotation([0, 1, 0], angle);

end
