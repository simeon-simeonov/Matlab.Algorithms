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

function ch = graham_scan(x)

z = closed_path(x);

ch = z(1:3, :);

for i = 4:length(z)
    s = size(ch,1);
    rot = cw([ch(s-1,:); ch(s,:); z(i,:)]);
    if rot == 1
        ch = [ch; z(i,:)];
    else
        ch(s,:) = z(i,:);
    end
end

while (length(z) ~= length(ch))
    z = ch;
    ch = z(1:3, :);
    
    for i = 4:length(z)
        s = size(ch,1);
        rot = cw([ch(s-1,:); ch(s,:); z(i,:)]);
        if rot == 1
            ch = [ch; z(i,:)];
        else
            ch(s,:) = z(i,:);
        end
    end
end
