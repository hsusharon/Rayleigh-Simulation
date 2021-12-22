f1 = figure;
f2 = figure;
f3 = figure;
f4 = figure;
f5 = figure;
f6 = figure;
f7 = figure;
f8 = figure;
f9 = figure;
f10 = figure;

%%
rayChan = comm.RayleighChannel('SampleRate',2000,'MaximumDopplerShift',20);
sig = 1i*ones(2000,1); % Signal
out_low  = rayChan(sig); % Pass signal through channel

%display magnitude and phase
figure(f1);
plot(20*log10(abs(out_low)));
title('Power of faded signal fm=20');
figure(f3);
phase = angle(out_low);
plot(phase);
title('Rayleigh Phase response fm=20');

%plot spectrogram of the signal
figure(f5);
outlow_freqdomain = fft(out_low);
n = length(out_low);          % number of samples
f = (0:n-1)*(2000/n);     % frequency range
power = abs(outlow_freqdomain).^2/n;    % power of the DFT
plot(f,power)
xlabel('Frequency')
ylabel('Power')
%plot(abs(outlow_freqdomain)/20);
title('Frequency Domain magnitude fm=20');

%plot distribution of slow fading
figure(f7)
rayChan = comm.RayleighChannel('SampleRate',2000,'MaximumDopplerShift',20);
sig = 1i*ones(20000,1); % Signal
out_low  = rayChan(sig); % Pass signal through channel.
distribution_r_low = abs(out_low);
histogram(distribution_r_low);
title('Distribution of magnitude after the channel fm=20');

%calculate the correlation of the received signal
figure(f9)
%%relation_low = zeros(20000);
%%for c = 1:20000
    %%relation_low(c) = corrcoef(out_low(1), out_low(c));
%%end
distribution_r_low = abs(out_low);
relation_low = xcorr(out_low);
histogram(abs(relation_low));
title('Correlation of slow fading');

%%

%%%fast fading channel
rayChan = comm.RayleighChannel('SampleRate',2000,'MaximumDopplerShift',200);
sig = 1i*ones(2000,1); % Signal
out_high = rayChan(sig); % Pass signal through channel.

%display magnitude and phase
figure(f2);
plot(20*log10(abs(out_high)));
title('Power of faded signal fm=200');
figure(f4);
phase = angle(out_high);
plot(phase);
title('Rayleigh Phase response fm=200');

%plot spectrogram
figure(f6);
outhigh_freqdomain = fft(out_high);
n = length(out_high);          % number of samples
f = (0:n-1)*(2000/n);     % frequency range
power = abs(outhigh_freqdomain).^2/n;    % power of the DFT
plot(f,power)
xlabel('Frequency')
ylabel('Power')
%plot(abs(outhigh_freqdomain));
title('Frequency Domain magnitude fm=200');

%plot distributiion of fast fading
figure(f8)
rayChan = comm.RayleighChannel('SampleRate',2000,'MaximumDopplerShift',200);
sig = 1i*ones(20000,1); % Signal
out_high  = rayChan(sig); % Pass signal through channel.
distribution_r_high = abs(out_high);
histogram(distribution_r_high);
title('Distribution of magnitude after the channel fm=200');

figure(f10)
distribution_r_high = abs(out_high);
relation_high = xcorr(out_high);
histogram(abs(relation_high));
title('Correlation of fast fading');

%%


