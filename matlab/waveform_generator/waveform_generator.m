% --------- SETTINGS ----------
COUNTER_BITS = 4;
DURATION = 5.0;
DT = 0.1;
LUT_ENTRIES = COUNTER_BITS ^ 2;

% ------ Initialisation -------
% Start counter at 0
counter = 0;

% Allocate memory for the output
num_data_points = (1 / DT) * DURATION;
t = zeros(1, num_data_points);
phase = zeros(1, num_data_points);
waveform = zeros(1, num_data_points);

% Create the figure
fig = figure(...
    'NumberTitle', 'Off', ...
    'Name', 'Output display');

% Create the plot
wave_plot = plot(t, waveform);

% Create the lookup table
sine_lut = 0 : ((2 * pi) / LUT_ENTRIES) : (2 * pi);
for i = 1:LUT_ENTRIES
   sine_lut(1,i) = sin(sine_lut(1,i)); 
end

% -------- Main loop ----------
tic;
n = 1;
while(1)
    if(~ishandle(fig))
        break;
    end
    
    if(toc >= DURATION)
        break;
    end
    
    t(1, n) = toc;
    waveform(1, n) = sine_lut(1, counter + 1);
    
    % Increment counter and wrap back around if necessary
    counter = counter + 1;
    if(counter == (2^COUNTER_BITS))
        counter = 0;
    end
    
    set(...
        wave_plot, ...
        'XData', t(1,1:n), ...
        'YData', waveform(1,1:n));
    
    drawnow();
    pause(DT);
    n = n + 1;
end