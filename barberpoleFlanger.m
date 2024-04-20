% BARBERPOLEFLANGER

%
% Input Variables
% in : single sample of the input signal
% buffer : used to store delayed samples of the signal
% n : current sample number used for the LFO
% depth : range of modulation (samples)
% rate : speed of modulation (frequency, Hz)
% predelay : offset of modulation (samples)
% wet : percent of processed signal

function [out,buffer,lfo] = barberpoleFlanger(in,buffer,Fs,n,depth,rate,predelay,wet)
% Calculate time in seconds for the current sample
t = (n-1)/Fs;
lfo = depth * sawtooth(2*pi*rate*t,0) + predelay;
% Wet/dry mix
mixPercent = wet; % 0 = only dry, 100 = only feedback
mix = mixPercent/100;
fracDelay = lfo;
intDelay = floor(fracDelay);
frac = fracDelay - intDelay;
% Store dry and wet signals
drySig = in;
wetSig = (1-frac)*buffer(intDelay,1) + (frac)*buffer(intDelay+1,1);
% Blend parallel paths
out = (1-mix)*drySig + mix*wetSig;
% Feedback is created by storing the output in the
% buffer instead of the input
buffer = [in ; buffer(1:end-1,1)];

 
