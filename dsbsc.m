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
c = ac*cos(2*pi*fc*t);
s = m.*c;
y = fft(s,N);

q = s.*c;
n = -200:1:200;
w = 2*pi*fm/fs;
h = sinc(n*w)*w/pi;
z = filter(h,1,q);

subplot(4,1,1)
plot(t,m)
grid on
subplot(4,1,2)
plot(t,s)
grid on
subplot(4,1,3)
plot(f,abs(y))
grid on
subplot(4,1,4)
plot(t,z)
grid on