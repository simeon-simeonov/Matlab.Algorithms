function y = polygon(x)

N = size(x,1); % Number of points
ind = zeros(N, 1); % ind contains the indices of the sorted coordinates
y = zeros(N+1,2);

% a contains the index(ices) of the starting point(s) - the point(s) with
% min y coordinate(s). A special case is that several points might have the
% same min y coordinate(s). If this happens we want to choose the point
% with min x coordinate amongst them.
a = find(x(:,2)==min(x(:,2)));

% Sort the points with min y coordinate wrt increasing x coordinate. This
% allows us to have the starting point at the index 1 in the b matrix and
% the rest of b contains the first few points of the polygon.
[v i] = sort(x(a,1));
ind(1:size(a,1)) = a(i);

d = x - repmat(x(ind(1),:), N, 1);
th = d(:,2)./(d(:,1) + d(:,2));

t = [sort(th(th>0)); sort(th(th<0))];
[v i] = ismember(t, th);
ind = [ind(ind~=0); i];

y = x(ind,:);
y(N+1, :) = y(1,:);
