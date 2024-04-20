 function y = endless_sound(signal, N, f, Fs, ensureLast)
    % INPUT
    % signal : the short signal segment to be extended
    % N : size of signal to generate
    % f : frequency (pulse density) of VN sequence
    % Fs : Samplerate
    % ensureLast : (optional) boolean. If pulse period doesn't divide
    %              evenly into N, force the last pulse to occur within the
    %              last window regardless of its size
    %
    % OUTPUT
    % y : output signal, length N

    % Generate the velvet noise
    vn = velvets(N, f, Fs, ensureLast);

    % Convolve the signal segment with the velvet noise using circular convolution
  y = ifft(fft(signal, N).' .* fft(vn, N));

    % Normalize the output signal
    y = y / max(abs(y));
end

