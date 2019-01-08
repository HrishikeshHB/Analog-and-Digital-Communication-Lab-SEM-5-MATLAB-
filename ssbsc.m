clc
clear all
close all
am = input('Message amplitude ')
ac = input('Carrier amplitude ')
fm = input('Message frequency ')
fc = input('Carrier frequency ')

N = 5000;
fs = 10000;
f = 0:fs/N:(N-1)*fs/N;
t = 0:1/fs:0.1;

m1 = am*cos(2*pi*fm*t);
m2 = am*sin(2*pi*fm*t);
c1 = ac*cos(2*pi*fc*t);
c2 = ac*sin(2*pi*fc*t);

q=am*cos(2*pi*fm*t).*(ac*sin(2*pi*fc*t));
p=am*sin(2*pi*fm*t).*(ac*cos(2*pi*fc*t));
r1 = p+q;
r2 = p-q;
q1 = fft(r1,N);
q2 = fft(r2,N);

subplot(2,1,1)
plot(f,abs(q1))
grid on
subplot(2,1,2)
plot(f,abs(q2))
grid on
