clear all;
close all;

load('feat.mat');
figure(1);
aplot(f2);
title('Features of All Images Block Size 2');
xlabel('Feature 1');
ylabel('Feature 2');

figure(2);
aplot(f8);
title('Features of All Images Block Size 8');
xlabel('Feature 1');
ylabel('Feature 2');

figure(3);
aplot(f32);
title('Features of All Images Block Size 32');
xlabel('Feature 1');
ylabel('Feature 2');