function prod = qprod( p, q )
%QPROD Quaternion product of p and q
%p and q can be vectors or quaternions

p = qFromVector( p );
q = qFromVector( q );

px = p(1);
py = p(2);
pz = p(3);
pw = p(4);

qx = q(1);
qy = q(2);
qz = q(3);
qw = q(4);

prod = [ ...
    pw*qx + px*qw + py*qz - pz*qy, ...
    pw*qy + py*qw + pz*qx - px*qz, ...
    pw*qz + pz*qw + px*qy - py*qx, ...
    pw*qw - px*qx - py*qy - pz*qz ...
    ];

end
