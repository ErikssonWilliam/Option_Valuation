function implicit_volatility = Implicit_sigma(BS, S0, K, r, tol, guess_sigma)

red_days = ['2024-12-24';'2024-12-25';'2024-12-26';'2024-12-31'; '2025-01-01';'2025-01-06'];
T = days252bus('2024-11-27', '2025-03-05', red_days);

CallOptionPrice = BlackScholes(S0, K, r, T/252, guess_sigma);

upper_sigma = 1;
lower_sigma = 0.01;
current_sigma = guess_sigma;

%nu kör vi intervallshalvering

while (abs(CallOptionPrice - BS) > tol)
    if CallOptionPrice < BS
        lower_sigma = current_sigma;
    else 
        upper_sigma = current_sigma;
    end
    current_sigma = (upper_sigma + lower_sigma) / 2;
    CallOptionPrice = BlackScholes(S0, K, r, T/252, current_sigma);
end

implicit_volatility = current_sigma;

end

function BS = BlackScholes(S0, K, r, T, current_sigma)
    
d1 = (log(S0/K) + (r + (current_sigma^2)/2)*T) / (current_sigma*sqrt(T));
d2 = d1 - current_sigma*sqrt(T);

BS = S0*normcdf(d1) - K*exp(-r*T)*normcdf(d2);

end



