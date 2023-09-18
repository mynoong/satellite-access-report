function vecResult = qrotate(v, Q)
% qrotate gives the vector vec after rotating vector v, using quaternion Q

% v can be either a single vector or
% a matrix in which each row is a vector to be rotated.
% Q can be either a single quaterninon or
% a matrix in which each row is a quaternion for rotation.
% If both v and Q are a matrix, they must have the same number of rows,
% and each vector is rotated with different quaternion.
% If v is a matrix, but Q is a single quaternion,
% all vectors in v are rotated with Q.


vsize = size(v);
vrow = vsize(1);
vcol = vsize(2);
Qsize = size(Q);
Qrow = Qsize(1);
Qcol = Qsize(2);

if vcol ~= 3
  disp('[qrotate] Vector must have three elements.');
  return;
end
if Qcol ~= 4
  disp('[qrotate] Quaternion must have four elements.');
  return;
end
if (Qrow ~= 1) && (Qrow ~= vrow)
  disp(['[qrotate] Vector matrix and quaternion matrix must have ' ...
        'the same number of rows.']);
  return;
end


vecResult = zeros(vsize);

for i = 1:vrow
  vec = v(i, :); % vec is the vector to be rotated from the matrix v
  if Qrow > 1
    quat = Q(i, :); % quat is the quaternion used for rotation
  else
    quat = Q; % same quat is applied if Q is a single quaternion
  end

  qconj = conjugateOfQ(quat);
  qvec = qproduct(quat, qproduct(vec, qconj)); % rotation
  vecResult(i, :) = qvec(1:3); % extracts a vector part from quaternion
end


end
