function price = UpOut(S0, K, r, T, sigma, x)
    %Calculating call price using Black & Scholes.
    Barrier = S0 * x;
    callPrice = BlackScholes(S0, K, r, T, sigma);
    % Prob that the option will be knocked out
    prob = normcdf((log(Barrier/S0) + (r + sigma^2/2)*T)/(sigma*sqrt(T)));
    % Returns option price
    price = callPrice * (1 - prob);
end