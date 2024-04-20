clc;
close all;
clear;
 
%% Load an audio signal
[data,fs] = audioread('Exercise4.wav');
soundsc(data,fs);
%% Define the parameters for the STFT
window_length = 256; % window length in samples
overlap_length = 128; % overlap length in samples
fft_length = 512; % FFT length in samples
window_function = 'hamming'; % window function name

% Choose a different window function
% window_function = 'hann';
% window_function = 'blackman';
%window_function = 'kaiser';

% Choose a different window length
%window_length = 128;
%window_length = 512;

% choose different overlap length in samples
%overlap_length = 64;
%overlap_length = 256;

% Choose a different FFT length
%fft_length = 256;
%fft_length = 1024;



% Create the window vector
w = window (window_function, window_length);

% Pre-allocate the STFT output matrix
nframes = fix ((length (data) - overlap_length) / (window_length - overlap_length)); % number of frames
s = zeros(fft_length, nframes); % STFT matrix

% Loop over the frames
for k = 1:nframes
    % Extract a segment of the signal
    xseg = data ((k-1) * (window_length - overlap_length) + 1 : (k-1) * (window_length - overlap_length) + window_length);
    
    % Apply the window function
    xw = w .* xseg;
    
    % Zero pad the windowed segment
    xwz = [xw; zeros(fft_length - window_length, 1)];
    
    % Compute the FFT of the windowed and zero padded segment
    s (:,k) = fft (xwz);
end
 
% Plot the magnitude of the STFT in decibels
sdb = mag2db (abs (s));
imagesc (sdb);
colorbar;
xlabel ('Time (frames)');
ylabel ('Frequency (bins)');
title ('STFT of audio signal');

%% Explanation
% The parameters of STFT( window length, overlap and fft length) affect 
% how the signal is divided into segments and howthe FFT is computed for 
% each segment.
%I used Some common window functions are Hamming, Hann, Blackman, and Kaiser.
% different window functions have different properties, such as the main 
% lobe width, the side lobe level, and the spectral leakage.  
%The window length determines the duration of each segment.
% A longer window length gives better frequency resolution but worse 
% time resolution, because it captures more frequency components but 
% less temporal variations. In contrast, a shorter window length gives better
% time resolution but worse frequency resolution.
%he overlap length determines the number of samples that are shared between
% two consecutive segments. A larger overlap length gives better 
% continuity and smoothness of the STFT output
%The FFT length determines the number of sampling points used to compute 
% the FFT of each segment. A larger FFT length gives finer frequency resolution 
% and less aliasing, but also increases the computation time and zero padding.
% A smaller FFT length gives faster computation and less zero padding, but 
% also reduces the frequency resolution and increases the aliasing.
% Zero padding is done to increase the frequency resolution of the FFT and 
% to avoid aliasing. If the FFT length is smaller than or equal to the
% window length, then no zero padding is needed.

%% reference
%1.https://www.mathworks.com/help/signal/ref/stft.html
 
