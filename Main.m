%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Task 1

r = 0.0278;
K = 55;
S0 = 62;
start_date = '2024-11-18';
end_date = '2025-07-18';
sigma = 0.2;
N = 8;
type = "C-EU";
%These parameters are not used for this assignment, same assignment was
%extended for assignment 3.
DIV = 0;
Div_date = 0;

disp("Task 1:")
[Option_price, optionTree] = Lab2_TPPE29_1(S0, K, sigma, start_date, end_date, N, r, DIV, Div_date, type)
disp(" ") 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Task 2a

disp("Task 2a")

BS = 88.25;
S0 = 2496.482;
K = 2500;
r = 0.0244;
tol = 0.000001;
guess_sigma = 0.4;


implicit_volatility = Implicit_sigma(BS, S0, K, r, tol, guess_sigma)

red_days = ['2024-12-24';'2024-12-25';'2024-12-26';'2024-12-31'; '2025-01-01';'2025-01-06'];
T = days252bus('2024-11-27', '2025-03-05', red_days);
T_new = T/252;

disp("Compare with BSM using implicit sigma")

BSM_New_Sigma = BlackScholes(S0, K, r, T_new, implicit_volatility)
disp(" ") 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Task 2b

disp("Task 2b")
disp("")

r = 0.0244;
K = 2500;
S0 = 2496.482;
start_date = '2024-11-27';
end_date = '2025-03-05';
N = 10;
type = "C-EU";

[Option_price, optionTree] = Lab2_TPPE29_1(S0, K, implicit_volatility, start_date, end_date, N, r, DIV, Div_date, type);
disp(Option_price)
disp(" ") 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Task 2c

disp("Task 2c")

[C0, bin_prices] = Lab2_TPPE29_2c(S0, K, implicit_volatility, start_date, end_date, r);
disp("Number of periods until convergence:")
disp(C0)


%Task 2d

disp("Task 2d")

BS = BlackScholes(S0, K , r, T_new ,implicit_volatility)
[C0, BIN200] = Lab2_TPPE29_2c(S0, K, implicit_volatility, start_date, end_date, r);
disp("Option price for 200 periods:")
disp(BIN200)
diff = (BS - BIN200) / BS;
disp("Difference between BlackScholes and option price (%):")
disp(diff * 100)
disp(" ") 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Task 3

disp("Task 3")

disp("European option price with dividend:")

[Option_price, optionTree] = Lab2_TPPE29_1(62, 55, 0.2, '2024-11-18', '2025-07-18', 8, 0.0278, 8, '2025-03-13', "C-EU");
disp(Option_price)
disp("European option tree:")
disp(optionTree)

disp("American option price with dividend:")

[Option_price, optionTree] = Lab2_TPPE29_1(62, 55, 0.2, '2024-11-18', '2025-07-18', 8, 0.0278, 8, '2025-03-13', "C-AM");
disp(Option_price)
disp("American option tree:")
disp(optionTree)
disp(" ") 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Task 4

S0 = 239.4;
K = 250;
current_sigma = 0.35;
start_date = '2024-11-27';
end_date = '2025-09-19';
N = 200;
r = 0.0225;
DIV = 1.6;
DIV_date = '2025-04-14';
type = "C-AM";

disp("Task 4")

MarketPrice = 26.375;

[C0, optiontree] = Lab2_TPPE29_1(S0, K, current_sigma, start_date, end_date, N, r, DIV, DIV_date, type);
disp("Option price of American option SAAB B:")
disp(C0)

disp("Deviation from market price: " + (MarketPrice - C0) / MarketPrice)
disp(" ") 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Task 5

disp("Task 5")

r = 0.0244;
K = 2500;
S0 = 2500;
start_date = '2024-11-27';
end_date = '2025-03-05';
sigma = 0.1699;

red_days = ['2024-12-24';'2024-12-25';'2024-12-26';'2024-12-31'; '2025-01-01';'2025-01-06';'2025-04-18';'2025-04-21';'2025-05-01';'2025-05-29'; '2025-06-06';'2025-06-20'];
T = days252bus(start_date, end_date, red_days); %Take inital step into consideration
tau = 1/252;
T_new = T * tau;

x = 1.05; %Change for some different x here

%Barrier option using BSM

PlainVanilla = BlackScholes(S0, K, r, T_new, sigma);
upIn = PlainVanilla - UpOut(S0, K, r, T_new, sigma, x);
disp("Option price Up and In: " + upIn)


