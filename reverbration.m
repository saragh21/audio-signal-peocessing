
clc;close all;clear all;
%% Define parameters
N = 10000; % For example, one second of audio at a 44.1 kHz sample rate
f=2000;
Fs = 44100; % Sample rate
M = 10;     % Number of sequences to combine
ensureLast = true; % Force the last pulse to occur within the last window
decayRate = 0.50; % decay rate
frequencies = linspace(100, 1500, M); % Create an array of frequencies

% Initialize the output signal
Y = zeros(N, 1);

% Generate M sequences
for i = 1:M
    Y = Y + velvets(N, frequencies(i), Fs, ensureLast);
end

% Normalize the output
Y = Y / M;
% Apply feedback filter to each velvet noise sequence
 
b = [1, -decayRate]; % filter coefficients
Y = filter(b, 1, Y);


% Now Y contains the late reverberation
[x,Fs]=audioread('december_tour.wav'); 
%soundsc(x,Fs);
% Convolve the input signal with the impulse response
output = conv(x, Y);
audiowrite("reverbed_december_tour.wav",output,Fs);
soundsc(output,Fs);

%%

Y = velvets(N, f, Fs);

% Plot the impulse response
figure;
plot(Y);
xlabel('Sample');
ylabel('Amplitude');
title('Impulse Response of Velvet Noise');

%%
figure;
plot(x);
xlabel('Sample');
ylabel('Amplitude');
title('input Signal');

%%
figure;
plot(output);
xlabel('Sample');
ylabel('Amplitude');
title('Output Signal');



