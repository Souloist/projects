%% Inversion and application for speech denoising
% The first part of this document shows the computation
% of the STFT and its inverse using 50 percent overlapping.
% The second part shows how thresholding the STFT representation
% can reduce noise in a speech signal.

%% Load and plot signal
% Load the wav file using the wavread command.

[s, fs] = audioread('sp1.wav');

x = s(1:18944)';    % 73 blocks of length 512 with 50 percent overlap

N = length(x);
plot((1:N)/fs, x)
title('Speech signal')
xlabel('Time (seconds)')

%% Play audio signal
% We can listen to the signal with the soundsc command.

soundsc(x, fs);     % Play the audio file

%% Forward STFT (50 percent overlap, no window)
% Here we compute the STFT using 50 percent overlap, but for
% simplicity we use no window.
% The STFT can be computed using the loop below.
% We use a block length of 512 samples here.

R = 512;
Nb = floor(2*N/R)-1;        % Number of blocks (number of columns of X)
X = zeros(R, Nb);
i = 0;
for k = 1:Nb
    X(:,k) = x(i + (1:R));
    i = i + R/2;
end
X = fft(X);                  % Compute the FFT of each block
Tr = R/fs;                   % Duration of each block (in seconds)

%% Display spectrogram
% The STFT is displayed using the imagesc function.
% Both positive and negative frequencies are shown.
% (Negative frequencies are from 8000 to 16000 Hz.)

imagesc([0 N/fs], [0 fs], abs(X)); 
cmap = flipud(gray);
colormap(cmap);
axis xy 
xlabel('Time (sec.)') 
ylabel('Frequency (Hz)') 
title('Spectrogram') 
colorbar

%%
% Display the STFT for frequencies up to fs/2.
% A lot of the display is white because many of the STFT
% values are small.

imagesc([0 N/fs], [0 fs/2], abs(X(1:R/2, :))); 
colormap(cmap);
colorbar
axis xy 
xlabel('Time (sec.)') 
ylabel('Frequency (Hz)') 
title('Spectrogram') 

%%
% Show in dB to make small values more visible.

imagesc([0 N/fs], [0 fs/2], 20*log10(abs(X(1:R/2, :)))); 
colormap(cmap);
colorbar
axis xy 
xlabel('Time (sec.)') 
ylabel('Frequency (Hz)') 
title('Spectrogram') 
caxis([-20 30])
    
%% Inverse STFT  (50 percent overlap, no window)
% This code shows how to invert the STFT. If correct, 
% we should recover the original speech signal.
% To verify the correctness of the STFT inverse,
% this difference between the original and reconstructed
% speech signals is shown below. As seen in the graph,
% the error is less than 10^(-16), that is zero to computer
% precision.
% Note that the first and last half-block of the inverse STFT
% require their own normalization due to the absence
% of over-lapped blocks.

Y = ifft(X);        % inverse FFT of each column of X
y = zeros(size(x));
i = 0;
for k = 1:Nb
    y(i + (1:R)) = y(i + (1:R)) + 0.5*Y(:, k).';
    i = i + R/2;
end
% Take care of first half-block
y(1:R/2) = 2*y(1:R/2);
% Take care of last half-block
y(end-R/2+(1:R/2)) = 2*y(end-R/2+(1:R/2));

% Display difference signal to verify perfect reconstruction
plot((1:N)/fs, x-y)
title('Reconstruction error')
xlabel('Time (sec.)') 
xlim([0 N/fs])

%% Window for STFT inversion
% When computing the STFT, it is better to multiply each block
% by a window. That will avoid discontinuities at the block
% boundaries in the reconstructed signal when the STFT coefficients
% are processed (quantized or thresholded).
% If the same window is used in both forward and inverse STFT,
% then the window should satisfy a specific
% property so that the STFT is invertible.
% One window satisfying that property is the half-cycle sine window
% shown here.

% half-cycle sine window
n = (1:R) - 0.5;
w  = sin(pi*n/R);

plot(w)
xlim([0 R])
title('Half-cycle sine window')
xlabel('n')

%% Verify the window 
% This code verifies that the window satisfies the 
% perfect reconstruction (PR) property:
% w(n)^2 + w(n+R/2)^2 = 1.
% We need verify this for n = 0,..,R/2-1.
% The plot here shows that the sine window satisfies this condition.

% Verify that the window satisfies the required conditions
pr = w(1:R/2).^2 + w(R/2+(1:R/2)).^2;

% For perfect reconstruction 'pr' should be equal to 1.
plot(pr)
title('Verify perfect reconstruction property')
ylim([0 1.2])
xlim([1 R/2])

%% Forward STFT using a window (50 percent overlap)
% This code shows the computation of the STFT using the
% sine window. Each block is multiplied point-by-point
% with the window.

N = length(x);
Nb = floor(2*N/R)-1        % Number of blocks (columns of X)
X = zeros(R, Nb);
i = 0;
for k = 1:Nb
    X(:,k) = w .* x(i + (1:R));   % multiply signal by window
    i = i + R/2;
end
X = fft(X);                  % Compute the FFT of each block

% Display STFT
imagesc([0 N/fs], [0 fs/2], 20*log10(abs(X(1:R/2+1,:)))); 
colormap(cmap);
caxis([-20 30])
colorbar
axis xy
xlabel('Time (sec.)') 
ylabel('Frequency (Hz)') 
title('Spectrogram') 

%% Inverse STFT using a window (50 percent overlap)
% This code shows the inverse STFT. After the inverse FFT,
% each block is again multiplied point-by-point with the window.
% Note that the first and last half-block require
% separate treatment because of the absence of overlapping
% for those half-blocks.

Y = ifft(X);        % inverse FFT of each column of X
y = zeros(size(x));
i = 0;
for k = 1:Nb
    y(i + (1:R)) = y(i + (1:R)) + w .* Y(:,k).';
    i = i + R/2;
end
% Take care of first half-block
y(1:R/2) = y(1:R/2) ./ (w(1:R/2).^2);
% Take care of last half-block
y(end-R/2+(1:R/2)) = y(end-R/2+(1:R/2)) ./ (w(R/2+1:R).^2);

% Display difference signal to verify perfect reconstruction
plot((1:N)/fs, x-y)
title('Reconstruction error')
xlabel('Time (sec.)')

%% Using a function for STFT
% For convenience, we can put the STFT and inverse STFT 
% in a separate command. 
% This code illustrates the perfect reconstruction property
% of my STFT and inverse STFT functions.
% My STFT and inverse STFT functions use the half-cycle sine window.

[s, fs] = audioread('sp1.wav');
N = 20000;
x = s(1:N)';
R = 512;
X = my_stft(x,R);     % function for STFT
y = my_istft(X);      % function for inverse STFT
err = x - y(1:N);
ME = max(abs(err))

% display STFT
imagesc([0 N/fs], [0 fs/2], 20*log10(abs(X(1:R/2+1, :)))); 
colormap(cmap);
caxis([-20 30])
colorbar
axis xy 
xlabel('Time (sec.)') 
ylabel('Frequency (Hz)') 
title('Spectrogram') 

%% Noise reduction using STFT and thresholding
% In the rest of this document, we illustrate the use of the STFT
% to filter a noisy speech signal.
% We simulate a noisy speech signal by adding white Gaussian
% noise to a noise-free speech signal.
% The method described below is a basic form of 'Spectral Subtraction',
% a method for speech noise reduction.

[s, fs] = audioread('sp1.wav');
N = 20000;
s = s(1:N)';
T = N/fs;                          % T: duration of signal (sec)

noise = 0.01 * randn(size(s));      % Make noise
x = s + noise;                      % Add noise
soundsc(x, fs);                     % Play noisy speech signal
audiowrite('noisy_speech.wav', x, fs);

plot((1:N)/fs,x)
title('Noisy signal')
xlabel('Time (sec.)') 

%% STFT of noisy speech signal
% Note that the STFT of the noisy speech signal is noisy.
% The noise is spread across time and frequency.

R = 512;
X = my_stft(x,R);

% Display STFT
imagesc([0 N/fs], [0 fs/2], 20*log10(abs(X(1:R/2, :)))); 
colormap(cmap);
caxis([-20 30])
colorbar
axis xy
xlabel('Time (sec.)') 
ylabel('Frequency (Hz)') 
title('Spectrogram of noisy speech signal') 

%% Apply threshold in STFT domain
% Much of the noise can be eliminated by simply setting the small
% STFT coefficients to zero.
% We define a threshold value and set all values less than the
% threshold value to zero.
% Now the STFT is much less noisy.

Y = X;
Threshold = 0.5;
k = abs(Y) < Threshold;
Y(k) = 0;
Y(:,1) = 0;   % remove start transients
Y(:,end) = 0;   % remove end transients

% display STFT
imagesc([0 N/fs], [0 fs/2], 20*log10(abs(Y(1:R/2, :)))); 
colormap(cmap);
caxis([-20 30])
colorbar
axis xy 
xlabel('Time (sec.)') 
ylabel('Frequency (Hz)') 
title('Spectrogram after thresholding') 

%% Denoised speech signal
% The processed speech signal is obtained by simply computing the inverse
% STFT.  The processed speech is much less noisy than the noisy
% speech signal. However, the processed speech is a bit distorted.
% You should be able to hear a difference between the
% noise-free speech and the processed speech.
% The processed speech signal is not as crisp.

y = my_istft(Y);
y = y(1:N);
audiowrite('processed_speech.wav', y, fs);

plot((1:N)/fs, y)
xlabel('Time (sec.)') 
title('Processed signal') 

%%

soundsc(y, fs)

%% Compare noisy and processed speech fragments
% Here we compare a fragment of the noisy speech and 
% the processed speech. The noise is visibly reduced.

n = 8401:9800;
subplot(2, 1, 1)
plot(n/fs, x(n))
title('Noisy speech - One segment')
axis tight

subplot(2, 1, 2)
plot(n/fs, y(n))
title('Processed speech - One segment')
axis tight

%% Lower threshold value
% To reduce the speech distortion caused by thresholding,
% we can use a lower threshold value. 
% This code repeats the thresholding step but now with a smaller
% threshold value. 
% Looking carefully at the STFT, it can be seen that more
% values in the STFT exceed the threshold and are not
% eliminated by the threshold operation.  Many of these
% values are scattered accross time and frequency; they are not part
% of the speech signal components.
% These are spurious noise spikes in the STFT.

Y = X;
Threshold = 0.3;
k = abs(Y) < Threshold;
Y(k) = 0;
Y(:,1) = 0;   % Remove start transients
Y(:,end) = 0;   % Remove end transients

% display STFT
clf
imagesc([0 N/fs], [0 fs/2], 20*log10(abs(Y(1:R/2, :)))); 
colormap(cmap);
caxis([-20 30])
colorbar
axis xy 
xlabel('Time (sec.)') 
ylabel('Frequency (Hz)') 
title('Spectrogram after thresholding') 


%% Musical noise artifact
% The spurious noise spikes in the STFT are audible as 'musical noise'
% in the processed speech signal. Listen to the signal.
%
% The choice of threshold value is therefore quite important for
% perceptual quality of this method.
% Moreover, one would like an automatic way to select a good
% threshold value. 
% 
% Additionally, different threshold functions can be used.
% Instead of the threshold function used here, a 'soft-threshold'
% function can be applied to the noisy STFT to reduce the musical noise.

y = my_istft(Y);
y = y(1:N);
audiowrite('processed_speech_2.wav', y, fs);

plot((1:N)/fs, y)
xlabel('Time (sec.)') 
title('Processed signal')

soundsc(y, fs)

%% Noise reduction with STFT with no window
% When no window is used in the STFT (that is,
% the window is rectangular), then STFT-domain
% thresholding can lead to discontinuities at
% the block boundaries. 
% Although it is not always very visible in the
% signal waveform, it can be audible in the reconstructed
% signal as a periodic interference.
% The audible artifact due to using no window is different than the musical noise
% artifact. The discontinuties that
% are present at the block boundaries occur at periodic 
% locations (at the block boundaries) and not randomly in time-frequency
% like musical noise.

% Compute STFT
R = 512;
X = my_stft_nowin(x, R);

% Apply threshold in STFT domain
Y = X;
Threshold = 0.8;
k = abs(Y) < Threshold;
Y(k) = 0;
Y(:,1) = 0;   % remove start transients
Y(:,end) = 0;   % remove end transients

% Invert STFT
y = my_istft_nowin(Y);
y = y(1:N);
audiowrite('processed_speech_nowindow.wav', y, fs);
soundsc(y, fs)
