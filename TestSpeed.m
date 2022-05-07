% This function tests the response of the vehicle to different speeds


function result = TestSpeed(n, d, roads)

    speed = 5: 0.5: 40; % Varying speed
    x = linspace(0,50, 251)'; % roadSurface sample spatial locations, in m
    result = zeros(length(speed), 4); 

    for i = 1: length(speed)
        t = x/speed(i); % Time vector
        [~ , sum_diff] = Testing(n, d, t, roads); 
        result (i, : ) = sum_diff; 
    end

    figure;
    subplot(4,1,1), plot(speed, result(: , 1));
    title('Change in speed affect the response to the trapezoidal bump'), xlabel('Speed (m/s)'), ylabel('Difference (m)');
    subplot(4,1,2), plot(speed, result(: , 2));
    title('Change in speed affect the response to the sinusoidal road'), xlabel('Speed (m/s)'), ylabel('Difference(m)');
    subplot(4,1,3), plot(speed, result(: , 3));
    title('Change in speed affect the response to the pothole road'), xlabel('Speed (m/s)'), ylabel('Difference(m)');
    subplot(4,1,4), plot(speed, result(: , 4));
    title('Change in speed affect the response to the inverse trapezoidal bump'), xlabel('Speed (m/s)'), ylabel('Difference(m)');


end

