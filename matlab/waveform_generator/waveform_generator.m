% --------- SETTINGS ----------
COUNTER_BITS = 4;
DURATION = 5.0;
DT = 0.1;
LUT_ENTRIES = COUNTER_BITS ^ 2;
VOLUME = 8;

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
hold on;

% Create the phase plot
subplot(2, 1, 1);
phase_plot = plot(t, phase);
xlabel('Time (s)');
ylabel('Phase (SOM<ETHING)');

% Create the waveform plot
subplot(2, 1, 2);
wave_plot = plot(t, waveform);
xlabel('Time (s)');
ylabel('Voltage');

% Create the lookup table
sine_lut = 0 : ((2 * pi) / LUT_ENTRIES) : (2 * pi);
for i = 1:LUT_ENTRIES
   sine_lut(1,i) = sin(sine_lut(1,i));
end

% -------- Main loop ----------
tic;
n = 1;
while(1)
    % Check that the figure is still valid
    if(~ishandle(fig))
        break;
    end
    
    % Check for end of runtime
    if(toc >= DURATION)
        break;
    end
    
    
    
    % Update the newest time value
    t(1, n) = toc;
    waveform(1, n) = sine_lut(1, counter + 1) * VOLUME;
    
    % Increment counter and wrap back around if necessary
    counter = counter + 1;
    if(counter == (2^COUNTER_BITS))
        counter = 0;
    end
    
    
    
    % Update phase plot
    set(...
        phase_plot, ...
        'XData', t(1,1:n), ...
        'YData', phase(1,1:n));
    
    % Update waveform plot
    set(...
        wave_plot, ...
        'XData', t(1,1:n), ...
        'YData', waveform(1,1:n));
    
    % Redraw
    drawnow();
    
    % Pause and increment the counter
    pause(DT);
    n = n + 1;
end