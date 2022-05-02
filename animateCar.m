function animateCar(y, r, v, dt, T)
% function to animate the car 
% y - car body displacement, vs. time
% r - road surface, vs. time
% v - speed (m/s)
% dt - sampling period in time waveform
% T - total duration of time waveform

hold on
% animate from 10 m to end length
for t = round(10/(v*dt)):round(T/dt) % samples to animate
    drawFrame(y, r, t, v, dt)
    drawnow, % pause(.05)
end
hold off

end

% A helper function for the case study. When called, it plots a single
% frame of the vehicle simulation
function drawFrame(y, r, t, v, dt)
    %Clear current frame
    cla
    
    %Compute positions of frame objects
    backLocSample = max(round(t-5/(v*dt))); % sample location for back wheel
    backwheelY = r(backLocSample,1)+.25; % height of back wheel 
    backbodyY = .75+y(backLocSample,1); % height of body, back
    frontwheelY = r(t)+.25; % height of front wheel
    frontbodyY = .75+y(t); % height of body, front
       
    roadHeight = r(max(round(t-10/(v*dt)),1): min(round(t+5/(v*dt)),length(r)));
    roadFrame = linspace(0,15,15/(v*dt));
    
    %Trim sim boundaries to mitigate roundoff errors
    if length(roadHeight)>round(15/(v*dt))
        roadHeight = roadHeight(1:round(15/(v*dt)));
    end
    
    hold on;
    %Draw road
    plot(roadFrame(1:length(roadHeight)), roadHeight);
    %Draw wheels
    circle(5,backwheelY,.25);
    circle(10,frontwheelY,.25);
    %Draw frame
    line([5,5], [backwheelY, backbodyY]);
    line([5,10], [backbodyY, frontbodyY]);
    line([10,10], [frontwheelY, frontbodyY]);

    %Plot constraints
    xlim([0 15]);
    ylim([-1 2]);
    title(['Vehicle Simulation, travel distance ' num2str(round(v*t*dt)) ' m'])
    xlabel('Body frame length, m'), ylabel('Height, m')

end