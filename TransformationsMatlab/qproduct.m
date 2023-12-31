function prod = qproduct(p, q)
%qproduct gives a quaternion product of p and q,
%while p and q can be either vectors or quaternions

p = getQFromVec(p);
px = p(1);
py = p(2);
pz = p(3);
pw = p(4);

q = getQFromVec(q);
qx = q(1);
qy = q(2);
qz = q(3);
qw = q(4);

prod = [ ...
    px*qw + py*qz + pw*qx - pz*qy, ...
    py*qw + pz*qx + pw*qy - px*qz, ...
    pz*qw + px*qy + pw*qz - py*qx, ...
    pw*qw - px*qx - py*qy - pz*qz];

end
