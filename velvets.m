function y =  velvets(N, f, Fs, ensureLast)
    % INPUT
    % N : size of signal to generate
    % f : frequency (pulse density) of VN sequence
    % Fs : Samplerate
    % M : number of sequences combined
    % ensureLast : (optional) boolean. If pulse period doesn't divide
    %              evenly into N, force the last pulse to occur within the
    %              last window regardless of its size
    %
    % OUTPUT
    % y : output signal, length N

    % The pulse period is calculated as the sample rate divided by the frequency.
    T = Fs/f;        % pulse period

    % The number of pulses to generate is the ceiling of the size of the signal divided by the pulse period.
    nP = ceil(N/T);  % number of pulses to generate

    % Initialize the output signal as a zero vector of length N.
    y = zeros(N, 1); % output signal

    % For each pulse to be generated...
    for m = 0:nP-1                              % m needs to start at 0

        % Calculate the location of the pulse within this pulse period.
        p_idx = round((m*T) + rand()*(T-1));    % k_m, location of pulse within this pulse period

        % If the pulse location is within the bounds of the signal...
        if (p_idx <= N)                         % make sure the last pulse is in bounds (in case nP was fractional)

            % Insert a pulse (either 1 or -1) at the calculated location.
            y(p_idx+1) = 2 * round(rand()) - 1; % value of pulse: 1 or -1
                                                % p_idx+1: bump from 0- to 1-based indexing
        % If the 'ensureLast' argument is provided and is true...
        elseif nargin > 4
            if ensureLast

                % Force the last pulse to occur within the last window, regardless of its size.
                p_idx = round((m*T) + rand()*(T-1-mod(N,T)));
                y(p_idx+1) = 2 * round(rand()) - 1; 

                % Display a message indicating that the last pulse was forced within bounds.
                disp('forcing last pulse within bounds')
            end
        end                                           
    end
%%
%reference:https://github.com/mtmccrea/LateVelvet/blob/master/matlab/functions/velvet.m 
