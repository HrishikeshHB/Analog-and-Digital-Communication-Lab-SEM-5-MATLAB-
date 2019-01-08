clc
clear all
close all
am = input('Message amplitude = ');
ac = input('Carrier amplitude = ');
fm = input('Message frequency = ');
fc = input('Carrier frequency = ');

fs = 10000;
N = 5000;
f = 0:fs/N:(N-1)*fs/N;
t = 0:1/fs:0.5-1/fs;
ka = 1/ac;

m = am*cos(2*pi*fm*t);
c = ac*cos(2*pi*fc*t);
m1 = am*sin(2*pi*fm*t);
c1 = ac*sin(2*pi*fc*t);

s1 = (1+ka.*m).*c;
s2 = c.*m;
s31 = c1.*m+c.*m1;
s32 = c1.*m-c.*m1;


ds1 = c.*s1;
ds2 = c.*s2;
ds31 = c.*s31;
ds32 = c1.*s32;

n = 0:1:200;
w = 2*pi*fm/fs;
h = sinc(n*w)*w/pi;
y1 = filter(h,1,ds1);
y2 = filter(h,1,ds2);
y3 = filter(h,1,ds31);
y4 = filter(h,1,ds32);

subplot(4,1,1)
plot(t,s1)
grid on
subplot(4,1,2)
plot(t,s2)
grid on
subplot(4,1,3)
plot(t,s31)
grid on
subplot(4,1,4)
plot(t,s32)
grid on

figure
subplot(4,1,1)
plot(t,y1)
grid on
subplot(4,1,2)
plot(t,y2)
grid on
subplot(4,1,3)
plot(t,y3)
grid on
subplot(4,1,4)
plot(t,y4)
grid on

figure
subplot(4,1,1)
plot(f,abs(fft(s1,N)))
grid on
subplot(4,1,2)
plot(f,abs(fft(s2,N)))
grid on
subplot(4,1,3)
plot(f,abs(fft(s31,N)))
grid on
subplot(4,1,4)
plot(f,abs(fft(s32,N)))
grid on