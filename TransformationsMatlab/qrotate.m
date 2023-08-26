function vr = qrotate( v, Q )
%QROTATE Rotate v using quaternion Q
% v can be a matrix where each column is a vector to be rotated
% Q can be a matrix where each row is a quaternion
%   In this case each vector is rotated with different quaternion

sv = size(v);
nr = sv(1);
if nr == 1
  v = v'; % Change a row vector into a column vector
elseif nr ~= 3
  v = v';
end

sv = size(v);
nr = sv(1);
nc = sv(2);
if nr ~= 3
  disp( 'qrotate: Must have three elements in vector! Aborting' );
  return
end

sQ = size( Q );
nqr = sQ(1);
nqc = sQ(2);
if nqc ~= 4
  disp( 'qrotate: Quaternion must have 4 columns! Aborting' );
  return;
end
if (nqr ~= 1) && (nqr ~= nc)
  disp( ['qrotate: Quaternion matrix must have #rows equal to #vectors. ' ...
         'Aborting!'] );
  return;
end

vr = zeros( sv );

Qc = qconj( Q );

for ic = 1:nc
  vec = v(:,ic); % vec is the ic'th column vector
  if nqr > 1
    q = Q(ic,:); % take the ic'th row of Q
  else
    q = Q;
  end
  qc = qconj( q );
  vecrot = qprod( q, qprod( vec, qc ) );
  vr(:,ic) = vecrot(1:3); % Put the rotated column vector in the output
end

end
