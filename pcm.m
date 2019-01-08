clc
clear all
close all
am = input('Message Amplitude = ');
fm = input('Frequency = ');
phase = input('Phase = ');
fs = input('Sampling Frequency = ');
n = input('n = ');
L = 2^n;
t = 0:1/fs:10/fm-1/fs;
min = -am;
m = am*sin(2*pi*fm*t+phase);
ss = 2*am/(L-1);
delta = ss/2;
l = zeros(1,length(t));
p = zeros(1,length(t));
for i = 1:length(t)
    for k = -1:L-2
        if m(i)>min+k*ss+delta && m(i)<min+(k+1)*ss+delta
            p(i) = min+(k+1)*ss;
            l(i) = k+1;
        end
    end
end
plot(t,l);
wc=2*pi*fm/fs;
nn=0:1:200;
h=sinc(nn*wc)*wc/pi;
y = filter(h,1,l);
figure 
plot(t,y)
            