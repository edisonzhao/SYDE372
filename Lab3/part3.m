% Labelled Classification
numClasses = 10; numBlocks = 16;
load('feat.mat');

% Compute Sample Means And Sample Covariance
means_f2 = zeros(2, 10);
means_f8 = zeros(2, 10);
means_f32 = zeros(2, 10);

cov_f2 = cell(10, 1);
cov_f8 = cell(10, 1);
cov_f32 = cell(10, 1);

for i=1:numClasses
    samples_f2 = zeros(2, 16);
    samples_f8 = zeros(2, 16);
    samples_f32 = zeros(2, 16);
    for j=1:numBlocks
        samples_f2(:,j) = f2(1:2, (i-1)*numBlocks+j);
        samples_f8(:,j) = f8(1:2, (i-1)*numBlocks+j);
        samples_f32(:,j) = f32(1:2, (i-1)*numBlocks+j);
    end
    means_f2(:,i) = mean(samples_f2, 2);
    means_f8(:,i) = mean(samples_f8, 2);
    means_f32(:,i) = mean(samples_f32, 2);
    cov_f2{i} = cov(samples_f2');
    cov_f8{i} = cov(samples_f8');
    cov_f32{i} = cov(samples_f32');
end

% Classify Test Data Using MICD Classifier
MICD_f2t = zeros(160, 1);
MICD_f8t = zeros(160, 1);
MICD_f32t = zeros(160, 1);

for i = 1:160
    MICD_f2t(i) = MICD(f2t(1:2, i), means_f2, cov_f2);
    MICD_f8t(i) = MICD(f8t(1:2, i), means_f8, cov_f8);
    MICD_f32t(i) = MICD(f32t(1:2, i), means_f32, cov_f32);
end

% Build Confusion Matrix
known_f2t = f2t(3, :)';
known_f8t = f8t(3, :)';
known_f32t = f32t(3, :)';
cm_f2 = confusionmat(known_f2t, MICD_f2t);
cm_f8 = confusionmat(known_f8t, MICD_f8t);
cm_f32 = confusionmat(known_f32t, MICD_f32t);


