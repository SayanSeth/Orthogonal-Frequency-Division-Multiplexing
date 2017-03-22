% Design filter by specifying delay in units and
% looking at mag and phase response
% Good default values for fft_size = 128 and num_carriers = 32
delay_1 = 6; % 6
attenuation_1 = 0.35; % 0.35
delay_2 = 10; % 10
attenuation_2 = 0.30; % 0.30
num = [1, zeros(1, delay_1-1), attenuation_1, zeros(1, delay_2-delay_1-1), attenuation_2];
[H, W] = freqz(num, 1, 512); % compute frequency response
mag = 20*log10(abs(H)); % magnitude in dB
phase = angle(H) * 180/pi; % phase angle in degrees
figure(9), clf
subplot(211), plot(W/(2*pi),mag)
title('Magnitude response of multipath channel')
xlabel('Digital Frequency'), ylabel('Magnitude in dB')
subplot(212), plot(W/(2*pi),phase)
title('Phase response of multipath channel')
xlabel('Digital Frequency'), ylabel('Phase in Degrees')
break
% Design filter using MATLAB command 'fir2'
nn = 40; % order of filter
f = [0, 0.212, 0.253, 0.293, 0.5];
m =[1, 1, 0.5, 1, 1];
num = fir2(nn, 2*f, m);
den = 1;
[H, W] = freqz(num, den, 256); % Compute freq response
mag = 20*log10(abs(H)); % Get mag in dB
phase = angle(H)*180/pi; % Get phase in degrees
clf
subplot(211), plot(W/(2*pi),mag)
subplot(212), plot(W/(2*pi),phase)
break
% Design filter using MATLAB command 'fir1'
% These coeffs work well for OFDM vs. QAM!!!
% nn = 4; % order of filter
% wl = 0.134; % low cutoff of stopband
% wh = 0.378; % high cutoff of stopband
% nn = 4; % order of filter
% wl = 0.195; % low cutoff of stopband
% wh = 0.309; % high cutoff of stopband
nn = 8; % order of filter
wl = 0.134; % low cutoff of stopband
wh = 0.378; % high cutoff of stopband
num = fir1(nn, 2*[wl, wh], 'stop');
den = 1;
[H, W] = freqz(num, den, 256); % Compute freq response
mag = 20*log10(abs(H)); % Get mag in dB
phase = angle(H)*180/pi; % Get phase in degrees
clf
subplot(211), plot(W,mag), hold on, plot(wl*2*pi,0,'o'), plot(wh*2*pi,0,'o')
subplot(212), plot(W,phase), hold on, plot(wl*2*pi,0,'o'), plot(wh*2*pi,0,'o')
hold off
break
% Design filter by specifying delay in units and looking at mag and phase response
n = 512;
d1 =4;
a1 = 0.2;
d2 = 5;
a2 = 0.3;
num = [1, zeros(1, d1-1), a1, zeros(1, d2-d1-1), a2]
den = [1];
[H, W] = freqz(num, den, n);
% F = 0:.1:pi;
% H = freqz(num, den, F*180/pi, 11025);
mag = 20*log10(abs(H));
% phase = angle(H * 180/pi);
phase = angle(H);
clf
subplot(211), plot(W,mag), hold on, plot(0.17*pi,0,'o'), plot(0.34*pi,0,'o')
subplot(212), plot(W,phase), hold on, plot(pi/2,0,'o')
hold off
break
% Design filter by specifying mag response at particular frequencies
n = 2;
f = [0, 0.25, 0.5];
mag = [1, .05, 1];
[num, den] = yulewalk(n,2*f,mag);
[H, W] = freqz(num, den);
mag = 20*log10(abs(H));
phase = angle(H * 180/pi);
clf
subplot(211), plot(W,mag)
subplot(212), plot(W,phase)