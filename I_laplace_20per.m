function inv_lapt = I_laplace_20per(t)
syms s;
inv_lapt = ilaplace((4*3.2)/(15*s^3+50*s^2+24*s),s,t);
