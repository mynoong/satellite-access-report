function q = qFromVector( v )
%QFROMVECTOR Answer the quaternion with vector part v and scalar
%part 0

if length( v ) == 4
  q = v; % Already a quaternion
elseif length( v ) == 3
  q = [ v(1) v(2) v(3) 0 ];
else
  disp( 'qFromVector: v is not a vector!' )
  v
end
