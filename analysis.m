% Analysis
disp(' '), disp('------------------------------------------------------------')
disp('Preparing Analysis')
figure(1), clf
if (input_type == 1) & (test_input_type == 1)
subplot(221), stem(data_in), title('OFDM Binary Input Data');
subplot(223), stem(output), title('OFDM Recovered Binary Data')
else
subplot(221), plot(data_samples), title('OFDM Symbol Input Data');
subplot(223), plot(output_samples), title('OFDM Recovered Symbols');
end
subplot(222), plot(xmit), title('Transmitted OFDM');
subplot(224), plot(recv), title('Received OFDM');
% dig_x_axis = (1:length(QAM_tx_data))/length(QAM_tx_data);
% figure(4), clf, subplot(212)
% freq_data = abs(fft(QAM_rx_data));
% L = length(freq_data)/2;
dig_x_axis = (1:length(xmit))/length(xmit);
figure(2), clf
if channel_on ==1
num = [1, zeros(1, d1-1), a1, zeros(1, d2-d1-1), a2];
den = [1];
[H, W] = freqz(num, den, 512);
mag = 20*log10(abs(H));
phase = angle(H) * 180/pi;
subplot(313)
freq_data = abs(fft(recv));
L = length(freq_data)/2;
plot(dig_x_axis(1:L), freq_data(1:L))
xlabel('FFT of Received OFDM')
axis_temp = axis;
subplot(311),
freq_data = abs(fft(xmit));
plot(dig_x_axis(1:L), freq_data(1:L)), axis(axis_temp)
title('FFT of Transmitted OFDM')
subplot(312)
plot(W/(2*pi),mag),
ylabel('Channel Magnitude Response')
else
subplot(212)
freq_data = abs(fft(recv));
L = length(freq_data)/2;
plot(dig_x_axis(1:L), freq_data(1:L))
xlabel('FFT of Received OFDM')
axis_temp = axis;
subplot(211),
freq_data = abs(fft(xmit));
plot(dig_x_axis(1:L), freq_data(1:L)), axis(axis_temp)
title('FFT of Transmitted OFDM')
end
% if file_input_type == 4
% figure(5)
% subplot(211)
% image(data_in);
% colormap(map);
% subplot(212)
% image(output);
% colormap(map);
% end
if do_QAM == 1 % analyze if QAM was done
figure(3), clf
if (input_type == 1) & (test_input_type == 1)
subplot(221), stem(data_in), title('QAM Binary Input Data');
subplot(223), stem(QAM_data_out), title('QAM Recovered Binary Data')
else
subplot(221), plot(data_samples), title('QAM Symbol Input Data');
subplot(223), plot(QAM_output_samples), title('QAM Recovered Symbols');
end
subplot(222), plot(QAM_tx_data), title('Transmitted QAM');
subplot(224), plot(QAM_rx_data), title('Received QAM');
dig_x_axis = (1:length(QAM_tx_data))/length(QAM_tx_data);
figure(4), clf
if channel_on ==1
subplot(313)
freq_data = abs(fft(QAM_rx_data));
L = length(freq_data)/2;
plot(dig_x_axis(1:L), freq_data(1:L))
xlabel('FFT of Received QAM')
axis_temp = axis;
subplot(311),
freq_data = abs(fft(QAM_tx_data));
plot(dig_x_axis(1:L),freq_data(1:L)), axis(axis_temp)
title('FFT of Transmitted QAM')
subplot(312)
plot(W/(2*pi),mag)
ylabel('Channel Magnitude Response')
else
subplot(212)
freq_data = abs(fft(QAM_rx_data));
L = length(freq_data)/2;
plot(dig_x_axis(1:L), freq_data(1:L))
title('FFT of Received QAM')
axis_temp = axis;
subplot(211),
freq_data = abs(fft(QAM_tx_data));
plot(dig_x_axis(1:L),freq_data(1:L)), axis(axis_temp)
title('FFT of Transmitted QAM')
end
% Plots the QAM Received Signal Constellation
figure(5), clf, plot(xxx,yyy,'ro'), grid on, axis([-2.5 2.5 -2.5 2.5]), hold on
% % Overlay plot of transmitted constellation
% x_const = [-1.5 -0.5 0.5 1.5 -1.5 -0.5 0.5 1.5 -1.5 -0.5 0.5 1.5 -1.5 -0.5 0.5 1.5];
% y_const = [-1.5 -1.5 -1.5 -1.5 -0.5 -0.5 -0.5 -0.5 0.5 0.5 0.5 0.5 1.5 1.5 1.5 1.5];
% plot(x_const, y_const, 'b*')
% Overlay of constellation boundarys
x1 = [-2 -2]; x2 = [-1 -1]; x3 = [0 0]; x4 = [1 1]; x5 = [2 2]; x6 = [-2 2];
y1 = [-2 -2]; y2 = [-1 -1]; y3 = [0 0]; y4 = [1 1]; y5 = [2 2]; y6 = [-2 2];
plot(x1,y6), plot(x2,y6), plot(x3,y6), plot(x4,y6), plot(x5,y6)
plot(x6,y1), plot(x6,y2), plot(x6,y3), plot(x6,y4), plot(x6,y5)
hold off
title('16-QAM Received Signal Constellation and Decision Boundarys')
binary_err_bits_QAM = 0;
for i = 1:length(data_in)
err = abs(data_in(i)-QAM_data_out(i));
if err > 0
binary_err_bits_QAM = binary_err_bits_QAM + 1;
end
end
BER_QAM = 100 * binary_err_bits_QAM/data_length;
end
figure(6), clf
if channel_on == 1
subplot(211), plot(W/(2*pi),mag),title('Channel Magnitude Response')
xlabel('Digital Frequency'),ylabel('Magnitude in dB')
subplot(212), plot(W/(2*pi),phase),title('Channel Phase Response')
xlabel('Digital Frequency'),ylabel('Phase in Degrees')
else
title('Channel is turned off - No frequency response to plot')
end
% Compare output to input and count errors
binary_err_bits_OFDM = 0;
for i = 1:length(data_in)
err = abs(data_in(i)-output(i));
if err > 0
binary_err_bits_OFDM = binary_err_bits_OFDM +1;
end
end
BER_OFDM = 100 * binary_err_bits_OFDM/data_length;
disp(strcat('OFDM: BER=', num2str(BER_OFDM,3), ' %'))
disp(strcat(' Number of error bits=', num2str(binary_err_bits_OFDM)))
if (do_QAM == 1)
disp(strcat('QAM: BER=', num2str(BER_QAM,3), ' %'))
disp(strcat(' Number of error bits=', num2str(binary_err_bits_QAM)))
end
% Display text file before and after modulation
if (input_type == 2) & (file_input_type == 2)
original_text_file = char(data_samples')
if do_QAM ==1
edit QAM_text_out.txt
end
edit OFDM_text_out.txt
end
% Listen to sounds
if (input_type == 2) & (file_input_type == 3)
do_again = '1';
while ( ~(isempty(do_again)) )
disp(' ')
disp('Press any key to hear the original sound'), %pause
sound(data_samples,11025)
disp('Press any key to hear the sound after OFDM transmission'), %pause
sound(output_samples,11025)
if do_QAM == 1
disp('Press any key to hear the sound after QAM transmission'), %pause
sound(QAM_output_samples,11025)
end
do_again = '';
do_again = input('Enter "1" to hear the sounds again or press "Return" to end ', 's');
end
end