function BS = BlackScholes(S0, K, r, T, current_sigma)
    
d1 = (log(S0/K) + (r + (current_sigma^2)/2)*T) / (current_sigma*sqrt(T));
d2 = d1 - current_sigma*sqrt(T);

BS = S0*normcdf(d1) - K*exp(-r*T)*normcdf(d2);

end
