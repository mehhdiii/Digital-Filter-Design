%% reading File: 
Fs = 44100; 
[s,Fs]=audioread('NoisyHUAnthem.wav'); 
% sound(s,Fs); 
pause(5); 

%% Analysis: 
N = length(s); % determine length of signal 
n = ceil(log2(N)); % ceil to the closest power of 2
N = 2^n; % use this N for fft 
X= fft(s, N); 

f = linspace(0, Fs,N);
stem(f, abs(X), '.')

set(gca, 'XTickLabel', get(gca, 'XTick'));
title('Original signal: DFT Magnitude response')
print -deps dft_original.eps

%% Filtering: 
close all
filter_coeffs = load('lpf_a.mat')
filtered = filter(filter_coeffs.Hd, s);
sound(filtered,Fs);

%calculate fft: 
N = length(filtered); % determine length of signal 
n = ceil(log2(N)); % ceil to the closest power of 2
N = 2^n; % use this N for fft 
X= fft(filtered, N);

figure()
stem(f, abs(X), '.')
title('Filtered signal DFT')
xlabel('f (Hz)')
set(gca, 'XTickLabel', get(gca, 'XTick'));
title('Filtered signal: DFT Magnitude response')
print -deps dft_filtered.eps
audiowrite('recovered.wav', filtered, Fs)
