clc

A = [0 1 0 0;0 0 1 0; 0 0 0 1;0 0 0 -5];
B = [0;0;0;17];
C = [1 0 0 0];
D = 0;

sys = ss(A,B,C,D);
E = eig(A);

P = [-40-18.22i -40+18.22i -60 -80];
K = place(A,B,P);

Acl = A - B*K;
Ecl = eig(Acl);
syscl = ss(Acl,B,C,D);
step(syscl);

Kdc = dcgain(syscl);
Kr = 1 / Kdc;
syscl_sc = ss(Acl,B*Kr,C,D);
[y, t] = step(syscl_sc);
[num , den] = ss2tf(Acl,B*Kr,C,D);
G = tf(num , den);

[num1 , den1] = ss2tf(A,B,C,D);
P = tf(num1 , den1);
C = G/(P-G*P);
% Calculate step response characteristics using stepinfo
info= stepinfo(y,t);
step(syscl_sc);
disp('info computed via State feedback:') 
info


