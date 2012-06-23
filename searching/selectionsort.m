% Find the smallest element in the array and exchange it with the element
% in the first position. Then find the second smallest element and exchange
% it with the element in the second position etc.

function y = selectionsort(x)

% Needed by plotting mechanism
minX = min(x);
maxX = max(x);
len = length(x);

for j = 1:length(x) - 1
    for i = j+1:length(x)       
        if(x(i) < x(j))
            tmp = x(j);
            x(j) = x(i);
            x(i) = tmp;
        end
    end
    
    % The code below is purely for plotting.
    hold off;
    plot(1:length(x), x, '*'); % Plot all 2D points
    hold on;
    axis([0 (length(x) + 1) (minX - 1) (maxX + 1)]); % Adjust axes
    plot(j,linspace(x(j), maxX), 'r-'); % Plot vertical tracking line
    plot(linspace(j,len), x(j), 'r-'); % Plot horizontal tracking line
    drawnow;
end

y = x;
