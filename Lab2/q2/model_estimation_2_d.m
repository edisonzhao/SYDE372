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



