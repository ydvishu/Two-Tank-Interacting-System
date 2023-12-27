function inv_lapt = I_laplace_10per(t)
syms s;
inv_lapt = ilaplace((4*1.6)/(15*s^3+50*s^2+24*s),s,t);
