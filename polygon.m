clear all;
close all;
clc;


N = 10; % Number of points
maxInt = 100; % Max coordinate

x = randi(maxInt, N, 2); % Get random integer coordinates within interval [0, maxInt]

ind = zeros(max(size(x)), 1); % ind contains the indices of the sorted coordinates
p = 1; % pointer for the ind matrix

% a contains the index of the starting point - the point with min y coordinate. A
% special case is that several points might have the same min y coordinate.
% If this happens we want to choose the point with min x coordinate amongst
% them.
a = find(x(:,2)==min(x(:,2)));

% Sort the points with min y coordinate wrt increasing x coordinate. This
% allows us to have the starting point at the index 1 in the b matrix and
% the rest of b contains the first few points of the polygon.
b = sort(x(a,1));

[v i] = ismember(b, x(:, 1));
ind(p:size(b,1)) = i;

p = p + size(a,1);

d = x - repmat(x(ind(1),:), max(size(x)), 1);
%t = d(:,2)./d(:,1);
%th_tmp = atan(t);
th_tmp = d(:,2)./(d(:,1) + d(:,2));

th = {th_tmp(th_tmp>0) th_tmp(th_tmp<0)};

j = 1;

if(isempty(th{j}) == 0)
    for i = p : p + size(th{j},1) - 1
        ind(i) = find(th_tmp==min(th{j}));
        th{j}(th{j}==min(th{j})) = NaN;
    end
    p = p + size(th{j},1);
end

j = 2;

if(isempty(th{j}) == 0)
    for i = p : p + size(th{j},1) - 1
        ind(i) = find(th_tmp==min(th{j}));
        th{j}(th{j}==min(th{j})) = NaN;
    end
end

y = x(ind,:);
y(N+1, :) = y(1,:);

plot(y(:,1), y(:,2), '*');
hold on;
plot(y(:,1), y(:,2));