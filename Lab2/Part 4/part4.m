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





