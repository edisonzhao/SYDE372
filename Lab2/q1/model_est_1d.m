%%%%%%%%%%%%% Parametric Estimation - Gaussian %%%%%%%%%%%%%%%%%
clear;
data = load('lab2_1.mat');

% 1st data set
mu_a = 5;
sigma_a = 1;

mu_est_a = (1/length(data.a))*sum(data.a);
sigma_est_a = (1/length(data.a)).*sum((data.a - repmat(mu_est_a, size(data.a))).^2);

x_vals = linspace(0, 10);

y_true_a = normpdf(x_vals, mu_a, sigma_a);
y_est_a = normpdf(x_vals, mu_est_a, sigma_est_a);

figure(1);
plot(x_vals, y_true_a, x_vals, y_est_a);
xlabel('x');
ylabel('p(x)');
legend('True', 'Estimated');
title('Parametric Gaussian Estimation (Dataset a)')

% Data Set b
lambda_b = 1;
mu_est_b = (1/length(data.b))*sum(data.b);
sigma_est_b = (1/length(data.b)).*sum((data.b - repmat(mu_est_b, size(data.b))).^2);

y_true_b = exppdf(x_vals, 1/lambda_b);
y_est_b = normpdf(x_vals, mu_est_b, sqrt(sigma_est_b));

figure(2)
plot(x_vals, y_true_b, x_vals, y_est_b);
xlabel('x');
ylabel('p(x)');
legend('True', 'Estimated');
title('Parametric Gaussian Estimation (Dataset b)')


%%%%%%% Parametric Estimation - Exponential %%%%%%%%%% 

% Data Set a
lambda_est_a = (1/length(data.a))*sum(data.a);

y_est_a_exp = exppdf(x_vals, 1/lambda_est_a);

figure(3)
plot(x_vals, y_true_a, x_vals, y_est_a_exp);
xlabel('x');
ylabel('p(x)');
legend('True', 'Estimated');
title('Parametric Exponential Estimation (Dataset a)')

% Data Set b
lambda_est_b = (1/length(data.b))*sum(data.b);

y_est_b_exp = exppdf(x_vals, 1/lambda_est_b);

figure(4)
plot(x_vals, y_true_b, x_vals, y_est_b_exp);
xlabel('x');
ylabel('p(x)');
legend('True', 'Estimated');
title('Parametric Exponential Estimation (Dataset b)')


%%%%%% Parametric Estimation - Uniform %%%%%%%

% Dataset a
a_est_a = min(data.a);
b_est_a = max(data.a);

y_est_a_uniform = unifpdf(x_vals, a_est_a, b_est_a);

figure(5)
plot(x_vals, y_true_a, x_vals, y_est_a_uniform);
xlabel('x');
ylabel('p(x)');
legend('True', 'Estimated');
title('Parametric Uniform Estimation (Dataset a)')


% Dataset b
a_est_b = min(data.b);
b_est_b = max(data.b);

y_est_b_uniform = unifpdf(x_vals, a_est_b, b_est_b);

figure(6)
plot(x_vals, y_true_b, x_vals, y_est_b_uniform);
xlabel('x');
ylabel('p(x)');
legend('True', 'Estimated');
title('Parametric Uniform Estimation (Dataset b)')

% Non-Parametric Approach
result_a_1 = Parzan1_D(data.a, 0.1);
result_a_2 = Parzan1_D(data.a, 0.4);

figure()
subplot(2,1,1)
plot (result_a_1(:, 1), result_a_1(:, 2), result_a_1(:, 1), normpdf(result_a_1(:, 1), 5, 1));
legend('Estimated density', 'True density');
title('Parzen Window estimation on data a with h = 0.1')

subplot(2,1,2)
plot (result_a_2(:, 1), result_a_2(:, 2), result_a_2(:, 1), normpdf(result_a_2(:, 1), 5, 1));
legend('Estimated density', 'True density');
title('Parzen Window estimation on data a with h = 0.4')

result_b_1 = Parzan1_D(data.b, 0.1);
result_b_2 = Parzan1_D(data.b, 0.4);

figure()
subplot(2,1,1)
plot (result_b_1(:, 1), result_b_1(:, 2), result_b_1(:, 1), exppdf(result_b_1(:, 1),1));
legend('Estimated density', 'True density');
title('Parzen Window estimation on data b with h = 0.1')

subplot(2,1,2)
plot (result_b_2(:, 1), result_b_2(:, 2), result_b_2(:, 1), exppdf(result_b_2(:, 1),1));
legend('Estimated density', 'True density');
title('Parzen Window estimation on data b with h = 0.4')
