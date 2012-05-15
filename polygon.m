function y = polygon(x)
xx = x;
N = size(x,1); % Number of points
idx = zeros(N, 1); % ind contains the indices of the sorted coordinates

a = find(x(:,2)==min(x(:,2)));

if(size(a,1) > 1)
    [v i] = sort(x(a,1));
    a = a(i(1));
end

x_1 = x(find(x(:,2)==x(a,2)),:); % find all x with the same y coordinate
x_2 = x(find(x(:,1)==x(a,1)),:); % find all x with the same x coordinate

if(size(x_1,1) > 1 || size(x_2,1) > 1)
    x_1 = sort(x_1);
    x_2 = sort(x_2, 'descend');
    
    x_1 = x_1(2:size(x_1,1),:);
    x_2 = x_2(1:size(x_2,1)-1,:);
    
    x_not = [x_2; x_1];
    
    x = setdiff(x, x_not, 'rows');
    N = size(x,1);
    a = 1;
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

y = [x(1,:); x_1; x(idx(2:size(idx,1)),:); x_2; x(1,:)];
