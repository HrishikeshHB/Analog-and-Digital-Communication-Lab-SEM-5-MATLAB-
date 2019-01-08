clc
clear all
close all
am = input('Message Amplitude ')
ac = input('Carrier Amplitude ')
fm = input('Message Frequency ')
fc = input('Carrier Frequency ')

N = 5000;
fs = 10000;
f = 0:fs/N:(N-1)*fs/N;
t = 0:1/fs:0.1;

ka = 1/ac;
m = am*cos(2*pi*fm*t);
s = ac*(1+ka.*m).*cos(2*pi*fc*t);
c = ac*cos(2*pi*fc*t);
n = -20:1:200;
wc = 2*pi*fm/fs;
h = sinc(n*wc)*wc/pi;
y = s.*c;
z = filter(h,1,y);
w = fft(s,N);
plot(f,w)
figure 
plot(t,z)