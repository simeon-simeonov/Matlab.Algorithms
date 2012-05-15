function y = polygon(x)

N = size(x,1); % Number of points
idx = zeros(N, 1); % ind contains the indices of the sorted coordinates

a = find(x(:,2)==min(x(:,2)));

if(size(a,1) > 1)
    [v i] = sort(x(a,1));
    a = i(1);
end

d = x - repmat(x(a,:), N, 1);
th = d(:,2)./(d(:,1) + d(:,2));

[v0 idx0] = ismember(sort(th(th==0)), th);
[v1 idx1] = ismember(sort(th(th>0)), th);
[v2 idx2] = ismember(sort(th(th<0)), th);

idx = [a; idx0; idx1; idx2];
% I contains the indices of idx in a sorted order. [v i] = sort(idx) then
% i==I.
[~,I,J]= unique(idx);
R = histc(J, 1:size(I,1)); % R(1) will always be 1?

idx_sorted = idx(I);
r = find(R>1);
for ri = r'
    idx_repeated = idx_sorted(ri);
    idx(idx==idx_repeated) = find(th==th(idx_sorted(ri)));
end

y = [x(idx,:); x(a,:)];
