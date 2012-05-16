%% Copyright (C) 2012 Simeon Simeonov <simeon.simeonov.s@gmail.com>
%%
%% This program is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 3 of the License, or
%% (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with this program; if not, see <http://www.gnu.org/licenses/>.
%%
%% -*- texinfo -*-
%% @deftypefn {Function File} {@var{y} =} polygon (@var{x})
%% Returns a simple closed path that passes through all the points in x.
%% x is a vector containing 2D coordinates of the points.
%%
%% @end deftypefn

%% Author: Simeon Simeonov <simeon.simeonov.s@gmail.com>

function y = polygon(x)

if(size(x,1) > 1 && size(x,1) < size(x,2))
    x = x';
end

N = size(x,1); % Number of points
idx = zeros(N, 1); % ind contains the indices of the sorted coordinates

a = find(x(:,2)==min(x(:,2)));

if(size(a,1) > 1)
    [~, i] = sort(x(a,1));
    a = a(i(1));
end

x_1 = x(x(:,2)==x(a,2),:); % find all x with the same y coordinate

if(x(a,1) == min(x(:,1)))
    x_2 = x(x(:,1)==x(a,1),:); % find all x with the same x coordinate
else
   x_2 = x(a,:);
end

if(size(x_1,1) > 1 || size(x_2,1) > 1)
    if(size(x_1,1) > 1)
        x_1 = sort(x_1); % Sort by x coordinate
        y(1,:) = x(a,:); % original starting point
    end
    
    if (size(x_2,1) > 1)
        x_2 = sort(x_2, 'descend');
    end
    
    x_not = [x_1; x_2];
    i = ismember(x,x_not,'rows');
    x(i, :) = [];
    x = [x_1(size(x_1,1),:); x];
    x_1(size(x_1, 1),:) = [];
    N = size(x,1);
    a = 1;
else
    x_1 = [];
    x_2 = x(a,:);
end
d = x - repmat(x(a,:), N, 1);
th = d(:,2)./(d(:,1) + d(:,2));

[~, idx0] = ismember(sort(th(th==0)), th);
[~, idx1] = ismember(sort(th(th>0)), th);
[~, idx2] = ismember(sort(th(th<0)), th);

idx = [a; idx0; idx1; idx2];
% I contains the indices of idx in a sorted order. [v i] = sort(idx) then
% i==I.
[~,I,J]= unique(idx);
if(size(I,1) ~= size(J,1))
    R = histc(J, 1:size(I,1)); % R(1) will always be 1?
    idx_sorted = idx(I);
    r = find(R>1);
    for ri = r'
        idx_repeated = idx_sorted(ri);
        idx(idx==idx_repeated) = find(th==th(idx_sorted(ri)));
    end
end

y = [x_1; x(idx,:); x_2;];
