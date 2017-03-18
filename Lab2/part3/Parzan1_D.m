function [ res ] = Parzan1_D( data, h )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
N = size(data,2);
x_coor = linspace(0,10);
res = ones(N, 2);
for i = 1:length(x_coor)
    res(i, 1) = x_coor(i);
    total = 0;
    for j=1:N
        total = total + (1/(sqrt(2*pi)*h))*exp(-0.5*((x_coor(i)-data(j))/h)^2);
    end
    res(i, 2) = (1/N) * total;
end

end

