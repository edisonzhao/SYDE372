function [ dist ] = ED(p1, p2)
%ED calculates the euclidean distance between two points
    dist = (((p1(1) - p2(1))^2) + ((p1(2) - p2(2))^2))^0.5;
end

