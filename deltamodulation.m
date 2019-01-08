clc
clear all
close all
am = input('Msg Amplitude ')
fm = input('Msg Frequency ')
phase = input('Phase ')
fs = input('Sampling Frequency ')
t = 0:1/fs:5/fm;
delta = 2*pi*fm*am/fs;
q = input('n = ')
delta = q*delta;
m = am*sin(2*pi*fm*t+phase);
e = zeros(1,length(t));
eq = zeros(1,length(t));
mq = zeros(1,length(t));
encode = zeros(1,length(t));
e(1) = m(1);
eq(1) = delta*sign(e(1));
mq(1) = eq(1);
if eq(1)>0
    encode(1) = 1;
else
    encode(1) = 0;
end
for i=2:length(t)
    e(i) = m(i) - mq(i-1);
    eq(i) = delta*sign(e(i));
    mq(i) = eq(i) + mq(i-1);
    if eq(i)>0
        encode(i) = 1;
    else
        encode(i) = 0;
    end
end

decode = zeros(1,length(t));
for i = 1:length(t)
    if encode(i)>0
        decode(i) = delta;
    else
        decode(i) = -delta;
    end
end
dmq = zeros(1,length(t));
deq(1) = decode(1);
dmq(1) = deq(1);
for i = 2:length(t)
    dmq(i) = decode(i)+ dmq(i-1);
end

fs1 = 400*fm;
wc=2*pi*fm/fs1;
nn=0:1:200;
h=sinc(nn*wc)*wc/pi;
y = filter(h,1,dmq);

subplot(3,1,1)
stairs(t,mq)
grid on

subplot(3,1,2)
stem(t,encode)
grid on

subplot(3,1,3)
plot(t,y)
grid on