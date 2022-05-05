
% This function models the vehicle's behaviour for the four types of bumps

function [diff, sum_diff] = Testing(n, d, t, roads)   

    diff = zeros(251, 4);
    
%     Differences for two trapizoidal bumps - lateral disturbance
% We want this to be as small as possible
    diff(: , 1) = abs(roads(:,1) - lsim(n,d,roads(:,1),t)); 
    diff(: , 4) = abs(roads(:,4) - lsim(n,d,roads(:,4),t)); 
    
%     Differences for verticle disturbances bumps
    flat_road = zeros(251, 1);
    diff(: , 2) = abs(flat_road - lsim(n,d,roads(:,2),t)); 
    diff(: , 3) = abs(flat_road - lsim(n,d,roads(:,3),t)); 

    sum_diff = sum(diff, 1); 

end