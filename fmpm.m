clc
clear all
close all
am = input('Message amplitude = ');
ac = input('Carrier Amplitude = ');
fm = input('Message Frequency = ');
fc = input('Carrier Frequency = ');
fs = input('Sampling Frequency = ');
Dp = input('Dp = ');
Df = input('Df = ');
delF = (1/(2*pi))*Df*am;
Beta = delF/fm;

t = 0:1/fs:1/fm-1/fs;
m = am*cos(2*pi*fm*t);
N = length(t);
f = 0:fs/N:(N-1)*fs/N;
s = ac*cos(2*pi*fc*t+(Df*am/(Dp*2*pi*fm))*sin(2*pi*fm*t));
s1 = fmmod(m,fc,fs,delF/am);
q = fft(s,N);
q1 = fft(s1,N);
w = fmdemod(s,fc,fs,delF/am,0);
w1 = fmdemod(s1,fc,fs,delF/am,0);
Bt = 2*(Beta+1)*fm;
subplot(1,2,1)
plot(t,s)
grid on
subplot(1,2,2)
plot(t,s1)
grid on
figure
subplot(2,1,1)
plot(f,abs(q))
grid on
subplot(2,1,2)
plot(f,abs(q))
grid on
figure
subplot(2,1,1)
plot(f,w)
grid on
subplot(2,1,2)
plot(f,w1)
grid on
