%%
% Copyright (c) 2016 Carnegie Mellon University, Sanjiban Choudhury <sanjibac@andrew.cmu.edu>
%
% For License information please see the LICENSE file in the root directory.
%
%% EXAMPLE_WALL_WITH_GAPS
% Make a wall with a gap
clc;
clear;
close all;

%% Create two rectangles
scenario = 2;
switch scenario
    case 1
        bbox = [0 1 0 1]; %unit bounding box
        rectangle_array = get_wall_with_uniform_gaps( bbox, 0.4, 0.2, 0.1, [1 1 0 1] );
    case 2
        bbox = [0 1 0 1]; %unit bounding box
        rectangle_array1 = get_wall_with_uniform_gaps( bbox, 0.3, 0.2, 0.1, [1 1 0 1] );
        rectangle_array2 = get_wall_with_uniform_gaps( bbox, 0.7, 0.2, 0.1, [1 0 1 1] );
        rectangle_array = [rectangle_array1 rectangle_array2];
end


%% Visualize
figure;
visualize_shapes(rectangle_array);
axis(bbox)