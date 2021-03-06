%% 
% Copyright (c) 2017 Carnegie Mellon University, Sanjiban Choudhury <sanjibac@andrew.cmu.edu>
%
% For License information please see the LICENSE file in the root directory.
%

function [ selected_test, selected_gain, marginal_gain] = max_l1_diff(  selected_test_outcome, region_test, test_bias, is_max_prob )
%DIRECT_DRD_BERN Summary of this function goes here
%   Detailed explanation goes here
num_test = size(region_test,2);
if (~isempty(selected_test_outcome))
    candidate_test_set = setdiff(find(sum(region_test, 1)), selected_test_outcome(:,1)');
else
    candidate_test_set = find(sum(region_test, 1));
end
region_status = get_region_status( selected_test_outcome, region_test, test_bias );

if (isempty(candidate_test_set) || any(region_status == 1) || ~any(region_status > 0))
    selected_test = [];
    selected_gain = 0;
    marginal_gain = [];
    return;
end

% prune regions since drd will fail to eliminate them
region_test = region_test(region_status > 0, :);
region_status = region_status(region_status > 0);
candidate_test_set = intersect(candidate_test_set, find(sum(region_test, 1)));

if (is_max_prob)
    [~, region_idx] = max(region_status);
    candidate_test_set =  intersect( find( region_test(region_idx, :) ), candidate_test_set);
end

marginal_gain = zeros(1, num_test);

for t = candidate_test_set
    gain = 0;
    for xt = [true false]
        augmented_outcome = [selected_test_outcome; t xt];
        region_status_new = get_region_status( augmented_outcome, region_test, test_bias );
        prob = ( test_bias(t)^xt )*(( 1 - test_bias(t))^(~xt));
        gain = gain + prob*sum(abs(region_status_new - region_status));
    end
    marginal_gain(t) = gain ;
end
[selected_gain, selected_test] = max(marginal_gain);


end
