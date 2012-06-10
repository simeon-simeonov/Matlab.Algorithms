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

function y = cw(x)

% ---
% This function checks wether the turn between 3 points is
% counterclockwise. For example
%
%            .(P3)                 .(P1)                          .(P2)
%
%
%
%                        .(P2)                           .P(3)        .(P1)
%
%
%                      Clockwise                     Counterclockwise

p2 = x(1,:);
p0 = x(2,:);
p1 = x(3,:);

dx1 = p1(1) - p0(1);
dy1 = p1(2) - p0(2);

dx2 = p2(1) - p0(1);
dy2 = p2(2) - p0(2);

if(dx1*dy2 > dy1*dx2)
    y = true;
    return
end

if(dx1*dy2 < dy1*dx2)
    y = false;
    return;
end

if((dx1*dx2 < 0) || (dy1*dy2 < 0))
    y = false;
    return;
end

if((dx1*dx1+dy1*dy1) < (dx2*dx2+dy2*dy2))
    y = true;
    return;
end

y = false;

