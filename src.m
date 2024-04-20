
clc;close all; clear all;

%%
% a distorted sine wave
fs = 44100; % Original sample rate in Hz
t = 0:1/fs:1-1/fs; % Time vector
x = sin(2*pi*1000*t) + 0.5*randn(size(t)); % Distorted sine wave

% Specify the new sample rate
fs_new = 48000; % New sample rate in Hz

% Apply the giantFFT function
y = giantFFT(x, fs, fs_new);

% Now y is the signal x resampled at the new sample rate fs_nee
%%
% Compute the FFT of the original and resampled signals
X = abs(fft(x));
Y = abs(fft(y));

% Compute the frequency vectors for the original and resampled signals
f = (0:length(X)-1)*fs/length(X);
f_new = (0:length(Y)-1)*fs_new/length(Y);

% Plot the magnitude spectra of the original and resampled signals
figure;
subplot(2,1,1);
plot(f, 20*log10(X));
title('Magnitude Spectrum of Original Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

subplot(2,1,2);
plot(f_new, 20*log10(Y));
title('Magnitude Spectrum of Resampled Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
