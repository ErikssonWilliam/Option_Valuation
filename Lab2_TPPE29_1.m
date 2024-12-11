
function [C0, optionTree] = Lab2_TPPE29_1(S0, K, sigma, start_date, end_date, N, r, DIV, Div_date, type)

red_days = ['2024-12-24';'2024-12-25';'2024-12-26';'2024-12-31'; '2025-01-01';'2025-01-06';'2025-04-18';'2025-04-21';'2025-05-01';'2025-05-29'; '2025-06-06';'2025-06-20'];
T = days252bus(start_date, end_date, red_days); %Take inital step into consideration

tau = 1/252; %length of each time step in binomial tree model
delta_t = T*tau/N;

%For Task 3
Tdiv = days252bus(start_date, Div_date, red_days);
Sstar = S0 - DIV * exp(-r*Tdiv*tau);

%för uppgift 2b, ändra parametrar till Lab2_TPPE29_1(2500, 2500, 0.2, '2024-11-18', '2025-05-18', 10, 0.0244)

u = exp(sigma * sqrt(delta_t));
d = exp(-sigma * sqrt(delta_t));
q = (exp(r * delta_t)-d)/(u-d); %Riskneutral probability
z = exp(r * delta_t);

stock_tree = zeros(N+1,N+1); %Binomial tree, initialize matrix with inital values equal to zero.
option_tree = zeros(N+1,N+1); 

disc_factor = exp(-r * delta_t);

%Populate the stock tree 

stock_tree(1,1) = Sstar;

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
    option_tree(i, N+1) = max(stock_tree(i, N+1) - K, 0); 
end

%Backwards induction

for j = N:-1:1
    for i = 1:j
        if type == "C-AM"
            if j  ==  ceil((Tdiv*N)/T) %if j is our div_date
                %option_tree(i, j) = max(stock_tree(i,j) + DIV - K, disc_factor ...
                   % *(q * option_tree(i, j+1) + (1-q) * option_tree(i, j)));
                option_tree(i, j) = max(stock_tree(i,j) + DIV - K, disc_factor ...
                    *(q * option_tree(i, j+1) + (1-q) * option_tree(i+1, j+1)));
                %disp("inne"
            else
                
                option_tree(i, j) = disc_factor * (q * option_tree(i, j+1) + (1-q)*option_tree(i+1,j+1));
            end        
        elseif type == "C-EU"
            option_tree(i, j) = disc_factor * (q * option_tree(i, j+1) + (1-q)*option_tree(i+1,j+1));
        end
    end
end
optionTree = option_tree;
C0 = option_tree(1,1);


%Run Task 3

%Lab2_TPPE29_1(62, 55, 0.2, '2024-11-18', '2025-07-18', 8, 0,0278, '2025-03-13', "C-EU")
%Lab2_TPPE29_1(62, 55, 0.2, '2024-11-18', '2025-07-18', 8, 0,0278, '2025-03-13', "C-AM")

%Run Task 4

%vi körde bs, på 200 perioder och det skulle överensstämma med
%trädfunktionen på 200 perioder. 

%Lab2_TPPE29_1(239.4, 250, 0.35, '2024-11-27', '2025-09-05', 200, 0.025, 1,6, '2025-04-10', "C-AM")


end
