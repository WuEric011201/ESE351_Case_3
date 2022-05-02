function [] = systemSimulation(m, b, k, v, roads)

    % copy paste from 'GenerateRoadSurface.m'
    totalDist = 50; % simulation distance in m
    
    N = 251; % number of samples in road surface
    
    % road surface simulation
    x = linspace(0,totalDist,N)'; % roadSurface sample spatial locations, in m
    
    t = x/v; % Time vector

    % plots
    n = k; % system numerator
    d = [m, b, k]; % system denominator
    sys = tf(n, d);
    
    % impulse response, step response, pole-zero plot
    figure;
    subplot(2,3,1), impulse(sys,t);
    subplot(2,3,2), step(sys,t);
    subplot(2,3,3), pzmap(sys);
    
    % frequency response
    natural_freq = sqrt(k/m);
    damping_ratio = b/m/2/natural_freq;
    [h, w] = freqs(n,d);
    subplot(2,3,4), semilogx(w,abs(h));
    title(['abs of frequency response with w_n = ' num2str(natural_freq,4) ' and \xi = ' num2str(damping_ratio,4)]);
    xlabel('frequency (rad/s)'), ylabel('magnitude'); grid on;
    subplot(2,3,5), semilogx(w,angle(h));
    title('angle of freqeuncy response');
    xlabel('frequency (rad/s)'), ylabel('angle'); grid on;

    % road simulation
    figure;
    subplot(3,1,1), plot(x,roads(:,1),x,lsim(n,d,roads(:,1),t)+0.5);
    title('roadTrap simulation');
    subplot(3,1,2), plot(x,roads(:,2),x,lsim(n,d,roads(:,2),t)+0.5);
    title('roadSin simulation');
    subplot(3,1,3), plot(x,roads(:,3),x,lsim(n,d,roads(:,3),t)+0.5);
    title('roadPothole simulation');

    for i = 1:3
        subplot(3,1,i);
        legend('u(t)','y(t)');
        xlabel('time t (s)');
        ylabel('amplitude (m)');
    end 

end