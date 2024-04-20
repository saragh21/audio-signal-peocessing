clc;close all; clear all;


%% Define the physical parameters of the system
nModes = 10; % Number of modes
damping = 0.01; % Damping factor
duration = 5; % Duration of the sound in seconds
fs = 44100; % Sampling frequency

% Initialize the modal frequencies and shapes
modalFrequencies = linspace(100, 2000, nModes); % Example frequencies
modalShapes = rand(nModes, 1); % Random shapes for simplicity

% Initialize the output signal
outputSignal = zeros(1, duration * fs);

% Define the excitation (e.g., a hammer strike)
excitation = zeros(1, duration * fs);
excitation(1) = 1; % Impulse at the beginning

% Modal synthesis
for mode = 1:nModes
    % Each mode's response to the excitation
    modeResponse = filter(modalShapes(mode), [1, -2*exp(-damping)*cos(2*pi*modalFrequencies(mode)/fs), exp(-2*damping)], excitation);
    
    % Add the mode's contribution to the output signal
    outputSignal = outputSignal + modeResponse;
end

% Normalize the output signal
outputSignal = outputSignal / max(abs(outputSignal));

%plot output signal
 
 
N=length(outputSignal);
Ttot = N./fs;                   % duration in seconds
t = 0: Ttot/N : Ttot-Ttot/N;% time sequence
figure(1);
 
plot( t, outputSignal)
xlabel('Time (s)');
ylabel('Amplitude');
title('original sound file');
hold on

figure(2);
f = (0:N-1)*fs/N;
plot(f, 20*log10(abs(outputSignal)))
grid
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
title('Frequency Spectrum');

% Play the sound
sound(outputSignal, fs);

%% % Define the physical parameters of the system
nModes = 10; % Number of modes
dampingFactors = linspace(0.01, 0.05, nModes); % Varied damping factors
duration = 5; % Duration of the sound in seconds
fs = 44100; % Sampling frequency

% Initialize the modal frequencies and shapes based on a physical model
modalFrequencies = calculateModalFrequencies(nModes, 'violin'); % Hypothetical function
modalShapes = calculateModalShapes(nModes, 'violin'); % Hypothetical function

% Initialize the output signal
outputSignal = zeros(1, duration * fs);

% Define a more complex excitation (e.g., a recorded impulse response)
excitation = createComplexExcitation(duration, fs); % Hypothetical function

% Modal synthesis with FM and varied damping
for mode = 1:nModes
    % Apply frequency modulation to the modal frequency
    fmDepth = 50; % Frequency deviation in Hz
    modulatorFrequency = 5; % Modulation frequency in Hz
    fmSignal = sin(2 * pi * modulatorFrequency * (0:duration*fs-1) / fs);
    modulatedFrequency = modalFrequencies(mode) + fmDepth * fmSignal;
    
    % Each mode's response to the excitation with FM and varied damping
    modeResponse = filter(modalShapes(mode), [1, -2*exp(-dampingFactors(mode))*cos(2*pi*modulatedFrequency/fs), exp(-2*dampingFactors(mode))], excitation);
    
    % Add the mode's contribution to the output signal
    outputSignal = outputSignal + modeResponse;
end

% Normalize the output signal
outputSignal = outputSignal / max(abs(outputSignal));

% Plot output signal
N = length(outputSignal);
Ttot = N / fs; % duration in seconds
t = 0 : Ttot/N : Ttot - Ttot/N; % time sequence
figure(1);
plot(t, outputSignal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Enhanced Sound File');

figure(2);
f = (0:N-1)*fs/N;
plot(f, 20*log10(abs(outputSignal)))
grid
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
title('Frequency Spectrum');

% Play the sound
sound(outputSignal, fs);

%% 
% Define the physical parameters of the system
nModes = 10; % Number of modes
damping = linspace(0.01, 0.03, nModes); % Damping factors for each mode
duration = 5; % Duration of the sound in seconds
fs = 44100; % Sampling frequency

% Initialize the modal frequencies and shapes
% For a more realistic model, these values should be based on the physical properties of the instrument
modalFrequencies = [261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25, 587.33, 659.25]; % Frequencies for the first 10 harmonics of C4
modalShapes = linspace(1, 0.1, nModes); % Simplified modal shapes decreasing in amplitude

% Initialize the output signal
outputSignal = zeros(1, duration * fs);

% Define a more realistic excitation (e.g., a soft mallet strike)
excitation = [linspace(0, 1, fs*0.01) linspace(1, 0, fs*0.01) zeros(1, duration*fs - fs*0.02)]; % A simple envelope for the strike

% Modal synthesis
for mode = 1:nModes
    % Each mode's response to the excitation
    modeResponse = filter(modalShapes(mode), [1, -2*exp(-damping(mode))*cos(2*pi*modalFrequencies(mode)/fs), exp(-2*damping(mode))], excitation);
    
    % Add the mode's contribution to the output signal
    outputSignal = outputSignal + modeResponse;
end

% Normalize the output signal
outputSignal = outputSignal / max(abs(outputSignal));

% Plot the time-domain signal
figure(1);
t = (0:length(outputSignal)-1) / fs; % Time vector
plot(t, outputSignal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Time-Domain Signal of the Synthesized Sound');

% Plot the frequency spectrum
figure(2);
f = (0:length(outputSignal)-1) * fs / length(outputSignal); % Frequency vector
magnitude = 20 * log10(abs(fft(outputSignal)));
plot(f, magnitude);
xlim([0 fs/2]); % Limit to half the sampling rate
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Frequency Spectrum of the Synthesized Sound');

% Play the sound
soundsc(outputSignal, fs);

%% 
% Define the physical parameters of the system
nModes = 10; % Number of modes
%damping = linspace(0.01, 0.05, nModes);
damping = [0.01, 0.012, 0.015, 0.018, 0.02, 0.022, 0.025, 0.03, 0.035, 0.04]; % More realistic damping factors
duration = 5; % Duration of the sound in seconds
fs = 44100; % Sampling frequency

% Initialize the modal frequencies and shapes based on a physical model
% These should be derived from actual instrument data
%modalFrequencies = linspace(100, 2000, nModes); % Example frequencies
modalFrequencies = [261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25, 587.33, 659.25]; % Example frequencies
%modalShapes = [1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1]; % Example shapes
modalShapes = linspace(1, 0.1, nModes);
% Initialize the output signal
outputSignal = zeros(1, duration * fs);
% Define a more complex excitation 
%excitation = zeros(1, duration * fs);
%excitation(1) = 1; % Impulse at the beginning

excitation = [linspace(0, 1, fs*0.01) linspace(1, 0, fs*0.01) zeros(1, duration*fs - fs*0.02)]; % A simple envelope for the strike
 
%excitation = sawtooth(2 * pi * 5 * (0:1/fs:duration-1/fs)); % Example of a bowing motion

% Modal synthesis with refined damping and excitation
for mode = 1:nModes
    % Each mode's response to the excitation
    modeResponse = filter(modalShapes(mode), [1, -2*exp(-damping(mode))*cos(2*pi*modalFrequencies(mode)/fs), exp(-2*damping(mode))], excitation);
    
    % Add the mode's contribution to the output signal
    outputSignal = outputSignal + modeResponse;
end

% Apply a saturation effect to introduce nonlinearity
outputSignal = tanh(outputSignal);

% Normalize the output signal
outputSignal = outputSignal / max(abs(outputSignal));
% Plot the time-domain signal
figure(1);
t = (0:length(outputSignal)-1) / fs; % Time vector
plot(t, outputSignal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Time-Domain Signal of the Synthesized Sound');

% Plot the frequency spectrum
figure(2);
f = (0:length(outputSignal)-1) * fs / length(outputSignal); % Frequency vector
magnitude = 20 * log10(abs(fft(outputSignal)));
plot(f, magnitude);
xlim([0 fs/2]); % Limit to half the sampling rate
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Frequency Spectrum of the Synthesized Sound');

% Play the sound
%soundsc(outputSignal, fs);

N = duration * fs; % Length of the velvet noise impulse response
f = 2000; % Frequency (pulse density) of VN sequence
ensureLast = true; % Force the last pulse to occur within the last window

% Generate the velvet noise impulse response
velvetImpulse = velvets(N, f, fs, ensureLast);

% Your existing modal synthesis code here...

% Convolve the output signal with the velvet noise impulse response
reverberatedSignal = conv(outputSignal, velvetImpulse, 'same');

% Normalize the reverberated signal
reverberatedSignal = reverberatedSignal / max(abs(reverberatedSignal));

% Play the sound
sound(reverberatedSignal, fs);
 

