clc; 
clear; 
 %load audiofile
[signal, Fs] = audioread('staticBand.wav');
%convert to mono
if size (signal,2)==2
    signal=mean(signal,2);
end

 
% Define the parameters for the flanger effect, such as depth, rate, predelay, and wet
depth = 0.5; % range of modulation (samples)
rate = 0.1; % speed of modulation (frequency, Hz)
predelay = 25; % offset of modulation (samples)
wet = 50; % percent of processed signal (dry = 100 – wet)

% Create a delay buffer to hold the maximum possible delay time
 
 buffer=zeros(51,1);
% Initialize the output signal as a zero vector with the same length as the input signal
output = zeros(size(signal));
 
% Use a for loop to iterate over each sample of the input signal
for n = 1:length(signal)
    % Call the function with the input sample, the delay buffer, the sampling frequency, the current sample index, and the flanger parameters as inputs
    [output(n), buffer, lfo] = barberpoleFlanger(signal(n), buffer, Fs, n, depth, rate, predelay, wet);
end

 

% Play  and save processed audio sample using the audioplayer or audiowrite functions
audiowrite('processed_audio.wav', output, Fs);
soundsc(output,Fs);
%soundsc(signal,Fs);

% Create a new figure
figure;

% Calculate and plot the spectrogram for the input signal
subplot(2, 1, 1);
spectrogram(signal, 256, [], [], Fs, 'yaxis');
title('Spectrogram of Input Signal');

% Calculate and plot the spectrogram for the output signal
subplot(2, 1, 2);
spectrogram(output, 256, [], [], Fs, 'yaxis');
title('Spectrogram of Output Signal');
%% reference
%1.Eric Tarr,Hack Audio An Introduction to Computer Programming and
%Digital Signal Processing in MATLAB(i used the barberpoleFlanger function from this book)
%2.mathworks(documentation)
