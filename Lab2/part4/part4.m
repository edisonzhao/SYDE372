clear all;
close all;

load('lab2_3.mat');

% Part 1
for i = 1:3
    figure(i);
    hold on;
    scatter(a(:,1), a(:,2), 10, '+', 'r');
    scatter(b(:,1), b(:,2), 10, '*', 'b');

    [prototypes, misclass] = SequentialClassifier(a, b, -1);

    x = (1: 1: 550);
    y = (1: 1: 550);
    seq_classifier = zeros(length(y),length(x));
    
    for x_idx=1:550
        for y_idx=1:550
            for j=1:length(prototypes(:,1))
                g = MED(prototypes(j,1:2)', prototypes(j,3:4)', [x_idx y_idx]');
                if g == 1 && misclass(j,2) == 0
                    seq_classifier(y_idx, x_idx) = 1;
                    break;
                elseif g == 2 && misclass(j,1) == 0
                    seq_classifier(y_idx, x_idx) = 2;
                    break;
                end
            end
        end
    end

    [X, Y] = meshgrid(x,y);
    contour(X,Y, seq_classifier, '-y');
    xlabel('Feature 1');
    ylabel('Feature 2');
    title('Sequential Classifier (Unbounded)');
    legend('Class 1', 'Class 2');
    hold off;
end

% Part 3
avg_err = zeros(10,1);
max_err = zeros(10,1);
min_err = zeros(10,1);
stddev_err = zeros(10,1);

for j = 1:10
    error = zeros(20,1);
    for m = 1:20
        [prototypes, misclass] = SequentialClassifier(a, b, j);

        ab = vertcat(a,b);
        actual = zeros(size(ab,1),1);
        actual(1:length(a(:,1))) = 1;
        actual(length(a(:,1))+1:length(ab)) = 2;
        predicted = zeros(size(actual));

        for k=1:400
            for l=1:length(prototypes(:,1))
                g = MED(prototypes(l,1:2)', prototypes(l,3:4)', ab(k,:)');
                if g == 1 && misclass(l,2) == 0
                    predicted(k) = 1;
                    break;
                elseif g == 2 && misclass(l,1) == 0
                    predicted(k) = 2;
                    break;
                end
            end
        end

        correct = length(find(actual == predicted));
        error(m) = (400-correct)/400;
    end
    avg_err(j) = mean(error);
    max_err(j) = max(error);
    min_err(j) = min(error);
    stddev_err(j) = std(error);
end

figure();
hold on;
plot(avg_err, 'r');
plot(max_err, 'b');
plot(min_err, 'y');
plot(stddev_err, 'g');
xlabel('J Sequences');
ylabel('Error');
title('Error Rate vs. J Sequences');
legend('Avg Error Rate', 'Max Error Rate', ...
    'Min Error Rate', 'Std Dev Error Rate');
hold off;

