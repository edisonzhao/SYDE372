function [ class_id ] = ML( sample, means, covs )
    function dist = calcDist(mu_1, mu_2, cov_1, cov_2, point)
        Q0 = inv(cov_1) - inv(cov_2);
        Q1 = 2.*((mu_2.' * inv(cov_2)) - (mu_1.' * inv(cov_1)));
        Q2 = mu_1.' * inv(cov_1) * mu_1 - mu_2.' * inv(cov_2) * mu_2;
        Q3 = 0;
        Q4 = log(det(cov_1)/det(cov_2));
        dist = point.'*Q0*point + Q1*point + Q2 + 2.*Q3 + Q4;
    end

    distances = [0 0 0];
    if length(means) == 3
        distances(1) = calcDist(means(:,1), means(:,2), covs{1}, covs{2}, sample);
        distances(2) = calcDist(means(:,2), means(:,3), covs{2}, covs{3}, sample);
        distances(3) = calcDist(means(:,3), means(:,1), covs{3}, covs{1}, sample);
        
        if distances(1) < 0 && distances(3) > 0
            class_id = 1;
        elseif distances(2) < 0 && distances(1) > 0
            class_id = 2;
        elseif distances(3) < 0 && distances(2) > 0
            class_id = 3;
        else
            class_id = -1;
        end
    else
        class_id = -1;
    end
end

