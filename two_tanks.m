function f= two_tanks(t,H)
% Initial Conditions 

a1 = 3;
a2 = 5;
c1 = 8;
c2 = 12;

% making the input variable global
global qi


% Given Differential Equations 
q1 = c1 * sqrt(H(1) - H(2));
q2 = c2 * sqrt(H(2));

dh1_dt = (qi-q1)/ a1;
dh2_dt = (q1-q2)/a2;

f= [dh1_dt, dh2_dt];
f=f';
end