 function y = giantFFT(x, fs, fs_new)
    % x: input signal
    % fs: original sample rate
    % fs_new: new sample rate

    % Compute the FFT of the input signal
    X = fft(x);

    % Compute the length of the original and new signals
    N = length(x);
    N_new = round(N * fs_new / fs);

    % Create a new spectrum with the same length as the new signal
    X_new = zeros(N_new, 1);

    % Copy the positive frequencies of the original spectrum to the new spectrum
    X_new(1:N/2) = X(1:N/2);

    % If up-sampling, insert zeros between the positive and negative frequencies
    if fs_new > fs
        X_new(N/2+1:N_new-N/2) = 0;
    end

    % Copy the negative frequencies of the original spectrum to the new spectrum
    X_new(end - N/2 + 2:end) = X(end - N/2 + 2:end);

    % Divide the Nyquist bin (real-valued) in two
    X_new(N/2 + 1) = X(N/2 + 1) / 2;
    X_new(end - N/2 + 1) = X(N/2 + 1) / 2;

    % Compute the inverse FFT of the new spectrum
    y = ifft(X_new);

    % Scale the output signal by the ratio of the new and original sample rates
    y = y * fs_new / fs;
end
