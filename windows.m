clc;
close all;
clear;

%% Generate a pure tone signal
fs = 1000; % sampling frequency
f = 105; % signal frequency
N = 128; % signal length
n = 0:N-1; % time index
x = sin(2*pi*f*n/fs); % signal
%%  Plot the original signal
figure
plot(n,x)
xlabel('Time index')
ylabel('Amplitude')
title('Original signal')


%% Choose a DFT length(higher than the signal lenght to increase frequency
% resolution)
M = 256; % DFT length
if M > N
    x = [x zeros(1,M-N)]; % pad signal with zeros
end

 

%% Apply different window functions and normalized the output
w1 = window('rectwin',M); % rectangular window
w2 = window('hann',M); % Hanning window
w3 = window('hamming',M); % Hamming window
w4 = window('blackman',M); % Blackman window

x1 = x.*w1'; % windowed signal 1
x2 = x.*w2'; % windowed signal 2
x3 = x.*w3'; % windowed signal 3
x4 = x.*w4'; % windowed signal 4

% Compute the DFT of the windowed signals
X1 = fft(x1)/M; % DFT of signal 1
X2 = fft(x2)/M; % DFT of signal 2
X3 = fft(x3)/M; % DFT of signal 3
X4 = fft(x4)/M; % DFT of signal 4

 

%% Plot the magnitude spectra in logarithmic scale
f = (0:M-1)*fs/M; % frequency vector
subplot(2,2,1)
semilogy(f,abs(X1))
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
title('Rectangular window')
subplot(2,2,2)
semilogy(f,abs(X2))
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
title('Hanning window')
subplot(2,2,3)
semilogy(f,abs(X3))
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
title('Hamming window')
subplot(2,2,4)
semilogy(f,abs(X4))
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
title('Blackman window')

%% output analyzing
%The rectangular window has the best amplitude resolution, but the worst
% spectral leakage.
%The Hanning window has a good balance between amplitude resolution and 
% spectral leakage, but a lower frequency resolution.
%The Hamming window has a similar performance as the Hanning window,
% but a slightly higher spectral leakage and dynamic range.
%The Blackman window has the best spectral leakage, but the worst amplitude
% and frequency resolution. It also has the highest dynamic range.
