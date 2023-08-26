function qtest
%QTEST Test quaternion routines
%Modeled after quaternion.py

k = [ 0 0 sind(15) cosd(15) ]
R = qToRotationMatrix( k )
q = qFromRotationMatrix( R, 1 )

disp( 'Next line is rotated by R to give following line' )
v = [ 1 0 0 ]'
vrot = R * v
disp('Next one: rotation is by quat, should be same' )
vr = qrotate( v, k )

