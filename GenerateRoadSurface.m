%% Generate road surface

totalDist = 50; % simulation distance in m
v = 10;         % Vehicle speed in m/s, between 5 and 30 m/s

N = 251; % number of samples in road surface

% road surface simulation
x = linspace(0,totalDist,N)'; % roadSurface sample spatial locations, in m
dx = totalDist/(N-1); % simulation interval in m

t = x/v; % Time vector
dt = dx/v; % simulation interval in seconds
T = totalDist/v;    % Simulation length in seconds

surfModel = 'inverse_trap'; % 'pothole' 'speed' or 'trapBump' or 'inverse_trap'

if strcmp(surfModel,'pothole')
    
    % random road surface with potholes
    bumpiness = 10;            % Amplitude of road noise in cm
    pothole_depth = 25;        % Depth of potholes in cm
    pothole_width = 30; % 30;       % Width of potholes in cm
    pothole_locations = [20 30];      % location in m
    
    %Generate terrain
    %     roadSurface = generateTerrain(T, dt, v, bumpiness, pothole_depth, pothole_width, pothole_location);
    potholeSamp = round(pothole_width/(100*dx)); % pothole width in samples
    potholes = zeros(N,1);
    potholes(round(pothole_locations/dx)) = 1;
    potholes = conv(potholes,ones(potholeSamp,1),"same")*(-pothole_depth/100); % pothole model
    
    roadSurface = 2*(rand(N,1)-.5)*(bumpiness/100)+potholes;
    
    % start and end with smooth surface
    roadSurface(x<10) = 0;
    roadSurface(x>totalDist-10) = 0;
    
elseif strcmp(surfModel,'trapBump')
    
    roadSurface = zeros(N,1);
    bmpStart = 15; rampUp = 5; rampLength = 25;
    bmpEnd = bmpStart + rampLength;
    rampAmp = .5;
    rampUpDur = find(x>bmpStart & x <= bmpStart + rampUp);
    roadSurface(rampUpDur) = rampAmp*(0:1/length(rampUpDur):1-1/length(rampUpDur));
    roadSurface(x>=bmpStart+rampUp & x<=bmpEnd-rampUp)=rampAmp;
    rampDownDur = find(x>bmpEnd-rampUp & x<bmpEnd);
    roadSurface(rampDownDur) = rampAmp*(1-1/length(rampUpDur):-1/length(rampDownDur):0);
    
elseif strcmp(surfModel,'speed') % gridded road surface
    
    spDist = 4; % 4; % spatial period of speed bump
    rippleHeight = 0.1; % height in m
    roadSurface = rippleHeight*sin(2*pi*x/spDist);
    roadSurface(x<10) = 0;
    roadSurface(x>totalDist-10) = 0;

elseif strcmp(surfModel, 'inverse_trap')

    roadSurface = zeros(N,1);
    bmpStart = 15; rampUp = 5; rampLength = 25;
    bmpEnd = bmpStart + rampLength;
    rampAmp = -.5;
    rampUpDur = find(x>bmpStart & x <= bmpStart + rampUp);
    roadSurface(rampUpDur) = rampAmp*(0:1/length(rampUpDur):1-1/length(rampUpDur));
    roadSurface(x>=bmpStart+rampUp & x<=bmpEnd-rampUp)=rampAmp;
    rampDownDur = find(x>bmpEnd-rampUp & x<bmpEnd);
    roadSurface(rampDownDur) = rampAmp*(1-1/length(rampUpDur):-1/length(rampDownDur):0);
    inverse_trap = roadSurface; 
    save("RoadSurfaceSamples.mat", "inverse_trap", '-append'); 
end
