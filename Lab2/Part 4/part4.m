clear all;
close all;

load('lab2_3.mat');

prototypes = zeros(20,2);
misclass = zeros(20,2);
j = 1;
j_thres = 20;

while size(a,1) > 0 && size(b,1) > 0
    while j <= j_thres
        n_aB = -1;
        n_bA = -1;
        
        AB = vertcat(a,b);
        known_AB = zeros(length(AB),1);
        predicted = zeros(size(known_AB));
        
        while n_aB ~= 0 && n_bA ~= 0
            rand_a_index = randi(size(a,1));
            rand_b_index = randi(size(b,1));

            proto_a = a(rand_a_index);
            proto_b = b(rand_b_index);
            
            known_AB(1:length(a)) = 1;
            known_AB(length(a)+1:length(known_AB)) = 2;

            for i=1:length(AB)
                predicted(i) = MED(proto_a', proto_b', AB(i,:)');
            end

            CM = confusionmat(known_AB, predicted);

            n_aB = CM(1,2);
            n_bA = CM(2,1);
        end
        % this is good, save discriminant
        prototypes(j,:) = [proto_a proto_b];
        misclass(j,:) = [n_aB n_bA];

        j = j + 1;
        
        if n_aB == 0
            % remove b that G classified as B
            ind = [];
            for i=(length(a)+1):length(known_AB)
                if known_AB(i) == predicted(i)
                    % remove b(i - length(a))
                    ind = [ind, (i-length(a))];
                end
            end
            b(ind, :) = [];
        end
        
        if n_bA == 0
            ind = [];
            for i=1:length(a)
                if known_AB(i) == predicted(i)
                    % remove a(i))
                    ind = [ind, i];
                end
            end
            a(ind, :) = [];
        end
    end
end

% at this point we would have seq of discriminants
x = (0: 1: 550);
y = (0: 1: 450);
seq_classifier = zeros(length(x),length(y));
for x_idx=1:550
    for y_idx=1:450
        for j=1:length(prototypes,1)
            g = MED(prototypes(j,1), prototypes(j,2), [x_idx y_idx]);
            if g == 1 && misclass(j,2) == 0
                seq_classifier(x_idx, y_idx) = 1;
                break;
            elseif g == 2 && misclass(j,1) == 0
                seq_classifier(x_idx, y_idx) = 2;
                break;
            end
        end
    end
end

figure(1);
hold on;
scatter(a(:,1), a(:,2));
scatter(b(:,1), b(:,2));
[X, Y] = meshgrid(x,y);
contour(X,Y, seq_classifier);
