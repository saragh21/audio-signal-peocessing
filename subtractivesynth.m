 clear;clc;

%% Parameters
Fs = 44100; % Sampling frequency
Ts = 1/Fs; % Sampling period
t = 0:Ts:1-Ts; % Time vector

f0 = 440; % Fundamental frequency

% Generate a square wave
squareWave = square(2*pi*f0*t);

% Generate a sawtooth wave
sawtoothWave = sawtooth(2*pi*f0*t);

% Design a low-pass filter
lpf = designfilt('lowpassiir', 'FilterOrder', 8, 'PassbandFrequency', 880, 'PassbandRipple', 0.2, 'SampleRate', Fs);

% Apply the filter to the waveforms
filteredSquareWave = filter(lpf, squareWave);
filteredSawtoothWave = filter(lpf, sawtoothWave);

% Generate a sinusoidal signal
f = 2; % frequency in Hz
phi = 0; % phase offset
Fs_sin = 100; % sampling rate for sinusoid
Ts_sin = 1/Fs_sin; % sampling period for sinusoid
lenSec = 5; % 5 second long signal
N_sin = Fs_sin*lenSec; % convert to time samples for sinusoid
t_sin = 0:Ts_sin:5-Ts_sin; % Time vector for sinusoid
sinusoid = sin(2*pi*f*t_sin+phi);

% Apply subtractive synthesis
synthesizedSquareWave = sinusoid .* filteredSquareWave(1:N_sin)';
synthesizedSawtoothWave = sinusoid .* filteredSawtoothWave(1:N_sin)';

% Plot the original and synthesized signals
figure;

plot(t_sin, sinusoid);
hold on;
plot(t_sin, synthesizedSquareWave);
hold on;
plot(t_sin, synthesizedSawtoothWave)
xlabel('Time (sec.)'); ylabel('Amplitude');
legend('Original Sinusoid', 'Synthesized Square Wave','synthesized sawtooth wave');


%%

% Convert to mono
synthesizedSquareWaveMono = mean(synthesizedSquareWave, 2);
synthesizedSawtoothWaveMono = mean(synthesizedSawtoothWave, 2);

% Normalize to [-1, 1]
synthesizedSquareWaveMono = synthesizedSquareWaveMono / max(abs(synthesizedSquareWaveMono));
synthesizedSawtoothWaveMono = synthesizedSawtoothWaveMono / max(abs(synthesizedSawtoothWaveMono));



% Play sounds
soundsc(sinusoid,Fs);
pause(2);
sound(synthesizedSquareWaveMono, Fs);
pause(2);
sound(synthesizedSawtoothWaveMono, Fs);

% Plot the original and synthesized signals
figure;

plot(t_sin, sinusoid);
hold on;
plot(t_sin, synthesizedSquareWaveMono);
hold on;
plot(t_sin, synthesizedSawtoothWaveMono)
xlabel('Time (sec.)'); ylabel('Amplitude');
legend('Original Sinusoid', 'Synthesized Square Wave','synthesized sawtooth wave');
%%

% Compute the FFT of the original and synthesized signals
Y = fft(sinusoid);
Y_square = fft(synthesizedSquareWaveMono);
Y_sawtooth = fft(synthesizedSawtoothWaveMono);

% Compute the frequency vector
f = Fs*(0:(N_sin/2))/N_sin;

% Plot the frequency spectrum of the original and synthesized signals
figure;
subplot(3,1,1);
plot(f, abs(Y(1:N_sin/2+1)));
title('Frequency Spectrum of Original Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3,1,2);
plot(f, abs(Y_square(1:N_sin/2+1)));
title('Frequency Spectrum of Synthesized Square Wave');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3,1,3);
plot(f, abs(Y_sawtooth(1:N_sin/2+1)));
title('Frequency Spectrum of Synthesized Sawtooth Wave');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

 

 
