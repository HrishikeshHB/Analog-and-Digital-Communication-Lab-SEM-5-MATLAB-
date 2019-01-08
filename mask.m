clc
clear all
close all
len = input('Length = ')
fc = input('Carrier Frequency = ')
Tb = input('Bit time = ')
fs = input('Sampling Frequency = ')
Eb = input('Energy = ')
m  = input('m = ')
n = log(m)/log(2);
t = 0:1/fs:len*Tb/n-1/fs;
b = randi([0,1],1,len);
rtEb = sqrt(Eb);
d = zeros(1,n);
c = zeros(1,len/n);
p = 1;
for i = 1:n:len
    k = 1;
    for j = i:i+n-1
      d(k) = b(j);
      k = k+1;
    end
    c(p) = bi2de(fliplr(d));
    p = p+1;
end
c = c.*rtEb;
car = sqrt(2/Tb)*cos(2*pi*fc*t);
z = 0;
w = zeros(1,len*fs*Tb/n);
for i = 1:len/n
    for j = (i-z):fs*Tb
        w(j+(i-1)*fs*Tb) = c(i);
    end
end
w = w.*car;

q = w.*car;
z=0;
dq = zeros(1,len/n);
for i=1:len/n
    sum = 0;
    for j=(i-z):fs*Tb
        sum = sum+q(j+(i-1)*fs*Tb);
    end
    z = z+1;
    sum = sum/fs;
    dq(i) = round(sum);
end
k = zeros(1,len*fs*Tb/n);
z=0;
for i=1:len/n
    for j=(i-z):fs*Tb
        k(j+(i-1)*fs*Tb) = dq(i);
    end
    z = z+1;
end
k = k./rtEb;
subplot(2,1,1)
plot(t,w)
grid on
subplot(2,1,2)
plot(t,k)
grid on
