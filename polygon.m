clear all;
close all;
clc;


N = 10; % Number of points
maxInt = 100; % Max coordinate

x = randi(maxInt, N, 2); % Get random integer coordinates within interval [0, maxInt]

ind = zeros(max(size(x)), 1); % ind contains the indices of the sorted coordinates

% a contains the index of the starting point - the point with min y coordinate. A
% special case is that several points might have the same min y coordinate.
% If this happens we want to choose the point with min x coordinate amongst
% them.
a = find(x(:,2)==min(x(:,2)));
b = x(a,1);
ind(1) = a(find(b==min(b)));

d = x - repmat(x(ind(1),:), max(size(x)), 1);
th_tmp = d(:,2)./(d(:,1) + d(:,2));

th = {th_tmp(th_tmp>0) th_tmp(th_tmp<0)};
t = [sort(th{1}); sort(th{2})];
[v i] = ismember(t, th_tmp);
ind = [ind(ind~=0); i];

y = x(ind,:);
y(N+1, :) = y(1,:);

plot(y(:,1), y(:,2), '*');
hold on;
plot(y(:,1), y(:,2));