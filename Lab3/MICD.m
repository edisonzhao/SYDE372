function [ class_id ] = MICD( sample, means, covs )
    % Obtained from Lab 1, MICD Classifier
    distances=[];
    for i=1:length(means)
        dist=((sample-means(:,i)).' * inv(covs{i}) * (sample-means(:,i))).^0.5;
        distances= [distances dist];
    end
    [min_dist, class_id]= min(distances);
end