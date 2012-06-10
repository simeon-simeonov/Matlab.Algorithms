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

function y = closed_path(x)

if(size(x,1) > 1 && size(x,1) < size(x,2))
    x = x';
end

N = size(x,1); % Number of points
idx = zeros(N, 1); % ind contains the indices of the sorted coordinates

% Find the index of the point(s) with min y coordinate
a = find(x(:,2)==min(x(:,2)));

% In case there are more than one point with the same min y coordinate,
% sort these points by their x coordinate and let a be the index of
% the point with min y and min x coordinate.
if(size(a,1) > 1)
    [~, i] = sort(x(a,1));
    a = a(i(1));
end

% -- Section 1 --

% This code deals with points that are on the same horizontal or vertical line
% as the starting point.

% find all points with the same y coordinate as the starting point x(a,:)
x_1 = x(x(:,2)==x(a,2),:);

% If the starting point happens to also be the point with the smallest x coordinate
% then find all other points which have the same x coordinate. Otherwise set x_2 to
% the starting point.
if(x(a,1) == min(x(:,1)))
    x_2 = x(x(:,1)==x(a,1),:);
else
   x_2 = x(a,:);
end

if(size(x_1,1) > 1 || size(x_2,1) > 1)
    if(size(x_1,1) > 1)
        x_1 = sort(x_1); % Sort by x coordinate
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

% -- Section 1 --

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

y = [x_1; x(idx,:); x_2];
