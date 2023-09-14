function q = rotationAsQ(axis, angle)
%rotationAsQ gives the quaternion representation of rotation given by
%axis (3-vector) and angle (degrees)

axis = reshape(axis, [1,3]); % Reshape into a row vector
axis = axis / norm(axis); % Make it a unit vector
q = [axis * sind(angle/2), cosd(angle/2)];

end
