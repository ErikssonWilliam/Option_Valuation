
function [C0, Bin200] = Lab2_TPPE29_2c(S0, K, sigma, start_date, end_date, r)

periods = 5:200;
bin_prices = zeros(1,length(periods));
imp_sigma = Implicit_sigma(88.25, S0, K, r, 0.00001, sigma);

red_days = ['2024-12-24';'2024-12-25';'2024-12-26';'2024-12-31'; '2025-01-01';'2025-01-06';'2025-04-18';'2025-04-21';'2025-05-01';'2025-05-29'; '2025-06-06';'2025-06-20'];
T = days252bus(start_date, end_date, red_days); %Take inital step into consideration
tau = 1/252;
T_new = T * tau;
converging_value = 0;

for i = 1:length(periods)
    N = periods(i);
    bin_prices(i) = Lab2_TPPE29_1(S0,K,imp_sigma,start_date,end_date, N, r, 0, 0, "C-EU");

    if BlackScholes(S0, K, r, T_new, imp_sigma) * 0.995 <= bin_prices(i) &&  bin_prices(i) <= BlackScholes(S0, K, r, T_new, imp_sigma) * 1.005 && converging_value == 0
        converging_value = N;
    end

end
C0 = converging_value;
Bin200 = bin_prices(196);
plot(periods, bin_prices);



end



