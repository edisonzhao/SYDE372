clear all;
close all;

% 1 Parametric estimation
data = load('lab2_2.mat');

% Sample Means
sample_mean_a = [0 0];
sample_mean_b = [0 0];
sample_mean_c = [0 0];

for i = 1 : 100
    sample_mean_a = sample_mean_a + data.al(i,:);
end
for i = 1 : 100
    sample_mean_b = sample_mean_b + data.bl(i,:);
end
for i = 1 : 100
    sample_mean_c = sample_mean_c + data.cl(i,:);
end

sample_mean_a = sample_mean_a ./ 100;
sample_mean_b = sample_mean_b ./ 100;
sample_mean_c = sample_mean_c ./ 100;

% Sample Covariances
sample_cov_a = [0 0; 0 0];
sample_cov_b = [0 0; 0 0];
sample_cov_c = [0 0; 0 0];

for i = 1 : 100
    sample_cov_a = sample_cov_a + ...
        (data.al(i,:)-sample_mean_a)'*(data.al(i,:)-sample_mean_a);
end
for i = 1 : 100
    sample_cov_b = sample_cov_b + ...
        (data.bl(i,:)-sample_mean_b)'*(data.bl(i,:)-sample_mean_b);
end
for i = 1 : 100
    sample_cov_c = sample_cov_c + ...
        (data.cl(i,:)-sample_mean_c)'*(data.cl(i,:)-sample_mean_c);
end

sample_cov_a = sample_cov_a ./ (100-1);
sample_cov_b = sample_cov_b ./ (100-1);
sample_cov_c = sample_cov_c ./ (100-1);

% Plot Data and ML Classifier
x = (0: 1: 500);
y = (0: 1: 500);
ML_classifier = zeros(length(x), length(y));

for i = 1:length(x)
    for j = 1:length(y)
        ML_classifier(j,i) = ML([x(i);y(j)] ...
            ,[sample_mean_a' sample_mean_b' sample_mean_c'] ...
            ,{sample_cov_a sample_cov_b sample_cov_c});
    end
end

figure();
hold on;
scatter(data.al(:,1), data.al(:,2), 10, 'y', '+');
scatter(data.bl(:,1), data.bl(:,2), 10, 'm', '*');
scatter(data.cl(:,1), data.cl(:,2), 10, 'b', 'o');
[X Y] = meshgrid(x,y);
contour(X, Y, ML_classifier, '-k');
xlabel('Feature 1', 'fontsize', 10);
ylabel('Feature 2', 'fontsize', 10);
title('Parametric Estimation & ML Classification');
legend('Cluster A','Cluster B','Cluster C');
hold off;

% Non-Parametric Approach
res = [1 0 0 500 500];

window = fspecial('gaussian', [50 50], 400);

[p_al, x_al, y_al] = parzen(data.al, res, window);
[p_bl, x_bl, y_bl] = parzen(data.bl, res, window);
[p_cl, x_cl, y_cl] = parzen(data.cl, res, window);

decision_mat = zeros(502, 502);

for i=1:502
    for j=1:502
        if max([p_al(i,j), p_bl(i,j), p_cl(i,j)]) == p_al(i,j)
            decision_mat(i,j) = 1;
        elseif max([p_al(i,j), p_bl(i,j), p_cl(i,j)]) == p_bl(i,j)
            decision_mat(i,j) = 2;
        elseif max([p_al(i,j), p_bl(i,j), p_cl(i,j)]) == p_cl(i,j)
            decision_mat(i,j) = 3;
        end
    end
end

figure()
plot(data.at(:,1),data.at(:,2),'ro', data.bt(:,1),data.bt(:,2),'go', data.ct(:,1),data.ct(:,2),'yo')
legend('at', 'bt', 'ct')
hold on
contour(decision_mat, 'Color', 'blue')
title('Non-parametric estimation of 2D data')
