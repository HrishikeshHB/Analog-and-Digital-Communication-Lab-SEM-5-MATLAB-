clc
clear all
close all
am = input('Message Amplitude = ');
fm = input('Frequency = ');
phase = input('Phase = ');
fs = input('Sampling Frequency = ');
n = input('Pulse Time In Terms of Sampling Frequency = ');
fc = fs/n;
t = 0:1/fs:1/fm-1/fs;
m = am*sin(2*pi*fm*t+phase);
l = zeros(1,length(t));
p = zeros(1,length(t));
c = 1;
for i = 1:fc:length(t)
    for j=1:fc
        if mod(c,2)
            l(j+(i-1)) = m(i);
            p(j+(i-1)) = 1;
        else 
            l(j+(i-1)) = 0;
            p(j+(i-1)) = 0;
        end
    end
    c = c+1;
end
wc=2*pi*fm/fs;
nn=0:1:2000;
h=sinc(nn*wc)*wc/pi;
y = filter(h,1,l);

plot(t,l);
hold on
title('Pulse Amplitude Modulation');
xlabel('time->');
ylabel('Amplitude');
plot(t,m);
hold off
figure
plot(t,p);
axis([0 0.1 -0.5 1.5])
title('Pulse Train');
xlabel('time->');
ylabel('Amplitude');
figure
plot(t,y);
title('De-Modulation');
xlabel('time->');
ylabel('Amplitude');

            