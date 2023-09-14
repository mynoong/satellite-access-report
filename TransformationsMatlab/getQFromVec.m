function q = getQFromVec(v)
%getQFromVec transforms vector v into the quaternion with vector part v 
%and scalar part 0

if length(v) == 4
  q = v; % v is alreay a quaternion
elseif length(v) == 3
  q = [v(1), v(2), v(3), 0];
else
  disp('[getQFromVec] v cannot be transformed into quaternion format!')
  disp(v)
end
  
end
