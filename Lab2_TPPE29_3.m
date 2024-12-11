function C0 = Lab2_TPPE29_3(S0, K, sigma, start_date, end_date, N, r)

red_days = ['2024-12-24';'2024-12-25';'2024-12-26';'2024-12-31'; '2025-01-01';'2025-01-06';'2025-04-18';'2025-04-21';'2025-05-01';'2025-05-29'; '2025-06-06';'2025-06-20'];
T = days252bus(start_date, end_date, red_days); %Take inital step into consideration

tau = 1/252; %length of each time step in binomial tree model
delta_t = T*tau/N;

u = exp(sigma * sqrt(delta_t));
d = exp(-sigma * sqrt(delta_t));
q = (exp(r * delta_t)-d)/(u-d); %Riskneutral probability

stock_tree = zeros(N+1,N+1); %Binomial tree, initialize matrix with inital values equal to zero.
option_tree = zeros(N+1,N+1); 

disc_factor = exp(-r * delta_t);

%Populate the stock tree 

stock_tree(1,1) = S0;

for j = 2:N+1
    for i = 1:j
        if i == 1
            stock_tree(i,j) = stock_tree(i, j-1) * u;
        else
            stock_tree(i, j) = stock_tree(i-1, j-1) * d;
        end
    end
end

% Populate terminal payoff (max(S-K, 0))

for i = 1:N+1 %number of leaves
    option_tree(i, j) = max(stock_tree(i, N+1) - K, 0); 
end

%Backwards induction

for j = N:-1:1
    for i = 1:j
        option_tree(i, j) = disc_factor * (q * option_tree(i, j+1) + (1-q)*option_tree(i+1,j+1));
    end
end

C0 = option_tree(1,1)

