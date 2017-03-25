clc;
clear all;

load feat.mat

random_location = zeros(1,10);
%random_coor = zeros(2, 10);

i = 1;
while i <= 10
    randPt = round(160*rand(1));
    if any(random_location~=randPt)
        random_location(1, i) = randPt;
        i = i + 1;
    end
end

random_coor = f32(1:2, random_location);

converge = 0;

while converge == 0
    prev_coor = random_coor;
    
    classification = zeros(1, 160);
    distance = zeros(1, 10);
    for j = 1:160
        for k = 1:10
            distance(k) = ED(f32(1:2, j), prev_coor(:, k));
        end
        [dist, location] = min(distance);
        classification(j) = location;
    end
    
    for j = 1:10
        coor_loc = find(classification == j);
        random_coor(:,j) = mean(f32(1:2, coor_loc), 2);
    end
    
    if isequal(prev_coor, random_coor)
        converge = 1;
    end
end

figure(1);
hold on;
aplot(f32);
plot(random_coor(1,:), random_coor(2, :), 'xb', 'LineWidth', 3, 'MarkerSize',12)
title('K-Means Plot');
hold off;

% Fuzzy K-Means
b = 2;
K = 10;

[centroids,U,obj_fn] = fcm(f32(1:2,:)',K);
maxU = max(U);

hold on;
plot(centroids(:, 1), centroids(:, 2), 'xr', 'LineWidth', 3, 'MarkerSize',12)